"""Pure face-feature extraction for Surface Split."""
import math

from surface_split_core import dot as _dot
from surface_split_core import norm as _norm
from surface_split_core import sub as _sub

_NBIN = 24


def _eig3(cov):
    a = [row[:] for row in cov]
    v = [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
    for _ in range(30):
        p, q, mx = 0, 1, abs(a[0][1])
        if abs(a[0][2]) > mx:
            p, q, mx = 0, 2, abs(a[0][2])
        if abs(a[1][2]) > mx:
            p, q, mx = 1, 2, abs(a[1][2])
        if mx < 1e-12:
            break
        theta = 0.5 * math.atan2(2 * a[p][q], a[q][q] - a[p][p])
        c, s = math.cos(theta), math.sin(theta)
        for k in range(3):
            akp = c * a[k][p] - s * a[k][q]
            akq = s * a[k][p] + c * a[k][q]
            a[k][p], a[k][q] = akp, akq
        for k in range(3):
            akp = c * a[p][k] - s * a[q][k]
            akq = s * a[p][k] + c * a[q][k]
            a[p][k], a[q][k] = akp, akq
        for k in range(3):
            vkp = c * v[k][p] - s * v[k][q]
            vkq = s * v[k][p] + c * v[k][q]
            v[k][p], v[k][q] = vkp, vkq
    return [(v[0][i], v[1][i], v[2][i]) for i in range(3)]


def _solve3(m, b):
    a = [m[0][:] + [b[0]], m[1][:] + [b[1]], m[2][:] + [b[2]]]
    for i in range(3):
        piv = max(range(i, 3), key=lambda r: abs(a[r][i]))
        if abs(a[piv][i]) < 1e-12:
            return None
        a[i], a[piv] = a[piv], a[i]
        for r in range(3):
            if r != i:
                f = a[r][i] / a[i][i]
                for c in range(i, 4):
                    a[r][c] -= f * a[i][c]
    return [a[i][3] / a[i][i] for i in range(3)]


def _accum_elem(en, ids, enorms, einfo, nn):
    """Accumulate one element's normal/centroid into the fit buffers.

    Pure (no Jupiter access): `en` are node positions (mm), `ids` node ids.
    Kept in the SAME accumulation order as the old face_features loop so the
    resulting nn/enorms are bit-identical."""
    e1 = _sub(en[1], en[0])
    e2 = _sub(en[2], en[0])
    cx = (e1[1] * e2[2] - e1[2] * e2[1],
          e1[2] * e2[0] - e1[0] * e2[2],
          e1[0] * e2[1] - e1[1] * e2[0])
    for i in range(3):
        for j in range(3):
            nn[i][j] += cx[i] * cx[j]
    ec = (sum(p[0] for p in en) / len(en),
          sum(p[1] for p in en) / len(en),
          sum(p[2] for p in en) / len(en))
    enorms.append((cx, ec))
    einfo.append((set(ids), cx))


def face_features(face):
    """Public wrapper: read one Jupiter face, then fit. Kept for callers /
    tests. The hot path (_body_geometry) reads elements ONCE and calls
    _features_core directly."""
    pts = []
    for n in face.nodes:
        p = n.pos
        pts.append((p.x * 1000.0, p.y * 1000.0, p.z * 1000.0))
    nn = [[0.0] * 3 for _ in range(3)]
    enorms = []
    einfo = []
    for e in face.elems:
        ids = []
        en = []
        for nd in e.nodes:
            ids.append(nd.id)
            p = nd.pos
            en.append((p.x * 1000.0, p.y * 1000.0, p.z * 1000.0))
        if len(en) < 3:
            continue
        _accum_elem(en, ids, enorms, einfo, nn)
    return _features_core(pts, enorms, einfo, nn)


def _features_core(pts, enorms, einfo, nn):
    """Cylinder / ring fit from pre-read element data (no Jupiter access).

    `nn` is the summed normal-outer-product built in element order by
    _accum_elem; passing it in (instead of rebuilding) keeps the float
    accumulation bit-identical to the original face_features."""
    if len(pts) < 4:
        return None
    if len(enorms) < 1:
        return None
    geom_area = 0.5 * sum(_norm(nrm) for nrm, _ in enorms)

    # ALWAYS-PRESENT part: average normal/centroid + einfo (for the
    # coplanar/smooth checks). CAUTION: the cylinder fit below fails on
    # planar faces -- returning None here silently broke every coplanar
    # comparison involving a flat face (bug found by static test 07-11).
    nsum0 = [0.0, 0.0, 0.0]
    csum0 = [0.0, 0.0, 0.0]
    for nrm0, ec0 in enorms:
        for i in range(3):
            nsum0[i] += nrm0[i]
            csum0[i] += ec0[i]
    nl0 = _norm(nsum0)
    base = {
        "navg": ((nsum0[0] / nl0, nsum0[1] / nl0, nsum0[2] / nl0)
                 if nl0 > 1e-9 else None),
        "cavg": (csum0[0] / len(enorms), csum0[1] / len(enorms),
                 csum0[2] / len(enorms)),
        "einfo": einfo,
        "area": geom_area,
        "cv": None,            # None = cylinder fit failed (planar face...)
    }
    if len(enorms) < 3:
        return base

    def quad(v):
        return sum(nn[i][j] * v[i] * v[j] for i in range(3) for j in range(3))
    ax = min(_eig3(nn), key=quad)
    al = _norm(ax)
    if al < 1e-9:
        return base
    ax = (ax[0] / al, ax[1] / al, ax[2] / al)
    ref = (1.0, 0.0, 0.0) if abs(ax[0]) < 0.9 else (0.0, 1.0, 0.0)
    u = (ax[1] * ref[2] - ax[2] * ref[1],
         ax[2] * ref[0] - ax[0] * ref[2],
         ax[0] * ref[1] - ax[1] * ref[0])
    ul = _norm(u)
    u = (u[0] / ul, u[1] / ul, u[2] / ul)
    w = (ax[1] * u[2] - ax[2] * u[1],
         ax[2] * u[0] - ax[0] * u[2],
         ax[0] * u[1] - ax[1] * u[0])
    n = len(pts)
    xs = [_dot(p, u) for p in pts]
    ys = [_dot(p, w) for p in pts]
    ts = [_dot(p, ax) for p in pts]
    sz = [x * x + y * y for x, y in zip(xs, ys)]
    m = [[sum(x * x for x in xs), sum(x * y for x, y in zip(xs, ys)), sum(xs)],
         [sum(x * y for x, y in zip(xs, ys)), sum(y * y for y in ys), sum(ys)],
         [sum(xs), sum(ys), float(n)]]
    b = [-sum(z * x for z, x in zip(sz, xs)),
         -sum(z * y for z, y in zip(sz, ys)),
         -sum(sz)]
    sol = _solve3(m, b)
    if sol is None:
        return base
    D, E, F = sol
    cx2, cy2 = -D / 2.0, -E / 2.0
    r2 = cx2 * cx2 + cy2 * cy2 - F
    if r2 <= 0:
        return base
    radius = math.sqrt(r2)
    radial = [math.hypot(x - cx2, y - cy2) for x, y in zip(xs, ys)]
    rm = sum(radial) / n
    if rm < 1e-6:
        return base
    cv = math.sqrt(sum((r - rm) ** 2 for r in radial) / n) / rm
    hollow = min(radial) / rm          # ~1: tube/ring hollow center; ~0: solid disc
    angs = [math.atan2(y - cy2, x - cx2) for x, y in zip(xs, ys)]
    bins = set(int((a + math.pi) / (2 * math.pi) * _NBIN) % _NBIN for a in angs)
    tm = sum(ts) / n
    center = (u[0] * cx2 + w[0] * cy2 + ax[0] * tm,
              u[1] * cx2 + w[1] * cy2 + ax[1] * tm,
              u[2] * cx2 + w[2] * cy2 + ax[2] * tm)
    # average normal & centroid (used by the contact coplanarity check)
    nsum = [0.0, 0.0, 0.0]
    csum = [0.0, 0.0, 0.0]
    for nrm, ec in enorms:
        for i in range(3):
            nsum[i] += nrm[i]
            csum[i] += ec[i]
    nl = _norm(nsum)
    navg = (nsum[0] / nl, nsum[1] / nl, nsum[2] / nl) if nl > 1e-9 else None
    cavg = (csum[0] / len(enorms), csum[1] / len(enorms),
            csum[2] / len(enorms))
    n_in = 0
    tilt_sum = 0.0
    conc = [0.0, 0.0, 0.0]
    for nrm, ec in enorms:
        nl2 = _norm(nrm)
        if nl2 > 1e-12:
            un = (nrm[0] / nl2, nrm[1] / nl2, nrm[2] / nl2)
            tilt_sum += abs(_dot(un, ax))
            for i in range(3):
                conc[i] += un[i]
        rad = _sub(ec, center)
        t = _dot(rad, ax)
        rad = _sub(rad, (ax[0] * t, ax[1] * t, ax[2] * t))
        if _dot(nrm, rad) < 0:
            n_in += 1
    tilt = tilt_sum / len(enorms)      # ~0: UPRIGHT cylinder wall; ~0.7: 45-deg bevel
    nconc = _norm(conc) / len(enorms)  # ~1: elements coplanar; ~0: closed cylinder
    nsum_vec = tuple(conc)             # sum of unit normals (for group closure)
    n_nrm = len(enorms)

    # RIM metric: refit with axis = navg (average normal). For a CLOSED rim
    # (chamfer / bolt seat / flat washer ring) the radial components of the
    # normals cancel around the loop, so navg approximates the true axis.
    # (The eigen-normal axis is WRONG for shallow/flat rims -- bug 07-11.)
    ring = None
    if navg is not None:
        rr = _kasa_ring(pts, enorms, navg)
        if rr is not None:
            ring = rr
    out = {"cv": cv, "radius": radius,
           "coverage": len(bins) / float(_NBIN),
           "length": max(ts) - min(ts), "inward": n_in / float(len(enorms)),
           "axis": ax, "center": center, "bins": bins,
           "tilt": tilt, "nconc": nconc, "hollow": hollow,
           "nsum": nsum_vec, "n_nrm": n_nrm,
           "area": geom_area,
           "navg": navg, "cavg": cavg, "einfo": einfo}
    if ring:
        out["ring_bins"] = ring[0]
        out["ring_inward"] = ring[1]
        out["ring_radius"] = ring[2]
        out["ring_cv"] = ring[3]
        out["ring_center"] = ring[4]
        out["ring_hollow"] = ring[5]
    return out


def _kasa_ring(pts, enorms, ax):
    """Circle fit around axis ax: (bins, inward, radius, cv, center, hollow)
    or None."""
    ref = (1.0, 0.0, 0.0) if abs(ax[0]) < 0.9 else (0.0, 1.0, 0.0)
    u = (ax[1] * ref[2] - ax[2] * ref[1],
         ax[2] * ref[0] - ax[0] * ref[2],
         ax[0] * ref[1] - ax[1] * ref[0])
    ul = _norm(u)
    if ul < 1e-9:
        return None
    u = (u[0] / ul, u[1] / ul, u[2] / ul)
    w = (ax[1] * u[2] - ax[2] * u[1],
         ax[2] * u[0] - ax[0] * u[2],
         ax[0] * u[1] - ax[1] * u[0])
    n = len(pts)
    xs = [_dot(p, u) for p in pts]
    ys = [_dot(p, w) for p in pts]
    sz = [x * x + y * y for x, y in zip(xs, ys)]
    m = [[sum(x * x for x in xs), sum(x * y for x, y in zip(xs, ys)), sum(xs)],
         [sum(x * y for x, y in zip(xs, ys)), sum(y * y for y in ys), sum(ys)],
         [sum(xs), sum(ys), float(n)]]
    b = [-sum(z * x for z, x in zip(sz, xs)),
         -sum(z * y for z, y in zip(sz, ys)),
         -sum(sz)]
    sol = _solve3(m, b)
    if sol is None:
        return None
    D, E, F = sol
    cx, cy = -D / 2.0, -E / 2.0
    r2 = cx * cx + cy * cy - F
    if r2 <= 0:
        return None
    radial = [math.hypot(x - cx, y - cy) for x, y in zip(xs, ys)]
    rm = sum(radial) / n
    if rm < 1e-6:
        return None
    cv = math.sqrt(sum((r - rm) ** 2 for r in radial) / n) / rm
    hollow = min(radial) / rm
    angs = [math.atan2(y - cy, x - cx) for x, y in zip(xs, ys)]
    bins = set(int((a + math.pi) / (2 * math.pi) * _NBIN) % _NBIN for a in angs)
    # inward around the navg axis: ring center placed on the axis
    tm = sum(_dot(p, ax) for p in pts) / n
    center = (u[0] * cx + w[0] * cy + ax[0] * tm,
              u[1] * cx + w[1] * cy + ax[1] * tm,
              u[2] * cx + w[2] * cy + ax[2] * tm)
    n_in = 0
    for nrm, ec in enorms:
        rad = _sub(ec, center)
        t = _dot(rad, ax)
        rad = _sub(rad, (ax[0] * t, ax[1] * t, ax[2] * t))
        if _dot(nrm, rad) < 0:
            n_in += 1
    return bins, n_in / float(len(enorms)), math.sqrt(r2), cv, center, hollow



