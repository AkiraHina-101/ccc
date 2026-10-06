"""
find_outer.py - Phan loai part OUTSIDE / INSIDE tu file NASTRAN bdf (shell mesh).

Y tuong: nguoi dung nhin thay part khi tia nhin thang tu ngoai khong bi can.
1. Voxel hoa toan bo mat luoi.
2. Chieu orthographic tu nhieu huong quanh mat cau (mo phong xoay model):
   voi moi huong nhin, chi voxel DAU TIEN bi tia cham moi la "thay duoc".
3. Part outside = ty le phan tu thay duoc >= nguong (mac dinh 2%).
(Flood-fill khong khi van duoc tinh de tham khao - cot exposed.)

Chay:  python find_outer.py [mesh.bdf]
Tham so (default da kiem chung tren model NVH 10/7/2026):
  --voxel 5.0      do phan giai luoi voxel (mm)
  --close 30.0     bit lo/khe <= duong kinh nay (mm)
  --threshold 0.05 ty le thay duoc toi thieu de la OUTSIDE
  --ndir 128       so huong nhin quanh mat cau
Ket qua: outer_result.json + outer_visible_eids.json canh file bdf.
"""
import sys
import os
import json
import time
import argparse
import numpy as np

# Output directory override (set from --outdir in main). None = write next to
# the bdf, preserving the old behavior. find_outer_fast reads this global too.
OUTPUT_DIR = None


def parse_bdf(path):
    """Doc GRID + CTRIA3 (small field 8 cot) + comment '$ Part :' de gan part."""
    node_ids = []
    node_xyz = []
    tri_nodes = []      # (n1,n2,n3)
    tri_eid = []        # element id trong bdf
    tri_part = []       # index vao part_names
    part_names = []
    cur_part = -1

    def ffloat(s):
        s = s.strip()
        if not s:
            return 0.0
        # NASTRAN dang 1.5-3 = 1.5e-3
        try:
            return float(s)
        except ValueError:
            for i in range(len(s) - 1, 0, -1):
                if s[i] in "+-" and s[i - 1] not in "eE":
                    return float(s[:i] + "e" + s[i:])
            raise

    with open(path, "r", errors="ignore") as fh:
        for line in fh:
            if line.startswith("GRID"):
                node_ids.append(int(line[8:16]))
                node_xyz.append((ffloat(line[24:32]),
                                 ffloat(line[32:40]),
                                 ffloat(line[40:48])))
            elif line.startswith("CTRIA3"):
                tri_eid.append(int(line[8:16]))
                tri_nodes.append((int(line[24:32]),
                                  int(line[32:40]),
                                  int(line[40:48])))
                tri_part.append(cur_part)
            elif line.startswith("$ Part :"):
                name = line[8:].strip()
                part_names.append(name)
                cur_part = len(part_names) - 1

    node_ids = np.asarray(node_ids, dtype=np.int64)
    node_xyz = np.asarray(node_xyz, dtype=np.float64)
    tri_nodes = np.asarray(tri_nodes, dtype=np.int64)
    tri_eid = np.asarray(tri_eid, dtype=np.int64)
    tri_part = np.asarray(tri_part, dtype=np.int32)

    # map node id -> index
    remap = np.full(node_ids.max() + 1, -1, dtype=np.int64)
    remap[node_ids] = np.arange(len(node_ids))
    tri_idx = remap[tri_nodes]
    if (tri_idx < 0).any():
        bad = int((tri_idx < 0).any(axis=1).sum())
        print(f"[WARN] {bad} tri tham chieu node khong ton tai - bo qua")
        ok = (tri_idx >= 0).all(axis=1)
        tri_idx = tri_idx[ok]
        tri_eid = tri_eid[ok]
        tri_part = tri_part[ok]
    return node_xyz, tri_idx, tri_eid, tri_part, part_names


