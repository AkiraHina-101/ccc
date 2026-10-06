"""Pure geometry/contact decisions for Surface Split.

This module deliberately has no JPT or pyjdg dependency.  The Jupiter-facing
tool owns model access and UI state, then passes plain Python values here.
"""
import math


def sub(a, b):
    return (a[0] - b[0], a[1] - b[1], a[2] - b[2])


def dot(a, b):
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2]


def norm(a):
    return math.sqrt(dot(a, a))


def smooth_across(ff, fg, shared_nodes, cos_tol=0.94):
    """Return whether two faces continue smoothly at their shared boundary."""
    if not ff or not fg or not shared_nodes:
        return False

    def boundary_normal(feat):
        ns = [0.0, 0.0, 0.0]
        got = 0
        for nid_set, nrm in feat.get("einfo", []):
            if len(nid_set & shared_nodes) >= 2:
                nl = norm(nrm)
                if nl < 1e-12:
                    continue
                for i in range(3):
                    ns[i] += nrm[i] / nl
                got += 1
        if not got:
            return None
        nl = norm(ns)
        return None if nl < 1e-9 else (
            ns[0] / nl, ns[1] / nl, ns[2] / nl)

    n1 = boundary_normal(ff)
    n2 = boundary_normal(fg)
    if n1 is None or n2 is None:
        return False
    return abs(dot(n1, n2)) >= cos_tol


def contact_gate(ct, n_in, ct_in, shn, reach, rule):
    """Return ``core``, ``pressed``, ``prox`` or ``None``."""
    if shn >= rule["core_min_shn"]:
        return "core"
    if (n_in >= rule["pressed_min_interior"]
            and ct_in >= rule["pressed_min_ct_in"]):
        return "pressed"
    if (ct >= rule["prox_min_ct"] and reach <= rule["prox_max_reach"]
            and shn <= 0.0):
        return "prox"
    return None


def coplanar_pressed(n_in, ct_in, ct, vis, shn, reach, rule):
    """Return whether a core-adjacent face has pressed-contact evidence."""
    if shn >= rule["coplanar_core_shn"]:
        return True
    if n_in > 0 and ct_in >= rule["coplanar_min_ct_in"]:
        return True
    if ct < rule["coplanar_min_ct"] or ct < vis:
        return False
    if (reach >= rule["coplanar_open_min_reach"]
            and ct < rule["coplanar_open_min_ct"]):
        return False
    return True


def is_hole_single(feat, n_elem, rule):
    """Return the matching single-face hole tier, or ``None``."""
    if feat is None or feat.get("cv") is None:
        return None
    if feat["radius"] > rule["hole_max_radius"]:
        if not (feat["radius"] <= rule["holeXL_max_radius"]
                and feat["coverage"] >= rule["holeXL_min_cover"]
                and feat["cv"] <= rule["holeXL_max_cv"]
                and feat.get("tilt", 0) <= rule["holeXL_max_tilt"]):
            return None
    if (feat.get("tilt", 0) > rule["hole_max_tilt"]
            or feat.get("hollow", 1) < rule["hole_min_hollow"]
            or feat.get("nconc", 0) > rule["hole_max_nconc"]):
        return None
    len_ratio = feat.get("length", 0) / max(feat["radius"], 1e-9)
    if (feat.get("tilt", 0) >= rule["hole_shallow_tilt_min"]
            and len_ratio < rule["hole_shallow_max_len_ratio"]):
        return None
    rv, cov, inw = feat["cv"], feat["coverage"], feat["inward"]
    tilt = feat.get("tilt", 0)
    conc = feat.get("nconc", 0)
    rconc = math.sqrt(max(0.0, conc * conc - tilt * tilt))
    closed = rconc <= rule["hole_closed_max_rconc"]
    if (closed and n_elem >= rule["t1_min_elem"]
            and rv <= rule["t1_max_cv"] and cov >= rule["t1_min_cover"]
            and inw >= rule["t1_min_inward"]):
        return "tier1"
    if (closed and n_elem >= rule["t2_min_elem"]
            and rv <= rule["t2_max_cv"] and cov >= rule["t2_min_cover"]
            and inw >= rule["t2_min_inward"]):
        return "tier2"
    if (n_elem >= rule["t3_min_elem"] and rv <= rule["t3_max_cv"]
            and cov >= rule["t3_min_cover"]
            and feat["length"] >= rule["t3_len_per_radius"] * feat["radius"]
            and inw >= rule["t3_min_inward"]):
        return "tier3"
    if (closed and n_elem >= rule["t4_min_elem"]
            and rv <= rule["t4_max_cv"] and cov >= rule["t4_min_cover"]
            and inw >= rule["t4_min_inward"]):
        return "tier4"
    if (n_elem >= rule["r0_min_elem"]
            and feat.get("nconc", 1) <= rule["r0_max_nconc"]
            and feat.get("tilt", 1) <= rule["r0_max_tilt"]
            and rv <= rule["r0_max_cv"]
            and feat.get("hollow", 0) >= rule["r0_min_hollow"]
            and inw >= rule["r0_min_inward"]):
        return "ring0"
    return None


