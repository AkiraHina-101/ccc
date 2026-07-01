import re

from PySide2.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QFormLayout, QLineEdit, QComboBox,
    QCheckBox, QTableWidget, QTableWidgetItem, QHeaderView, QPushButton,
    QDialogButtonBox, QLabel, QWidget, QMessageBox,
)
from PySide2.QtCore import Qt

from app.logic.parse_utils import choice_list
from app.ui import message_box


def slugify(label):
    """Convert label -> safe key. 'Memory (GB)' -> 'memory_gb'."""
    s = re.sub(r'[^a-zA-Z0-9]+', '_', str(label).lower()).strip('_')
    return s or 'field'


def unique_key(base, existing_keys):
    """Append _2, _3, ... if base already taken. existing_keys is set/list."""
    if base not in existing_keys:
        return base
    i = 2
    while f'{base}_{i}' in existing_keys:
        i += 1
    return f'{base}_{i}'


class FieldEditorDialog(QDialog):
    """Popup to edit one sub-field of a solver.

    Input: field dict (may be empty for a new field).
    Output: dialog.result_field — dict after user clicks OK, or None on Cancel.
    """

    def __init__(self, field=None, existing_keys=None, parent=None):
        super().__init__(parent)
        self.setWindowTitle('Edit field')
        self.setObjectName('fieldEditorDialog')
        self.setAttribute(Qt.WA_StyledBackground, True)
        self.setMinimumWidth(520)
        self._field = dict(field or {})
        self._existing_keys = set(existing_keys or [])
        # When editing an existing field, drop its own key from existing to avoid self-conflict
        if self._field.get('key'):
            self._existing_keys.discard(self._field['key'])
        self.result_field = None
        self._init_ui()
        self._load_field()
        self._update_choices_visibility()
        self._apply_dark_title_bar()

    def _apply_dark_title_bar(self):
        """Match the app: dark native Windows title bar via DWM."""
        try:
            import sys
            if sys.platform != 'win32':
                return
            import ctypes
            from ctypes import wintypes
            hwnd = int(self.winId())
            value = ctypes.c_int(1)
            dwmapi = ctypes.windll.dwmapi
            for attr in (20, 19):
                try:
                    dwmapi.DwmSetWindowAttribute(
                        wintypes.HWND(hwnd), ctypes.c_int(attr),
                        ctypes.byref(value), ctypes.sizeof(value))
                except Exception:
                    pass
        except Exception:
            pass

    def _init_ui(self):
        root = QVBoxLayout(self)
        root.setContentsMargins(12, 12, 12, 12)
        root.setSpacing(10)

        form = QFormLayout()
        form.setLabelAlignment(Qt.AlignRight)

        self.label_input = QLineEdit()
        self.label_input.setPlaceholderText('e.g. Version, Memory (GB)')
        form.addRow('Label (UI text):', self.label_input)

        self.type_cb = QComboBox()
        self.type_cb.addItems(['choice', 'text'])
        self.type_cb.currentTextChanged.connect(self._update_choices_visibility)
        form.addRow('Field type:', self.type_cb)

        self.default_input = QLineEdit()
        self.default_input.setPlaceholderText('Default value')
        form.addRow('Default:', self.default_input)

        self.required_chk = QCheckBox('Required')
        form.addRow('', self.required_chk)

        self.show_label_chk = QCheckBox('Show label in summary')
        form.addRow('', self.show_label_chk)

        root.addLayout(form)

        # Choices area (visible only khi type=choice)
        self._choices_box = QWidget()
        cl = QVBoxLayout(self._choices_box)
        cl.setContentsMargins(0, 4, 0, 0)
        cl.setSpacing(4)

        hdr = QLabel('Choices — list of options for the dropdown')
        hdr.setProperty('role', 'accent')
        cl.addWidget(hdr)

        hint = QLabel(
            '• <b>Display</b>: text shown in the dropdown (e.g. "Nastran v2019.1")\n'
            '• <b>SH value</b>: actual value written to the .sh script (e.g. "4")'
        )
        hint.setProperty('role', 'dim')
        hint.setWordWrap(True)
        cl.addWidget(hint)

        self.choice_table = QTableWidget(0, 2)
        self.choice_table.setObjectName('choiceTable')
        self.choice_table.setHorizontalHeaderLabels(['Display name', 'SH value'])
        self.choice_table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.choice_table.verticalHeader().setDefaultSectionSize(26)
        cl.addWidget(self.choice_table)

        btn_row = QHBoxLayout()
        btn_row.setContentsMargins(0, 0, 0, 0)
        self.add_choice_btn = QPushButton('+ Add choice')
        self.del_choice_btn = QPushButton('Delete')
        self.up_choice_btn = QPushButton('↑')
        self.down_choice_btn = QPushButton('↓')
        for b in (self.add_choice_btn, self.del_choice_btn, self.up_choice_btn, self.down_choice_btn):
            b.setFixedHeight(26)
            btn_row.addWidget(b)
        btn_row.addStretch()
        cl.addLayout(btn_row)

        self.add_choice_btn.clicked.connect(self._on_add_choice)
        self.del_choice_btn.clicked.connect(self._on_del_choice)
        self.up_choice_btn.clicked.connect(lambda: self._move_choice(-1))
        self.down_choice_btn.clicked.connect(lambda: self._move_choice(+1))

        root.addWidget(self._choices_box)

        # OK/Cancel
        btns = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel)
        btns.accepted.connect(self._on_accept)
        btns.rejected.connect(self.reject)
        root.addWidget(btns)

    # ------------------------------------------------------------------
    def _load_field(self):
        self.label_input.setText(str(self._field.get('label', '')))
        ftype = str(self._field.get('type') or 'text')
        idx = self.type_cb.findText(ftype)
        if idx >= 0:
            self.type_cb.setCurrentIndex(idx)
        self.default_input.setText(str(self._field.get('default', '')))
        self.required_chk.setChecked(bool(self._field.get('required', False)))
        self.show_label_chk.setChecked(bool(self._field.get('show_label', False)))
        for ch in self._field.get('choices', []) or []:
            self._append_choice_row(
                str(ch.get('display', '')), str(ch.get('value', '')))

    def _append_choice_row(self, display='', value=''):
        r = self.choice_table.rowCount()
        self.choice_table.insertRow(r)
        self.choice_table.setItem(r, 0, QTableWidgetItem(display))
        self.choice_table.setItem(r, 1, QTableWidgetItem(value))

    def _update_choices_visibility(self):
        is_choice = self.type_cb.currentText() == 'choice'
        self._choices_box.setVisible(is_choice)

    def _on_add_choice(self):
        self._append_choice_row()
        self.choice_table.setCurrentCell(self.choice_table.rowCount() - 1, 0)

    def _on_del_choice(self):
        r = self.choice_table.currentRow()
        if r >= 0:
            self.choice_table.removeRow(r)

    def _move_choice(self, delta):
        r = self.choice_table.currentRow()
        new_r = r + delta
        if r < 0 or new_r < 0 or new_r >= self.choice_table.rowCount():
            return
        choices = self._read_choices()
        choices[r], choices[new_r] = choices[new_r], choices[r]
        self.choice_table.setRowCount(0)
        for c in choices:
            self._append_choice_row(c.get('display', ''), c.get('value', ''))
        self.choice_table.setCurrentCell(new_r, 0)

    def _read_choices(self):
        out = []
        for r in range(self.choice_table.rowCount()):
            d_item = self.choice_table.item(r, 0)
            v_item = self.choice_table.item(r, 1)
            d = d_item.text().strip() if d_item else ''
            v = v_item.text().strip() if v_item else ''
            if not d and not v:
                continue
            out.append({'display': d or v, 'value': v or d})
        return out

    # ------------------------------------------------------------------
    def _on_accept(self):
        label = self.label_input.text().strip()
        if not label:
            message_box.warning(self, 'Missing label', 'Label must not be empty.')
            return

        # Keep old key when editing; derive a new one from the label when adding
        key = self._field.get('key', '').strip()
        if not key:
            key = unique_key(slugify(label), self._existing_keys)

        ftype = self.type_cb.currentText()
        default = self.default_input.text()
        required = self.required_chk.isChecked()
        choices = choice_list(self._read_choices()) if ftype == 'choice' else []

        if ftype == 'choice' and not choices:
            r = message_box.question(
                self, 'No choices',
                'Field type is "choice" but no options were added. Save anyway?',
                QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            if r != QMessageBox.Yes:
                return

        role = 'sleep' if key == 'sleep' else 'heredoc_input'
        self.result_field = {
            'key': key,
            'label': label,
            'type': ftype,
            'role': role,
            'default': default,
            'required': required,
            'show_label': self.show_label_chk.isChecked(),
            'choices': choices,
        }
        self.accept()


def edit_field(parent, field=None, existing_keys=None):
    """Helper: open dialog, return field dict or None if user cancels."""
    dlg = FieldEditorDialog(field, existing_keys, parent)
    if dlg.exec_() == QDialog.Accepted:
        return dlg.result_field
    return None