def voxelize_tris(node_xyz, tri_idx, voxel, origin, dims):
    """Tra ve (occupancy bool 3D, danh sach voxel index phang cua tung tri).

    Moi tam giac duoc sample du day theo kich thuoc voxel (barycentric),
    dam bao khong thung lo tren tuong mong.
    """
    v0 = node_xyz[tri_idx[:, 0]]
    v1 = node_xyz[tri_idx[:, 1]]
    v2 = node_xyz[tri_idx[:, 2]]

    # so buoc chia theo canh dai nhat cua tri (don vi voxel)
    e = np.maximum(np.linalg.norm(v1 - v0, axis=1),
                   np.maximum(np.linalg.norm(v2 - v0, axis=1),
                              np.linalg.norm(v2 - v1, axis=1)))
    nsub = np.clip(np.ceil(e / (voxel * 0.5)).astype(np.int32), 1, 256)

    occ = np.zeros(dims, dtype=bool)
    nx, ny, nz = dims
    tri_vox = [None] * len(tri_idx)

    # gom tri theo nsub de vector hoa
    order = np.argsort(nsub)
    sorted_ns = nsub[order]
    start = 0
    total = len(order)
    t0 = time.time()
    while start < total:
        n = sorted_ns[start]
        end = np.searchsorted(sorted_ns, n, side="right")
        sel = order[start:end]
        # luoi barycentric (i+j<=n)
        ii, jj = np.meshgrid(np.arange(n + 1), np.arange(n + 1), indexing="ij")
        mask = (ii + jj) <= n
        a = (ii[mask] / n)[None, :, None]
        b = (jj[mask] / n)[None, :, None]
        pts = (v0[sel][:, None, :] * (1 - a - b)
               + v1[sel][:, None, :] * a
               + v2[sel][:, None, :] * b)          # (m, npts, 3)
        idx = np.floor((pts - origin) / voxel).astype(np.int32)
        np.clip(idx[..., 0], 0, nx - 1, out=idx[..., 0])
        np.clip(idx[..., 1], 0, ny - 1, out=idx[..., 1])
        np.clip(idx[..., 2], 0, nz - 1, out=idx[..., 2])
        flat = (idx[..., 0].astype(np.int64) * ny + idx[..., 1]) * nz + idx[..., 2]
        occ.ravel()[flat.ravel()] = True

        # Every row has the same barycentric sample count within one nsub
        # group.  Calling np.unique once per triangle costs millions of Python
        # and NumPy dispatches on a large tetra model.  Sort all rows in one
        # C-level operation, remove adjacent duplicates with one vectorized
        # mask, then expose each compact row as a view into the shared values
        # buffer.  np.unique(flat[k]) also returns ascending values, so this is
        # result-equivalent while avoiding one np.unique call per triangle.
        flat.sort(axis=1)
        keep = np.ones(flat.shape, dtype=bool)
        if flat.shape[1] > 1:
            keep[:, 1:] = flat[:, 1:] != flat[:, :-1]
        counts = np.count_nonzero(keep, axis=1)
        values = flat[keep]
        ends = np.cumsum(counts)
        begin = 0
        for k, t in enumerate(sel):
            end_pos = int(ends[k])
            tri_vox[t] = values[begin:end_pos]
            begin = end_pos
        start = end
        if time.time() - t0 > 5:
            print(f"  voxelize {start}/{total} tri...")
            t0 = time.time()
    return occ, tri_vox


def _dilate(x, n):
    """Dilate 6-connectivity n vong."""
    for _ in range(n):
        y = x.copy()
        y[1:, :, :] |= x[:-1, :, :]
        y[:-1, :, :] |= x[1:, :, :]
        y[:, 1:, :] |= x[:, :-1, :]
        y[:, :-1, :] |= x[:, 1:, :]
        y[:, :, 1:] |= x[:, :, :-1]
        y[:, :, :-1] |= x[:, :, 1:]
        x = y
    return x


def close_holes(occ, n):
    """Morphological closing: bit kin lo/khe nho hon ~2n voxel.

    Mo phong viec lo bi part khac nhet vao trong assembly day du.
    """
    if n <= 0:
        return occ
    return occ | ~_dilate(~_dilate(occ, n), n)


