"""
find_outer_fast.py - Ban tang toc cua find_outer.py (thuat toan GIU NGUYEN).

Chi thay phan z-buffer trong visible_from_views: ban goc lexsort ~4x so voxel
blocker MOI huong nhin (128-256 lan) — day la cho ton thoi gian nhat.
Ban nay dung z-buffer 2D dac (dense) ghi truc tiep:
  --engine numba : vong lap JIT bang numba (co san trong python cua Jupiter)
  --engine numpy : np.minimum.at tren buffer dac (khong can numba)
Ket qua PHAI trung voi ban goc (cung splat 2x2, cung nguong +0.5).

Cach chay: y het find_outer.py, them --engine:
  python find_outer_fast.py data/run/mesh.bdf --engine numba --suffix _fast
Moi tham so khac (--voxel --close --ndir --suffix ...) giu nguyen.
"""
import sys
import os
import time
import numpy as np

# PSJ chay script bang exec -> KHONG co __file__ (quy uoc da xac minh);
# khi do dung duong dan tuyet doi va bat che do PSJ (tu chay 2 cau hinh chuan)
try:
    # Normal path: the tool launches this as a subprocess (python file.py),
    # so __file__ is defined and gives the real folder on any machine.
    _DIR = os.path.dirname(os.path.abspath(__file__))
    _IN_PSJ = False
except NameError:
    # exec-inside-Jupiter fallback (not used by the tool); derive from argv,
    # never a machine-specific hardcoded path.
    _DIR = os.path.dirname(os.path.abspath(sys.argv[0])) if sys.argv and \
        sys.argv[0] else os.getcwd()
    _IN_PSJ = True

sys.path.insert(0, _DIR)
import find_outer as base  # noqa: E402

# bdf mac dinh khi khong truyen duong dan (che do PSJ / --all khong doi so)
_PSJ_BDF = os.path.join(os.path.dirname(_DIR), "data", "run", "mesh.bdf")


def _ffloat(s):
    s = s.strip()
    if not s:
        return 0.0
    try:
        return float(s)
    except ValueError:
        for i in range(len(s) - 1, 0, -1):
            if s[i] in "+-" and s[i - 1] not in "eE":
                return float(s[:i] + "e" + s[i:])
        raise


def _write_tri2eid(bdf_path, F, FE, FP, part_names):
    """Ghi map [3 node goc da sort] -> EID tetra cha (outer_tri2eid.json).

    Can cho model 3D: Jupiter tu danh so element FACET khi boc mat solid,
    KHONG trung EID tetra trong json ket qua. Node GRID thi giong nhau
    2 ben -> tool dich facet -> tetra EID qua bo 3 node goc.
    Format: {part: [n1,n2,n3,eid, n1,n2,n3,eid, ...]} (flat, F da sort)."""
    import json as _json
    if not part_names:
        raise ValueError("[BDF-PART] Cannot write outer_tri2eid.json: "
                         "no part groups were resolved from the BDF.")
    elif len(FP):
        pmin, pmax = int(np.min(FP)), int(np.max(FP))
        if pmin < 0 or pmax >= len(part_names):
            raise ValueError(f"[BDF-PART] Boundary-face part index range "
                             f"{pmin}..{pmax} is invalid for "
                             f"{len(part_names)} resolved part groups.")
    mp = {}
    flat = np.column_stack([F, FE]).tolist()
    for row, p in zip(flat, FP.tolist()):
        mp.setdefault(part_names[p], []).extend(row)
    out_dir = base.OUTPUT_DIR or os.path.dirname(os.path.abspath(bdf_path))
    out = os.path.join(out_dir, "outer_tri2eid.json")
    with open(out, "w", encoding="utf-8") as fh:
        _json.dump(mp, fh)
    print(f"      [3D] tri->eid map: {out}")


# Parse cache: run_psj parses the SAME bdf for both configs (5mm and 3mm).
# Parsing ~5M GRID + ~3M CTETRA lines takes ~30s, so the second parse is a
# pure waste. Cache the pristine parse by absolute path and return COPIES so
# neither run can mutate the other's arrays. Saves one full re-parse (~30s).
_PARSE_CACHE = {"path": None, "data": None}


def _copy_parse(data):
    node_xyz, tri_idx, tri_eid, tri_part, part_names = data
    return (node_xyz.copy(), tri_idx.copy(), tri_eid.copy(),
            tri_part.copy(), list(part_names))


