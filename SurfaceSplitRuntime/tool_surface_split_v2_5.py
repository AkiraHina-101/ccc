"""
tool_surface_split_v2_5.py - v2.5 analyzer with 9-digit BDF element-ID support.

Same classification logic/caches and grid dialog as v2.4.1 (frozen). This
version pairs with the faster find_outer_fast analyzer (parse-once cache +
vectorized BDF reader, both validated byte-equivalent) - analyze wall time
dropped from ~109s to ~71s on the 628MB 3D model with identical JSON output.

tool_surface_split_v2_4.py - Cached full-model OUTER / INNER / HOLE / CONTACT

Final architecture (agreed with user, 2026-07-10..12):
  1. HOLE detection by geometry: cylinder fit from element normals
     + Kasa circle fit; 4 single-face tiers + coaxial fragment grouping.
     The decisive fragment-group test is "CLOSED WHEN JOINED"
     (|sum of unit normals| / count <= 0.45). Rules tuned with
     hole_trainer.py against user-labeled ground truth (~99%).
     Faces saved manually in hole_samples.json ("hole" section) are holes too.
  2. Closed TILTED rims (chamfers / bolt seats): NOT hole, NOT contact
     -> ordinary faces (banned from both gates).
  3. CONTACT = core (100% of the face's nodes are shared nodes -- user's
     definition of a shared face) + full-face pressed (interior contact
     ratio) + proximity candidates in clusters touching core/pressed
     + coplanar faces directly adjacent to core.
  4. OUTER = free region-grow from visible seeds; barriers = HOLE + CONTACT;
     island fill only for islands adjacent to grown outer;
     invariant: outer is ONE connected component.
  5. INNER = a continuous region grown from the main interior component,
     stopping only at OUTER. HOLE and CONTACT may also be INNER when this
     grow reaches them; isolated HOLE/CONTACT clusters remain non-INNER.

Requires: outer_visible_eids_split.json + outer_reach_eids_split.json
(find_outer.py --suffix _split), outer_visible_eids.json (close-30 run).
Shared faces/nodes (used to decide CONTACT) are read directly from the
open Jupiter model through JPT.GetSharedFaces/GetSharedNodes -- no JSON
dependency for CONTACT anymore. outer_contact_eids_split.json and
hole_samples.json are both optional (diagnostics only).

Buttons: Run Analyzer, Load JSON, Classify All, Select OUTER / INNER / HOLE /
CONTACT, Debug, offline Help (English / Vietnamese).
Selecting a part and pressing any Select button classifies automatically.
"""
from pyjdg import *
import os
import sys
import json
import math

# ============ PORTABLE INSTALL LOCATION (no machine-specific paths) ==========
# Jupiter runs this script with exec(): there is no __file__, sys.executable is
# the GUI exe (not python.exe), and neither cwd nor sys.path point at the repo
# (verified by probe). So the install folder is resolved in this order:
#   1. env var OUTER_EXTRACT_ROOT
#   2. cached file  ~/.outer_extract_root
#   3. __file__ / cwd / sys.path search (works when run outside Jupiter)
#   4. LEARNED from the first BDF the user browses (models ship inside the
#      repo, so walking up from the BDF finds the marker), then cached.
# The analyzer's python.exe sits next to the running Jupiter exe, so it is
# derived from sys.executable and works for any Jupiter version/install.
_MARKER = os.path.join("src", "find_outer_fast.py")
_ROOT_CFG = os.path.join(os.path.expanduser("~"), ".outer_extract_root")


def _is_root(d):
    return bool(d) and os.path.isfile(os.path.join(d, _MARKER))


def _walk_up_for_root(start):
    """Return the repo root at or above `start`, else ''."""
    try:
        d = os.path.abspath(start)
    except Exception:
        return ""
    if os.path.isfile(d):
        d = os.path.dirname(d)
    seen = set()
    for _ in range(8):
        if not d or d in seen:
            break
        seen.add(d)
        if _is_root(d):
            return d
        parent = os.path.dirname(d)
        if parent == d:
            break
        d = parent
    return ""


def _resolve_root():
    env = os.environ.get("OUTER_EXTRACT_ROOT", "").strip().strip('"')
    if _is_root(env):
        return os.path.abspath(env)
    try:
        if os.path.isfile(_ROOT_CFG):
            with open(_ROOT_CFG, "r", encoding="utf-8") as fh:
                d = fh.read().strip()
            if _is_root(d):
                return os.path.abspath(d)
    except Exception:
        pass
    try:
        d = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        if _is_root(d):
            return d
    except NameError:
        pass
    for base in [os.getcwd()] + [p for p in sys.path if p]:
        d = _walk_up_for_root(base)
        if d:
            return d
    return ""


def _cache_root(d):
    try:
        with open(_ROOT_CFG, "w", encoding="utf-8") as fh:
            fh.write(d)
    except Exception:
        pass


def _set_root(d):
    """(Re)bind every install-relative path to root `d`."""
    global _DIR, _RUN_DIR, _BDF_CFG, _JSON_CFG, _HELP_PATH, _HELP_EN_PATH
    global _HELP_VI_PATH, _SAMPLES
    global _ANALYZER_FAST, _ANALYZER_UI_WATCHER, _CLASS_COLOR_CFG
    _DIR = d or os.getcwd()
    _RUN_DIR = os.path.join(_DIR, "data", "run")
    _BDF_CFG = os.path.join(_RUN_DIR, "last_bdf.txt")
    _JSON_CFG = os.path.join(_RUN_DIR, "last_json.txt")
    _CLASS_COLOR_CFG = os.path.join(_RUN_DIR, "classification_colors.json")
    # Development layout keeps Help under docs/; a flat release keeps the
    # self-contained pages beside the tool.  Support both layouts.
    _docs_dir = os.path.join(_DIR, "docs")
    if not os.path.isdir(_docs_dir):
        _docs_dir = _DIR
    _HELP_PATH = os.path.join(_docs_dir, "SURFACE_SPLIT_HELP_AND_HISTORY.md")
    _HELP_EN_PATH = os.path.join(_docs_dir, "help_en.html")
    _HELP_VI_PATH = os.path.join(_docs_dir, "help_vi.html")
    _SAMPLES = os.path.join(_DIR, "data", "labels", "hole_samples.json")
    _ANALYZER_FAST = os.path.join(_DIR, "src", "find_outer_fast.py")
    _ANALYZER_UI_WATCHER = os.path.join(
        _DIR, "src", "analyzer_ui_watcher.py")


def _learn_root_from(path):
    """When the install is not yet known, try to discover it from a browsed
    file (a BDF/JSON living inside the repo) and cache it for next time."""
    if _is_root(_DIR):
        return
    d = _walk_up_for_root(path)
    if d:
        _set_root(d)
        _cache_root(d)
        print(f"[V2.4] Located install folder from path: {d}")


# python.exe ships next to the running Jupiter executable.
_ANALYZER_PY = os.path.join(os.path.dirname(os.path.abspath(sys.executable)),
                            "python.exe")

_set_root(_resolve_root())
if not _is_root(_DIR):
    print("[V2.4] Install folder not auto-detected yet. Browse a BDF inside "
          "the package to locate it, or set the OUTER_EXTRACT_ROOT env var / "
          f"write the path into {_ROOT_CFG}.")

# Pure decisions live outside the Jupiter/UI layer.  Keep the public helper
# names below as compatibility wrappers for existing tests and scripts.
_CORE_DIR = os.path.join(_DIR, "src")
if _CORE_DIR not in sys.path:
    sys.path.insert(0, _CORE_DIR)
import surface_split_core as _core
import surface_split_data as _data
import surface_split_geometry as _geometry
import surface_split_classifier as _classifier
import surface_split_analyzer as _analyzer
import importlib as _importlib

# Jupiter executes this tool repeatedly in one long-lived Python process.
# Reload local modules so reopening the dialog never reuses an older module
# object left in sys.modules after a runtime update.
for _module in (_core, _data, _geometry, _classifier, _analyzer):
    _importlib.reload(_module)


def _get_json(dlg=None):
    """Return the explicitly selected JSON file (absolute priority).

    Any file in the result set identifies the containing dataset folder."""
    if dlg is not None:
        try:
            p = dlg.get_item_text("TbJson").strip().strip('"')
            # An empty field explicitly clears the saved JSON choice.
            return p if (p and os.path.isfile(p)) else ""
        except Exception:
            pass
    try:
        with open(_JSON_CFG, "r", encoding="utf-8") as fh:
            p = fh.read().strip()
        if p and os.path.isfile(p):
            return p
    except Exception:
        pass
    return ""


def _save_json(path):
    try:
        with open(_JSON_CFG, "w", encoding="utf-8") as fh:
            fh.write(path)
    except Exception:
        pass


def _get_bdf(dlg=None):
    """Return dialog BDF path, then saved path, or an empty string."""
    if dlg is not None:
        try:
            p = dlg.get_item_text("TbBdf").strip().strip('"')
            if p and os.path.isfile(p):
                return p
        except Exception:
            pass
    try:
        with open(_BDF_CFG, "r", encoding="utf-8") as fh:
            p = fh.read().strip()
        if p and os.path.isfile(p):
            return p
    except Exception:
        pass
    return ""


def _save_bdf(path):
    try:
        with open(_BDF_CFG, "w", encoding="utf-8") as fh:
            fh.write(path)
    except Exception:
        pass


def _model_run_dir(verbose=False, dlg=None):
    """Resolve dataset folder: JSON field, BDF folder, document, legacy."""
    js = _get_json(dlg)
    if js:
        d = os.path.dirname(os.path.abspath(js))
        if verbose:
            print(f"[V2] Data folder theo o JSON (uu tien tuyet doi): {d}")
        return d
    bdf = _get_bdf(dlg)
    if bdf:
        d = os.path.dirname(os.path.abspath(bdf))
        if verbose:
            print(f"[V2] Data folder theo BDF: {d}")
        return d
    key = ""
    try:
        p = JPT.GetCurrentDocumentPath()
        key = os.path.splitext(os.path.basename(p))[0]
        key = "".join(c if (c.isalnum() or c in "-_.") else "_" for c in key)
    except Exception:
        pass
    if key:
        d = os.path.join(_RUN_DIR, key)
        if os.path.isfile(os.path.join(d, "outer_visible_eids_split.json")):
            if verbose:
                print(f"[V2] Data folder theo model: data/run/{key}/")
            return d
        if verbose:
            print(f"[V2.4] WARNING: no dedicated dataset for '{key}'; "
                  "using legacy data/run, which may belong to another model. "
                  "Select a BDF and run the analyzer to create a safe dataset.")
    return _RUN_DIR


def _json_paths(verbose=False, dlg=None):
    d = _model_run_dir(verbose, dlg)
    return {
        "vis": os.path.join(d, "outer_visible_eids_split.json"),
        "ct": os.path.join(d, "outer_contact_eids_split.json"),
        "rc": os.path.join(d, "outer_reach_eids_split.json"),
        "rc10": os.path.join(d, "outer_reach10_eids_split.json"),
        "rc20": os.path.join(d, "outer_reach20_eids_split.json"),
        "vis30": os.path.join(d, "outer_visible_eids.json"),
        "t2e": os.path.join(d, "outer_tri2eid.json"),
    }
    # vis30 is close-30 open visibility used as island evidence.


# (_SAMPLES / _ANALYZER_FAST / _ANALYZER_PY are bound by _set_root above.)