def flood_outside(occ):
    """Flood fill 6-connectivity tu bien mien tren cac voxel trong."""
    free = ~occ
    outside = np.zeros_like(occ)
    # seed: toan bo mat bien free
    outside[0, :, :] = free[0, :, :]
    outside[-1, :, :] = free[-1, :, :]
    outside[:, 0, :] = free[:, 0, :]
    outside[:, -1, :] = free[:, -1, :]
    outside[:, :, 0] = free[:, :, 0]
    outside[:, :, -1] = free[:, :, -1]

    # Jupiter ships SciPy.  binary_propagation performs the same masked
    # 6-connected flood in native code instead of allocating/scanning the
    # complete 3-D grid once per Python iteration.  Keep the original NumPy
    # loop as a portability fallback for runtimes without SciPy.
    try:
        from scipy import ndimage
        structure = ndimage.generate_binary_structure(3, 1)
        outside = ndimage.binary_propagation(
            outside, structure=structure, mask=free)
        print(f"  flood native, outside voxels = {int(outside.sum())}")
        return outside
    except (ImportError, AttributeError):
        pass

    it = 0
    while True:
        grown = outside.copy()
        grown[1:, :, :] |= outside[:-1, :, :]
        grown[:-1, :, :] |= outside[1:, :, :]
        grown[:, 1:, :] |= outside[:, :-1, :]
        grown[:, :-1, :] |= outside[:, 1:, :]
        grown[:, :, 1:] |= outside[:, :, :-1]
        grown[:, :, :-1] |= outside[:, :, 1:]
        grown &= free
        it += 1
        if grown.sum() == outside.sum():
            break
        outside = grown
        if it % 50 == 0:
            print(f"  flood iter {it}, outside voxels = {int(outside.sum())}")
    print(f"  flood xong sau {it} vong, outside voxels = {int(outside.sum())}")
    return outside


def build_hole_caps(node_xyz, tri_idx, tri_part, npart):
    """Va nap AO cac vong canh bien (free-edge loop) cua tung part.

    Nap chi dung lam vat can tia trong analyzer (nhu ACModeling.CloseHoleAuto
    nhung khong dung den model that). Chi bit lo topology (vong kin) —
    khong day ranh giua cac gan.
    Tra ve (cap_v0, cap_v1, cap_v2): cac tam giac quat tu tam vong.
    """
    # dem canh theo (part, n_min, n_max)
    edge_cnt = {}
    for t in range(len(tri_idx)):
        p = tri_part[t]
        a, b, c = tri_idx[t]
        for u, v in ((a, b), (b, c), (c, a)):
            k = (p, u, v) if u < v else (p, v, u)
            edge_cnt[k] = edge_cnt.get(k, 0) + 1

    # canh bien = xuat hien dung 1 lan; adjacency theo part
    adj = {}
    for (p, u, v), cnt in edge_cnt.items():
        if cnt != 1:
            continue
        adj.setdefault((p, u), []).append(v)
        adj.setdefault((p, v), []).append(u)

    v0s, v1s, v2s = [], [], []
    used = set()
    n_loop = 0
    for (p, start), neigh in list(adj.items()):
        for first in neigh:
            ek = (p, start, first) if start < first else (p, first, start)
            if ek in used:
                continue
            # lan theo chuoi canh bien
            loop = [start, first]
            used.add(ek)
            ok = True
            while True:
                cur, prev = loop[-1], loop[-2]
                nxts = [x for x in adj.get((p, cur), []) if x != prev]
                nxt = None
                for x in nxts:
                    k2 = (p, cur, x) if cur < x else (p, x, cur)
                    if k2 not in used:
                        nxt = x
                        break
                if nxt is None:
                    ok = loop[-1] == loop[0] or (loop[0] in nxts)
                    break
                k2 = (p, cur, nxt) if cur < nxt else (p, nxt, cur)
                used.add(k2)
                if nxt == loop[0]:
                    break
                loop.append(nxt)
                if len(loop) > 100000:
                    ok = False
                    break
            if not ok or len(loop) < 3:
                continue
            n_loop += 1
            pts = node_xyz[loop]
            cen = pts.mean(axis=0)
            for i in range(len(loop)):
                v0s.append(cen)
                v1s.append(pts[i])
                v2s.append(pts[(i + 1) % len(loop)])
    if not v0s:
        return None, 0
    print(f"      va {n_loop} vong bien -> {len(v0s)} tam giac nap ao")
    return (np.asarray(v0s), np.asarray(v1s), np.asarray(v2s)), n_loop