# Switch: vectorized reader (v2.5). Falls back to the line-by-line reader
# automatically on any unexpected structure. Validated byte-equivalent (as a
# multiset of tris + exact node coords + part names) on the 628MB 3D model.
_USE_FAST_PARSER = True


def parse_bdf_ext(path):
    """Mo rong parse_bdf goc: them CTRIA6 (3 nut goc) va CTETRA (mesh KHOI).

    Voi CTETRA: tu boc MAT NGOAI tung part (mat tetra chi xuat hien 1 lan
    trong part = boundary), moi mat -> 1 tam giac mang EID cua tetra cha,
    de tool select dung element khi doc json. File shell thuan (chi CTRIA3)
    cho ket qua Y HET parse_bdf goc.
    """
    ap = os.path.abspath(path)
    if _PARSE_CACHE["path"] == ap and _PARSE_CACHE["data"] is not None:
        print("      [FAST] reuse parsed BDF from previous run (skip re-parse)")
        return _copy_parse(_PARSE_CACHE["data"])
    reader = _read_bdf_fast if _USE_FAST_PARSER else _read_bdf_slow
    try:
        parts = reader(path)
    except Exception as exc:
        if reader is _read_bdf_fast:
            print(f"[WARN][BDF-FAST] Fixed-column parser failed: "
                  f"{type(exc).__name__}: {exc}")
            print("[INFO][BDF-FAST] Retrying with the tolerant line-by-line "
                  "parser (supports 9-digit element-ID overflow).")
            try:
                parts = _read_bdf_slow(path)
            except Exception as slow_exc:
                print(f"[ERROR][BDF-PARSE] Tolerant parser also failed: "
                      f"{type(slow_exc).__name__}: {slow_exc}")
                print(f"[ERROR][BDF-PARSE] Input file: {ap}")
                print("[HINT][BDF-PARSE] Check the first malformed GRID / "
                      "CTRIA3 / CTRIA6 / CTETRA line reported above.")
                raise
        else:
            raise
    _print_parse_diagnostics(ap, parts)
    data = _finalize_parse(path, *parts)
    _PARSE_CACHE["path"] = ap
    _PARSE_CACHE["data"] = data
    return _copy_parse(data)


def _print_parse_diagnostics(path, parts):
    """Print parser health information without changing parsed data."""
    (node_ids, _node_xyz, tri_nodes, _tri_eid, tri_part,
     tet_nodes, _tet_eid, tet_part, part_names) = parts
    print(f"[INFO][BDF-SUMMARY] GRID={len(node_ids):,}, "
          f"CTRIA={len(tri_nodes):,}, CTETRA={len(tet_nodes):,}, "
          f"part markers={len(part_names):,}")
    if not part_names and (len(tri_nodes) or len(tet_nodes)):
        print("[ERROR][BDF-PART] No exact '$ Part :' marker was found.")
        print("[ERROR][BDF-PART] Elements therefore have no part name; "
              "the analyzer cannot create per-part JSON output.")
        print("[HINT][BDF-PART] This Jupiter/BDF export may use a different "
              "comment such as '$HMNAME', '$ Component', or PID only.")
        print(f"[HINT][BDF-PART] Inspect comment lines immediately before "
              f"the first element in: {path}")
    for card, indices in (("CTRIA", tri_part), ("CTETRA", tet_part)):
        bad = sum(1 for p in indices if p < 0 or p >= len(part_names))
        if bad:
            print(f"[ERROR][BDF-PART] {bad:,}/{len(indices):,} {card} "
                  "elements are not assigned to a valid '$ Part :' marker.")


def _parts_from_pid(tri_pid, tet_pid):
    """Create internal part groups when the BDF contains no part-name comments.

    These names are deliberately synthetic.  The Jupiter-side tool recognizes
    them and uses global EID membership instead of body.name matching.
    """
    pids = sorted(set(int(p) for p in list(tri_pid) + list(tet_pid)))
    if not pids:
        return [], [], []
    index = {pid: i for i, pid in enumerate(pids)}
    names = ["__BDF_PID_%s__" % pid for pid in pids]
    tri_part = [index[int(pid)] for pid in tri_pid]
    tet_part = [index[int(pid)] for pid in tet_pid]
    print(f"[INFO][BDF-PART] No '$ Part :' names; using {len(names)} "
          "internal PID group(s): " + ", ".join(str(p) for p in pids[:12]))
    if len(pids) > 12:
        print(f"[INFO][BDF-PART] ... plus {len(pids) - 12} more PID groups.")
    if pids == [0]:
        print("[WARN][BDF-PART] PID is blank/unavailable; treating the BDF "
              "as one anonymous mesh group.")
    print("[INFO][BDF-PART] Jupiter mapping will use Element/Node IDs, not "
          "part names.")
    return names, tri_part, tet_part


