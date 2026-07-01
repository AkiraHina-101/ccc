from PySide2.QtWidgets import QMessageBox

from app.data.field_defs import resolve_fields_for_solver
from app.data.settings import get_solver
from app.ui import message_box


def confirm_and_swap(parent_widget, data, settings, strip, new_solver):
    """Confirm dialog -> swap solver fields. Returns True if swapped, False if user cancels.

    - data: dict card._data (will be mutated)
    - strip: SettingsStrip instance
    """
    old_solver = data.get('solver', '')
    if new_solver == old_solver:
        return True

    new_def = get_solver(settings, new_solver)
    new_fields = resolve_fields_for_solver(new_def, settings)
    new_keys = {f['key'] for f in new_fields}

    old_def = get_solver(settings, old_solver)
    old_fields = resolve_fields_for_solver(old_def, settings)
    orphan_keys = [f['key'] for f in old_fields if f['key'] not in new_keys]

    msg = (f"Change solver: '{old_solver}' -> '{new_solver}'.\n\n"
           f"Fields not in the new solver will be removed: "
           f"{', '.join(orphan_keys) if orphan_keys else '(none)'}.\n\n"
           "Continue?")
    btn = message_box.question(parent_widget, 'Change solver', msg,
                               QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
    if btn != QMessageBox.Yes:
        strip.revert_solver_combo()
        return False

    for k in orphan_keys:
        data.pop(k, None)
    for f in new_fields:
        if f['key'] not in data:
            data[f['key']] = f.get('default', '')
    data['solver'] = new_solver
    strip.rebuild_for_solver(new_solver)
    return True