# ===================== TUNING PARAMETERS -- EDIT HERE ONLY =====================
# Every threshold below was fitted on user-labeled ground truth
# (contact_samples.json / hole_samples.json, 2026-07-10..12).
# After changing ANY value: run  python static_test_v2_2.py  and make sure
# all geometric tests pass and GT precision stays 100%.
_RULE = {
    # ---- HOLE: global guards applied to every single-face tier ----
    "hole_max_radius": 45.0,   # mm; larger cylinders are open bores, not holes
    # user 07-12: PERFECT closed upright cylinders may exceed the cap
    # (e.g. seal ring bore r=48.4, cover=1.0 cv=0 tilt=0). Strict gates so
    # big OPEN bores (crank bore...) stay non-hole.
    "holeXL_max_radius": 60.0, "holeXL_min_cover": 0.95,
    "holeXL_max_cv": 0.05, "holeXL_max_tilt": 0.3,
    "hole_max_tilt": 0.55,     # |normal.axis| mean; 0=upright wall, 0.7=45deg
                               # bevel. Real holes confirmed up to 0.51.
    "hole_min_hollow": 0.35,   # min(radial)/mean(radial); flat solid disc ~0
    "hole_max_nconc": 0.95,    # |sum unit normals|/n; ~1 = flat face, reject

    # user 07-12: tier1/tier2 (tru KIN 1 face) phai kin that -- phan
    # HUONG TAM cua nconc (da tru phan nghieng tilt) phai triet tieu.
    # A 3/4 open arc has rconc~.5; a real tilted bore can still have rconc~0.
    "hole_closed_max_rconc": 0.45,
    # A short sloped frustum is a chamfer/rim, not the bore wall itself.
    # 228665207: tilt=.34, length/radius=.15 -> ordinary face. Upright
    # shallow cylinders and genuinely deep tilted holes remain eligible.
    "hole_shallow_tilt_min": 0.30,
    "hole_shallow_max_len_ratio": 0.20,
    # ---- HOLE tier 1: closed cylinder, normal mesh ----
    "t1_min_elem": 8, "t1_max_cv": 0.20, "t1_min_cover": 0.80,
    "t1_min_inward": 0.6,
    # ---- HOLE tier 2: dense mesh, mostly closed ----
    "t2_min_elem": 40, "t2_max_cv": 0.05, "t2_min_cover": 0.65,
    "t2_min_inward": 0.9,
    # ---- HOLE tier 3: deep tube (length >= 2.5 * radius) ----
    "t3_min_elem": 50, "t3_max_cv": 0.05, "t3_min_cover": 0.42,
    "t3_len_per_radius": 2.5, "t3_min_inward": 0.95,
    # ---- HOLE tier 4: half-open but dense and very cylindrical ----
    "t4_min_elem": 30, "t4_max_cv": 0.02, "t4_min_cover": 0.52,
    "t4_min_inward": 0.95,
    # ---- HOLE ring0: upright CLOSED ring, even one element row ----
    "r0_min_elem": 8, "r0_max_nconc": 0.4, "r0_max_tilt": 0.3,
    "r0_max_cv": 0.35, "r0_min_hollow": 0.5, "r0_min_inward": 0.6,

    # ---- HOLE fragments (pieces that join into one bore) ----
    "frag_min_elem": 14,       # per-piece element count
    "frag_min_interior": 1,    # must have interior elements (>=2x2 mesh);
                               # 1-row strips around bolt seats do not qualify
    "frag_max_cv": 0.45,
    "frag_min_inward": 0.8,
    "frag_max_tilt": 0.5,      # fragment must be an upright wall
    "frag_min_hollow": 0.35,
    # user 07-12: MICRO fragments -- small drill bores (r<=6) meshed as a
    # single element row have n_in=0 and few elements; admit them with
    # much stricter geometry instead. Bolt-seat strips (r~8.4) stay out
    # via the radius cap; the CLOSED-WHEN-JOINED group test still decides.
    "fragS_max_radius": 6.0, "fragS_min_elem": 4, "fragS_max_cv": 0.08,
    "fragS_max_tilt": 0.3, "fragS_min_hollow": 0.85,
    # Large fragments remain eligible when the wall is deep relative to radius.
    "fragS_min_len_ratio": 0.8,
    # A fenced island requires a real close-30 visibility seed.
    "island_rescue_min_vis": 0.2,
    # v2.3.1 final: strict continuity wins over visibility. A directly
    # visible patch cut away from the main OUTER component is INNER too.
    # Trade-off accepted by user: exposed pressed pin 228665185 may become
    # INNER; do not reopen this generic rescue to fix a single feature.
    "scrap_rescue_enabled": False,
    # v2.3.1 narrow gate: topology wins by default, but a HOLE-cut island may
    # return to OUTER only when the WHOLE component is broadly visible AND
    # broadly open to outside air. Scrap rescue stays disabled separately.
    "jailed_island_rescue_enabled": True,
    # Component visibility uses real geometric-area weighting.
    # Live geometric-area metric for the confirmed exterior 87-face bracket
    # is 0.24 (element-count weighting used to report 0.304). Keep a small
    # margin at 0.23; the independent reach gates remain deliberately high.
    "rescue_min_mean_vis": 0.23,
    # Independent path for a component whose visible share is broad enough
    # by itself (confirmed exterior island 7: meanvis=0.30). This does not
    # admit a large component with only one bright speck.
    "rescue_min_broad_vis": 0.28,
    # Independent air-coverage evidence for a broadly open exterior island.
    "rescue_min_mean_reach": 0.80,
    "rescue_high_reach_face_ratio": 0.80,
    "rescue_min_high_reach_area": 0.70,
    # decisive group test -- CLOSED WHEN JOINED:
    "group_closure_max": 0.45,  # |sum unit normals of group|/count; ~0 means
                                # the pieces cover the full loop => real bore
    # coaxial matching between fragments:
    "cyl_min_axis_cos": 0.90, "cyl_radius_tol": 0.25, "cyl_center_tol": 0.3,

    # ---- RIM (closed chamfer / bolt-seat ring): banned from hole+contact ----
    "ring_max_radius": 45.0,
    "ring_max_cv": 0.35,       # also blocks open arcs curling into fake rings
    "ring_min_inward": 0.6,
    "ring_min_hollow": 0.45,   # a solid disc is not a rim
    "ring_centroid_tol": 0.35,  # centroid-to-center dist / radius; closed
                                # rims ~0, open arcs ~0.9
    "ring_min_bins": 5,        # coarse 8-segment rims land in only 5-8 bins
    "ring_max_gap": 4,         # max angular gap in 24-bin circle (60 deg)

    # ---- CONTACT gates (6 types finalized with user 07-11) ----
    "core_min_shn": 0.98,      # shared face = 100% of nodes are shared nodes
    "pressed_min_interior": 3,  # pressed gate needs >=3 interior elements
    "pressed_min_ct_in": 0.6,   # ...with >=60% of them in proximity contact
    "prox_min_ct": 0.8,        # proximity gate: >=80% elements within 3mm
    "prox_max_reach": 0.2,     # ...and air cannot reach (pressed, not a gap)
    # coplanar expansion (type 6): one layer from core shared faces
    "coplanar_min_cos": 0.94,  # normals within ~20 deg
    "coplanar_max_dist": 3.0,  # same plane within 3 mm
    # UNIFIED coplanar rule (user 07-12, tuned on 4 GT cases): a coplanar
    # face joins CONTACT only when PRESSED -- interior elems pressed
    # (ct_in), or proximity dominating visibility (ct >= vis) on a face
    # that is not a partially-shared smeared edge (shn low).
    "coplanar_min_ct_in": 0.6,  # same bar as the pressed gate
    "coplanar_min_ct": 0.6,     # (b) proximity share of the face; must
                                # also DOMINATE visibility (ct >= vis)
    # Open-air coplanar face: reach >=80% is weak evidence of a gap. In that
    # case require the stronger original proximity bar ct>=80%; this rejects
    # 228744784 (reach100, ct70) without losing high-ct contact GT.
    "coplanar_open_min_reach": 0.80,
    "coplanar_open_min_ct": 0.80,
    # (coplanar_max_shn veto REMOVED, user 07-12 final: hidden ct-dominant
    #  faces are contact regardless of partial share -- 228877131 and
    #  228736853 are physically identical, both labeled contact.)
    "coplanar_core_shn": 0.5,   # majority-shared (shn >= this)
                                # = a shared face split in two -> CONTACT
                                # regardless of ct (228876752: ct 0,
                                # shn 80 -> contact; user 07-12)

    # (legacy keys kept for hole_trainer.py compatibility)
    "max_cv": 0.20, "min_coverage": 0.80, "max_radius": 45.0,
    "min_elem": 8, "min_inward": 0.6, "min_group_coverage": 0.45,
    "max_cv_frag": 0.45, "min_elem_frag": 14, "min_inward_frag": 0.8,
}
_NBIN = 24

_state = {"outer": [], "inner": [], "hole": [], "contact": [],
          "coplanar": [], "diag": {}, "body_results": {},
          "last_scope": [], "cache_token": None, "edit_scopes": {},
          "body_face_map": {}, "active_color_kind": None,
          "class_colors": {}, "last_reflow_faces": set()}
_JSON_CACHE = _data.CACHE
_GEOM_CACHE = {"document": None, "tri_path": None, "bodies": {}}


def _document_key():
    try:
        return JPT.GetCurrentDocumentPath() or "<unsaved>"
    except Exception:
        return "<unknown>"


def _invalidate_caches(reason=""):
    _state["body_results"] = {}
    _state["diag"] = {}
    _state["last_scope"] = []
    _state["cache_token"] = None
    _state["edit_scopes"] = {}
    _state["body_face_map"] = {}
    for key in ("outer", "inner", "hole", "contact", "coplanar"):
        _state[key] = []
    _JSON_CACHE["signature"] = None
    _JSON_CACHE["bundle"] = None
    if reason:
        print(f"[V2.4] Cache invalidated: {reason}")


def _load_json_bundle(paths):
    return _data.load_json_bundle(paths)


def _eids_for_body(data, body_name):
    """Return name-matched EIDs, or global EIDs for anonymous PID datasets."""
    return _data.eids_for_body(data, body_name)


# ============ geometry helpers (kept in sync with hole_trainer.py) ============

def _sub(a, b):
    return _core.sub(a, b)


def _dot(a, b):
    return _core.dot(a, b)


# Compatibility aliases: callers/tests keep the v2.5 public helper names.
_eig3 = _geometry._eig3
_solve3 = _geometry._solve3
_accum_elem = _geometry._accum_elem
face_features = _geometry.face_features
_features_core = _geometry._features_core
_kasa_ring = _geometry._kasa_ring


def detect_holes(faces_feat):
    """faces_feat: {fid: (feat, n_elem, n_in)} -> {fid: via}."""
    return _core.detect_holes(faces_feat, _RULE)


# ==================== classify ====================

def _ratio(dlg, name, default):
    try:
        return float(dlg.get_item_text(name))
    except Exception:
        return default


def is_ring_face(feat):
    """Return whether a feature is a closed inner rim."""
    return _core.is_ring_face(feat, _RULE, _NBIN)


# Tetra model: map sorted corner-node triples to parent tetra EIDs.
_TRI2EID = {"path": None, "map": {}}


def _load_tri2eid(paths):
    p = paths.get("t2e", "")
    if _TRI2EID["path"] == p:
        return
    _TRI2EID["path"] = p
    _TRI2EID["map"] = {}
    if not os.path.isfile(p):
        return
    try:
        with open(p, "r", encoding="utf-8") as fh:
            raw = json.load(fh)
        mp = {}
        for flat in raw.values():
            for i in range(0, len(flat), 4):
                mp[(flat[i], flat[i + 1], flat[i + 2])] = flat[i + 3]
        _TRI2EID["map"] = mp
        print(f"[V2.4] Loaded tetra parent map ({len(mp)} boundary facets).")
    except Exception as exc:
        print(f"[V2.4] WARNING: could not read outer_tri2eid.json ({exc}).")


def _map_eid(e):
    """EID dung de tra json: model 3D -> EID tetra cha (qua 3 node goc)."""
    mp = _TRI2EID["map"]
    if not mp:
        return e.id
    nid = [n.id for n in e.nodes][:3]   # tri3/tri6: 3 node goc dau tien
    nid.sort()
    return mp.get((nid[0], nid[1], nid[2]), e.id)


def _mean_vis(comp, fvis, fvis30, faces_feat):
    """Geometric-area-weighted component visibility."""
    return _core.mean_visibility(comp, fvis, fvis30, faces_feat)


def _mean_area(comp, fmap, faces_feat):
    """Geometric-area-weighted mean of a face metric."""
    return _core.mean_metric(comp, fmap, faces_feat)


def _high_area_fraction(comp, fmap, threshold, faces_feat):
    return _core.high_area_fraction(comp, fmap, threshold, faces_feat)


def _rescue_ok(comp, fvis, fvis30, frc, faces_feat, label=""):
    """Two narrow component gates: broad visibility, or vis+air coverage."""
    ok, has_seed, mv, mr, hf = _core.rescue_metrics(
        comp, fvis, fvis30, frc, faces_feat, _RULE)
    if has_seed:
        print(f"[V2] rescue{label}: size={len(comp)} meanvis={mv:.2f} "
              f"meanreach={mr:.2f} highreach={hf:.2f} seed={has_seed} -> "
              f"{'OUTER' if ok else 'giu nguyen'}")
    return ok