def _resolve_part_groups(part_names, tri_part, tet_part, tri_pid, tet_pid):
    """Keep named blocks; assign elements before the first marker by PID."""
    if not part_names:
        return _parts_from_pid(tri_pid, tet_pid)
    names = list(part_names)
    groups = {}
    resolved = []
    recovered = 0
    for indices, pids in ((tri_part, tri_pid), (tet_part, tet_pid)):
        output = []
        for part, pid in zip(indices, pids):
            part = int(part)
            if part < 0 or part >= len(part_names):
                pid = int(pid)
                if pid not in groups:
                    name = "__BDF_PID_%s__" % pid
                    while name in names:
                        name += "_"
                    groups[pid] = len(names)
                    names.append(name)
                part = groups[pid]
                recovered += 1
            output.append(part)
        resolved.append(output)
    if recovered:
        print(f"[WARN][BDF-PART] {recovered:,} elements without a valid "
              "'$ Part :' marker assigned to internal PID groups. "
              "Jupiter mapping for these groups uses Element/Node IDs.")
    return names, resolved[0], resolved[1]


def _read_bdf_slow(path):
    """Original line-by-line reader. Returns the raw per-kind buffers."""
    node_ids, node_xyz = [], []
    tri_nodes, tri_eid, tri_part = [], [], []
    tet_nodes, tet_eid, tet_part = [], [], []
    tri_pid, tet_pid = [], []
    part_names = []
    cur_part = -1

    overflow_reported = [False]

    def element_fields(line, node_count, line_no):
        """Read a normal small-field card, with a safe overflow fallback.

        Some Jupiter exports write a 9-digit element ID into the nominal
        8-character EID field.  That shifts the remaining fixed columns and
        can leave the slices below empty.  In that exporter variant the node
        IDs are still whitespace-separated at the right end of the card, so
        recover EID from the first token and nodes from the final tokens.
        """
        try:
            eid = int(line[8:16])
            pid_text = line[16:24].strip()
            pid = int(pid_text) if pid_text else 0
            nodes = tuple(int(line[24 + 8 * i:32 + 8 * i])
                          for i in range(node_count))
            return eid, pid, nodes
        except ValueError:
            fields = line.split()
            if len(fields) < node_count + 2:
                print(f"[ERROR][BDF-FORMAT] Line {line_no}: cannot read "
                      f"{line[:80].rstrip()!r}")
                raise
            if not overflow_reported[0]:
                overflow_reported[0] = True
                print(f"[INFO][BDF-FORMAT] Line {line_no}: recovered a "
                      "non-standard/overflow element card using whitespace "
                      "tokens. Further recoveries are not printed.")
            pid = int(fields[-node_count - 1]) \
                if len(fields) >= node_count + 3 else 0
            return int(fields[1]), pid, tuple(map(int, fields[-node_count:]))

    with open(path, "r", errors="ignore") as fh:
        for line_no, line in enumerate(fh, 1):
            if line.startswith("GRID"):
                node_ids.append(int(line[8:16]))
                node_xyz.append((_ffloat(line[24:32]),
                                 _ffloat(line[32:40]),
                                 _ffloat(line[40:48])))
            elif line.startswith("CTRIA3"):
                eid, pid, nodes = element_fields(line, 3, line_no)
                tri_eid.append(eid)
                tri_nodes.append(nodes)
                tri_part.append(cur_part)
                tri_pid.append(pid)
            elif line.startswith("CTRIA6"):
                eid, pid, nodes = element_fields(line, 3, line_no)
                tri_eid.append(eid)
                tri_nodes.append(nodes)
                tri_part.append(cur_part)
                tri_pid.append(pid)
            elif line.startswith("CTETRA"):
                eid, pid, nodes = element_fields(line, 4, line_no)
                tet_eid.append(eid)
                tet_nodes.append(nodes)
                tet_part.append(cur_part)
                tet_pid.append(pid)
            elif line.startswith("$ Part :"):
                part_names.append(line[8:].strip())
                cur_part = len(part_names) - 1
    part_names, tri_part, tet_part = _resolve_part_groups(
        part_names, tri_part, tet_part, tri_pid, tet_pid)
    return (node_ids, node_xyz, tri_nodes, tri_eid, tri_part,
            tet_nodes, tet_eid, tet_part, part_names)


