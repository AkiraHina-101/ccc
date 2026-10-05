"""Create a two-view PowerPoint report from Shared Edge Check TSV data.

The Tcl tool supplies the actual surface network and error edges. This helper
only renders that data; it never opens or changes a HyperMesh model.
"""

from __future__ import annotations

import io
import math
import os
import sys
from collections import defaultdict
from pathlib import Path
from statistics import median

from PIL import Image, ImageDraw, ImageFont
from pptx import Presentation
from pptx.dml.color import RGBColor
from pptx.util import Inches, Pt


LABELS = {
    "missing": "Missing shared node",
    "extra": "Extra shared edge",
    "inconsistent": "Inconsistent shared edge",
}
AXES = "XYZ"
SIZE = (1210, 900)
MAX_ERRORS_PER_SLIDE = 4
AXIS_COLORS = ((225, 40, 40), (22, 185, 62), (40, 96, 228))


def read_data(path: Path):
    nodes = {}
    segments = defaultdict(set)
    errors = []
    colors = {}
    with path.open("r", encoding="utf-8-sig") as stream:
        header = stream.readline().rstrip("\n\r")
        if header != "SHARED_EDGE_REPORT\t1":
            raise ValueError("Unsupported report data format")
        for number, line in enumerate(stream, 2):
            fields = line.rstrip("\n\r").split("\t")
            kind = fields[0]
            try:
                if kind == "NODE" and len(fields) == 5:
                    nodes[int(fields[1])] = tuple(map(float, fields[2:5]))
                elif kind == "SEG" and len(fields) == 4:
                    a, b = int(fields[2]), int(fields[3])
                    segments[fields[1]].add((min(a, b), max(a, b)))
                elif kind == "ERR" and len(fields) >= 5:
                    group, category = fields[1:3]
                    a, b = int(fields[3]), int(fields[4])
                    mid = int(fields[5]) if len(fields) > 5 else 0
                    if category not in LABELS:
                        raise ValueError("Unknown error category")
                    errors.append((group, category, a, b, mid))
                elif kind == "COLOR" and len(fields) == 5:
                    colors[fields[1]] = tuple(map(int, fields[2:5]))
                else:
                    raise ValueError("Unexpected row")
            except (TypeError, ValueError) as exc:
                raise ValueError(f"Invalid report data on line {number}: {exc}") from exc
    if not errors:
        raise ValueError("No error edges were provided")
    for group, category, a, b, mid in errors:
        if a not in nodes or b not in nodes:
            raise ValueError(f"Missing coordinates for error edge {a}-{b}")
        if group not in segments or not segments[group]:
            raise ValueError(f"No surface network for group {group}")
        colors.setdefault(category, {"missing": (225, 35, 35),
                                     "extra": (238, 180, 0),
                                     "inconsistent": (233, 120, 0)}[category])
    return nodes, segments, errors, colors


def font(size, bold=False):
    names = ["arialbd.ttf", "DejaVuSans-Bold.ttf"] if bold else [
        "arial.ttf", "DejaVuSans.ttf"]
    for name in names:
        try:
            return ImageFont.truetype(name, size)
        except OSError:
            continue
    return ImageFont.load_default()


def projection(group_segments, nodes):
    used = {n for edge in group_segments for n in edge}
    spans = []
    for axis in range(3):
        values = [nodes[n][axis] for n in used if n in nodes]
        spans.append((max(values) - min(values)) if values else 0.0)
    dominant = sorted(range(3), key=lambda index: spans[index], reverse=True)[:2]
    return tuple(sorted(dominant))