def _body_geometry(body):
    """Build or reuse immutable geometry/topology for one Jupiter body."""
    document = _document_key()
    tri_path = _TRI2EID["path"]
    if (_GEOM_CACHE["document"] != document
            or _GEOM_CACHE["tri_path"] != tri_path):
        _GEOM_CACHE["document"] = document
        _GEOM_CACHE["tri_path"] = tri_path
        _GEOM_CACHE["bodies"] = {}
    try:
        face_count = len(body.faces)
    except Exception:
        face_count = -1
    cached = _GEOM_CACHE["bodies"].get(body.id)
    if cached and cached["face_count"] == face_count:
        return cached, True

    eids_by_face = {}
    interior_by_face = {}
    fnodes = {}
    fedges = {}
    faces_feat = {}
    mp = _TRI2EID["map"]
    # SINGLE-PASS read: each element's e.nodes and each node's .pos are read
    # exactly once here, then reused for the mapped EID, the interior/edge
    # classification, and the cylinder fit. (The old code read e.nodes ~4x
    # per element and n.pos 3x per node through the Jupiter bridge -- the
    # dominant cold cost.) Results are bit-identical to the old path.
    for face in body.faces:
        fid = face.id
        fn_ids = set()
        pts = []
        for n in face.nodes:
            fn_ids.add(n.id)
            p = n.pos
            pts.append((p.x * 1000.0, p.y * 1000.0, p.z * 1000.0))
        eids = []
        elem_ids = []          # (mapped eid, node ids) for interior pass
        edge_cnt = {}
        enorms = []
        einfo = []
        nn = [[0.0] * 3 for _ in range(3)]
        for e in face.elems:
            ids = []
            en = []
            for nd in e.nodes:
                ids.append(nd.id)
                p = nd.pos
                en.append((p.x * 1000.0, p.y * 1000.0, p.z * 1000.0))
            # mapped EID (tetra parent via sorted corner triple; e.id read
            # only on a rare map miss or shell model)
            if mp and len(ids) >= 3:
                k = sorted(ids[:3])
                eid = mp.get((k[0], k[1], k[2]))
                if eid is None:
                    eid = e.id
            else:
                eid = e.id
            eids.append(eid)
            if len(ids) >= 3:
                elem_ids.append((eid, ids))
                m = len(ids)
                for kk in range(m):
                    a, b = ids[kk], ids[(kk + 1) % m]
                    key = (a, b) if a < b else (b, a)
                    edge_cnt[key] = edge_cnt.get(key, 0) + 1
            if len(en) >= 3:
                _accum_elem(en, ids, enorms, einfo, nn)
        if not eids:
            continue
        # interior = elements not touching two boundary nodes (edge count 1)
        bnodes = set()
        for (a, b), c in edge_cnt.items():
            if c == 1:
                bnodes.update((a, b))
        interior = [eid for eid, ids in elem_ids
                    if sum(1 for n in ids if n in bnodes) < 2]
        try:
            fedges_set = set(edge.id for edge in face.edges)
        except Exception:
            fedges_set = set()
        eids_by_face[fid] = eids
        interior_by_face[fid] = interior
        fnodes[fid] = fn_ids
        fedges[fid] = fedges_set
        faces_feat[fid] = (_features_core(pts, enorms, einfo, nn),
                           len(eids), len(interior))
    cached = {
        "face_count": face_count,
        "eids": eids_by_face,
        "interior": interior_by_face,
        "fnodes": fnodes,
        "fedges": fedges,
        "faces_feat": faces_feat,
    }
    _GEOM_CACHE["bodies"][body.id] = cached
    return cached, False


def contact_gate(ct, n_in, ct_in, shn, reach):
    """Classify a contact candidate per the 6 TYPES finalized with the
    user on 07-11.

    shn = fraction of the face's NODES that are shared nodes (user's
    definition: shared face <=> 100% of nodes shared; partially shared =
    smeared edge, NOT contact).

    Returns: 'core'    -- true shared face (100% nodes shared)
             'pressed' -- pressed over the whole face (interior elements
                         are contact too)
             'prox'    -- proximity candidate (only accepted if its cluster
                         touches a core/pressed face)
             None      -- not contact
    """
    return _core.contact_gate(ct, n_in, ct_in, shn, reach, _RULE)


def coplanar_pressed(n_in, ct_in, ct, vis, shn, reach):
    """Pressed evidence for one face directly adjacent to native core."""
    return _core.coplanar_pressed(
        n_in, ct_in, ct, vis, shn, reach, _RULE)


def _native_shared_evidence(bodies):
    """Read shared topology with one native vector call when possible."""
    face_ids = set()
    node_ids = set()
    native_bodies = bodies
    if isinstance(bodies, (list, tuple)):
        try:
            native_bodies = JPT.GetEntitiesByID(
                JPT.DItemType.BODY, [body.id for body in bodies])
        except Exception:
            native_bodies = bodies
    try:
        face_ids.update(item.id for item in JPT.GetSharedFaces(native_bodies))
        node_ids.update(item.id for item in JPT.GetSharedNodes(native_bodies))
    except Exception:
        try:
            for body in bodies:
                items = JPT.GetEntitiesByID(JPT.DItemType.BODY, body.id)
                face_ids.update(
                    item.id for item in JPT.GetSharedFaces(items))
                node_ids.update(
                    item.id for item in JPT.GetSharedNodes(items))
        except Exception as exc:
            print(f"[V2.4-NATIVE] Could not read shared topology: {exc}")
            return None, None
    print(f"[V2.4-NATIVE] parts={len(bodies)} "
          f"shared_faces={len(face_ids)} shared_nodes={len(node_ids)}")
    return face_ids, node_ids