def _read_bdf_fast(path):
    """Vectorized reader: one fixed-width uint8 matrix, numpy column slicing.

    NASTRAN data lines (GRID/CTRIA/CTETRA) fit in the first 56 columns, so the
    whole file is viewed as an (n, 56) uint8 matrix in one C-level op and every
    field is extracted with vectorized slicing. Float parsing keeps _ffloat
    semantics: numpy astype on the fast path (bit-identical to Python float for
    standard formats), exact per-element _ffloat only if a NASTRAN
    exponent-without-E value is present. Part names are read from the FULL
    (untruncated) lines so long names are never cut."""
    import locale
    enc = locale.getpreferredencoding(False)
    with open(path, "rb") as fh:
        raw = fh.read()
    lines = raw.split(b"\n")
    n = len(lines)
    M = np.array(lines, dtype="|S56").view(np.uint8).reshape(n, 56)

    def pref(s):
        b = np.frombuffer(s, np.uint8)
        return (M[:, :b.size] == b).all(axis=1)

    is_grid = pref(b"GRID")
    is_t3 = pref(b"CTRIA3")
    is_t6 = pref(b"CTRIA6")
    is_tet = pref(b"CTETRA")
    is_part = pref(b"$ Part :")

    def col_str(mask, a, b):
        sub = np.ascontiguousarray(M[mask, a:b])
        return np.char.strip(sub.view("|S%d" % (b - a)).ravel())

    def to_int(mask, a, b):
        return col_str(mask, a, b).astype(np.int64)

    def to_optional_int(mask, a, b):
        s = col_str(mask, a, b)
        s = np.where(s == b"", b"0", s)
        return s.astype(np.int64)

    def to_float(mask, a, b):
        s = col_str(mask, a, b)
        s = np.where(s == b"", b"0", s)      # empty field -> 0.0 (like _ffloat)
        try:
            return s.astype(np.float64)
        except (ValueError, TypeError):
            return np.array([_ffloat(x.decode("latin1")) for x in s],
                            dtype=np.float64)

    node_ids = to_int(is_grid, 8, 16)
    node_xyz = np.column_stack([to_float(is_grid, 24, 32),
                                to_float(is_grid, 32, 40),
                                to_float(is_grid, 40, 48)])

    part_pos = np.nonzero(is_part)[0]
    part_names = [lines[i].rstrip(b"\r")[8:].decode(enc, "ignore").strip()
                  for i in part_pos]

    def cur_part_of(mask):
        idx = np.nonzero(mask)[0]
        return np.searchsorted(part_pos, idx, side="right") - 1

    tri_nodes_l, tri_eid_l, tri_part_l, tri_pid_l = [], [], [], []
    for m in (is_t3, is_t6):
        if not m.any():
            continue
        tri_eid_l.append(to_int(m, 8, 16))
        tri_nodes_l.append(np.column_stack([to_int(m, 24, 32),
                                            to_int(m, 32, 40),
                                            to_int(m, 40, 48)]))
        tri_part_l.append(cur_part_of(m))
        tri_pid_l.append(to_optional_int(m, 16, 24))
    tri_eid = (np.concatenate(tri_eid_l) if tri_eid_l
               else np.zeros(0, np.int64))
    tri_nodes = (np.vstack(tri_nodes_l) if tri_nodes_l
                 else np.zeros((0, 3), np.int64))
    tri_part = (np.concatenate(tri_part_l) if tri_part_l
                else np.zeros(0, np.int64))
    tri_pid = (np.concatenate(tri_pid_l) if tri_pid_l
               else np.zeros(0, np.int64))

    if is_tet.any():
        tet_nodes = np.column_stack([to_int(is_tet, 24, 32),
                                     to_int(is_tet, 32, 40),
                                     to_int(is_tet, 40, 48),
                                     to_int(is_tet, 48, 56)])
        tet_eid = to_int(is_tet, 8, 16)
        tet_part = cur_part_of(is_tet)
        tet_pid = to_optional_int(is_tet, 16, 24)
    else:
        tet_nodes = np.zeros((0, 4), np.int64)
        tet_eid = np.zeros(0, np.int64)
        tet_part = np.zeros(0, np.int64)
        tet_pid = np.zeros(0, np.int64)

    if not part_names or (tri_part < 0).any() or (tet_part < 0).any():
        part_names, tri_part, tet_part = _resolve_part_groups(
            part_names, tri_part, tet_part, tri_pid, tet_pid)
        tri_part = np.asarray(tri_part, dtype=np.int64)
        tet_part = np.asarray(tet_part, dtype=np.int64)

    return (node_ids, node_xyz, tri_nodes, tri_eid, tri_part,
            tet_nodes, tet_eid, tet_part, part_names)