def axis_triad(axes):
    """Show which model axes run right, up, and out of the slide."""
    image = Image.new("RGBA", (170, 140), (255, 255, 255, 0))
    draw = ImageDraw.Draw(image)
    horizontal, vertical = axes
    normal = next(axis for axis in range(3) if axis not in axes)
    origin = (64, 106)
    hcolor, vcolor, ncolor = (AXIS_COLORS[i] for i in (horizontal, vertical, normal))
    arm = 68
    draw.line((origin, (origin[0] + arm, origin[1])), fill=hcolor, width=3)
    draw.polygon(((origin[0] + arm + 4, origin[1]),
                  (origin[0] + arm - 9, origin[1] - 6),
                  (origin[0] + arm - 9, origin[1] + 6)), fill=hcolor)
    draw.line((origin, (origin[0], origin[1] - arm)), fill=vcolor, width=3)
    draw.polygon(((origin[0], origin[1] - arm - 4),
                  (origin[0] - 6, origin[1] - arm + 9),
                  (origin[0] + 6, origin[1] - arm + 9)), fill=vcolor)
    draw.text((origin[0] + arm + 8, origin[1] - 15), AXES[horizontal],
              fill=(20, 27, 35), font=font(19))
    draw.text((origin[0] - 10, origin[1] - arm - 27), AXES[vertical],
              fill=(20, 27, 35), font=font(19))
    draw.ellipse((origin[0] - 9, origin[1] - 9,
                  origin[0] + 9, origin[1] + 9), outline=ncolor, width=2)
    draw.ellipse((origin[0] - 3, origin[1] - 3,
                  origin[0] + 3, origin[1] + 3), fill=ncolor)
    draw.text((origin[0] - 35, origin[1] + 8), AXES[normal],
              fill=(20, 27, 35), font=font(17))
    data = io.BytesIO()
    image.save(data, format="PNG")
    data.seek(0)
    return data


def group_errors(errors, segments, nodes, axes_by_group):
    """Keep nearby errors together only while a useful detail crop remains."""
    by_group = defaultdict(list)
    for error in errors:
        by_group[error[0]].append(error)
    slides = []
    for group in sorted(by_group):
        axes = axes_by_group[group]
        points = [nodes[n] for edge in segments[group] for n in edge]
        extents = [max(p[axis] for p in points) - min(p[axis] for p in points)
                   for axis in axes]
        whole_span = max(extents)
        lengths = [math.dist(nodes[a], nodes[b]) for a, b in segments[group]]
        typical_edge = median(lengths) if lengths else 0.0
        distance_limit = max(whole_span * 0.30, typical_edge * 14)

        def center(error):
            a, b = error[2:4]
            return tuple((nodes[a][i] + nodes[b][i]) / 2 for i in range(3))

        group_slides = []
        for error in by_group[group]:
            candidate = center(error)
            placed = False
            for slide_errors in group_slides:
                if len(slide_errors) >= MAX_ERRORS_PER_SLIDE:
                    continue
                if all(math.dist(candidate, center(other)) <= distance_limit and
                       math.hypot(*(candidate[axis] - center(other)[axis]
                                    for axis in axes)) <= distance_limit
                       for other in slide_errors):
                    slide_errors.append(error)
                    placed = True
                    break
            if not placed:
                group_slides.append([error])
        slides.extend(group_slides)
    return slides


