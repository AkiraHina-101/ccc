import json
import hashlib
from app.data.json_io import load_json, save_json, JSONLoadError, load_errors
from app.data.settings import PRESETS_FILE, get_solver
from app.data.field_defs import resolve_fields_for_solver


_RESERVED_KEYS = {'solver', 'fields', 'command', 'teraterm_fields',
                  'setting_order', 'preset', 'preset_fields'}


def normalize_preset(preset, s):
    """Ensure preset has shape `{'solver': str, 'fields': [field_keys]}`.

    A preset is now JUST a named selection of which solver sub-fields exist
    in this preset — it has no values and no choice metadata. Values stay
    in the live job/card data; choices live on the solver field definition.

    Migration: legacy presets that stored per-field values are converted by
    treating any non-reserved key as evidence the field belonged to the
    preset. If no field info can be recovered, every field on the solver is
    included by default. Orphan keys (not present on the solver anymore)
    are dropped.
    """
    preset = dict(preset or {})
    if 'solver' not in preset and 'command' in preset:
        preset['solver'] = preset.pop('command')
    solver_name = str(preset.get('solver') or s.get('default_solver') or 'nast')

    solver_def = get_solver(s, solver_name)
    valid = [f['key'] for f in resolve_fields_for_solver(solver_def, s)]
    valid_set = set(valid)

    raw_fields = preset.get('fields')
    if isinstance(raw_fields, list) and raw_fields:
        fields_list = [str(k) for k in raw_fields if str(k) in valid_set]
    else:
        # Legacy presets: any non-reserved key was a field value.
        legacy_keys = [k for k in preset.keys()
                       if k not in _RESERVED_KEYS and k in valid_set]
        fields_list = legacy_keys if legacy_keys else list(valid)

    return {'solver': solver_name, 'fields': fields_list}


def preset_hash(preset, s):
    preset = normalize_preset(preset, s)
    payload = {
        'solver': preset.get('solver', ''),
        'fields': sorted(preset.get('fields', [])),
    }
    raw = json.dumps(payload, sort_keys=True, ensure_ascii=True)
    return hashlib.sha1(raw.encode('utf-8')).hexdigest()


def load_presets(s):
    try:
        raw = load_json(PRESETS_FILE)
    except JSONLoadError as e:
        load_errors.append(e)
        raw = {}
    presets = {}
    if isinstance(raw, dict):
        for name, preset in raw.items():
            if str(name).strip() and isinstance(preset, dict):
                presets[str(name)] = normalize_preset(preset, s)
    return presets


def save_presets(presets, s):
    clean = {str(name): normalize_preset(preset, s)
             for name, preset in presets.items()
             if str(name).strip() and isinstance(preset, dict)}
    save_json(PRESETS_FILE, clean)


def preset_from_solver(solver_name, s):
    """Create a default preset containing every field of the solver."""
    solver_def = get_solver(s, solver_name)
    fields = resolve_fields_for_solver(solver_def, s)
    return {
        'solver': str(solver_name),
        'fields': [f['key'] for f in fields],
    }