def _finalize_parse(path, node_ids, node_xyz, tri_nodes, tri_eid, tri_part,
                    tet_nodes, tet_eid, tet_part, part_names):
    """Shared tail: peel tetra boundary faces, append, remap node ids.
    Identical numpy logic for both readers."""
    node_ids = np.asarray(node_ids, dtype=np.int64)
    node_xyz = np.asarray(node_xyz, dtype=np.float64).reshape(-1, 3)
    tri_nodes = (np.asarray(tri_nodes, dtype=np.int64).reshape(-1, 3)
                 if len(tri_nodes) else np.zeros((0, 3), np.int64))
    tri_eid = np.asarray(tri_eid, dtype=np.int64)
    tri_part = np.asarray(tri_part, dtype=np.int32)

    if len(tet_nodes):
        print(f"      [3D] {len(tet_nodes)} CTETRA -> boc mat ngoai tung "
              "part...")
        t0 = time.time()
        tet = np.asarray(tet_nodes, dtype=np.int64).reshape(-1, 4)
        te = np.asarray(tet_eid, dtype=np.int64)
        tp = np.asarray(tet_part, dtype=np.int64)
        F = np.concatenate([tet[:, (0, 1, 2)], tet[:, (0, 1, 3)],
                            tet[:, (0, 2, 3)], tet[:, (1, 2, 3)]])
        FE = np.concatenate([te, te, te, te])
        FP = np.concatenate([tp, tp, tp, tp])
        F = np.sort(F, axis=1)
        key = np.column_stack([FP, F])
        _, inv, cnt = np.unique(key, axis=0,
                                return_inverse=True, return_counts=True)
        keep = cnt[inv] == 1     # mat chi xuat hien 1 lan trong part = bien
        F, FE, FP = F[keep], FE[keep], FP[keep]
        print(f"      [3D] {len(F)} mat bien ({time.time()-t0:.1f}s)")
        _write_tri2eid(path, F, FE, FP, part_names)
        tri_nodes = np.vstack([tri_nodes, F]) if len(tri_nodes) else F
        tri_eid = np.concatenate([tri_eid, FE])
        tri_part = np.concatenate([tri_part, FP.astype(np.int32)])

    if len(tri_nodes) == 0:
        print(f"[ERROR][BDF-ELEMENT] No supported surface could be built "
              f"from: {os.path.abspath(path)}")
        print("[HINT][BDF-ELEMENT] Supported cards are CTRIA3, CTRIA6 and "
              "CTETRA. Check card names and export format.")
        sys.exit("[ERR] bdf khong co CTRIA3/CTRIA6/CTETRA nao doc duoc.")

    if len(node_ids) == 0:
        print("[ERROR][BDF-NODE] No GRID cards were read. The next node-remap "
              "step cannot continue.")
        print(f"[HINT][BDF-NODE] Check GRID formatting in: "
              f"{os.path.abspath(path)}")
    remap = np.full(node_ids.max() + 1, -1, dtype=np.int64)
    remap[node_ids] = np.arange(len(node_ids))
    tri_idx = remap[tri_nodes]
    if (tri_idx < 0).any():
        bad = int((tri_idx < 0).any(axis=1).sum())
        sample = np.unique(tri_nodes[tri_idx < 0])[:10].tolist()
        print(f"[WARN][BDF-NODE] {bad:,} triangles reference missing GRID "
              "IDs and will be skipped.")
        print(f"[WARN][BDF-NODE] Missing GRID sample: {sample}")
        ok = (tri_idx >= 0).all(axis=1)
        tri_idx = tri_idx[ok]
        tri_eid = tri_eid[ok]
        tri_part = tri_part[ok]
    return node_xyz, tri_idx, tri_eid, tri_part, part_names