def do_classify(dlg, bodies_override=None, progress=None):
    """Classify a body scope and cache each body's result."""
    if bodies_override is not None:
        bodies = list(bodies_override)
    else:
        try:
            bodies = JPT.GetSelectedParts()
        except Exception:
            bodies = None
    if not bodies:
        print("[V2.4] No part selected.")
        return
    paths = _json_paths(verbose=True, dlg=dlg)
    _load_tri2eid(paths)
    try:
        bundle, signature, json_cached = _load_json_bundle(paths)
    except Exception as e:
        print(f"[V2.4] Could not read result JSON ({e}). Press the "
              "'Run analyzer' button first (~1 min, once per model).")
        return
    if _state.get("cache_token") != signature:
        _state["body_results"] = {}
        _state["diag"] = {}
        _state["cache_token"] = signature
    vis_all = bundle["vis"]
    ct_all = bundle["ct"]
    rc_all = bundle["rc"]
    rc10_all = bundle["rc10"]
    rc20_all = bundle["rc20"]
    vis30_all = bundle["vis30"]
    print(f"[V2.4-CACHE] JSON {'hit' if json_cached else 'loaded'}")
    manual_holes = set()
    try:
        with open(_SAMPLES, "r", encoding="utf-8") as fh:
            manual_holes = set(int(k) for k in json.load(fh).get("hole", {}))
    except Exception:
        pass
    if not rc10_all or not rc20_all:
        print("[V2.4] reach10/reach20 are unavailable; reach40 remains valid.")
    import time as _time
    _t0 = _time.time()
    native_shared_faces, shared_nodes = _native_shared_evidence(bodies)
    print(f"[V2-TIME] shared topology: {_time.time()-_t0:.1f}s")
    if native_shared_faces is None:
        print("[V2.4-NATIVE] Classification stopped; shared contact must not be "
              "silently disabled.")
        return
    if not vis30_all:
        print("[V2.4] Missing close-30 visibility; island evidence is weaker.")

    r_seed = _ratio(dlg, "TbSeed", 0.2)
    r_contact = _ratio(dlg, "TbContact", 0.15)
    max_island = int(_ratio(dlg, "TbIsland", 1000))

    outer, inner, holes_out, contact = [], [], [], []
    coplanar_all = []
    # Phase timers (aggregate over all bodies) so one live run pinpoints the
    # bottleneck: geometry = Jupiter reads + cylinder fit (cached after the
    # first build); ratios = JSON evidence per face; classify = contact /
    # hole / grow / shell / inner graph work.
    _tg = _tr = _tk = 0.0
    total_bodies = len(bodies)
    for body_index, body in enumerate(bodies):
        if progress:
            progress(body_index, total_bodies, body.name)
        anonymous_map = (body.name not in vis_all and
                         any(str(k).startswith("__BDF_PID_")
                             for k in vis_all))
        if anonymous_map:
            print(f"[V2.5-MAP] Part '{body.name}': BDF has no part name; "
                  "mapping analyzer evidence by Element/Node IDs.")
        vis = _eids_for_body(vis_all, body.name)
        ct = _eids_for_body(ct_all, body.name)
        rc = _eids_for_body(rc_all, body.name)
        rc10 = _eids_for_body(rc10_all, body.name)
        rc20 = _eids_for_body(rc20_all, body.name)
        vis30 = _eids_for_body(vis30_all, body.name)
        if not vis and not ct:
            sample = sorted(vis_all)[:5]
            print(f"[V2.4] WARNING: part '{body.name}' is absent from JSON. "
                  f"Sample JSON keys: {sample}. Check BDF/Jupiter name mapping.")

        _g0 = _time.time()
        geometry, geometry_cached = _body_geometry(body)
        _tg += _time.time() - _g0
        _r0 = _time.time()
        fnodes = geometry["fnodes"]
        fedges = geometry["fedges"]
        faces_feat = geometry["faces_feat"]
        evidence = _classifier.build_face_evidence(
            geometry, (vis, ct, rc, rc10, rc20, vis30), shared_nodes)
        fvis, fct, frc = evidence["vis"], evidence["ct"], evidence["rc"]
        frc10, frc20 = evidence["rc10"], evidence["rc20"]
        fvis30 = evidence["vis30"]
        fctin, fshn = evidence["ctin"], evidence["shn"]
        _tr += _time.time() - _r0
        _k0 = _time.time()
        print(f"[V2.4-CACHE] body {body.id}: geometry "
              f"{'hit' if geometry_cached else 'built'}")

        node_core = set(fid for fid, ratio in fshn.items()
                        if ratio >= _RULE["core_min_shn"])
        api_core = set(fnodes) & native_shared_faces
        nodes_only = node_core - api_core
        api_only = api_core - node_core
        print(f"[V2.4-NATIVE] {body.name}: core_both="
              f"{len(node_core & api_core)} nodes_only={len(nodes_only)} "
              f"faces_only={len(api_only)}")
        if nodes_only:
            print(f"[V2.4-NATIVE] nodes_only sample={sorted(nodes_only)[:10]}")
        if api_only:
            print(f"[V2.4-NATIVE] faces_only sample={sorted(api_only)[:10]}")

        hole_via = detect_holes(faces_feat)
        for f in (manual_holes & set(fnodes)):
            hole_via.setdefault(f, "manual")
        hole_faces = set(hole_via)
        # Closed RIMS (chamfer / bolt seat / beveled ring): NOT hole,
        # NOT contact (user finalized 07-11 evening) -> ordinary faces,
        # banned from both gates. (Routing rims -> HOLE was wrong: user
        # filtered out ~70% false holes coming from that path.)
        rings = set(f for f, item in faces_feat.items()
                    if f not in hole_faces and is_ring_face(item[0]))
        if rings:
            print(f"[V2] {len(rings)} closed rims -> ordinary faces "
                  "(banned from hole + contact)")
        for fid in fnodes:
            _state["diag"][fid] = {}   # reset; island pass overwrites details
        # CONTACT per the 6 types finalized 07-11: preliminary gate labels
        # here (core / pressed / prox); prox clustering and coplanar
        # expansion are handled AFTER the neighbor table is built.
        gate = {}
        for f in fnodes:
            if f in hole_faces or f in rings:
                continue
            g = contact_gate(fct[f], fctin[f][0], fctin[f][1],
                             fshn[f], frc[f])
            if g:
                gate[f] = g
        ct_faces = set(f for f, g in gate.items() if g in ("core", "pressed"))

        # Adjacency = SHARED EDGE ID (Jupiter's real topology, fast) merged
        # with sharing >= 2 nodes (fallback net when edge ids are missing)
        neighbors = {fid: set() for fid in fnodes}
        edge2f = {}
        for fid, es in fedges.items():
            for e in es:
                edge2f.setdefault(e, []).append(fid)
        for lst in edge2f.values():
            for i in range(len(lst)):
                for j in range(i + 1, len(lst)):
                    neighbors[lst[i]].add(lst[j])
                    neighbors[lst[j]].add(lst[i])
        node2f = {}
        for fid, nodes in fnodes.items():
            for n in nodes:
                node2f.setdefault(n, []).append(fid)
        for lst in node2f.values():
            for i in range(len(lst)):
                for j in range(i + 1, len(lst)):
                    a, b = lst[i], lst[j]
                    if b not in neighbors[a] and len(fnodes[a] & fnodes[b]) >= 2:
                        neighbors[a].add(b)
                        neighbors[b].add(a)

        # TYPE 1: a prox candidate is only accepted if its connected
        # cluster (through other contact candidates) touches at least one
        # core/pressed face -- an isolated cluster with no shared face is
        # just two surfaces sitting close together; drop it.
        prox = set(f for f, g in gate.items() if g == "prox")
        cand = prox | ct_faces
        visited_p = set()
        n_prox_kept = 0
        for p0 in list(prox):
            if p0 in visited_p:
                continue
            comp = {p0}
            queue = [p0]
            has_base = False
            while queue:
                f = queue.pop()
                for g2 in neighbors[f]:
                    if g2 in cand and g2 not in comp:
                        comp.add(g2)
                        queue.append(g2)
                        if g2 in ct_faces:
                            has_base = True
            visited_p |= comp & prox
            if has_base:
                kept = comp & prox
                ct_faces |= kept
                n_prox_kept += len(kept)
        if prox:
            print(f"[V2] prox: kept {n_prox_kept}/{len(prox)} "
                  "(clusters touching core/pressed)")

        # v2.3 NATIVE CONTACT (2026-07-12): GT-validated -- native shared
        # faces (JPT.GetSharedFaces, no _CT_JSON/_RC_JSON) + one coplanar
        # layer reproduce the GT CONTACT set exactly (189/189 on the
        # UM_PROD_BODY probe). This replaces the old shn/ct/pressed/prox
        # gate above as the decision for ct_faces; contact_gate() and the
        # gate/prox computation above are kept ONLY for diagnostics
        # (d["gate"]) and regression scoring (static_test_v2_2.py) against
        # the old rule -- they no longer decide CONTACT membership.
        ct_faces = set(api_core) - hole_faces - rings

        # TYPE 6: COPLANAR expansion from contact (faces that are not
        # shared but coplanar with an adjacent shared face) --
        # plane test 20 deg / 3 mm.
        def _coplanar(f, g2):
            ff = faces_feat.get(f, (None,))[0]
            fg = faces_feat.get(g2, (None,))[0]
            if not ff or not fg or not ff.get("navg") or not fg.get("navg"):
                return False
            n1, n2 = ff["navg"], fg["navg"]
            if abs(_dot(n1, n2)) < _RULE["coplanar_min_cos"]:
                return False
            d = _sub(fg["cavg"], ff["cavg"])
            return abs(_dot(d, n1)) <= _RULE["coplanar_max_dist"]

        # v2.2 (user 07-12): a coplanar face must be DIRECTLY ATTACHED to a
        # SHARED FACE (core) -- one layer from core only, NO chaining through
        # other coplanar faces. (NOTE: do not add an nconc>=0.9 "truly flat"
        # gate -- tried on 07-12, it broke the gasket barrier ring and the
        # grow flooded the whole inner side. Do not repeat.)
        # user 07-12 (mesh 3D): a coplanar face joins CONTACT only if it
        # is HIDDEN -- a visible coplanar face is outer to the naked eye.
        coplanar_added = set()
        n_cop_visible = 0
        n_cop_nopress = 0
        core_set = set(ct_faces)
        for f in core_set:
            for g2 in neighbors[f]:
                if g2 in ct_faces or g2 in hole_faces or g2 in rings:
                    continue
                if not _coplanar(f, g2):
                    continue
                # UNIFIED coplanar rule (user 07-12, 4 GT cases):
                # a coplanar face joins CONTACT when it is PRESSED:
                #   (a) interior elems pressed (ct_in >= 0.6), or
                #   (b) proximity DOMINATES visibility (ct >= 0.6 and
                #       ct >= max(vis, vis30)) and the face is NOT a
                #       partially-shared smeared edge (shn <= 0.25 --
                #       user's rule: share-mot-phan != contact).
                # Cases: 1001614 (vis 59 ct 28) -> outer; 1905490
                # (ct 44 hidden) -> outer; 228736853 (ct 96 shn 32) ->
                # outer; 228988098 (vis 37 ct 63 shn 6) -> CONTACT.
                n_in, ct_in = fctin.get(g2, (0, 0.0))
                c = fct.get(g2, 0.0)
                v = max(fvis.get(g2, 0.0), fvis30.get(g2, 0.0))
                shn2 = fshn.get(g2, 0.0)
                # user 07-12 final: shn is NOT a veto for the hidden
                # ct-dominant branch (228877131 vs 228736853 -- physically
                # identical, both -> contact). shn only acts as the
                # POSITIVE majority-shared gate (c).
                pressed = coplanar_pressed(
                    n_in, ct_in, c, v, shn2, frc.get(g2, 0.0))
                if not pressed:
                    if v > c:
                        n_cop_visible += 1
                    else:
                        n_cop_nopress += 1
                    continue
                ct_faces.add(g2)
                coplanar_added.add(g2)
        if coplanar_added or n_cop_visible or n_cop_nopress:
            print(f"[V2] Contact: +{len(coplanar_added)} coplanar faces "
                  f"(attached to core, pressed); skipped: "
                  f"{n_cop_visible} visible, {n_cop_nopress} not pressed.")

        # MANUAL OVERRIDES act as real barriers/seeds so OUTER/INNER RE-FLOW
        # (user question 07-12): a face forced to HOLE/CONTACT becomes a grow
        # barrier -> OUTER stops there and INNER can form behind it; a face
        # forced to OUTER seeds the grow; forced INNER is kept out of the seed
        # set. With no override this block does nothing (identical result).
        ov_body = {f: t for f, t in _state.get("override", {}).items()
                   if f in fnodes}
        forced_outer = set()
        forced_inner = set()
        for f, t in ov_body.items():
            # NOT CONTACT is a negative override only: remove the automatic
            # contact label and let the normal OUTER/INNER/HOLE flow decide it.
            if t == "not_contact":
                ct_faces.discard(f)
                continue
            if t == "not_hole":
                hole_faces.discard(f)
                continue
            if t == "not_outer":
                forced_inner.add(f)
                continue
            if t == "not_inner":
                # INNER is the complement of OUTER + CONTACT. Removing a
                # face from INNER therefore means explicitly seeding OUTER.
                hole_faces.discard(f)
                ct_faces.discard(f)
                forced_outer.add(f)
                continue
            hole_faces.discard(f)
            ct_faces.discard(f)
            if t == "hole":
                hole_faces.add(f)
            elif t == "contact":
                ct_faces.add(f)
            elif t == "outer":
                forced_outer.add(f)
            elif t == "inner":
                forced_inner.add(f)
        if ov_body:
            print(f"[V2] Applied {len(ov_body)} manual override(s) as "
                  "barriers/seeds before grow (OUTER/INNER re-flow).")

        # shells = connected components of ALL faces of the body (a merged
        # part -- e.g. 12 loose bolts -- has one shell per loose piece)
        shell_of = {}
        n_shell = 0
        for f0 in fnodes:
            if f0 in shell_of:
                continue
            n_shell += 1
            shell_of[f0] = n_shell
            queue = [f0]
            while queue:
                f = queue.pop()
                for g2 in neighbors[f]:
                    if g2 not in shell_of:
                        shell_of[g2] = n_shell
                        queue.append(g2)

        seeds = [f for f in fnodes
                 if (fvis[f] >= r_seed or f in forced_outer)
                 and f not in hole_faces and f not in ct_faces
                 and f not in forced_inner]

        # v2.3.1: close-120 can erase ALL direct seeds of an exposed shell,
        # including a normal single-shell bracket. Fall back to close-30 only
        # for shells having ZERO close-120 seed. A shell that already owns a
        # main OUTER seed cannot use this path to promote an inner island;
        # the strict per-shell largest-component invariant still decides.
        seeded_shells = {shell_of[f] for f in seeds}
        extra = [f for f in fnodes
                 if shell_of[f] not in seeded_shells
                 and fvis30[f] >= r_seed
                 and f not in hole_faces and f not in ct_faces
                 and f not in forced_inner]
        if extra:
            n_fb_shell = len({shell_of[f] for f in extra})
            seeds += extra
            print(f"[V2] Shell fallback: {n_fb_shell} shell(s) had no "
                  f"close-120 seed -> seeded {len(extra)} faces from "
                  "vis30 (close-30).")

        # Grow: HOLE + CONTACT are both absolute barriers (the architecture
        # that produced a clean inner). Outer regions cut off by barriers
        # are recovered by the island-fill step below.
        barrier = hole_faces | ct_faces
        grown = set(seeds)
        stack = list(seeds)
        while stack:
            f = stack.pop()
            for g in neighbors[f]:
                if g not in grown and g not in barrier:
                    grown.add(g)
                    stack.append(g)

        # island fill: small patches enclosed by outer/barriers
        rest = set(fnodes) - grown - barrier
        visited = set()
        for f0 in list(rest):
            if f0 in visited:
                continue
            comp = {f0}
            queue = [f0]
            while queue:
                f = queue.pop()
                for g in neighbors[f]:
                    if g in rest and g not in comp:
                        comp.add(g)
                        queue.append(g)
            visited |= comp
            # ONLY fill islands ADJACENT to the grown outer region (07-12):
            # the old "isolated island touching a hole" branch wrongly
            # grabbed rims sitting INSIDE hole stacks on the inner side
            # (user: outer was 95% right, all errors were in that group).
            # The user's ShowAdjacent trick confirms: connectivity from an
            # outer seed + hole/contact barriers IS the definition of outer.
            has_evidence = any(fvis[f] > 0 or frc[f] > 0 or fvis30[f] > 0
                               for f in comp)
            touch_grown = any(g in grown for f in comp for g in neighbors[f])
            touch_hole = any(g in hole_faces
                             for f in comp for g in neighbors[f])
            filled = False
            if touch_grown and (touch_hole or has_evidence):
                grown |= comp
                filled = True
            # v2.3.1 narrow exception: a HOLE-cut island returns to OUTER
            # only when visibility AND reach cover most of its real area.
            # This recovers the exposed 87-face bracket but rejects the
            # moderately reached / weakly visible 2206-face inner cavity.
            elif (not touch_grown and touch_hole
                  and _RULE["jailed_island_rescue_enabled"]
                  and _rescue_ok(comp, fvis, fvis30, frc, faces_feat,
                                 label="-island")):
                grown |= comp
                filled = True
            comp_mv = _mean_vis(comp, fvis, fvis30, faces_feat)
            comp_mr = _mean_area(comp, frc, faces_feat)
            comp_hf = _high_area_fraction(
                comp, frc, _RULE["rescue_high_reach_face_ratio"], faces_feat)
            for f in comp:
                _state["diag"][f] = {
                    "comp": len(comp), "touch_grown": touch_grown,
                    "touch_hole": touch_hole, "evidence": has_evidence,
                    "filled": filled, "meanvis": comp_mv,
                    "meanreach": comp_mr, "highreach": comp_hf}

        # TOPOLOGICAL-ROLE POST-PROCESSING (currently disabled): a connected
        # contact cluster that does NOT border inner (surrounded only by
        # outer / holes / part boundary) = a pressed pad ON the outer skin
        # (under a bracket, bolt seat...) -> absorb into OUTER. Clusters
        # bordering inner (the gasket band separating inner from outer)
        # stay as barrier.
        _ABSORB_PADS = False   # kept off so the user reviews raw contact
        inner_now = set(fnodes) - grown - ct_faces - hole_faces
        ct_visited = set()
        n_absorb = 0
        for c0 in list(ct_faces) if _ABSORB_PADS else []:
            if c0 in ct_visited:
                continue
            comp = {c0}
            queue = [c0]
            while queue:
                f = queue.pop()
                for g in neighbors[f]:
                    if g in ct_faces and g not in comp:
                        comp.add(g)
                        queue.append(g)
            ct_visited |= comp
            touches_inner = any(g in inner_now
                                for f in comp for g in neighbors[f])
            if not touches_inner:
                grown |= comp
                ct_faces -= comp
                n_absorb += len(comp)
        if n_absorb:
            print(f"[V2] Absorbed {n_absorb} contact-pad faces (not bordering "
                  "inner) into OUTER.")
        barrier = hole_faces | ct_faces   # refresh after pad absorption

        # USER INVARIANT (07-12): outer is ONE connected component --
        # PER SHELL (user 07-12 (2)): merged parts (e.g. 12 loose bolts
        # merged into one part) consist of several DISCONNECTED shells;
        # each shell keeps its own largest outer component. A normal
        # 1-shell part behaves exactly as before.
        if grown:
            comps = []
            seen_g = set()
            for f0 in grown:
                if f0 in seen_g:
                    continue
                comp = {f0}
                queue = [f0]
                while queue:
                    f = queue.pop()
                    for g2 in neighbors[f]:
                        if g2 in grown and g2 not in comp:
                            comp.add(g2)
                            queue.append(g2)
                seen_g |= comp
                comps.append(comp)
            best = {}       # shell id -> largest outer comp in that shell
            for comp in comps:
                s = shell_of[next(iter(comp))]
                if s not in best or len(comp) > len(best[s]):
                    best[s] = comp
            keep = set()
            for comp in best.values():
                keep |= comp
            # v2.3.1 final: strict one-OUTER-component-per-shell invariant.
            # A second component remains INNER even when directly visible
            # through an opening. Optional code is retained for diagnostics,
            # but the released rule keeps scrap_rescue_enabled=False.
            n_rescued = 0
            for comp in comps if _RULE["scrap_rescue_enabled"] else []:
                if comp & keep:
                    continue
                if _rescue_ok(comp, fvis, fvis30, frc, faces_feat,
                              label="-scrap"):
                    keep |= comp
                    n_rescued += len(comp)
            if n_rescued:
                print(f"[V2] Scrap rescue: {n_rescued} fenced outer faces "
                      "(area-weighted visibility above bar) kept as OUTER.")
            dropped = grown - keep
            if dropped:
                grown -= dropped
                print(f"[V2] Dropped {len(dropped)} floating outer faces "
                      f"(part has {n_shell} shell(s)) -> inner")
            elif n_shell > 1:
                print(f"[V2] Part has {n_shell} disconnected shells -- "
                      f"outer kept per shell ({len(best)} components).")

        for fid in fnodes:
            d = _state["diag"].setdefault(fid, {})
            d["vis"] = fvis[fid]
            d["ct"] = fct[fid]
            d["shn"] = fshn[fid]
            d["n_in"], d["ct_in"] = fctin[fid]
            d["gate"] = gate.get(fid, "-")
            d["hole_via"] = ("ring-banned" if fid in rings
                             else hole_via.get(fid, "-"))
            _item = faces_feat.get(fid, (None, 0, 0))
            ft = _item[0]
            if ft and ft.get("cv") is not None:
                d["geo"] = (f"r={ft['radius']:.1f} cv={ft['cv']:.2f} "
                            f"cover={ft['coverage']:.2f} tilt={ft['tilt']:.2f} "
                            f"conc={ft['nconc']:.2f} hollow={ft['hollow']:.2f} "
                            f"inw={ft.get('inward', 0):.2f} "
                            f"len={ft.get('length', 0):.1f} "
                            f"ne={_item[1]} nin={_item[2] if len(_item) > 2 else 0}")
            d["reach"] = frc[fid]
            d["reach10"] = frc10[fid]
            d["reach20"] = frc20[fid]
            d["vis30"] = fvis30[fid]
            d["n_neighbor"] = len(neighbors[fid])
            d["nb_outer"] = sum(1 for g in neighbors[fid] if g in grown)
            d["nb_hole"] = sum(1 for g in neighbors[fid] if g in hole_faces)
            d["nb_contact"] = sum(1 for g in neighbors[fid] if g in ct_faces)
            d["class"] = ("hole" if fid in hole_faces else
                          "contact" if fid in ct_faces else
                          "outer" if fid in grown else "inner")

        b_outer = sorted(grown)

        # INNER = a continuous grow from the main interior region. HOLE and
        # CONTACT are allowed to participate when attached to that region;
        # OUTER is the only absolute stop. An isolated HOLE/CONTACT cluster
        # with no path to the main interior remains non-INNER.
        inner_set = set(fnodes) - grown - ct_faces - hole_faces
        inner_comps = []
        seen_i = set()
        for f0 in inner_set:
            if f0 in seen_i:
                continue
            comp = {f0}
            queue = [f0]
            while queue:
                f = queue.pop()
                for g2 in neighbors[f]:
                    if g2 in inner_set and g2 not in comp:
                        comp.add(g2)
                        queue.append(g2)
            seen_i |= comp
            inner_comps.append(comp)
        # Each disconnected shell owns one main interior component.
        best_i = {}
        for comp in inner_comps:
            shell = shell_of[next(iter(comp))]
            if shell not in best_i or len(comp) > len(best_i[shell]):
                best_i[shell] = comp
        inner_main = set()
        for comp in best_i.values():
            inner_main |= comp
        inner_reach = set(inner_main)
        stack_i = list(inner_main)
        while stack_i:
            f = stack_i.pop()
            for g2 in neighbors[f]:
                if g2 in inner_reach or g2 in grown:
                    continue
                inner_reach.add(g2)
                stack_i.append(g2)
        b_inner = sorted(inner_reach)
        body_holes = sorted(hole_faces)
        body_contact = sorted(ct_faces)
        body_coplanar = sorted(coplanar_added)
        body_diag = {fid: _state["diag"][fid] for fid in fnodes}
        _state["body_results"][body.id] = {
            "token": signature,
            "name": body.name,
            "outer": b_outer,
            "inner": b_inner,
            "hole": body_holes,
            "contact": body_contact,
            "coplanar": body_coplanar,
            "diag": body_diag,
        }
        outer += b_outer
        inner += b_inner
        holes_out += body_holes
        contact += body_contact
        coplanar_all += body_coplanar
        _tk += _time.time() - _k0
        print(f"[V2.4] {body.name}: {len(fnodes)} faces | seed={len(seeds)} "
              f"hole={len(hole_faces)} contact={len(ct_faces)} -> "
              f"outer={len(b_outer)} inner={len(b_inner)}")

    _state["outer"], _state["inner"] = outer, inner
    _state["hole"], _state["contact"] = holes_out, contact
    _state["coplanar"] = coplanar_all
    _state["last_scope"] = [body.id for body in bodies]
    _apply_overrides()
    if progress:
        progress(total_bodies, total_bodies, "Complete")
    print(f"[V2.4-TIME] Classified {len(bodies)} bodies in "
          f"{_time.time()-_t0:.1f}s")
    print(f"[V2.4-TIME] breakdown: geometry(read+fit)={_tg:.1f}s "
          f"ratios(json)={_tr:.1f}s classify(contact+hole+grow+inner)={_tk:.1f}s")
    print(f"[V2.4] TOTAL: outer={len(outer)} inner={len(inner)} "
          f"hole={len(holes_out)} contact={len(contact)}")
    return True