def render(segments, nodes, targets, axes, colors, detail):
    normal = next(axis for axis in range(3) if axis not in axes)
    # A shallow oblique view separates surfaces which overlap in a planar
    # projection, while keeping the overview in the two report axes.
    tilt = 0.22 if detail else 0.0
    projected = {nid: (xyz[axes[0]] + tilt * xyz[normal],
                       xyz[axes[1]] - tilt * 0.55 * xyz[normal])
                 for nid, xyz in nodes.items()}
    lines = [(projected[x], projected[y]) for x, y in segments
             if x in projected and y in projected]
    if not lines:
        raise ValueError("No drawable surface edges")
    if detail:
        target_points = [projected[n] for target in targets for n in target[2:4]]
        tx0, tx1 = min(p[0] for p in target_points), max(p[0] for p in target_points)
        ty0, ty1 = min(p[1] for p in target_points), max(p[1] for p in target_points)
        cx, cy = (tx0 + tx1) / 2, (ty0 + ty1) / 2
        distances = sorted(math.hypot((u[0] + v[0]) / 2 - cx,
                                      (u[1] + v[1]) / 2 - cy)
                           for u, v in lines)
        typical_edge = median(math.dist(u, v) for u, v in lines)
        if len(targets) == 1:
            radius = max(math.dist(target_points[0], target_points[1]) * 5,
                         distances[min(159, len(distances) - 1)] * 1.15)
            x0, x1 = cx - radius, cx + radius
            y0, y1 = cy - radius, cy + radius
        else:
            padding = max(typical_edge * 6, max(tx1 - tx0, ty1 - ty0) * 0.18)
            x0, x1 = tx0 - padding, tx1 + padding
            y0, y1 = ty0 - padding, ty1 + padding
        lines = [(u, v) for u, v in lines
                 if max(u[0], v[0]) >= x0 and min(u[0], v[0]) <= x1
                 and max(u[1], v[1]) >= y0 and min(u[1], v[1]) <= y1]
    else:
        xs = [p[0] for line in lines for p in line]
        ys = [p[1] for line in lines for p in line]
        x0, x1, y0, y1 = min(xs), max(xs), min(ys), max(ys)
    width, height = SIZE
    pad = 56
    span_x, span_y = max(x1 - x0, 1e-9), max(y1 - y0, 1e-9)
    scale = min((width - 2 * pad) / span_x, (height - 2 * pad) / span_y)
    offset_x = (width - span_x * scale) / 2
    offset_y = (height - span_y * scale) / 2

    def point(p):
        return (offset_x + (p[0] - x0) * scale,
                height - offset_y - (p[1] - y0) * scale)

    image = Image.new("RGB", SIZE, "white")
    draw = ImageDraw.Draw(image)
    for u, v in lines:
        draw.line((point(u), point(v)), fill=(181, 197, 192), width=2)
    for number, target in enumerate(targets, 1):
        _, category, a, b, _ = target
        color = colors[category]
        p1, p2 = point(projected[a]), point(projected[b])
        draw.line((p1, p2), fill=(67, 76, 82), width=12 if detail else 10)
        draw.line((p1, p2), fill=color, width=8 if detail else 6)
        for p in (p1, p2):
            radius = 7 if detail else 6
            draw.ellipse((p[0] - radius, p[1] - radius, p[0] + radius,
                          p[1] + radius), fill=color, outline="white", width=2)
        middle = ((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2)
        draw.text((middle[0] + 10, middle[1] - 32), str(number), fill=color,
                  font=font(30, bold=True), stroke_width=3, stroke_fill="white")
    data = io.BytesIO()
    image.save(data, format="PNG")
    data.seek(0)
    return data


def add_text(slide, text, x, y, w, h, size=16, bold=False, color=(32, 45, 61)):
    box = slide.shapes.add_textbox(Inches(x), Inches(y), Inches(w), Inches(h))
    frame = box.text_frame
    frame.word_wrap = False
    frame.margin_left = frame.margin_right = 0
    frame.margin_top = frame.margin_bottom = 0
    paragraph = frame.paragraphs[0]
    run = paragraph.add_run()
    run.text = text
    run.font.name = "Arial"
    run.font.size = Pt(size)
    run.font.bold = bold
    run.font.color.rgb = RGBColor(*color)


def make_ppt(nodes, segments, errors, colors, destination):
    deck = Presentation()
    deck.slide_width = Inches(13.333)
    deck.slide_height = Inches(7.5)
    blank = deck.slide_layouts[6]
    axes_by_group = {group: projection(edges, nodes)
                     for group, edges in segments.items()}
    order = {"missing": 0, "extra": 1, "inconsistent": 2}
    errors.sort(key=lambda e: (e[0], order[e[1]], min(e[2], e[3]), max(e[2], e[3])))
    grouped = group_errors(errors, segments, nodes, axes_by_group)
    for index, targets in enumerate(grouped, 1):
        group = targets[0][0]
        axes = axes_by_group[group]
        depth_axis = next(axis for axis in range(3) if axis not in axes)
        centers = [tuple((nodes[a][i] + nodes[b][i]) / 2 for i in range(3))
                   for _, _, a, b, _ in targets]
        depths = [center[depth_axis] for center in centers]
        depth_text = (f"{min(depths):.4f}" if len(depths) == 1 else
                      f"{min(depths):.4f} to {max(depths):.4f}")
        slide = deck.slides.add_slide(blank)
        title = LABELS[targets[0][1]] if len(targets) == 1 else "Shared-edge errors"
        add_text(slide, title, 0.42, 0.23, 9.2, 0.46,
                 size=26, bold=True)
        add_text(slide, f"{index} / {len(grouped)}", 12.1, 0.3, 0.85, 0.3,
                 size=14, color=(90, 101, 111))
        group_label = "Combined" if group == "All" else "Components " + group.replace(",", " & ")
        add_text(slide, f"{group_label}    {len(targets)} error edges",
                 0.44, 0.76, 5.4, 0.32, size=15, color=(78, 89, 101))
        add_text(slide, f"View {AXES[axes[0]]}-{AXES[axes[1]]}    Out-of-plane {AXES[depth_axis]}: {depth_text}",
                 5.5, 0.75, 5.15, 0.35, size=15, bold=True)
        add_text(slide, "Whole shared-edge network", 0.45, 1.23,
                 6.0, 0.35, size=18, bold=True)
        add_text(slide, "Around these edges (slight 3D tilt)", 6.84, 1.23,
                 6.0, 0.35, size=18, bold=True)
        whole = render(segments[group], nodes, targets, axes, colors, False)
        local = render(segments[group], nodes, targets, axes, colors, True)
        slide.shapes.add_picture(whole, Inches(0.42), Inches(1.6),
                                 width=Inches(6.05), height=Inches(4.5))
        slide.shapes.add_picture(local, Inches(6.82), Inches(1.6),
                                 width=Inches(6.05), height=Inches(4.5))
        # Keep the source aspect ratio so the two in-plane axis arms remain
        # the same visible length after PowerPoint scales the PNG.
        triad_width = 1.26
        slide.shapes.add_picture(axis_triad(axes), Inches(0.53), Inches(5.02),
                                 width=Inches(triad_width),
                                 height=Inches(triad_width * 140 / 170))
        for number, target in enumerate(targets, 1):
            _, category, a, b, mid = target
            mid_label = f"mid {mid}" if mid else "mid varies"
            label = f"{number}  {LABELS[category]}: {a}-{b} ({mid_label})"
            center = centers[number - 1]
            position = "Edge center  " + "   ".join(
                f"{AXES[axis]}={center[axis]:.4f}" for axis in range(3))
            column = (number - 1) % 2
            row = (number - 1) // 2
            x = 0.45 + 6.4 * column
            y = 6.19 + 0.47 * row
            add_text(slide, label, x, y, 6.0, 0.22,
                     size=12, bold=True, color=colors[category])
            add_text(slide, position, x, y + 0.21, 6.0, 0.22,
                     size=12, bold=True, color=(48, 61, 73))
        add_text(slide, "Positions are in model coordinates", 0.45, 7.22,
                 12.0, 0.23, size=11.5, color=(89, 101, 112))
    temporary = destination.with_name(destination.name + ".tmp")
    try:
        deck.save(str(temporary))
        os.replace(temporary, destination)
    finally:
        temporary.unlink(missing_ok=True)
    return len(grouped), len(errors)


def main(argv):
    if len(argv) != 3:
        raise ValueError("Usage: export_shared_edge_ppt.py data.tsv output.pptx")
    data_path, destination = map(Path, argv[1:])
    nodes, segments, errors, colors = read_data(data_path)
    slide_count, edge_count = make_ppt(nodes, segments, errors, colors, destination)
    print(f"Exported {edge_count} error edges on {slide_count} slides to {destination}")


if __name__ == "__main__":
    try:
        main(sys.argv)
    except Exception as exc:
        print(f"PowerPoint export failed: {exc}", file=sys.stderr)
        sys.exit(1)