# thay parser goc bang ban mo rong (shell thuan cho ket qua y het)
base.parse_bdf = parse_bdf_ext

# ----------------------------------------------------------------------
# engine numba: JIT vong lap ghi z-buffer + so sanh
# ----------------------------------------------------------------------
try:
    import numba

    # cache=True chi hoat dong khi chay tu file that; trong PSJ (exec tu
    # string) numba khong cache duoc -> dinh nghia khong cache, chap nhan
    # JIT lai vai giay moi lan chay
    _NJIT = numba.njit(cache=not _IN_PSJ)

    @_NJIT
    def _zbuf_fill_numba(bu, bv, depth_b, Wu, Wv):
        zbuf = np.full(Wu * Wv, np.inf, dtype=np.float64)
        for i in range(bu.shape[0]):
            for du in range(2):
                for dv in range(2):
                    k = (bu[i] + du) * Wv + (bv[i] + dv)
                    if depth_b[i] < zbuf[k]:
                        zbuf[k] = depth_b[i]
        return zbuf

    @_NJIT
    def _vis_check_numba(cu, cv, depth, zbuf, Wv, visible):
        for i in range(cu.shape[0]):
            if depth[i] <= zbuf[cu[i] * Wv + cv[i]] + 0.5:
                visible[i] = True

    @numba.njit(parallel=True, cache=not _IN_PSJ)
    def _visible_all_dirs_parallel(pts, pts_b, dirs, visible):
        """Moi huong nhin 1 iteration prange (z-buffer rieng tung thread).

        visible la uint8; chi ghi hang so 1 (khong doc-sua-ghi) nen race
        giua cac huong cung danh dau 1 voxel la vo hai.
        """
        m = pts.shape[0]
        mb = pts_b.shape[0]
        for k in numba.prange(dirs.shape[0]):
            d0 = dirs[k, 0]
            d1 = dirs[k, 1]
            d2 = dirs[k, 2]
            if abs(d0) < 0.9:
                a0, a1, a2 = 1.0, 0.0, 0.0
            else:
                a0, a1, a2 = 0.0, 1.0, 0.0
            # u = cross(d, a) chuan hoa; v = cross(d, u)  (y het ban goc)
            u0 = d1 * a2 - d2 * a1
            u1 = d2 * a0 - d0 * a2
            u2 = d0 * a1 - d1 * a0
            un = (u0 * u0 + u1 * u1 + u2 * u2) ** 0.5
            u0 /= un
            u1 /= un
            u2 /= un
            v0 = d1 * u2 - d2 * u1
            v1 = d2 * u0 - d0 * u2
            v2 = d0 * u1 - d1 * u0

            # quet min/max hinh chieu de dat offset/width nhu ban tuan tu
            pu_min = 1e30
            pu_max = -1e30
            pv_min = 1e30
            pv_max = -1e30
            for i in range(m):
                x = pts[i, 0] * u0 + pts[i, 1] * u1 + pts[i, 2] * u2
                y = pts[i, 0] * v0 + pts[i, 1] * v1 + pts[i, 2] * v2
                if x < pu_min:
                    pu_min = x
                if x > pu_max:
                    pu_max = x
                if y < pv_min:
                    pv_min = y
                if y > pv_max:
                    pv_max = y
            for i in range(mb):
                x = pts_b[i, 0] * u0 + pts_b[i, 1] * u1 + pts_b[i, 2] * u2 - 0.5
                y = pts_b[i, 0] * v0 + pts_b[i, 1] * v1 + pts_b[i, 2] * v2 - 0.5
                if x < pu_min:
                    pu_min = x
                if x > pu_max:
                    pu_max = x
                if y < pv_min:
                    pv_min = y
                if y > pv_max:
                    pv_max = y
            offu = int(np.floor(pu_min)) - 1
            offv = int(np.floor(pv_min)) - 1
            Wu = int(np.floor(pu_max)) - offu + 3
            Wv = int(np.floor(pv_max)) - offv + 3

            zbuf = np.full(Wu * Wv, np.inf, dtype=np.float64)
            for i in range(mb):
                dep = pts_b[i, 0] * d0 + pts_b[i, 1] * d1 + pts_b[i, 2] * d2
                x = pts_b[i, 0] * u0 + pts_b[i, 1] * u1 + pts_b[i, 2] * u2 - 0.5
                y = pts_b[i, 0] * v0 + pts_b[i, 1] * v1 + pts_b[i, 2] * v2 - 0.5
                bu = int(np.floor(x)) - offu
                bv = int(np.floor(y)) - offv
                for du in range(2):
                    for dv in range(2):
                        kk = (bu + du) * Wv + (bv + dv)
                        if dep < zbuf[kk]:
                            zbuf[kk] = dep
            for i in range(m):
                dep = pts[i, 0] * d0 + pts[i, 1] * d1 + pts[i, 2] * d2
                x = pts[i, 0] * u0 + pts[i, 1] * u1 + pts[i, 2] * u2
                y = pts[i, 0] * v0 + pts[i, 1] * v1 + pts[i, 2] * v2
                cu = int(np.floor(x)) - offu
                cv = int(np.floor(y)) - offv
                if dep <= zbuf[cu * Wv + cv] + 0.5:
                    visible[i] = 1

    _HAS_NUMBA = True
