"""JSON evidence loading and caching without Jupiter/UI dependencies."""
import json
import os


CACHE = {"signature": None, "bundle": None}


def paths_signature(paths):
    signature = []
    for key in sorted(paths):
        path = paths[key]
        try:
            stat = os.stat(path)
            signature.append((key, path, stat.st_mtime_ns, stat.st_size))
        except Exception:
            signature.append((key, path, None, None))
    return tuple(signature)


def read_json_optional(path, default=None):
    try:
        with open(path, "r", encoding="utf-8") as stream:
            return json.load(stream)
    except Exception:
        return {} if default is None else default


def load_json_bundle(paths):
    signature = paths_signature(paths)
    if CACHE["signature"] == signature and CACHE["bundle"]:
        return CACHE["bundle"], signature, True
    if not os.path.isfile(paths["vis"]):
        raise OSError("Missing required file: " + paths["vis"])
    bundle = {
        key: read_json_optional(paths[key])
        for key in ("vis", "ct", "rc", "rc10", "rc20", "vis30")
    }
    CACHE["signature"] = signature
    CACHE["bundle"] = bundle
    return bundle, signature, False


def eids_for_body(data, body_name):
    """Return named EIDs plus anonymous candidates, matched by ID per body."""
    matched = set(data.get(body_name, []))
    anonymous = [values for name, values in data.items()
                 if str(name).startswith("__BDF_PID_")]
    matched.update(eid for values in anonymous for eid in values)
    return matched