def do_debug(dlg):
    """Diagnose any selected faces without requiring a selected part."""
    output = []
    try:
        faces = list(JPT.GetSelectedFaces())
    except Exception as exc:
        line = f"[V2-DBG] Could not read selected faces: {exc}"
        print(line, flush=True)
        return [line]
    if not faces:
        line = "[V2-DBG] No face selected. Select face(s), then press again."
        print(line, flush=True)
        return [line]
    selected_ids = [f.id for f in faces]
    evidence = {}
    try:
        paths = _json_paths(verbose=False, dlg=dlg)
        _load_tri2eid(paths)
        bundle, _, _ = _load_json_bundle(paths)

        def merged(name):
            result = set()
            for values in bundle.get(name, {}).values():
                result.update(int(v) for v in values)
            return result

        evidence = {name: merged(name) for name in
                    ("vis", "ct", "rc", "rc10", "rc20", "vis30")}
    except Exception as exc:
        print(f"[V2-DBG] Analyzer evidence unavailable: {exc}", flush=True)

    for f in faces:
        d = _state["diag"].get(f.id)
        if not d or "class" not in d:
            try:
                nnodes = len(f.nodes)
            except Exception:
                nnodes = "?"
            try:
                nelems = len(f.elems)
            except Exception:
                nelems = "?"
            try:
                eids = [_map_eid(elem) for elem in f.elems]
            except Exception:
                eids = []
            if eids and evidence:
                total = len(eids)
                pct = lambda name: 100.0 * sum(
                    eid in evidence.get(name, set()) for eid in eids) / total
                line = (f"[V2-DBG] {f.id}: class=NOT_CLASSIFIED "
                        f"vis={pct('vis'):.1f}% ct={pct('ct'):.1f}% "
                        f"reach={pct('rc'):.1f}% r10={pct('rc10'):.1f}% "
                        f"r20={pct('rc20'):.1f}% vis30={pct('vis30'):.1f}% "
                        f"nodes={nnodes} elems={nelems}")
            else:
                line = (f"[V2-DBG] {f.id}: nodes={nnodes} elems={nelems} | "
                        "No analyzer data")
            print(line, flush=True)
            output.append(line)
            continue
        line = (f"[V2-DBG] {f.id}: class={d['class']} "
                f"vis={100*d['vis']:.1f}% ct={100*d['ct']:.1f}% "
                f"shn={100*d.get('shn', 0):.1f}% "
                f"gate={d.get('gate', '-')} hole_via={d.get('hole_via', '-')} "
                f"ct_in={100*d.get('ct_in', 0):.1f}%(n_in={d.get('n_in', 0)}) "
                f"reach={100*d['reach']:.1f}% "
                f"r10={100*d.get('reach10', 0):.1f}% "
                f"r20={100*d.get('reach20', 0):.1f}% "
                f"vis30={100*d['vis30']:.1f}% | "
                f"neighbors={d['n_neighbor']} "
                f"(outer={d['nb_outer']} hole={d['nb_hole']} "
                f"contact={d['nb_contact']})")
        if d.get("geo"):
            line += f" [{d['geo']}]"
        if "comp" in d:
            line += (f" | island: size={d['comp']} "
                     f"touch_grown={d['touch_grown']} "
                     f"touch_hole={d['touch_hole']} "
                     f"evidence={d['evidence']} filled={d['filled']} "
                     f"meanvis={d.get('meanvis', 0):.2f} "
                     f"meanreach={d.get('meanreach', 0):.2f} "
                     f"highreach={d.get('highreach', 0):.2f}")
        print(line, flush=True)
        output.append(line)
    return output


def do_debug_visible(dlg):
    """Print selected-face diagnostics to Jupiter's Python API console."""
    try:
        dlg.set_item_text("LbDebugStatus", "Debug")
    except Exception:
        pass
    try:
        lines = do_debug(dlg) or []
    except Exception as exc:
        import traceback
        traceback.print_exc()
        lines = [f"[V2-DBG] ERROR: {type(exc).__name__}: {exc}"]
        print(lines[0], flush=True)
    # In Jupiter's ribbon launcher, ordinary print() is not routed to the
    # visible Python API pane.  JDG status updates are echoed there, so emit
    # every diagnostic line through that same channel.  The label itself only
    # retains the last line; the Python API console retains the full sequence.
    for line in lines:
        try:
            dlg.set_item_text("LbDebugStatus", line)
        except Exception:
            pass
    count = sum("No face selected" not in line and "ERROR:" not in line
                and "Could not read" not in line for line in lines)
    print(f"[V2-DBG] DONE: {count} face(s) inspected.", flush=True)
    try:
        dlg.set_item_text("LbDebugStatus", f"Debug: {count} face(s)")
    except Exception:
        pass


def _activate_cached_results(bodies):
    """Activate cached result arrays for a body scope without recomputing."""
    results = []
    for body in bodies:
        result = _state["body_results"].get(body.id)
        if not result or result.get("token") != _state.get("cache_token"):
            return False
        results.append(result)
    for kind in ("outer", "inner", "hole", "contact", "coplanar"):
        _state[kind] = [fid for result in results for fid in result[kind]]
    _state["diag"] = {
        fid: diag for result in results for fid, diag in result["diag"].items()
    }
    _state["last_scope"] = [body.id for body in bodies]
    _apply_overrides()
    print(f"[V2.4-CACHE] Activated {len(bodies)} cached body result(s).")
    return True


# ==================== manual override (exception faces) ====================
# Some faces are physically OUTER/INNER but have zero visibility/reach
# evidence (e.g. a fully enclosed island, vis=vis30=reach=0). The automatic
# logic correctly cannot rescue them without also mis-rescuing real inner
# cavities. For these exceptions the user reassigns them by hand; the choice
# is remembered per dataset (outer_manual_override.json) so it survives
# Select clicks and reopening the model.

def _msgbox(text, kind="info"):
    """Show a native Jupiter message box. kind: 'info' (OK) or 'yesno'.
    Returns the raw JPT result (or None). Never raises."""
    try:
        mt = (JPT.MsgBoxType.MB_WARNING_YESNO if kind == "yesno"
              else JPT.MsgBoxType.MB_INFORMATION_OK)
        return JPT.MessageBoxPSJ(text, mt)
    except Exception as exc:
        print(f"[V2.4] (message box unavailable: {exc})")
        return None


def _apply_overrides():
    """Reassign overridden faces on top of the current result arrays.

    Only touches faces that are already present in the current scope, so an
    override for a part that is not selected does not leak into the
    selection."""
    ov = _state.get("override", {})
    if not ov:
        return
    kinds = ("outer", "inner", "hole", "contact")
    primary = ("outer", "hole", "contact")
    cur = {k: set(_state.get(k, [])) for k in kinds}
    present = set()
    for s in cur.values():
        present |= s
    for fid, target in ov.items():
        if fid not in present or target not in cur:
            continue
        if target == "inner":
            cur["outer"].discard(fid)
            cur["inner"].add(fid)
        elif target in ("hole", "contact"):
            for kind in primary:
                cur[kind].discard(fid)
            cur[target].add(fid)
        else:
            for kind in primary:
                cur[kind].discard(fid)
            cur[target].add(fid)
            cur["inner"].discard(fid)
    for k in kinds:
        _state[k] = sorted(cur[k])


def _override_path(dlg):
    return os.path.join(_model_run_dir(dlg=dlg), "outer_manual_override.json")


def _classification_state_path(dlg):
    return os.path.join(
        _model_run_dir(dlg=dlg), "outer_classification_state.json")


def _save_classification_state(dlg):
    """Persist the last fully re-flowed result for SHOW after reopening."""
    payload = {"version": 1}
    for kind in ("outer", "inner", "hole", "contact", "coplanar"):
        payload[kind] = list(_state.get(kind, []))
    body_map = dict(_state.get("body_face_map", {}))
    for body_id, result in _state.get("body_results", {}).items():
        body_map[int(body_id)] = sorted(result.get("diag", {}))
    _state["body_face_map"] = body_map
    payload["body_faces"] = {
        str(body_id): list(face_ids) for body_id, face_ids in body_map.items()
    }
    try:
        with open(_classification_state_path(dlg), "w",
                  encoding="utf-8") as fh:
            json.dump(payload, fh)
        return True
    except Exception as exc:
        print(f"[V2.5] Could not save classification state: {exc}")
        return False


def _load_classification_state(dlg):
    """Restore the last fully re-flowed result for the selected dataset."""
    try:
        with open(_classification_state_path(dlg), "r",
                  encoding="utf-8") as fh:
            payload = json.load(fh)
        for kind in ("outer", "inner", "hole", "contact", "coplanar"):
            _state[kind] = sorted({int(fid)
                                   for fid in payload.get(kind, [])})
        _state["body_face_map"] = {
            int(body_id): sorted({int(fid) for fid in face_ids})
            for body_id, face_ids in payload.get("body_faces", {}).items()
        }
        # OUTER / CONTACT / HOLE are mutually exclusive. INNER may overlap
        # HOLE/CONTACT only where the saved continuous grow reached them.
        contact = set(_state["contact"])
        outer = set(_state["outer"]) - contact
        hole = set(_state["hole"]) - contact - outer
        inner = set(_state["inner"]) - outer
        _state["contact"] = sorted(contact)
        _state["hole"] = sorted(hole)
        _state["outer"] = sorted(outer)
        _state["inner"] = sorted(inner)
        print("[V2.5] Restored last classification state: "
              f"outer={len(outer)} inner={len(inner)} "
              f"hole={len(hole)} contact={len(contact)}")
        return True
    except Exception:
        return False