except Exception as _exc:  # pragma: no cover
    _HAS_NUMBA = False
    _NUMBA_ERR = _exc


def _zbuf_fill_numpy(bu, bv, depth_b, Wu, Wv):
    zbuf = np.full(Wu * Wv, np.inf, dtype=np.float64)
    for du in (0, 1):
        for dv in (0, 1):
            np.minimum.at(zbuf, (bu + du) * Wv + (bv + dv), depth_b)
    return zbuf


def make_visible_from_views(engine):
    def visible_from_views(occ, occ_block, voxel, ndir):
        idx = np.argwhere(occ)
        pts = idx.astype(np.float64) + 0.5
        idx_b = np.argwhere(occ_block)
        pts_b = idx_b.astype(np.float64) + 0.5
        m = len(pts)
        dims = occ.shape

        if engine == "parallel":
            vis8 = np.zeros(m, dtype=np.uint8)
            _visible_all_dirs_parallel(pts, pts_b,
                                       base.fibonacci_dirs(ndir), vis8)
            visible = vis8.astype(bool)
            vis_flat = np.zeros(dims[0] * dims[1] * dims[2], dtype=bool)
            flat_idx = (idx[:, 0] * dims[1] + idx[:, 1]) * dims[2] + idx[:, 2]
            vis_flat[flat_idx[visible]] = True
            return vis_flat

        visible = np.zeros(m, dtype=bool)
        t0 = time.time()
        for k, d in enumerate(base.fibonacci_dirs(ndir)):
            a = (np.array([1.0, 0.0, 0.0]) if abs(d[0]) < 0.9
                 else np.array([0.0, 1.0, 0.0]))
            u = np.cross(d, a)
            u /= np.linalg.norm(u)
            v = np.cross(d, u)
            depth = pts @ d
            pu = pts @ u
            pv = pts @ v
            depth_b = pts_b @ d
            pbu = pts_b @ u - 0.5
            pbv = pts_b @ v - 0.5

            # offset/width theo min-max THAT cua tung huong chieu — buffer
            # dac phu tron ca candidate lan blocker (splat +1), khong rot
            # blocker ngoai ria nhu offset span co dinh
            offu = int(np.floor(min(pu.min(), pbu.min()))) - 1
            offv = int(np.floor(min(pv.min(), pbv.min()))) - 1
            Wu = int(np.floor(max(pu.max(), pbu.max()))) - offu + 3
            Wv = int(np.floor(max(pv.max(), pbv.max()))) - offv + 3
            cu = np.floor(pu).astype(np.int64) - offu
            cv = np.floor(pv).astype(np.int64) - offv
            bu = np.floor(pbu).astype(np.int64) - offu
            bv = np.floor(pbv).astype(np.int64) - offv

            if engine == "numba":
                zbuf = _zbuf_fill_numba(bu, bv, depth_b, Wu, Wv)
                _vis_check_numba(cu, cv, depth, zbuf, Wv, visible)
            else:
                zbuf = _zbuf_fill_numpy(bu, bv, depth_b, Wu, Wv)
                visible |= depth <= zbuf[cu * Wv + cv] + 0.5
            if time.time() - t0 > 5:
                print(f"  view {k+1}/{ndir}...")
                t0 = time.time()

        vis_flat = np.zeros(dims[0] * dims[1] * dims[2], dtype=bool)
        flat_idx = (idx[:, 0] * dims[1] + idx[:, 1]) * dims[2] + idx[:, 2]
        vis_flat[flat_idx[visible]] = True
        return vis_flat

    return visible_from_views