def is_hole_fragment(feat, n_elem, n_in, rule):
    if feat is None or feat.get("cv") is None:
        return False
    if (n_elem >= rule["frag_min_elem"]
            and n_in >= rule["frag_min_interior"]
            and feat["cv"] <= rule["frag_max_cv"]
            and feat["radius"] <= rule["hole_max_radius"]
            and feat["inward"] >= rule["frag_min_inward"]
            and feat.get("tilt", 0) <= rule["frag_max_tilt"]
            and feat.get("hollow", 1) >= rule["frag_min_hollow"]):
        return True
    size_ok = (feat["radius"] <= rule["fragS_max_radius"]
               or (feat["radius"] <= rule["hole_max_radius"]
                   and feat.get("length", 0)
                   >= rule["fragS_min_len_ratio"] * feat["radius"]))
    return (n_elem >= rule["fragS_min_elem"] and size_ok
            and feat["cv"] <= rule["fragS_max_cv"]
            and feat["inward"] >= rule["frag_min_inward"]
            and feat.get("tilt", 0) <= rule["fragS_max_tilt"]
            and feat.get("hollow", 1) >= rule["fragS_min_hollow"])


def same_cylinder(f1, f2, rule):
    if abs(dot(f1["axis"], f2["axis"])) < rule["cyl_min_axis_cos"]:
        return False
    if abs(f1["radius"] - f2["radius"]) > (
            rule["cyl_radius_tol"] * max(f1["radius"], 1.0)):
        return False
    dc = sub(f1["center"], f2["center"])
    axial = dot(dc, f1["axis"])
    perp = sub(dc, tuple(x * axial for x in f1["axis"]))
    return norm(perp) <= max(rule["cyl_center_tol"] * f1["radius"], 2.0)


def detect_holes(faces_feat, rule):
    """Classify single holes and cylinder fragments from plain features."""
    holes = {}
    frags = []
    for fid, item in faces_feat.items():
        feat, n_elem = item[0], item[1]
        n_in = item[2] if len(item) > 2 else 0
        via = is_hole_single(feat, n_elem, rule)
        if via:
            holes[fid] = via
        elif is_hole_fragment(feat, n_elem, n_in, rule):
            frags.append((fid, feat))
    used = set()
    for i in range(len(frags)):
        if i in used:
            continue
        group = [i]
        for j in range(i + 1, len(frags)):
            if j not in used and same_cylinder(frags[i][1], frags[j][1], rule):
                group.append(j)
        if len(group) < 2:
            continue
        gsum = [0.0, 0.0, 0.0]
        gcnt = 0
        for k in group:
            nsum = frags[k][1].get("nsum", (0, 0, 0))
            for axis in range(3):
                gsum[axis] += nsum[axis]
            gcnt += frags[k][1].get("n_nrm", 0)
        gconc = norm(gsum) / gcnt if gcnt else 1.0
        if gconc <= rule["group_closure_max"]:
            used.update(group)
            for k in group:
                holes[frags[k][0]] = "frag"
    return holes


def is_ring_face(feat, rule, nbin):
    """Return whether a feature is a closed inner rim."""
    if not feat or "ring_bins" not in feat:
        return False
    if (feat["ring_radius"] > rule["ring_max_radius"]
            or feat["ring_cv"] > rule["ring_max_cv"]
            or feat["ring_inward"] < rule["ring_min_inward"]
            or feat.get("ring_hollow", 1) < rule["ring_min_hollow"]):
        return False
    dc = sub(feat["cavg"], feat["ring_center"])
    axis = feat.get("navg")
    if axis:
        axial = dot(dc, axis)
        dc = sub(dc, tuple(x * axial for x in axis))
    if norm(dc) > rule["ring_centroid_tol"] * feat["ring_radius"]:
        return False
    bins = sorted(feat["ring_bins"])
    if len(bins) < rule["ring_min_bins"]:
        return False
    gaps = [(bins[(i + 1) % len(bins)] - bins[i]) % nbin
            for i in range(len(bins))]
    return max(gaps) <= rule["ring_max_gap"]


def face_weight(fid, faces_feat):
    """Geometric face area; element count is only a legacy fallback."""
    item = faces_feat.get(fid, (None, 1))
    feat = item[0]
    if feat and feat.get("area", 0) > 0:
        return feat["area"]
    return item[1] or 1


def mean_visibility(comp, fvis, fvis30, faces_feat):
    total = seen = 0.0
    for fid in comp:
        weight = face_weight(fid, faces_feat)
        total += weight
        seen += weight * max(fvis.get(fid, 0.0), fvis30.get(fid, 0.0))
    return (seen / total) if total else 0.0


def mean_metric(comp, face_metric, faces_feat):
    total = value = 0.0
    for fid in comp:
        weight = face_weight(fid, faces_feat)
        total += weight
        value += weight * face_metric.get(fid, 0.0)
    return (value / total) if total else 0.0


def high_area_fraction(comp, face_metric, threshold, faces_feat):
    total = high = 0.0
    for fid in comp:
        weight = face_weight(fid, faces_feat)
        total += weight
        if face_metric.get(fid, 0.0) >= threshold:
            high += weight
    return (high / total) if total else 0.0


def rescue_metrics(comp, fvis, fvis30, reach, faces_feat, rule):
    """Return the rescue decision and its diagnostic metrics."""
    mean_vis = mean_visibility(comp, fvis, fvis30, faces_feat)
    mean_reach = mean_metric(comp, reach, faces_feat)
    has_seed = any(
        fvis.get(fid, 0.0) >= rule["island_rescue_min_vis"]
        or fvis30.get(fid, 0.0) >= rule["island_rescue_min_vis"]
        for fid in comp)
    high_reach = high_area_fraction(
        comp, reach, rule["rescue_high_reach_face_ratio"], faces_feat)
    broad_vis = mean_vis >= rule["rescue_min_broad_vis"]
    air_backed = (mean_vis >= rule["rescue_min_mean_vis"]
                  and mean_reach >= rule["rescue_min_mean_reach"]
                  and high_reach >= rule["rescue_min_high_reach_area"])
    return (has_seed and (broad_vis or air_backed), has_seed,
            mean_vis, mean_reach, high_reach)
