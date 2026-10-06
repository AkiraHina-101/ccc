"""Jupiter command launcher for the Surface Split runtime package."""
import os

try:
    import JPT as _JPT
except Exception:
    # Direct PSJ command execution can inject JPT into the caller globals.
    _JPT = globals().get("JPT")


_RUNTIME = os.path.join(
    os.environ.get("APPDATA", os.path.expanduser("~\\AppData\\Roaming")),
    "TechnoStar", "JPT5.0.4", "SurfaceSplitRuntime")
_TOOL = os.path.join(_RUNTIME, "tool_surface_split_v2_5.py")

if not os.path.isfile(_TOOL):
    raise RuntimeError("Surface Split runtime is missing: " + _TOOL)
if _JPT is None:
    raise RuntimeError("Jupiter JPT API is unavailable in this command context")

# The tool uses this package root for its analyzers, Help pages, and cache.
os.environ["OUTER_EXTRACT_ROOT"] = _RUNTIME
with open(_TOOL, "r", encoding="utf-8") as _fh:
    _code = compile(_fh.read(), _TOOL, "exec")
_scope = {"__name__": "__main__", "__file__": _TOOL, "JPT": _JPT}
exec(_code, _scope)