def voxelize_raw_tris(v0, v1, v2, voxel, origin, dims):
    """Voxel hoa tam giac cho truoc (dung cho nap ao) — chi tra occupancy."""
    e = np.maximum(np.linalg.norm(v1 - v0, axis=1),
                   np.maximum(np.linalg.norm(v2 - v0, axis=1),
                              np.linalg.norm(v2 - v1, axis=1)))
    nsub = np.clip(np.ceil(e / (voxel * 0.5)).astype(np.int32), 1, 512)
    occ = np.zeros(dims, dtype=bool)
    nx, ny, nz = dims
    order = np.argsort(nsub)
    sorted_ns = nsub[order]
    start = 0
    while start < len(order):
        n = sorted_ns[start]
        end = np.searchsorted(sorted_ns, n, side="right")
        sel = order[start:end]
        ii, jj = np.meshgrid(np.arange(n + 1), np.arange(n + 1), indexing="ij")
        mask = (ii + jj) <= n
        a = (ii[mask] / n)[None, :, None]
        b = (jj[mask] / n)[None, :, None]
        pts = (v0[sel][:, None, :] * (1 - a - b)
               + v1[sel][:, None, :] * a + v2[sel][:, None, :] * b)
        idx = np.floor((pts - origin) / voxel).astype(np.int32)
        np.clip(idx[..., 0], 0, nx - 1, out=idx[..., 0])
        np.clip(idx[..., 1], 0, ny - 1, out=idx[..., 1])
        np.clip(idx[..., 2], 0, nz - 1, out=idx[..., 2])
        flat = (idx[..., 0].astype(np.int64) * ny + idx[..., 1]) * nz + idx[..., 2]
        occ.ravel()[flat.ravel()] = True
        start = end
    return occ


def fibonacci_dirs(n):
    """n huong phan bo deu tren mat cau."""
    i = np.arange(n, dtype=np.float64)
    phi = (1 + 5 ** 0.5) / 2
    z = 1 - (2 * i + 1) / n
    r = np.sqrt(np.maximum(0.0, 1 - z * z))
    theta = 2 * np.pi * i / phi
    return np.stack([r * np.cos(theta), r * np.sin(theta), z], axis=1)


