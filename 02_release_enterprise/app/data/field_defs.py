import json
from app.logic.parse_utils import choice_list
from app.data.settings import CORE_FIELD_KEYS, HEREDOC_INPUT_FIELDS, _default_solver_fields


def default_solver_fields(s=None):
    """Six default sub-fields for a new solver.

    `s` is optional — keep the signature flexible for UI callers (e.g. when creating a new solver).
    """
    return [dict(f) for f in _default_solver_fields()]


def normalize_field_defs(fields, s=None):
    """Normalize a list of field definitions (key/label/type/role/default/required/choices).

    Drop fields missing a key, dedupe, force valid role for special keys (sleep).
    """
    if not isinstance(fields, list) or not fields:
        return default_solver_fields(s)
    normalized = []
    seen = set()
    for f in fields:
        if not isinstance(f, dict):
            continue
        key = str(f.get('key', '')).strip()
        if not key or key in seen:
            continue
        seen.add(key)
        nf = {
            'key': key,
            'label': str(f.get('label') or key),
            'type': str(f.get('type') or 'text'),
            'role': str(f.get('role') or 'heredoc_input'),
            'default': str(f.get('default', '')),
            'required': bool(f.get('required', False)),
            'show_label': bool(f.get('show_label', False)),
            'choices': choice_list(f.get('choices', [])),
        }
        if key == 'sleep':
            nf.update({'type': 'text', 'role': 'sleep', 'show_label': True})
        normalized.append(nf)
    return normalized


def resolve_fields_for_solver(solver_def, s=None):
    """Return the solver's sub-fields, normalized.

    Returns an empty list if solver_def is None/invalid.
    """
    if not isinstance(solver_def, dict):
        return []
    return normalize_field_defs(solver_def.get('fields', []), s)


def field_value(data, key, filename=''):
    if key == 'filename':
        return filename or data.get('filename', '')
    return str(data.get(key, ''))


def field_display(field, value):
    value = str(value)
    for ch in field.get('choices', []):
        if str(ch.get('value', '')) == value:
            return str(ch.get('display', value))
    return value


def choice_value(field, display):
    display = str(display)
    for ch in field.get('choices', []):
        if str(ch.get('display', '')) == display:
            return str(ch.get('value', display))
    return display