def _save_overrides(dlg):
    try:
        with open(_override_path(dlg), "w", encoding="utf-8") as fh:
            json.dump({str(k): v for k, v in _state.get("override", {}).items()},
                      fh)
    except Exception as exc:
        print(f"[V2.4] Could not save overrides: {exc}")


def _load_overrides(dlg):
    _state["override"] = {}
    _state["edit_scopes"] = {}
    try:
        with open(_override_path(dlg), "r", encoding="utf-8") as fh:
            _state["override"] = {int(k): v for k, v in json.load(fh).items()}
        if _state["override"]:
            print(f"[V2.4] Loaded {len(_state['override'])} manual "
                  "override(s) for this dataset.")
    except Exception:
        pass


def _reclassify_edited_parts(dlg, edited_fids):
    """Re-flow only cached Parts touched by an edited face selection."""
    _state["last_reflow_faces"] = set(edited_fids)
    try:
        all_bodies = list(JPT.GetAllParts())
    except Exception:
        all_bodies = []
    results = _state.get("body_results", {})
    token = _state.get("cache_token")
    cache_complete = bool(all_bodies) and all(
        body.id in results and results[body.id].get("token") == token
        for body in all_bodies)
    face_map = {}
    if cache_complete:
        face_map = {body.id: set(results[body.id].get("diag", {}))
                    for body in all_bodies}
    else:
        face_map = {int(body_id): set(face_ids) for body_id, face_ids
                    in _state.get("body_face_map", {}).items()}
        # A reopened/partially cached tool may have an incomplete persisted
        # face->Part map. Resolve only what is needed from Jupiter topology;
        # this is a cheap database scan and must never trigger Classify All.
        mapped = set().union(*face_map.values()) if face_map else set()
        if not edited_fids.issubset(mapped):
            missing = edited_fids - mapped
            for body in all_bodies:
                if not missing:
                    break
                try:
                    ids = {face.id for face in body.faces}
                except Exception:
                    continue
                face_map.setdefault(body.id, set()).update(ids)
                missing -= ids
    affected = []
    found = set()
    for body in all_bodies:
        hit = face_map.get(body.id, set()) & edited_fids
        if hit:
            affected.append(body)
            found |= hit
    if affected and found == edited_fids:
        old_state = {kind: set(_state.get(kind, [])) for kind in
                     ("outer", "inner", "hole", "contact", "coplanar")}
        affected_faces = set().union(
            *(face_map.get(body.id, set()) for body in affected))
        _state["last_reflow_faces"] = affected_faces
        names = ", ".join(body.name for body in affected)
        print(f"[V2.5] Incremental re-flow: {len(affected)} Part(s): "
              f"{names}")
        try:
            dlg.set_item_text(
                "LbOverrideStatus",
                f"Re-flowing {len(affected)} affected Part(s)...")
        except Exception:
            pass
        if do_classify(dlg, bodies_override=affected):
            if cache_complete and _activate_cached_results(all_bodies):
                _save_classification_state(dlg)
                return True, len(affected)
            # A reopened tool has the saved whole-model arrays and only the
            # face->Part map. Merge the freshly classified Part(s) into those
            # arrays without recomputing untouched Parts.
            for kind in ("outer", "inner", "hole", "contact", "coplanar"):
                fresh = set(_state.get(kind, []))
                _state[kind] = sorted(
                    (old_state[kind] - affected_faces) | fresh)
            _state["body_face_map"] = face_map
            _save_classification_state(dlg)
            return True, len(affected)
    # SET is an interactive edit operation. Never surprise the user with a
    # full-model classification when an edited face cannot be mapped. The
    # override has already been saved and the visible arrays updated above;
    # Classify All remains an explicit user action.
    missing = edited_fids - found
    print("[V2.5] Incremental re-flow skipped; no full classification was "
          f"started ({len(missing)} edited face(s) could not be mapped).")
    try:
        dlg.set_item_text(
            "LbOverrideStatus",
            f"Saved | re-flow skipped ({len(missing)} face(s) unmapped)")
    except Exception:
        pass
    return False, 0


def _save_class_selection(dlg, target):
    """Replace the shown edit scope with the current face selection."""
    try:
        faces = list(JPT.GetSelectedFaces())
    except Exception:
        faces = []
    selected = {f.id for f in faces}
    scopes = _state.setdefault("edit_scopes", {})
    scope = set(scopes.get(target, []))
    if not scope and not selected:
        print(f"[V2.5] Press {target.upper()} in section 3, adjust the face "
              f"selection, then press SET {target.upper()} in section 4.")
        return
    added = selected - scope
    removed = scope - selected
    ov = _state.setdefault("override", {})
    for fid in added:
        ov[fid] = target
    for fid in removed:
        ov[fid] = "not_" + target
    _save_overrides(dlg)
    # Keep SHOW immediately consistent with the saved edit, even when the
    # current Jupiter selection contains faces only (no Part available for
    # _auto_classify).  The later Classify All still performs the full
    # topology re-flow around these persisted overrides.
    kinds = ("outer", "inner", "hole", "contact")
    primary = ("outer", "hole", "contact")
    current = {kind: set(_state.get(kind, [])) for kind in kinds}
    for fid in selected:
        if target == "inner":
            current["outer"].discard(fid)
            current["inner"].add(fid)
            continue
        for kind in primary:
            current[kind].discard(fid)
        current[target].add(fid)
        if target == "outer":
            current["inner"].discard(fid)
    for fid in scope - selected:
        current[target].discard(fid)
    for kind in kinds:
        _state[kind] = sorted(current[kind])
    _state["last_scope"] = []
    scopes[target] = sorted(selected)
    status = (f"SAVED {target.upper()}: {len(selected)} kept, "
              f"+{len(added)} added, -{len(removed)} removed")
    try:
        dlg.set_item_text("LbOverrideStatus", status)
    except Exception:
        pass
    print("[V2.5] " + status)
    edited = added | removed
    if not edited:
        _save_classification_state(dlg)
        _select_faces(target)
        try:
            dlg.set_item_text("LbOverrideStatus", status + " | no changes")
        except Exception:
            pass
        return
    print("[V2.5] Re-flowing only the affected Part(s)...")
    rebuilt, part_count = _reclassify_edited_parts(dlg, edited)
    if rebuilt:
        scopes[target] = list(_state.get(target, []))
        _select_faces(target)
        try:
            dlg.set_item_text(
                "LbOverrideStatus",
                status + f" | {part_count} Part re-flow READY")
        except Exception:
            pass
    else:
        print("[V2.5] Saved overrides, but automatic re-flow could not run.")
    try:
        _apply_saved_class_colors(_state.get("last_reflow_faces", edited))
    except Exception as exc:
        print(f"[V2.5-COLOR] Automatic class recolor failed: {exc}")


def do_force_outer(dlg):
    _save_class_selection(dlg, "outer")


def do_force_inner(dlg):
    _save_class_selection(dlg, "inner")


def do_force_hole(dlg):
    _save_class_selection(dlg, "hole")


def do_force_contact(dlg):
    _save_class_selection(dlg, "contact")


def do_clear_override(dlg):
    """Reset overrides only for selected faces in selected Parts."""
    try:
        bodies = list(JPT.GetSelectedParts())
    except Exception:
        bodies = []
    if not bodies:
        print("[V2.5] RESET requires a selected Part.")
        try:
            dlg.set_item_text("LbOverrideStatus",
                              "RESET: select a Part first")
        except Exception:
            pass
        return
    try:
        faces = list(JPT.GetSelectedFaces())
    except Exception:
        faces = []
    if not faces:
        print("[V2.5] RESET requires selected face(s) in the selected Part.")
        try:
            dlg.set_item_text("LbOverrideStatus",
                              "RESET: select face(s) in the selected Part")
        except Exception:
            pass
        return

    allowed = set()
    for body in bodies:
        try:
            allowed.update(face.id for face in body.faces)
        except Exception:
            pass
    selected_ids = {face.id for face in faces if face.id in allowed}
    if not selected_ids:
        print("[V2.5] RESET skipped: selected faces are outside the selected "
              "Part(s).")
        try:
            dlg.set_item_text("LbOverrideStatus",
                              "RESET: selected face(s) are outside Part")
        except Exception:
            pass
        return

    ov = _state.setdefault("override", {})
    removed_ids = {fid for fid in selected_ids if fid in ov}
    for fid in removed_ids:
        del ov[fid]
    _save_overrides(dlg)
    if removed_ids:
        rebuilt, _ = _reclassify_edited_parts(dlg, removed_ids)
        try:
            _apply_saved_class_colors(
                _state.get("last_reflow_faces", removed_ids))
        except Exception as exc:
            print(f"[V2.5-COLOR] Automatic class recolor failed: {exc}")
    else:
        rebuilt = False
    print(f"[V2.5] Cleared override on {len(removed_ids)} selected face(s) "
          "inside the selected Part(s).")
    try:
        dlg.set_item_text("LbOverrideStatus",
                          f"RESET: {len(removed_ids)} selected override(s) "
                          "cleared" + (" | Part re-flow READY"
                                       if rebuilt else ""))
    except Exception:
        pass


def _auto_classify(dlg):
    """Use cached selected-body results, or classify only the missing scope."""
    try:
        bodies = JPT.GetSelectedParts()
    except Exception:
        bodies = None
    if not bodies:
        return
    ids = [body.id for body in bodies]
    if ids == _state.get("last_scope"):
        return
    if not _activate_cached_results(bodies):
        do_classify(dlg, bodies_override=bodies)


def do_classify_all(dlg, notify=True):
    """Classify every body once and populate the full-model result cache."""
    try:
        bodies = list(JPT.GetAllParts())
    except Exception as exc:
        print(f"[V2.4] Could not get all bodies: {exc}")
        return False
    if not bodies:
        print("[V2.4] The current document has no bodies.")
        return False

    def progress(done, total, name):
        percent = int(round(100.0 * done / max(total, 1)))
        text = f"Classify All: {percent}% ({done}/{total}) {name}"
        try:
            dlg.set_item_text("LbClassifyStatus", text)
        except Exception:
            pass
        print(f"[V2.4-PROGRESS] {text}")

    print(f"[V2.4] Classify All started: {len(bodies)} bodies.")
    ok = do_classify(dlg, bodies_override=bodies, progress=progress)
    if ok:
        _save_classification_state(dlg)
        try:
            dlg.set_item_text(
                "LbClassifyStatus",
                f"READY: {len(bodies)} bodies cached (100%)")
        except Exception:
            pass
        print("[V2.4] Classify All complete; Select buttons now use cache.")
        n = len(_state.get("outer", [])) + len(_state.get("inner", [])) \
            + len(_state.get("hole", [])) + len(_state.get("contact", []))
        if notify:
            _msgbox(f"Classify All complete.\n{len(bodies)} bodies, {n} faces "
                    "classified.\nSelect a part, then press OUTER / INNER / "
                    "HOLE / CONTACT.")
        return True
    return False


def _select_faces(kind):
    ids = _state[kind]
    if not ids:
        print(f"[V2.4] No {kind} faces yet (run Classify or Classify All).")
        return
    JPT.ClearAllSelection()
    JPT.SelectionByIDs(JPT.DItemType.FACE, list(ids), True)
    print(f"[V2.4] Selected {len(ids)} {kind.upper()} faces.")


def _pick_color_dialog():
    """Return [r, g, b] from the standard Windows color dialog, or None."""
    import ctypes
    from ctypes import wintypes

    class CHOOSECOLORW(ctypes.Structure):
        _fields_ = [
            ("lStructSize", wintypes.DWORD),
            ("hwndOwner", wintypes.HWND),
            ("hInstance", wintypes.HWND),
            ("rgbResult", wintypes.COLORREF),
            ("lpCustColors", ctypes.POINTER(wintypes.COLORREF)),
            ("Flags", wintypes.DWORD),
            ("lCustData", wintypes.LPARAM),
            ("lpfnHook", ctypes.c_void_p),
            ("lpTemplateName", wintypes.LPCWSTR),
        ]

    custom = (wintypes.COLORREF * 16)()
    choice = CHOOSECOLORW()
    choice.lStructSize = ctypes.sizeof(CHOOSECOLORW)
    choice.lpCustColors = custom
    choice.Flags = 0x00000002  # CC_FULLOPEN
    if not ctypes.windll.comdlg32.ChooseColorW(ctypes.byref(choice)):
        return None
    value = int(choice.rgbResult)
    return [value & 255, (value >> 8) & 255, (value >> 16) & 255]