def visible_from_views(occ, occ_block, voxel, ndir):
    """Mark voxel thay duoc bang chieu orthographic tu ndir huong.

    occ       : voxel be mat that (ung vien thay duoc)
    occ_block : voxel chan tia (= occ sau khi bit lo, hoac chinh occ)
    """
    idx = np.argwhere(occ)                      # (m,3) ung vien
    pts = idx.astype(np.float64) + 0.5          # tam voxel (don vi voxel)
    idx_b = np.argwhere(occ_block)
    pts_b = idx_b.astype(np.float64) + 0.5
    m = len(pts)
    visible = np.zeros(m, dtype=bool)
    dims = occ.shape
    span = float(max(dims)) + 2

    t0 = time.time()
    for k, d in enumerate(fibonacci_dirs(ndir)):
        # he truc (u,v) vuong goc voi d
        a = np.array([1.0, 0.0, 0.0]) if abs(d[0]) < 0.9 else np.array([0.0, 1.0, 0.0])
        u = np.cross(d, a)
        u /= np.linalg.norm(u)
        v = np.cross(d, u)
        depth = pts @ d
        au = pts @ u + span
        av = pts @ v + span
        W = 2 * int(span) + 4

        # Pass 1: z-buffer che khuat tu occ_block, moi voxel splat 2x2 pixel
        # (kin nuoc, chong ro tia qua khe aliasing khi chieu nghieng)
        depth_b = pts_b @ d
        au_b = pts_b @ u + span
        av_b = pts_b @ v + span
        bu = np.floor(au_b - 0.5).astype(np.int64)
        bv = np.floor(av_b - 0.5).astype(np.int64)
        keys = np.concatenate([
            (bu + du) * W + (bv + dv)
            for du in (0, 1) for dv in (0, 1)
        ])
        depth4 = np.tile(depth_b, 4)
        order = np.lexsort((depth4, keys))
        k_sorted = keys[order]
        first = np.ones(len(k_sorted), dtype=bool)
        first[1:] = k_sorted[1:] != k_sorted[:-1]
        uniq_keys = k_sorted[first]
        zbuf = depth4[order][first]        # min depth moi pixel

        # Pass 2: voxel thay duoc neu depth <= zbuf tai pixel TAM + 0.5
        ckey = np.floor(au).astype(np.int64) * W + np.floor(av).astype(np.int64)
        pos = np.searchsorted(uniq_keys, ckey)
        pos = np.clip(pos, 0, len(uniq_keys) - 1)
        zc = np.where(uniq_keys[pos] == ckey, zbuf[pos], np.inf)
        visible |= depth <= zc + 0.5
        if time.time() - t0 > 5:
            print(f"  view {k+1}/{ndir}...")
            t0 = time.time()

    vis_flat = np.zeros(dims[0] * dims[1] * dims[2], dtype=bool)
    flat_idx = (idx[:, 0] * dims[1] + idx[:, 1]) * dims[2] + idx[:, 2]
    vis_flat[flat_idx[visible]] = True
    return vis_flat


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("bdf", nargs="?",
                    default=os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                         "data", "run", "mesh.bdf"))
    ap.add_argument("--voxel", type=float, default=5.0,
                    help="kich thuoc voxel (don vi cua bdf, mac dinh 5)")
    ap.add_argument("--threshold", type=float, default=0.05,
                    help="ty le phan tu thay duoc toi thieu de coi la OUTSIDE")
    ap.add_argument("--ndir", type=int, default=128,
                    help="so huong nhin quanh mat cau")
    ap.add_argument("--reach", type=float, default=40.0,
                    help="do sau (mm) khong khi ngoai duoc phep tham vao "
                         "khe/ho de danh dau face 'con thong ra ngoai'")
    ap.add_argument("--reach-levels", type=str, default="",
                    help="cac snapshot reach phu, cach nhau boi dau phay "
                         "(vd 10,20,40; reach40 van la file chuan)")
    ap.add_argument("--cap-part", type=str, default="",
                    help="ten (hoac 1 phan ten) part NAP do AC close hole tao "
                         "ra trong bdf — xuat them file eid cham nap de tool "
                         "test dung lam rao chan grow")
    ap.add_argument("--cap-holes", action="store_true",
                    help="va nap ao cac vong canh bien (bit lo topology "
                         "moi kich thuoc, khong dung model that)")
    ap.add_argument("--suffix", type=str, default="",
                    help="hau to ten file ket qua (vd _split -> "
                         "outer_result_split.json), de giu nhieu bo ket qua")
    ap.add_argument("--close", type=float, default=30.0,
                    help="bit kin lo/khe co duong kinh <= gia tri nay (mm) "
                         "truoc khi tinh visibility (mo phong lo bi part khac "
                         "nhet vao trong assembly day du)")
    ap.add_argument("--outdir", type=str, default="",
                    help="thu muc ghi ket qua (mac dinh = thu muc chua bdf); "
                         "dung folder rieng cho tung model")
    ap.add_argument("--vis-only", action="store_true",
                    help="chi tinh va ghi visible EIDs; bo flood/reach/contact "
                         "va report. Dung cho luot 5mm/close30 vis30.")
    args = ap.parse_args()
    global OUTPUT_DIR
    OUTPUT_DIR = os.path.abspath(args.outdir) if args.outdir else None
    if OUTPUT_DIR:
        os.makedirs(OUTPUT_DIR, exist_ok=True)

    t0 = time.time()
    print(f"[1/5] Doc {args.bdf} ...")
    node_xyz, tri_idx, tri_eid, tri_part, part_names = parse_bdf(args.bdf)
    print(f"      {len(node_xyz)} node, {len(tri_idx)} tri, {len(part_names)} part"
          f"  ({time.time()-t0:.1f}s)")

    lo = node_xyz.min(axis=0) - 2 * args.voxel
    hi = node_xyz.max(axis=0) + 2 * args.voxel
    dims = tuple(np.ceil((hi - lo) / args.voxel).astype(int) + 1)
    nvox = dims[0] * dims[1] * dims[2]
    print(f"[2/5] Voxel grid {dims} = {nvox/1e6:.1f}M voxel, voxel={args.voxel}")
    if nvox > 400e6:
        print("[ERR] Grid qua lon - tang --voxel len.")
        sys.exit(1)

    print("[3/5] Voxel hoa tam giac ...")
    occ, tri_vox = voxelize_tris(node_xyz, tri_idx, args.voxel, lo, dims)
    print(f"      occupied = {int(occ.sum())} voxel  ({time.time()-t0:.1f}s)")

    occ_block = occ
    if args.cap_holes:
        print("[3a]  Va nap ao cac vong canh bien (lo topology moi kich thuoc) ...")
        caps, n_loop = build_hole_caps(node_xyz, tri_idx, tri_part,
                                       len(part_names))
        if caps is not None:
            occ_cap = voxelize_raw_tris(caps[0], caps[1], caps[2],
                                        args.voxel, lo, dims)
            occ_block = occ | occ_cap
            print(f"      blocker + nap: {int(occ_block.sum())} voxel")

    nclose = int(np.ceil((args.close / 2.0) / args.voxel)) if args.close > 0 else 0
    if nclose > 0:
        print(f"[3b]  Bit lo <= {args.close}mm (closing {nclose} voxel) ...")
        occ_block = close_holes(occ_block, nclose)
        print(f"      blocker: {int(occ.sum())} -> {int(occ_block.sum())} voxel")

    if args.vis_only:
        print(f"[5/6] Chieu {args.ndir} huong nhin quanh mat cau "
              "(vis-only) ...")
        vis_flat = visible_from_views(occ, occ_block, args.voxel, args.ndir)
        print(f"      visible = {int(vis_flat.sum())} / "
              f"{int(occ.sum())} voxel occupied  ({time.time()-t0:.1f}s)")
        vis_eids = {}
        for t in range(len(tri_idx)):
            p = tri_part[t]
            if p < 0:
                continue
            if vis_flat[tri_vox[t]].any():
                vis_eids.setdefault(part_names[p], []).append(int(tri_eid[t]))
        sfx = args.suffix
        out_dir = OUTPUT_DIR or os.path.dirname(os.path.abspath(args.bdf))
        eid_path = os.path.join(out_dir, f"outer_visible_eids{sfx}.json")
        with open(eid_path, "w", encoding="utf-8") as fh:
            json.dump(vis_eids, fh, ensure_ascii=False)
        print(f"EID thay duoc theo part -> {eid_path}")
        print(f"Tong thoi gian: {time.time()-t0:.1f}s (vis-only)")
        return

    print("[4/5] Flood fill khong khi ngoai ...")
    outside = flood_outside(occ_block)

    # khong khi ngoai (da bit lo) tham sau them toi da --reach mm qua khe
    # ho THAT (tuong = luoi goc khong bit) -> voxel cham lop khi nay la
    # "con thong ra ngoai" du khong nhin thay truc tiep
    n_reach = int(np.ceil(args.reach / args.voxel))
    print(f"[4c]  Khi ngoai tham {args.reach}mm ({n_reach} voxel) ...")
    grown_air = outside.copy()
    free_raw = ~occ
    extra_levels = sorted(set(
        float(x) for x in args.reach_levels.split(",") if x.strip()
        if 0 < float(x) < args.reach))
    level_steps = {mm: int(np.ceil(mm / args.voxel))
                   for mm in extra_levels}
    # One uint8 depth-rank array: each triangle is queried ONCE later.
    # This avoids the ~17s cost of re-scanning 1.1M triangles per level.
    reach_rank_flat = (np.full(occ.size, 255, dtype=np.uint8)
                       if extra_levels else None)

    def _reach_mask(air):
        touch = np.zeros_like(occ)
        touch[1:, :, :] |= air[:-1, :, :]
        touch[:-1, :, :] |= air[1:, :, :]
        touch[:, 1:, :] |= air[:, :-1, :]
        touch[:, :-1, :] |= air[:, 1:, :]
        touch[:, :, 1:] |= air[:, :, :-1]
        touch[:, :, :-1] |= air[:, :, 1:]
        touch &= occ
        return touch

    for step in range(1, n_reach + 1):
        nxt = _dilate(grown_air, 1) & free_raw
        stable = nxt.sum() == grown_air.sum()
        grown_air = nxt
        for mm, snap_step in level_steps.items():
            if step == snap_step:
                mask = _reach_mask(grown_air).ravel()
                rank = extra_levels.index(mm)
                reach_rank_flat[mask & (reach_rank_flat == 255)] = rank
        if stable:
            break
    reach_touch = _reach_mask(grown_air)
    reach_flat = reach_touch.ravel()
    if reach_rank_flat is not None:
        reach_rank_flat[reach_flat & (reach_rank_flat == 255)] = len(extra_levels)
    print(f"      reach voxels = {int(reach_touch.sum())}")

    # voxel occupied ke voi outside air = voxel "lo ra ngoai"
    exposed = np.zeros_like(occ)
    exposed[1:, :, :] |= outside[:-1, :, :]
    exposed[:-1, :, :] |= outside[1:, :, :]
    exposed[:, 1:, :] |= outside[:, :-1, :]
    exposed[:, :-1, :] |= outside[:, 1:, :]
    exposed[:, :, 1:] |= outside[:, :, :-1]
    exposed[:, :, :-1] |= outside[:, :, 1:]
    exposed &= occ
    exposed_flat = exposed.ravel()

    # part nap (AC close hole) -> voxel cua nap + vung lan can 1 voxel
    cap_parts = set()
    cap_near = None
    if args.cap_part:
        cap_parts = set(i for i, n in enumerate(part_names)
                        if args.cap_part.lower() in n.lower())
        if not cap_parts:
            print(f"[WARN] Khong tim thay part nap khop '{args.cap_part}'")
        else:
            print(f"[4a]  Part nap: {[part_names[i] for i in sorted(cap_parts)]}")
            cap_occ = np.zeros(dims, dtype=bool)
            for t in range(len(tri_idx)):
                if tri_part[t] in cap_parts:
                    cap_occ.ravel()[tri_vox[t]] = True
            cap_near = _dilate(cap_occ, 1).ravel()

    print("[4b]  Phat hien voxel tiep xuc (>=2 part chung voxel) ...")
    nvox_total = dims[0] * dims[1] * dims[2]
    part_of = np.full(nvox_total, -1, dtype=np.int16)
    contact_vox = np.zeros(nvox_total, dtype=bool)
    for t in range(len(tri_idx)):
        p = tri_part[t]
        if p < 0:
            continue
        vox = tri_vox[t]
        cur = part_of[vox]
        contact_vox[vox[(cur != -1) & (cur != p)]] = True
        part_of[vox[cur == -1]] = p
    print(f"      contact voxels = {int(contact_vox.sum())}")

    print(f"[5/6] Chieu {args.ndir} huong nhin quanh mat cau ...")
    vis_flat = visible_from_views(occ, occ_block, args.voxel, args.ndir)
    print(f"      visible = {int(vis_flat.sum())} / {int(occ.sum())} voxel occupied"
          f"  ({time.time()-t0:.1f}s)")

    print("[6/6] Tinh ty le thay duoc tung part ...")
    npart = len(part_names)
    n_tri = np.zeros(npart, dtype=np.int64)
    n_vis = np.zeros(npart, dtype=np.int64)
    n_exp = np.zeros(npart, dtype=np.int64)
    vis_eids = {}                      # part name -> [eid thay duoc]
    contact_eids = {}                  # part name -> [eid tiep xuc part khac]
    reach_eids = {}                    # part name -> [eid khi ngoai tham toi]
    reach_level_eids = {mm: {} for mm in extra_levels}
    capct_eids = {}                    # part name -> [eid cham mesh nap]
    for t in range(len(tri_idx)):
        p = tri_part[t]
        if p < 0:
            continue
        if p in cap_parts:
            continue                   # bo qua chinh part nap
        if cap_near is not None and cap_near[tri_vox[t]].any():
            capct_eids.setdefault(part_names[p], []).append(int(tri_eid[t]))
        n_tri[p] += 1
        vox = tri_vox[t]
        if vis_flat[vox].any():
            n_vis[p] += 1
            vis_eids.setdefault(part_names[p], []).append(int(tri_eid[t]))
        elif contact_vox[vox].any():
            # chi tinh contact khi KHONG thay duoc (mat ap nhau bi che)
            contact_eids.setdefault(part_names[p], []).append(int(tri_eid[t]))
        reach_rank = (int(reach_rank_flat[vox].min())
                      if extra_levels and len(vox) else 255)
        if ((extra_levels and reach_rank <= len(extra_levels))
                or (not extra_levels and reach_flat[vox].any())):
            reach_eids.setdefault(part_names[p], []).append(int(tri_eid[t]))
        for rank, mm in enumerate(extra_levels):
            if reach_rank <= rank:
                reach_level_eids[mm].setdefault(part_names[p], []).append(
                    int(tri_eid[t]))
        if exposed_flat[vox].any():
            n_exp[p] += 1

    frac = np.where(n_tri > 0, n_vis / np.maximum(n_tri, 1), 0.0)
    frac_exp = np.where(n_tri > 0, n_exp / np.maximum(n_tri, 1), 0.0)
    result = {
        "bdf": os.path.abspath(args.bdf),
        "voxel": args.voxel,
        "threshold": args.threshold,
        "ndir": args.ndir,
        "close": args.close,
        "parts": [
            {
                "name": part_names[p],
                "n_elems": int(n_tri[p]),
                "visible_frac": round(float(frac[p]), 4),
                "exposed_frac": round(float(frac_exp[p]), 4),
                "class": "outside" if frac[p] >= args.threshold else "inside",
            }
            for p in range(npart)
        ],
    }
    sfx = args.suffix
    out_dir = OUTPUT_DIR or os.path.dirname(os.path.abspath(args.bdf))
    out_path = os.path.join(out_dir, f"outer_result{sfx}.json")
    with open(out_path, "w", encoding="utf-8") as fh:
        json.dump(result, fh, indent=1, ensure_ascii=False)
    eid_path = os.path.join(os.path.dirname(out_path),
                            f"outer_visible_eids{sfx}.json")
    with open(eid_path, "w", encoding="utf-8") as fh:
        json.dump(vis_eids, fh, ensure_ascii=False)
    print(f"EID thay duoc theo part -> {eid_path}")
    ct_path = os.path.join(os.path.dirname(out_path),
                           f"outer_contact_eids{sfx}.json")
    with open(ct_path, "w", encoding="utf-8") as fh:
        json.dump(contact_eids, fh, ensure_ascii=False)
    n_ct = sum(len(v) for v in contact_eids.values())
    print(f"EID tiep xuc theo part ({n_ct} elem) -> {ct_path}")
    rc_path = os.path.join(os.path.dirname(out_path),
                           f"outer_reach_eids{sfx}.json")
    with open(rc_path, "w", encoding="utf-8") as fh:
        json.dump(reach_eids, fh, ensure_ascii=False)
    n_rc = sum(len(v) for v in reach_eids.values())
    print(f"EID khi ngoai tham toi ({n_rc} elem) -> {rc_path}")
    for mm, level_eids in reach_level_eids.items():
        tag = int(mm) if mm.is_integer() else str(mm).replace(".", "p")
        level_path = os.path.join(os.path.dirname(out_path),
                                  f"outer_reach{tag}_eids{sfx}.json")
        with open(level_path, "w", encoding="utf-8") as fh:
            json.dump(level_eids, fh, ensure_ascii=False)
        print(f"EID reach snapshot {mm:g}mm -> {level_path}")
    if cap_near is not None:
        cc_path = os.path.join(os.path.dirname(out_path),
                               f"outer_capcontact_eids{sfx}.json")
        with open(cc_path, "w", encoding="utf-8") as fh:
            json.dump(capct_eids, fh, ensure_ascii=False)
        n_cc = sum(len(v) for v in capct_eids.values())
        print(f"EID cham mesh nap ({n_cc} elem) -> {cc_path}")

    n_out = sum(1 for p in result["parts"] if p["class"] == "outside")
    print("=" * 64)
    print(f"OUTSIDE: {n_out}   INSIDE: {npart - n_out}   -> {out_path}")
    print(f"{'part':<44}{'elems':>8}{'vis%':>7}{'exp%':>7}  class")
    for p in sorted(result["parts"], key=lambda x: -x["visible_frac"]):
        print(f"{p['name'][:43]:<44}{p['n_elems']:>8}{100*p['visible_frac']:>6.1f}%"
              f"{100*p['exposed_frac']:>6.1f}%  {p['class']}")
    print(f"Tong thoi gian: {time.time()-t0:.1f}s")


if __name__ == "__main__":
    main()
