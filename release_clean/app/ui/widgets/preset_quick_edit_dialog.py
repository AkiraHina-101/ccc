"""PresetQuickEditDialog â€” popup to toggle which solver fields belong to
the active preset.

A preset is a named selection of solver sub-fields, not field values. The
dialog therefore renders one checkbox per solver field; the result is the
list of field keys the user wants in the preset.
"""

from PySide2.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QCheckBox, QPushButton, QLabel,
    QScrollArea, QWidget,
)
from PySide2.QtCore import Qt

from app.data.field_defs import resolve_fields_for_solver
from app.data.settings import get_solver


class PresetQuickEditDialog(QDialog):
    """Popup to toggle which solver fields belong to the active preset."""

    def __init__(self, data: dict, settings: dict, active_fields, parent=None):
        super().__init__(parent)
        self.setObjectName('presetQuickEditDialog')
        self.setAttribute(Qt.WA_StyledBackground, True)
        self.setWindowTitle('Quick edit preset')
        self.setMinimumWidth(380)

        self._data = data
        self._s = settings
        self._active_set = set(active_fields or [])
        self._checks = {}     # key -> QCheckBox
        self.result_fields = None

        self._init_ui()
        self._apply_dark_title_bar()

    def _init_ui(self):
        root = QVBoxLayout(self)
        root.setContentsMargins(14, 14, 14, 14)
        root.setSpacing(10)

        solver_name = str(self._data.get('solver') or
                          self._s.get('default_solver') or 'nast')
        solver_def = get_solver(self._s, solver_name)
        fields = resolve_fields_for_solver(solver_def, self._s)

        header = QLabel(f"Solver: <b>{solver_name}</b> - toggle the fields "
                        f"this preset contains")
        header.setWordWrap(True)
        root.addWidget(header)

        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        body = QWidget()
        bl = QVBoxLayout(body)
        bl.setContentsMargins(2, 2, 2, 2)
        bl.setSpacing(4)

        for f in fields:
            key = f['key']
            if key == 'filename':
                continue
            label = str(f.get('label') or key)
            chk = QCheckBox(label)
            chk.setChecked(key in self._active_set)
            self._checks[key] = chk
            bl.addWidget(chk)
        bl.addStretch()
        scroll.setWidget(body)
        root.addWidget(scroll, 1)

        btn_row = QHBoxLayout()
        btn_row.addStretch()
        self.cancel_btn = QPushButton('Cancel')
        self.ok_btn = QPushButton('OK')
        self.ok_btn.setObjectName('btnPrimary')
        self.ok_btn.setDefault(True)
        btn_row.addWidget(self.cancel_btn)
        btn_row.addWidget(self.ok_btn)
        root.addLayout(btn_row)

        self.cancel_btn.clicked.connect(self.reject)
        self.ok_btn.clicked.connect(self._on_accept)

    def _on_accept(self):
        self.result_fields = [k for k, c in self._checks.items() if c.isChecked()]
        self.accept()

    def _apply_dark_title_bar(self):
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