def _load_class_colors():
    _state["class_colors"] = {}
    try:
        with open(_CLASS_COLOR_CFG, "r", encoding="utf-8") as fh:
            saved = json.load(fh)
        for kind in ("outer", "inner", "hole", "contact"):
            rgb = saved.get(kind)
            if (isinstance(rgb, list) and len(rgb) == 3
                    and all(isinstance(v, int) and 0 <= v <= 255
                            for v in rgb)):
                _state["class_colors"][kind] = rgb
    except Exception:
        pass


def _save_class_colors():
    try:
        os.makedirs(os.path.dirname(_CLASS_COLOR_CFG), exist_ok=True)
        with open(_CLASS_COLOR_CFG, "w", encoding="utf-8") as fh:
            json.dump(_state["class_colors"], fh, indent=2)
    except Exception as exc:
        print(f"[V2.5-COLOR] Could not save class colors: {exc}")


def _bulk_set_face_color(faces, jpt_color):
    items = [JPT.CastToDItem(face) for face in faces]
    cursors = JPT.DItemListToMacroListTCursor(items)
    result = JPT.Exec(f"ChangeEntityColor({cursors}, {int(jpt_color)})")
    if str(result).strip() in ("", "0"):
        raise RuntimeError(f"ChangeEntityColor returned {result!r}")


def _apply_saved_class_colors(face_ids):
    """Recolor only affected faces from their final classification."""
    scope = set(face_ids)
    colors = _state.get("class_colors", {})
    if not scope or not colors:
        return
    # Later classes win for overlapping INNER/HOLE/CONTACT memberships.
    assigned = {}
    for kind in ("outer", "inner", "hole", "contact"):
        if kind in colors:
            for fid in scope & set(_state.get(kind, [])):
                assigned[fid] = kind
    if not assigned:
        return
    objects = {}
    try:
        bodies = JPT.GetAllParts()
    except Exception:
        bodies = []
    remaining = set(assigned)
    for body in bodies:
        if not remaining:
            break
        try:
            for face in body.faces:
                if face.id in remaining:
                    objects[face.id] = face
                    remaining.remove(face.id)
        except Exception:
            pass
    for kind in ("outer", "inner", "hole", "contact"):
        faces = [objects[fid] for fid, final_kind in assigned.items()
                 if final_kind == kind and fid in objects]
        if not faces:
            continue
        rgb = colors[kind]
        color = JPT.ConvertRGBToJPTColor(rgb[0], rgb[1], rgb[2])
        _bulk_set_face_color(faces, color)
    print(f"[V2.5-COLOR] Updated colors for {len(objects)} affected face(s).")


def do_set_selected_color(dlg):
    kind = _state.get("active_color_kind")
    if kind not in ("outer", "inner", "hole", "contact"):
        print("[V2.5-COLOR] Press SHOW OUTER/INNER/HOLE/CONTACT first.")
        return
    try:
        faces = list(JPT.GetSelectedFaces())
    except Exception as exc:
        print(f"[V2.5-COLOR] Could not read face selection: {exc}")
        return
    if not faces:
        print("[V2.5-COLOR] No face selected.")
        return
    rgb = _pick_color_dialog()
    if rgb is None:
        return
    try:
        color = JPT.ConvertRGBToJPTColor(rgb[0], rgb[1], rgb[2])
        _bulk_set_face_color(faces, color)
        _state["class_colors"][kind] = rgb
        _save_class_colors()
        print(f"[V2.5-COLOR] Saved {kind.upper()} = RGB{tuple(rgb)}; set "
              f"{len(faces)} selected face(s).")
    except Exception as exc:
        print(f"[V2.5-COLOR] Could not set selected face color: {exc}")


def do_sel_outer(dlg):
    _auto_classify(dlg)
    _state.setdefault("edit_scopes", {})["outer"] = list(
        _state.get("outer", []))
    _select_faces("outer")
    _state["active_color_kind"] = "outer"


def do_sel_inner(dlg):
    _auto_classify(dlg)
    _state.setdefault("edit_scopes", {})["inner"] = list(
        _state.get("inner", []))
    _select_faces("inner")
    _state["active_color_kind"] = "inner"


def do_sel_hole(dlg):
    _auto_classify(dlg)
    _state.setdefault("edit_scopes", {})["hole"] = list(
        _state.get("hole", []))
    _select_faces("hole")
    _state["active_color_kind"] = "hole"


def do_sel_contact(dlg):
    _auto_classify(dlg)
    _state.setdefault("edit_scopes", {})["contact"] = list(
        _state.get("contact", []))
    _select_faces("contact")
    _state["active_color_kind"] = "contact"


def _show_name(dlg, item, prefix, path):
    """Put just the file NAME on a label so it is readable regardless of how
    the (left-aligned) browser field clips a long path."""
    try:
        dlg.set_item_text(item, f"{prefix}{os.path.basename(path)}"
                          if path else prefix)
    except Exception:
        pass


def _set_load_status(dlg, text):
    """Update section 2 only; analyzer status in section 1 is independent."""
    try:
        dlg.set_item_text("LbLoadStatus", text)
    except Exception:
        pass


def _on_pick_bdf(dlg, path_list=None):
    """Remember the BDF selected in the native browser."""
    p = path_list[0] if path_list else _get_bdf(dlg)
    if p:
        _learn_root_from(p)
        _save_bdf(p)
        _invalidate_caches("BDF path changed")
        _show_name(dlg, "LbB", "BDF: ", p)
        print(f"[V2.4] Selected BDF: {p}")


def _on_pick_json(dlg, path_list=None):
    """Remember the JSON index and print its dataset checklist."""
    p = path_list[0] if path_list else _get_json(dlg)
    if not p:
        return
    _learn_root_from(p)
    _save_json(p)
    d = os.path.dirname(p)
    _invalidate_caches("JSON path changed")
    _show_name(dlg, "LbJ", "JSON: ", p)
    _set_load_status(dlg, "Status: dataset selected; press Load")
    print(f"[V2.4] Selected JSON index: {p}")
    print(f"[V2.4] Dataset folder: {d}")
    for fn in ("outer_visible_eids_split.json",
               "outer_reach_eids_split.json",
               "outer_visible_eids.json"):
        ok = os.path.isfile(os.path.join(d, fn))
        print(f"       {'OK     ' if ok else 'MISSING'} {fn}")


def do_load_json(dlg):
    """Validate the selected result dataset and invalidate stale results."""
    p = _get_json(dlg)
    if not p:
        print("[JSON] No index selected. Browse to <bdf>.outer_index.json.")
        _set_load_status(dlg, "ERROR: no JSON index selected")
        return False
    _save_json(p)
    d = os.path.dirname(os.path.abspath(p))
    print(f"[JSON] Index: {p}")
    if p.endswith(".outer_index.json"):
        try:
            with open(p, "r", encoding="utf-8") as fh:
                idx = json.load(fh)
            print(f"[JSON] BDF: {idx.get('bdf', '?')} "
                  f"(created {idx.get('created', '?')})")
        except Exception as exc:
            print(f"[JSON] WARNING: could not read index ({exc}).")
    missing = []
    for fn in ("outer_visible_eids_split.json",
               "outer_reach_eids_split.json",
               "outer_visible_eids.json"):
        if not os.path.isfile(os.path.join(d, fn)):
            missing.append(fn)
    if missing:
        print("[JSON] ERROR: required files are missing:")
        for fn in missing:
            print(f"       MISSING {fn}")
        print("[JSON] Run the analyzer again for this model.")
        _set_load_status(dlg, f"ERROR: {len(missing)} required file(s) missing")
        return False
    try:
        with open(os.path.join(d, "outer_visible_eids_split.json"),
                  "r", encoding="utf-8") as fh:
            nparts = len(json.load(fh))
    except Exception as exc:
        print(f"[JSON] ERROR: invalid JSON ({exc}).")
        _set_load_status(dlg, "ERROR: invalid result JSON")
        return False
    _invalidate_caches("JSON dataset loaded")
    _load_overrides(dlg)
    restored = _load_classification_state(dlg)
    _set_load_status(dlg, f"READY: JSON loaded for {nparts} parts")
    print(f"[JSON] READY: complete dataset for {nparts} parts.")
    if restored:
        print("[JSON] Last saved classification is ready for SHOW.")
    return True


def _get_outdir(dlg, bdf):
    """Auto-name the analyzer output folder, created next to the BDF.

    Folder name = the current jth5 document name (fallback: the BDF stem).
    If a folder of that name already exists, bump 01, 02, ... so a fresh run
    never overwrites a previous dataset."""
    base_dir = os.path.dirname(os.path.abspath(bdf))
    stem = ""
    try:
        docp = JPT.GetCurrentDocumentPath()
        if docp:
            stem = os.path.splitext(os.path.basename(docp))[0]
    except Exception:
        pass
    if not stem:
        stem = os.path.splitext(os.path.basename(bdf))[0]
    stem = "".join(c if (c.isalnum() or c in "-_.") else "_"
                   for c in stem) or "model"
    cand = os.path.join(base_dir, stem)
    i = 1
    while os.path.exists(cand):
        cand = os.path.join(base_dir, "%s%02d" % (stem, i))
        i += 1
    return cand


def _find_analyzer_status_hwnd():
    """Return the upper Status label handle for the completion notifier."""
    try:
        import ctypes
        from ctypes import wintypes
        user32 = ctypes.windll.user32
        callback = ctypes.WINFUNCTYPE(
            wintypes.BOOL, wintypes.HWND, wintypes.LPARAM)
        candidates = []

        def top_cb(top, _):
            title = ctypes.create_unicode_buffer(256)
            user32.GetWindowTextW(top, title, len(title))
            if title.value != "Surface Split v2.5":
                return True

            def child_cb(child, __):
                cls = ctypes.create_unicode_buffer(64)
                text = ctypes.create_unicode_buffer(256)
                user32.GetClassNameW(child, cls, len(cls))
                user32.GetWindowTextW(child, text, len(text))
                if cls.value == "Static" and text.value.startswith("Status:"):
                    rect = wintypes.RECT()
                    user32.GetWindowRect(child, ctypes.byref(rect))
                    candidates.append((rect.top, int(child)))
                return True

            user32.EnumChildWindows(top, callback(child_cb), 0)
            return True

        user32.EnumWindows(callback(top_cb), 0)
        return min(candidates)[1] if candidates else 0
    except Exception:
        return 0


def _analyzer_progress_from_log(log_path):
    """v2.4 status behavior: read the latest phase when Run is pressed."""
    try:
        with open(log_path, "r", encoding="utf-8", errors="replace") as fh:
            lines = [line.strip() for line in fh if line.strip()]
    except Exception:
        return 0, "Starting analyzer"
    if not lines:
        return 0, "Starting analyzer"
    text = "Reading BDF"
    local = 0.0
    second_run = any("face-level" in line for line in lines)
    phase_map = (("[1/5]", 2, "Reading BDF"),
                 ("[2/5]", 15, "Building voxel grid"),
                 ("[3/5]", 22, "Voxelizing surfaces"),
                 ("[3b]", 32, "Closing holes"),
                 ("[4/5]", 42, "Flood filling outside air"),
                 ("[4c]", 52, "Computing air reach"),
                 ("[4b]", 58, "Computing proximity"),
                 ("[5/6]", 62, "Computing visibility"),
                 ("[6/6]", 95, "Writing JSON"),
                 ("Tong thoi gian", 100, "Run complete"))
    start = max((i for i, line in enumerate(lines)
                 if "[FAST] ====" in line), default=0)
    for line in lines[start:]:
        for marker, percent, label in phase_map:
            if marker in line:
                local, text = percent, label
        if line.startswith("view "):
            try:
                current, total = line.split()[1].split("/")
                local = 62 + 30 * int(current) / max(int(total), 1)
                text = "Visibility view %s/%s" % (current, total)
            except Exception:
                pass
    if any("[FAST] ALL DONE." in line for line in lines):
        return 100, "Analyzer complete"
    overall = (45 + 0.50 * local) if second_run else (0.45 * local)
    return min(99, int(round(overall))), text


