"""SolverFieldsTable — vertical key/value rendering of solver settings.

Same API as PresetPanel (signals + methods) so detail_variants can swap
implementations. Internally uses `helpers.KVTable` so the layout matches
Claude Design v2.0 (kvKeyCell / kvValueCell with the monospace key on the
left and the editor on the right).

Phase B.4b widget — PresetPanel is kept around but no longer used by
detail_variants.
"""

from PySide2.QtWidgets import (
    QWidget, QVBoxLayout, QLabel, QComboBox, QLineEdit, QSizePolicy,
    QInputDialog, QMessageBox,
)
from PySide2.QtCore import Signal, Qt

from app.data.field_defs import resolve_fields_for_solver, field_display, choice_value
from app.data.settings import get_solver
from app.data.presets import load_presets, save_presets
from app.ui import message_box
from app.ui.widgets.helpers import KVTable


# Fields hidden from the table; surfaced elsewhere in the detail view.
_HIDDEN_KEYS = {"filename"}


class SolverFieldsTable(QWidget):
    """Drop-in replacement for PresetPanel with KVTable rendering."""

    solver_change_requested = Signal(str)
    values_changed = Signal()

    def __init__(self, data: dict, settings: dict,
                 collapsed: bool = False, parent=None):
        super().__init__(parent)
        self._data = data
        self._s = settings
        self._field_widgets = {}    # key → widget (excluding solver_cb)
        self._field_meta = {}       # key → field def
        self._suppress_solver_signal = False
        self._presets = load_presets(settings)

        if data is not None and 'settings_collapsed' in data:
            self._collapsed = bool(data['settings_collapsed'])
        else:
            self._collapsed = bool(collapsed)
            if data is not None:
                data['settings_collapsed'] = self._collapsed

        self._init_ui()

    # ── layout ─────────────────────────────────────────────────────────

    def _init_ui(self):
        root = QVBoxLayout(self)
        root.setContentsMargins(0, 0, 0, 0)
        root.setSpacing(0)

        self._table = KVTable(self)
        root.addWidget(self._table)

        self._placeholder = QLabel("")
        self._placeholder.setObjectName("solverFieldsPlaceholder")
        self._placeholder.setAlignment(Qt.AlignCenter)
        self._placeholder.setVisible(False)

        if self._data is None:
            self._table.setVisible(False)
        else:
            self._build_rows()
            self._table.setVisible(not self._collapsed)

    def _build_rows(self):
        self._table.clear()
        self._field_widgets.clear()
        self._field_meta.clear()

        solver_names = list((self._s.get('solvers') or {}).keys())
        solver_name = str(self._data.get('solver') or
                          self._s.get('default_solver') or
                          (solver_names[0] if solver_names else 'nast'))
        self._data['solver'] = solver_name

        # Row 1: command/solver
        self.solver_cb = QComboBox()
        self.solver_cb.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Fixed)
        self.solver_cb.addItems(solver_names)
        idx = self.solver_cb.findText(solver_name)
        if idx >= 0:
            self.solver_cb.setCurrentIndex(idx)
        self.solver_cb.currentTextChanged.connect(self._on_solver_combo_changed)
        self._table.add_row("command", self.solver_cb)

        # Remaining solver fields
        solver_def = get_solver(self._s, solver_name)
        fields = resolve_fields_for_solver(solver_def, self._s)
        # Sort so 'sleep' goes last (it represents inter-job delay, secondary).
        ordered = [f for f in fields if f['key'] != 'sleep']
        ordered += [f for f in fields if f['key'] == 'sleep']

        # When a preset is active, only its field keys are rendered. A preset
        # now stores only which fields exist, not their values.
        active_keys = self._data.get('preset_fields')
        if isinstance(active_keys, list) and active_keys:
            active_set = set(active_keys)
            ordered = [f for f in ordered if f['key'] in active_set]

        last_idx = len(ordered) - 1
        for i, f in enumerate(ordered):
            key = f['key']
            if key in _HIDDEN_KEYS:
                continue
            self._field_meta[key] = f
            w = self._build_field_widget(f)
            is_last = (i == last_idx)
            self._table.add_row(key, w, border_bottom=not is_last)
            self._field_widgets[key] = w

    def _build_field_widget(self, f: dict) -> QWidget:
        key = f['key']
        cur = str(self._data.get(key, f.get('default', '')))
        if f.get('type') == 'choice':
            w = QComboBox()
            w.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Fixed)
            choices = f.get('choices', [])
            w.addItems([str(c.get('display', c.get('value', ''))) for c in choices])
            disp = field_display(f, cur)
            i = w.findText(disp)
            if i >= 0:
                w.setCurrentIndex(i)
            w.currentIndexChanged.connect(self._on_any_changed)
        else:
            w = QLineEdit(cur)
            w.setProperty("monospace", "true")
            w.setPlaceholderText(f.get('default', ''))
            w.textChanged.connect(self._on_any_changed)
        return w

    # ── public API (mirrors PresetPanel) ───────────────────────────────

    def set_data(self, data, settings=None):
        """Rebind to a different row/card dict. Pass None to show no rows."""
        self._data = data
        if settings is not None:
            self._s = settings
            self._presets = load_presets(settings)
        if data is None:
            self._field_widgets.clear()
            self._field_meta.clear()
            self._table.clear()
            self._table.setVisible(False)
            self._placeholder.setVisible(False)
            return
        self._placeholder.setVisible(False)
        if 'settings_collapsed' in data:
            self._collapsed = bool(data['settings_collapsed'])
        else:
            data['settings_collapsed'] = self._collapsed
        self._build_rows()
        self._table.setVisible(not self._collapsed)

    def toggle_collapsed(self) -> bool:
        self._collapsed = not self._collapsed
        if self._data is not None:
            self._data['settings_collapsed'] = self._collapsed
            self._table.setVisible(not self._collapsed)
        return self._collapsed

    def is_collapsed(self) -> bool:
        return self._collapsed

    def has_data(self) -> bool:
        return self._data is not None

    def update_filename_field(self, filename: str):
        # Filename lives outside the solver table; nothing to do.
        pass

    def revert_solver_combo(self):
        cur = str(self._data.get('solver', ''))
        self._suppress_solver_signal = True
        idx = self.solver_cb.findText(cur)
        if idx >= 0:
            self.solver_cb.setCurrentIndex(idx)
        self._suppress_solver_signal = False

    def rebuild_for_solver(self, new_solver: str):
        self._data['solver'] = str(new_solver)
        self._build_rows()

    def get_presets_list(self) -> list:
        return sorted(self._presets.keys())

    def apply_preset(self, name: str):
        """A preset now only controls which solver fields exist in this view.
        Field values are NOT modified — they stay on the card data."""
        if self._data is None:
            return
        preset = self._presets.get(name)
        if not preset:
            return
        target_solver = preset.get('solver', self._data.get('solver'))
        self._data['solver'] = target_solver
        self._data['preset'] = name
        self._data['preset_fields'] = list(preset.get('fields') or [])
        self._build_rows()
        self.values_changed.emit()

    def save_preset(self):
        """Save the current set of visible solver fields as a named preset."""
        self._flush()
        name, ok = QInputDialog.getText(self, 'Save preset', 'Preset name:')
        name = (name or '').strip()
        if not ok or not name:
            return
        if name in self._presets:
            r = message_box.question(
                self, 'Overwrite?',
                f"Preset '{name}' already exists. Overwrite?",
                QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            if r != QMessageBox.Yes:
                return
        preset = {
            'solver': self._data.get('solver', ''),
            'fields': list(self._field_widgets.keys()),
        }
        self._presets[name] = preset
        save_presets(self._presets, self._s)
        self._data['preset'] = name
        self._data['preset_fields'] = list(self._field_widgets.keys())
        message_box.information(self, 'Saved', f"Preset '{name}' saved.")

    def preset_summary(self) -> str:
        """Compact one-line summary for the PresetChip.

        A preset is the set of fields that exist in it. Summary shows the
        current value; fields opt into `Label(value)` with `show_label`.
        """
        parts = []
        solver = self._data.get('solver', '')
        if solver:
            parts.append(str(solver))
        for key, f in self._field_meta.items():
            label = str(f.get('label') or key)
            value = str(self._data.get(key, f.get('default', '')))
            if f.get('type') == 'choice':
                value = field_display(f, value)
            parts.append(f"{label}({value})" if f.get('show_label') else value)
        return " · ".join(parts) if parts else "(no fields)"

    # ── internal ───────────────────────────────────────────────────────

    def _on_solver_combo_changed(self, new_name: str):
        if self._suppress_solver_signal:
            return
        if new_name == self._data.get('solver'):
            return
        self.solver_change_requested.emit(new_name)

    def _on_any_changed(self, *_):
        self._flush()
        self.values_changed.emit()

    def _flush(self):
        if self._data is None:
            return
        if hasattr(self, 'solver_cb') and self.solver_cb is not None:
            self._data['solver'] = self.solver_cb.currentText()
        for key, w in self._field_widgets.items():
            f = self._field_meta.get(key, {})
            if f.get('type') == 'choice':
                self._data[key] = choice_value(f, w.currentText())
            else:
                self._data[key] = w.text().strip()