def _resolve_engine(engine):
    if engine in ("numba", "parallel") and not _HAS_NUMBA:
        print(f"[WARN] numba khong kha dung ({_NUMBA_ERR}) -> dung numpy")
        return "numpy"
    return engine


def run_psj(engine="parallel", bdf=None, outdir=None):
    """Chay ca 2 cau hinh chuan da kiem chung (PSJ mode / --all).

    bdf: duong dan mesh.bdf.
    outdir: thu muc ghi ket qua (mac dinh = thu muc chua bdf). Dung folder
    rieng tung model de tool lam viec voi nhieu model khac nhau.
    """
    bdf = bdf or _PSJ_BDF
    extra = ["--outdir", outdir] if outdir else []
    runs = [
        ("part-level 5mm/close30 vis-only",
         [bdf, "--vis-only"] + extra),
        ("face-level 3mm/close120 -> _split",
         [bdf, "--voxel", "3", "--close", "120", "--suffix", "_split",
          "--reach-levels", "10,20,40"] + extra),
    ]
    engine = _resolve_engine(engine)
    print(f"[FAST] engine = {engine} ({len(runs)} cau hinh), bdf = {bdf}")
    if outdir:
        print(f"[FAST] outdir = {outdir}")
    base.visible_from_views = make_visible_from_views(engine)
    for label, argv in runs:
        print(f"[FAST] ==== {label} ====")
        sys.argv = ["find_outer_fast"] + list(argv)
        try:
            base.main()
        except SystemExit as exc:
            print(f"[FAST] run '{label}' thoat voi ma {exc.code}")
    _write_index(bdf, outdir)
    print("[FAST] ALL DONE.")


def _write_index(bdf, outdir=None):
    """Ghi file chi muc MANG TEN BDF (<ten>.outer_index.json) canh bo ket qua.

    Day la file duy nhat user can chon trong o "JSON" cua tool — tool doc
    thu muc chua no. Noi dung liet ke bo file de kiem tra du/thieu."""
    import json as _json
    import time as _time
    d = outdir or os.path.dirname(os.path.abspath(bdf))
    stem = os.path.splitext(os.path.basename(bdf))[0]
    files = ["outer_visible_eids.json"]
    files.extend(f"outer_{k}_split.json"
                 for k in ("result", "visible_eids", "contact_eids",
                           "reach_eids"))
    files.extend(["outer_reach10_eids_split.json",
                  "outer_reach20_eids_split.json"])
    files.append("outer_tri2eid.json")  # chi co o model 3D (tetra)
    idx = {
        "bdf": os.path.basename(bdf),
        "created": _time.strftime("%Y-%m-%d %H:%M:%S"),
        "files": {fn: os.path.isfile(os.path.join(d, fn)) for fn in files},
    }
    path = os.path.join(d, f"{stem}.outer_index.json")
    with open(path, "w", encoding="utf-8") as fh:
        _json.dump(idx, fh, indent=1, ensure_ascii=False)
    print(f"[FAST] index -> {path}")


def main():
    engine = "parallel"
    argv = sys.argv[1:]
    if "--engine" in argv:
        i = argv.index("--engine")
        engine = argv[i + 1]
        del argv[i:i + 2]
    if engine not in ("numba", "numpy", "parallel"):
        sys.exit(f"--engine phai la numba|numpy|parallel, khong phai {engine!r}")
    if "--all" in argv:
        argv.remove("--all")
        outdir = None
        if "--outdir" in argv:
            i = argv.index("--outdir")
            outdir = argv[i + 1]
            del argv[i:i + 2]
        pos = [a for a in argv if not a.startswith("--")]
        run_psj(engine, bdf=pos[0] if pos else None, outdir=outdir)
        return
    engine = _resolve_engine(engine)
    print(f"[FAST] engine = {engine}")

    base.visible_from_views = make_visible_from_views(engine)
    sys.argv = [sys.argv[0]] + argv
    base.main()


if __name__ == "__main__":
    if _IN_PSJ:
        run_psj()
    else:
        main()