def do_run_analyzer(dlg):
    """Run analyzer in background; report only completion or failure."""
    import subprocess
    import time as _time
    proc = _state.get("analyzer_proc")
    if proc is not None and proc.poll() is None:
        percent, phase = _analyzer_progress_from_log(
            _state.get("analyzer_log", ""))
        elapsed = int(_time.time() - _state.get("analyzer_t0", _time.time()))
        status = "Analyzer: %d%% - %s (%ds)" % (percent, phase, elapsed)
        dlg.set_item_text("LbStatus", status)
        print("[ANALYZER] " + status)
        return
    if proc is not None and proc.poll() is not None:
        old_log = _state.pop("analyzer_log_handle", None)
        if old_log:
            try:
                old_log.close()
            except Exception:
                pass
        if proc.poll() == 0:
            dlg.set_item_text("LbStatus", "READY: Analyzer complete (100%)")
            print("[ANALYZER] Analyzer already completed; new run blocked. "
                  "Reopen Surface Split to start another run.")
        else:
            dlg.set_item_text("LbStatus", "FAILED: Analyzer did not complete")
            print("[ANALYZER] Previous analyzer failed; automatic rerun "
                  "blocked. Reopen Surface Split to try again.")
        return
    bdf = _get_bdf(dlg)
    if not bdf:
        print("[ANALYZER] Select a mesh BDF first.")
        return
    if not os.path.isfile(_ANALYZER_FAST):
        print(f"[ANALYZER] Analyzer script not found: {_ANALYZER_FAST}\n"
              "           The install folder is not located. Set the "
              "OUTER_EXTRACT_ROOT env var or browse a BDF inside the package.")
        return
    if not os.path.isfile(_ANALYZER_PY):
        print(f"[ANALYZER] Jupiter python.exe not found next to the app: "
              f"{_ANALYZER_PY}")
        return
    outdir = _get_outdir(dlg, bdf)
    try:
        os.makedirs(outdir, exist_ok=True)
    except Exception as exc:
        print(f"[ANALYZER] Could not create output folder {outdir}: {exc}")
        return
    _save_bdf(bdf)
    # Clear the old JSON selection so it is not confused with the run in
    # progress.  The user loads the new index after the completion notice.
    try:
        dlg.set_item_text("TbJson", "")
        dlg.set_item_text("LbJ", "Select <bdf>.outer_index.json:")
    except Exception:
        pass
    _save_json("")
    _invalidate_caches("analyzer started")
    proc, log, log_path = _analyzer.start(
        _ANALYZER_PY, _ANALYZER_FAST, bdf, outdir, _DIR)
    _state["analyzer_proc"] = proc
    _state["analyzer_log_handle"] = log
    _state["analyzer_log"] = log_path
    _state["analyzer_t0"] = _time.time()
    _state["analyzer_bdf"] = bdf
    # Capture the native label handle while its text still starts with
    # "Status:".  _find_analyzer_status_hwnd() uses that prefix to identify
    # the section-1 status label; after the next line the prefix is gone.
    status_hwnd = _find_analyzer_status_hwnd()
    dlg.set_item_text("LbStatus", "Analyzer: 0% - Starting")
    if status_hwnd and os.path.isfile(_ANALYZER_UI_WATCHER):
        ui_proc = subprocess.Popen(
            [_ANALYZER_PY, _ANALYZER_UI_WATCHER,
             "--pid", str(proc.pid), "--status-hwnd", str(status_hwnd)],
            cwd=_DIR, creationflags=0x00000008 | 0x08000000)
        print(f"[ANALYZER] Completion notifier PID {ui_proc.pid}.")
    else:
        print("[ANALYZER] WARNING: completion notifier unavailable.")
    print(f"[ANALYZER] Started PID {proc.pid}: {bdf}")
    print(f"[ANALYZER] Output folder: {outdir}")
    print("[ANALYZER] Running in background; a message appears when finished.")


def do_cancel(dlg):
    """Confirm on close while the analyzer is still running.

    The analyzer runs as a detached background process, so closing the window
    does NOT stop it - it finishes and writes its results; the user just loses
    the automatic load. We warn so a close is not accidental. (Whether the
    dialog honors the return to stay open is framework-dependent.)"""
    proc = _state.get("analyzer_proc")
    if proc is not None and proc.poll() is None:
        return _msgbox(
            "The analyzer is still running.\nIt keeps running in the "
            "background even if you close this window (reopen and Load JSON "
            "when it finishes).\nClose the tool anyway?", kind="yesno")
    return None


def simulate_space_key():
    import ctypes
    ctypes.windll.user32.keybd_event(0x20, 0, 0, 0)
    ctypes.windll.user32.keybd_event(0x20, 0, 2, 0)


def _open_help(path, label):
    """Open a self-contained offline Help page in the default browser."""
    if not os.path.isfile(path):
        msg = f"Help file is missing: {path}"
        print(f"[V2.4] {msg}")
        _msgbox(msg, kind="warning")
        return
    try:
        # Jupiter runs on Windows.  startfile preserves a local file path and
        # lets the user's default browser render the self-contained HTML.
        os.startfile(os.path.abspath(path))
        print(f"[V2.4] Opened {label} Help: {path}")
    except Exception as exc:
        msg = f"Could not open {label} Help: {exc}"
        print(f"[V2.4] {msg}")
        _msgbox(msg, kind="warning")


def do_help_en(dlg):
    _open_help(_HELP_EN_PATH, "English")


def do_help_vi(dlg):
    _open_help(_HELP_VI_PATH, "Vietnamese")


def main():
    _load_class_colors()

    # ---- grid metrics: one shared content width so every row's left and
    # right edges line up (browser, textbox, full buttons, status, and the
    # button rows all span COL_FULL). ----
    COL_FULL = 372          # full content width of every group box
    BTN_H = 22              # Jupiter's documented/default tool button height
    GAP = 4                 # gap between buttons in a row
    QUAD = (COL_FULL - 3 * GAP) // 4   # width of each of 4 buttons in a row
    TRI = (COL_FULL - 2 * GAP) // 3    # width of each of 3 buttons in a row
    PAIR = (COL_FULL - GAP) // 2        # wide SET buttons in section 4

    # Keep the main tool window at its designed fixed layout.  This setting
    # does not control the native file picker opened by add_browser().
    dlg = JDGCreator(title="Surface Split v2.5", resizable=False)
    # Selection list: Part selector on top, Face selector below (Force uses
    # the faces selected here / in Jupiter).
    dlg.add_part_selector()
    try:
        dlg.add_face_selector()
    except Exception as exc:
        print(f"[V2.4] Face selector unavailable: {exc}")

    # Labels double as filename readouts: the browser field is left-aligned so
    # a long path hides its tail, but the label shows the file NAME clearly.
    _b0, _j0 = _get_bdf(), _get_json()

    # ===== 1) Analyze a new model =====
    dlg.add_groupbox(name="GrpAn", text="1) Analyze a new model",
                     layout="Window")
    dlg.add_label(name="LbB",
                  text=("BDF: " + os.path.basename(_b0)) if _b0 else "BDF path:",
                  layout="GrpAn")
    dlg.add_browser(name="TbBdf", mode="file",
                    file_filter="NASTRAN bdf(*.bdf);;All Files(*.*)",
                    default=_b0, layout="GrpAn")
    dlg.add_button(name="BtnAn", text="Run Analyzer (~1 min, progress)",
                   width=COL_FULL, height=BTN_H, layout="GrpAn")
    dlg.add_label(name="LbStatus", text="Status: waiting",
                  width=COL_FULL, height=22, layout="GrpAn")

    # ===== 2) Load an existing result dataset =====
    dlg.add_groupbox(name="GrpJs",
                     text="2) Load an existing result dataset",
                     layout="Window")
    dlg.add_label(name="LbJ",
                  text=("JSON: " + os.path.basename(_j0)) if _j0
                  else "Select <bdf>.outer_index.json:", layout="GrpJs")
    dlg.add_browser(name="TbJson", mode="file",
                    file_filter="Outer index(*.outer_index.json);;"
                                "JSON(*.json);;All Files(*.*)",
                    default=_j0, layout="GrpJs")
    dlg.add_button(name="BtnLoad", text="Load and validate JSON",
                   width=COL_FULL, height=BTN_H, layout="GrpJs")
    dlg.add_label(name="LbLoadStatus", text="Status: waiting",
                  width=COL_FULL, height=22, layout="GrpJs")

    # ===== 3) Classify and select =====
    dlg.add_groupbox(name="GrpA", text="3) Classify and select",
                     layout="Window")
    dlg.add_label(name="LbG", text="Classify once, then select bodies/faces:",
                  layout="GrpA")
    dlg.add_label(name="LbClassifyStatus", text="Status: waiting",
                  width=COL_FULL, height=22, layout="GrpA")
    dlg.add_button(name="BtnAll", text="Classify All (cache full model)",
                   width=COL_FULL, height=BTN_H, layout="GrpA")
    dlg.add_hlayout(name="RowSel", margin=[0, 0, 0, 0], layout="GrpA")
    dlg.add_button(name="BtnO", text="SHOW OUTER",
                   width=QUAD, height=BTN_H, layout="RowSel")
    dlg.add_button(name="BtnI", text="SHOW INNER",
                   width=QUAD, height=BTN_H, layout="RowSel")
    dlg.add_button(name="BtnH", text="SHOW HOLE",
                   width=QUAD, height=BTN_H, layout="RowSel")
    dlg.add_button(name="BtnC", text="SHOW CONTACT",
                   width=QUAD, height=BTN_H, layout="RowSel")
    dlg.add_hlayout(name="RowTools", margin=[0, 0, 0, 0], layout="GrpA")
    dlg.add_button(name="BtnDbg", text="Debug selected faces",
                   width=PAIR, height=BTN_H, layout="RowTools")
    dlg.add_button(name="BtnSetColor", text="SET COLOR...",
                   width=PAIR, height=BTN_H, layout="RowTools")
    dlg.add_label(name="LbDebugStatus", text="Debug: waiting",
                  width=COL_FULL, height=22, layout="GrpA")

    # ===== 4) Save edited classification =====
    dlg.add_groupbox(name="GrpOv",
                     text="4) SET / SAVE edited classification",
                     layout="Window")
    dlg.add_label(name="LbOv",
                  text="SHOW in section 3 -> adjust faces -> SET here:",
                  layout="GrpOv")
    dlg.add_hlayout(name="RowSet1", margin=[0, 0, 0, 0], layout="GrpOv")
    dlg.add_button(name="BtnFO", text="SET OUTER",
                   width=PAIR, height=BTN_H, layout="RowSet1")
    dlg.add_button(name="BtnFI", text="SET INNER",
                   width=PAIR, height=BTN_H, layout="RowSet1")
    dlg.add_hlayout(name="RowSet2", margin=[0, 0, 0, 0], layout="GrpOv")
    dlg.add_button(name="BtnFH", text="SET HOLE",
                   width=PAIR, height=BTN_H, layout="RowSet2")
    dlg.add_button(name="BtnFK", text="SET CONTACT",
                   width=PAIR, height=BTN_H, layout="RowSet2")
    dlg.add_label(name="LbOverrideStatus", text="Edit status: waiting",
                  width=COL_FULL, height=22, layout="GrpOv")
    dlg.add_button(name="BtnFX", text="RESET override on selected faces",
                   width=COL_FULL, height=BTN_H, layout="GrpOv")

    # ===== Offline Help =====
    HALF = PAIR
    dlg.add_groupbox(name="GrpHelp", text="Help (offline)", layout="Window")
    dlg.add_hlayout(name="RowHelp", margin=[0, 0, 0, 0], layout="GrpHelp")
    # ASCII labels avoid encoding corruption in Jupiter's native dialog.
    dlg.add_button(name="BtnHelpEn", text="Help EN",
                   width=HALF, height=BTN_H, layout="RowHelp")
    dlg.add_button(name="BtnHelpVi", text="Help VN",
                   width=HALF, height=BTN_H, layout="RowHelp")

    dlg.on_button_clicked(name="BtnAn", callfunc=do_run_analyzer)
    dlg.on_button_clicked(name="BtnLoad", callfunc=do_load_json)
    dlg.on_button_clicked(name="BtnAll", callfunc=do_classify_all)
    try:
        dlg.on_browse("TbBdf", _on_pick_bdf)
        dlg.on_browse("TbJson", _on_pick_json)
    except Exception:
        pass
    dlg.on_button_clicked(name="BtnDbg", callfunc=do_debug_visible)
    dlg.on_button_clicked(name="BtnSetColor", callfunc=do_set_selected_color)
    dlg.on_button_clicked(name="BtnO", callfunc=do_sel_outer)
    dlg.on_button_clicked(name="BtnI", callfunc=do_sel_inner)
    dlg.on_button_clicked(name="BtnH", callfunc=do_sel_hole)
    dlg.on_button_clicked(name="BtnC", callfunc=do_sel_contact)
    dlg.on_button_clicked(name="BtnFO", callfunc=do_force_outer)
    dlg.on_button_clicked(name="BtnFI", callfunc=do_force_inner)
    dlg.on_button_clicked(name="BtnFH", callfunc=do_force_hole)
    dlg.on_button_clicked(name="BtnFK", callfunc=do_force_contact)
    dlg.on_button_clicked(name="BtnFX", callfunc=do_clear_override)
    dlg.on_button_clicked(name="BtnHelpEn", callfunc=do_help_en)
    dlg.on_button_clicked(name="BtnHelpVi", callfunc=do_help_vi)
    dlg.on_dlg_apply(callfunc=do_classify)
    dlg.on_dlg_ok(callfunc=lambda d: None)
    try:
        dlg.on_dlg_cancel(callfunc=do_cancel)
    except Exception as exc:
        print(f"[V2.4] Close-confirm unavailable: {exc}")
    # Reopening the tool should restore the last SET/Classify result without
    # requiring another Classify All. The snapshot is dataset-local.
    if _j0:
        _load_overrides(dlg)
        if _load_classification_state(dlg):
            try:
                dlg.set_item_text("LbClassifyStatus",
                                  "READY: last saved classification restored")
            except Exception:
                pass
    simulate_space_key()
    dlg.generate_window()


if __name__ == "__main__":
    main()
