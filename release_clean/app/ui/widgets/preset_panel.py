"""PresetPanel — horizontal/grid solver fields with labels placed on top.

No header dropdown or buttons here. They are placed in the card's title bar.
"""

from PySide2.QtWidgets import (
    QWidget, QVBoxLayout, QGridLayout, QLabel, QComboBox, QLineEdit,
    QSizePolicy, QInputDialog, QMessageBox,
)
from PySide2.QtCore import Signal

from app.data.field_defs import resolve_fields_for_solver, field_display, choice_value
from app.data.settings import get_solver
from app.data.presets import load_presets, save_presets
from app.ui import message_box


class PresetPanel(QWidget):
    solver_change_requested = Signal(str)   # solver change signal
    values_changed = Signal()
    preset_saved = Signal(str)  # emitted with the new preset name after save_preset()

    def __init__(self, data: dict, settings: dict, collapsed: bool = True, parent=None):
        super().__init__(parent)
        self._data = data
        self._s = settings
        self._field_widgets = {}    # key → widget
        self._field_meta    = {}    # key → field def
        self._suppress_solver_signal = False
        self._presets = load_presets(settings)
        
        if 'settings_collapsed' in self._data:
            self._collapsed = bool(self._data['settings_collapsed'])
        else:
            self._collapsed = bool(collapsed)
            self._data['settings_collapsed'] = self._collapsed
            
        self._init_ui()

    def _init_ui(self):
        root = QVBoxLayout(self)
        root.setContentsMargins(0, 0, 0, 0)
        root.setSpacing(0)

        # Body layout: 2 rows of columns (Labels in Row 0, Controls in Row 1)
        # Row 2 and 3 are reserved for Sleep field (Delay between files (s))
        self._body = QWidget()
        self._body_layout = QGridLayout(self._body)
        self._body_layout.setContentsMargins(0, 4, 0, 4)
        self._body_layout.setSpacing(8)
        
        # Grid columns stretching
        for c in range(10):
            self._body_layout.setColumnStretch(c, 1)
            
        root.addWidget(self._body)

        self._build_body()
        self._body.setVisible(not self._collapsed)

    def toggle_collapsed(self):
        self._collapsed = not self._collapsed
        self._data['settings_collapsed'] = self._collapsed
        self._body.setVisible(not self._collapsed)
        
        self.updateGeometry()
        p = self.parentWidget()
        while p:
            p.updateGeometry()
            if p.__class__.__name__ in ('SingleCard', 'FolderGroupCard', 'MultiFolderCard'):
                p.adjustSize()
                break
            p = p.parentWidget()
        return self._collapsed

    def _build_body(self):
        # Clear body layout
        while self._body_layout.count():
            item = self._body_layout.takeAt(0)
            w = item.widget()
            if w is not None:
                w.setParent(None)
                w.deleteLater()
        
        self._field_widgets.clear()
        self._field_meta.clear()

        solver_names = list((self._s.get('solvers') or {}).keys())
        solver_name = str(self._data.get('solver') or
                          self._s.get('default_solver') or
                          (solver_names[0] if solver_names else 'nast'))
        self._data['solver'] = solver_name

        # Command / Solver combo
        lbl_cmd = QLabel('Command')
        lbl_cmd.setProperty('role', 'field-label-top')
        self.solver_cb = QComboBox()
        self.solver_cb.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Fixed)
        self.solver_cb.addItems(solver_names)
        idx = self.solver_cb.findText(solver_name)
        if idx >= 0:
            self.solver_cb.setCurrentIndex(idx)
        self.solver_cb.currentTextChanged.connect(self._on_solver_combo_changed)
        
        self._body_layout.addWidget(lbl_cmd, 0, 0)
        self._body_layout.addWidget(self.solver_cb, 1, 0)
        
        col_idx = 1
        
        # Filename input (if present in card data, e.g. SingleCard)
        # But wait! In the layout, we also have filename selection. 
        # Mirroring it in body matches the screenshot
        if 'filename' in self._data:
            lbl_fn = QLabel('Filename')
            lbl_fn.setProperty('role', 'field-label-top')
            self.fn_input = QLineEdit(self._data.get('filename', ''))
            self.fn_input.textChanged.connect(self._on_fn_input_changed)
            self._body_layout.addWidget(lbl_fn, 0, col_idx)
            self._body_layout.addWidget(self.fn_input, 1, col_idx)
            self._field_widgets['filename'] = self.fn_input
            col_idx += 1

        solver_def = get_solver(self._s, solver_name)
        fields = resolve_fields_for_solver(solver_def, self._s)
        
        sleep_field = None
        for f in fields:
            if f['key'] == 'sleep':
                sleep_field = f
                continue
            
            self._field_meta[f['key']] = f
            lbl_text = f.get('label', f['key'])
            if lbl_text == 'Ver': lbl_text = 'Version'
            elif lbl_text == 'Acous': lbl_text = 'Acoustic'
            
            lbl = QLabel(lbl_text)
            lbl.setProperty('role', 'field-label-top')
            
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
                w.setPlaceholderText(f.get('default', ''))
                w.textChanged.connect(self._on_any_changed)
                
            self._body_layout.addWidget(lbl, 0, col_idx)
            self._body_layout.addWidget(w, 1, col_idx)
            self._field_widgets[key] = w
            col_idx += 1

        # Delay / Sleep field on Row 2/3
        if sleep_field:
            self._field_meta['sleep'] = sleep_field
            lbl_sleep = QLabel('Delay between files (s)')
            lbl_sleep.setProperty('role', 'field-label-top')
            
            cur_sleep = str(self._data.get('sleep', sleep_field.get('default', '0.5')))
            self.sleep_input = QLineEdit(cur_sleep)
            self.sleep_input.setPlaceholderText(sleep_field.get('default', '0.5'))
            self.sleep_input.textChanged.connect(self._on_any_changed)
            
            self._body_layout.addWidget(lbl_sleep, 2, 0)
            self._body_layout.addWidget(self.sleep_input, 3, 0)
            self._field_widgets['sleep'] = self.sleep_input

    def _on_fn_input_changed(self, text):
        self._data['filename'] = text
        self.values_changed.emit()

    def update_filename_field(self, filename):
        if 'filename' in self._field_widgets:
            try:
                self._field_widgets['filename'].blockSignals(True)
                self._field_widgets['filename'].setText(filename)
            finally:
                self._field_widgets['filename'].blockSignals(False)

    def _on_solver_combo_changed(self, new_name):
        if self._suppress_solver_signal:
            return
        if new_name == self._data.get('solver'):
            return
        self.solver_change_requested.emit(new_name)

    def revert_solver_combo(self):
        cur = str(self._data.get('solver', ''))
        self._suppress_solver_signal = True
        idx = self.solver_cb.findText(cur)
        if idx >= 0:
            self.solver_cb.setCurrentIndex(idx)
        self._suppress_solver_signal = False

    def rebuild_for_solver(self, new_solver):
        self._data['solver'] = str(new_solver)
        self._build_body()

    def _on_any_changed(self, *_):
        self._flush()
        self.values_changed.emit()

    def _flush(self):
        self._data['solver'] = self.solver_cb.currentText()
        for key, w in self._field_widgets.items():
            if key == 'filename':
                continue
            f = self._field_meta.get(key, {})
            if f.get('type') == 'choice':
                self._data[key] = choice_value(f, w.currentText())
            else:
                self._data[key] = w.text().strip()

    def get_presets_list(self) -> list:
        return sorted(self._presets.keys())

    def apply_preset(self, name):
        preset = self._presets.get(name)
        if not preset:
            return
        target_solver = preset.get('solver', self._data.get('solver'))
        if target_solver != self._data.get('solver'):
            self._data['solver'] = target_solver
            self._build_body()
            
        for key, w in self._field_widgets.items():
            if key == 'filename':
                continue
            val = str(preset.get(key, ''))
            f = self._field_meta.get(key, {})
            if f.get('type') == 'choice':
                disp = field_display(f, val)
                i = w.findText(disp)
                if i >= 0:
                    w.setCurrentIndex(i)
            else:
                w.setText(val)
        self._data['preset'] = name
        self._flush()
        self.values_changed.emit()

    def save_preset(self):
        self._flush()
        name, ok = QInputDialog.getText(
            self, 'Save preset', 'Preset name:')
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
        # Build preset dict from current data
        preset = {'solver': self._data.get('solver', '')}
        for key in self._field_widgets:
            if key == 'filename':
                continue
            preset[key] = self._data.get(key, '')
        self._presets[name] = preset
        save_presets(self._presets, self._s)
        self._data['preset'] = name
        # Card owns the preset_combo — tell it to reload; without this the
        # newly-saved preset never appears in the dropdown until app restart.
        self.preset_saved.emit(name)
        message_box.information(self, 'Saved', f"Preset '{name}' saved.")
