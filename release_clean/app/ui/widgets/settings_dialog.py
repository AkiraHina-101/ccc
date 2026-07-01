import json
import copy

from PySide2.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QStackedWidget, QWidget,
    QLabel, QLineEdit, QPushButton, QListWidget,
    QListWidgetItem, QMessageBox, QFrame, QComboBox, QTableWidget,
    QTableWidgetItem, QHeaderView, QCheckBox, QPlainTextEdit, QTabWidget,
    QScrollArea, QAbstractItemView,
)
from PySide2.QtCore import Signal, Qt, QEvent

from app.data.presets import load_presets, save_presets, normalize_preset, preset_from_solver
from app.data.settings import get_solver
from app.data.field_defs import (
    resolve_fields_for_solver, default_solver_fields, normalize_field_defs,
    field_display, choice_value,
)
from app.logic.parse_utils import choice_list
from app.ui import message_box
from app.ui.widgets.field_editor_dialog import edit_field


class SettingsDialog(QDialog):
    settings_applied = Signal(dict)

    def __init__(self, settings: dict, parent=None):
        super().__init__(parent)
        self._settings = copy.deepcopy(settings)
        self._solvers = copy.deepcopy(self._settings.get('solvers') or {})
        self._current_solver_name = None
        self._solver_drafts = {}
        self._copied_solver_field = None
        self._presets = load_presets(self._settings)
        self._original_presets = copy.deepcopy(self._presets)
        self._current_preset_name = None
        self._preset_value_widgets = {}     # key -> (use_item, field, show_label_item)
        self._rendering_preset = False
        self.setWindowTitle('Settings')
        self.setObjectName('settingsDialog')
        self.setAttribute(Qt.WA_StyledBackground, True)
        # 700x500 fits in a snap-tiled window. The dialog opens at 1100x760
        # by default for comfort; users can resize down to 700x500 if working
        # at narrow widths.
        self.setMinimumSize(700, 500)
        self.resize(1100, 760)
        self._apply_dark_title_bar()
        self._init_ui()
        self._connect_signals()
        # Trigger initial selection AFTER signals wired
        if self.solver_list.count():
            self.solver_list.setCurrentRow(0)
            self._on_solver_selected(self.solver_list.currentItem(), None)
        if self.preset_list.count():
            self.preset_list.setCurrentRow(0)
            self._on_preset_selected(self.preset_list.currentItem(), None)
        self._capture_current_drafts()
        self._original_snapshot = self._dirty_snapshot()

    # ------------------------------------------------------------------ UI

    def _init_ui(self):
        root = QVBoxLayout(self)
        root.setContentsMargins(0, 0, 0, 0)
        root.setSpacing(0)

        # Tab bar
        self._tab_bar = QWidget()
        self._tab_bar.setObjectName('settingsTabBar')
        self._tab_bar.setAttribute(Qt.WA_StyledBackground, True)
        self._tab_bar.setFixedHeight(44)
        tabl = QHBoxLayout(self._tab_bar)
        tabl.setContentsMargins(12, 0, 0, 0)
        tabl.setSpacing(0)
        self.tab_btns = {}
        for key, label in (('connection', 'Connection'),
                           ('presets',    'Presets')):
            b = QPushButton(label)
            b.setCheckable(True)
            b.setCursor(Qt.PointingHandCursor)
            b.clicked.connect(lambda checked=False, k=key: self._switch_tab(k))
            self.tab_btns[key] = b
            tabl.addWidget(b)
        tabl.addStretch(1)
        root.addWidget(self._tab_bar)

        # Content stack
        self.tabs = QStackedWidget()
        self.tabs.setObjectName('settingsContent')
        self.tabs.setAttribute(Qt.WA_StyledBackground, True)
        self.tabs.addWidget(self._build_connection_tab())   # 0
        self.tabs.addWidget(self._build_presets_tab())      # 1
        root.addWidget(self.tabs, 1)

        # Footer
        footer = QWidget()
        footer.setObjectName('settingsFooter')
        footer.setAttribute(Qt.WA_StyledBackground, True)
        fl = QHBoxLayout(footer)
        fl.setContentsMargins(16, 0, 16, 0)
        fl.addStretch(1)
        self.cancel_btn = QPushButton('Cancel')
        self.cancel_btn.setFixedHeight(30)
        fl.addWidget(self.cancel_btn)
        self.ok_btn = QPushButton('Save')
        self.ok_btn.setObjectName('btnPrimary')
        self.ok_btn.setFixedHeight(30)
        self.ok_btn.setDefault(False)
        self.ok_btn.setAutoDefault(False)
        fl.addWidget(self.ok_btn)
        root.addWidget(footer)

        self.cancel_btn.clicked.connect(self._on_cancel_requested)
        self.ok_btn.clicked.connect(self._on_apply)

        self._switch_tab('connection')

    def _switch_tab(self, key):
        idx = {'connection': 0, 'presets': 1}[key]
        self.tabs.setCurrentIndex(idx)
        for k, b in self.tab_btns.items():
            b.setChecked(k == key)

    def eventFilter(self, obj, event):
        if event.type() == QEvent.KeyPress and event.key() in (Qt.Key_Return, Qt.Key_Enter):
            if isinstance(obj, QLineEdit):
                obj.editingFinished.emit()
                return True
            if obj in (getattr(self, 'field_table', None),
                       getattr(self, 'preset_fields_table', None)):
                obj.closePersistentEditor(obj.currentItem())
                return True
        return super().eventFilter(obj, event)

    def _apply_dark_title_bar(self, widget=None):
        """Ask Windows to draw the native dialog title bar in dark mode."""
        import sys
        if sys.platform != 'win32':
            return
        try:
            import ctypes
            target = widget or self
            hwnd = int(target.winId())
            value = ctypes.c_int(1)
            for attr in (20, 19):
                result = ctypes.windll.dwmapi.DwmSetWindowAttribute(
                    ctypes.c_void_p(hwnd),
                    ctypes.c_int(attr),
                    ctypes.byref(value),
                    ctypes.sizeof(value),
                )
                if result == 0:
                    break
        except Exception:
            pass

    # --- Connection tab ---

    def _build_connection_tab(self):
        tab = QWidget()
        lay = QVBoxLayout(tab)
        lay.setContentsMargins(12, 12, 12, 12)
        lay.setSpacing(10)

        def row(label, value, echo=False):
            w = QWidget()
            rl = QHBoxLayout(w)
            rl.setContentsMargins(0, 0, 0, 0)
            lbl = QLabel(label)
            lbl.setFixedWidth(130)
            lbl.setProperty('role', 'accent')
            rl.addWidget(lbl)
            inp = QLineEdit(value)
            inp.installEventFilter(self)
            if echo:
                inp.setEchoMode(QLineEdit.Password)
            rl.addWidget(inp, stretch=1)
            lay.addWidget(w)
            return inp

        self.server_input   = row('Server:',   self._settings.get('server', ''))
        self.user_input     = row('Username:', self._settings.get('user', ''))
        self.password_input = row('Password:', self._settings.get('password', ''), echo=True)

        ttm_w = QWidget()
        ttm_l = QHBoxLayout(ttm_w)
        ttm_l.setContentsMargins(0, 0, 0, 0)
        lbl = QLabel('ttpmacro.exe:')
        lbl.setFixedWidth(130)
        lbl.setProperty('role', 'accent')
        ttm_l.addWidget(lbl)
        self.ttm_input = QLineEdit(self._settings.get('ttmacro_path', ''))
        self.ttm_input.installEventFilter(self)
        ttm_l.addWidget(self.ttm_input, stretch=1)
        self.ttm_browse_btn = QPushButton('Browse…')
        self.ttm_browse_btn.setFixedHeight(28)
        ttm_l.addWidget(self.ttm_browse_btn)
        lay.addWidget(ttm_w)

        self.prefix_input = row('Win prefix:', self._settings.get('win_prefix', ''))

        hint = QLabel('Win prefix is stripped when converting folder path to Linux.')
        hint.setProperty('role', 'dim')
        lay.addWidget(hint)

        ssh_header = QHBoxLayout()
        ssh_header.addWidget(QLabel('SSH buttons'))
        ssh_header.addStretch(1)
        self.ssh_button_add_btn = QPushButton('+ Add')
        self.ssh_button_del_btn = QPushButton('Delete')
        self.ssh_button_add_btn.setFixedHeight(26)
        self.ssh_button_del_btn.setFixedHeight(26)
        ssh_header.addWidget(self.ssh_button_add_btn)
        ssh_header.addWidget(self.ssh_button_del_btn)
        lay.addLayout(ssh_header)

        self.ssh_buttons_table = QTableWidget(0, 3)
        self.ssh_buttons_table.setObjectName('sshButtonsTable')
        self.ssh_buttons_table.setHorizontalHeaderLabels(['Use', 'Button label', 'Command'])
        self.ssh_buttons_table.horizontalHeader().setSectionResizeMode(QHeaderView.Interactive)
        self.ssh_buttons_table.horizontalHeader().setStretchLastSection(True)
        self.ssh_buttons_table.setColumnWidth(0, 48)
        self.ssh_buttons_table.setColumnWidth(1, 160)
        self.ssh_buttons_table.setColumnWidth(2, 520)
        self.ssh_buttons_table.setSelectionBehavior(QTableWidget.SelectRows)
        self.ssh_buttons_table.setSelectionMode(QTableWidget.SingleSelection)
        self.ssh_buttons_table.setDragEnabled(True)
        self.ssh_buttons_table.setAcceptDrops(True)
        self.ssh_buttons_table.setDropIndicatorShown(True)
        self.ssh_buttons_table.setDragDropMode(QAbstractItemView.InternalMove)
        self.ssh_buttons_table.setDefaultDropAction(Qt.MoveAction)
        self.ssh_buttons_table.installEventFilter(self)
        lay.addWidget(self.ssh_buttons_table, stretch=1)
        self._reload_ssh_buttons_table()

        ssh_hint = QLabel(
            'Optional variables: {selected_jobid} uses selected Queue row, '
            '{input} asks before run, {user}/{server}/{host} use Settings. '
            'Drag rows to reorder buttons. '
            'Examples: bkill {selected_jobid} | bjobs -u all -q nast16m | fstv_util')
        ssh_hint.setProperty('role', 'dim')
        lay.addWidget(ssh_hint)
        lay.addStretch()
        return tab

    # --- Solvers tab ---

    def _build_solvers_tab(self):
        tab = QWidget()
        lay = QHBoxLayout(tab)
        lay.setContentsMargins(8, 8, 8, 8)
        lay.setSpacing(8)

        # Left: solver list
        left = QWidget()
        left.setFixedWidth(200)
        ll = QVBoxLayout(left)
        ll.setContentsMargins(0, 0, 0, 0)
        ll.setSpacing(4)
        ll.addWidget(QLabel('Solvers'))
        self.solver_list = QListWidget()
        self.solver_list.setObjectName('solverListWidget')
        ll.addWidget(self.solver_list, stretch=1)
        btn_row = QWidget()
        bl = QHBoxLayout(btn_row)
        bl.setContentsMargins(0, 0, 0, 0)
        bl.setSpacing(4)
        self.solver_add_btn = QPushButton('+ Add')
        self.solver_del_btn = QPushButton('Delete')
        self.solver_del_btn.setProperty('role', 'warning')
        self.solver_up_btn  = QPushButton('↑')
        self.solver_down_btn = QPushButton('↓')
        for b in (self.solver_add_btn, self.solver_del_btn,
                  self.solver_up_btn, self.solver_down_btn):
            b.setFixedHeight(26)
            bl.addWidget(b)
        ll.addWidget(btn_row)
        lay.addWidget(left)

        div = QFrame()
        div.setFrameShape(QFrame.VLine)
        lay.addWidget(div)

        # Right: editor
        right = QWidget()
        rl = QVBoxLayout(right)
        rl.setContentsMargins(4, 0, 0, 0)
        rl.setSpacing(6)

        name_row = QWidget()
        nl = QHBoxLayout(name_row)
        nl.setContentsMargins(0, 0, 0, 0)
        nl.addWidget(self._lbl('Name:', 60))
        self.solver_name_input = QLineEdit()
        self.solver_name_input.installEventFilter(self)
        nl.addWidget(self.solver_name_input, stretch=1)
        nl.addWidget(self._lbl('Label:', 50))
        self.solver_label_input = QLineEdit()
        self.solver_label_input.installEventFilter(self)
        nl.addWidget(self.solver_label_input, stretch=1)
        rl.addWidget(name_row)

        self.field_table = QTableWidget(0, 6)
        self.field_table.setObjectName('fieldDefsTable')
        self.field_table.setHorizontalHeaderLabels(
            ['Label', 'Type', 'Default', 'Display name', 'Required', 'Show label'])
        self.field_table.horizontalHeader().setSectionResizeMode(QHeaderView.Interactive)
        self.field_table.horizontalHeader().setStretchLastSection(True)
        self.field_table.setColumnWidth(0, 160)
        self.field_table.setColumnWidth(1, 70)
        self.field_table.setColumnWidth(2, 90)
        self.field_table.setColumnWidth(3, 150)
        self.field_table.setColumnWidth(4, 70)
        self.field_table.setColumnWidth(5, 90)
        self.field_table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.field_table.setSelectionBehavior(QTableWidget.SelectRows)
        self.field_table.setContextMenuPolicy(Qt.CustomContextMenu)
        self.field_table.installEventFilter(self)
        self.field_table.cellDoubleClicked.connect(self._on_field_double_click)
        rl.addWidget(self.field_table, stretch=1)
        # Internal storage — the table is display only, source of truth lives here
        self._field_data = []

        fbtn_row = QWidget()
        fbl = QHBoxLayout(fbtn_row)
        fbl.setContentsMargins(0, 0, 0, 0)
        self.field_add_btn = QPushButton('+ Field')
        self.field_del_btn = QPushButton('Delete field')
        self.field_up_btn  = QPushButton('↑')
        self.field_down_btn = QPushButton('↓')
        for b in (self.field_add_btn, self.field_del_btn, self.field_up_btn, self.field_down_btn):
            b.setFixedHeight(26)
            fbl.addWidget(b)
        fbl.addStretch()
        self.solver_save_btn = QPushButton('💾  Save solver')
        self.solver_save_btn.setProperty('role', 'primary')
        self.solver_save_btn.setFixedHeight(28)
        self.solver_save_btn.setVisible(False)
        rl.addWidget(fbtn_row)

        self._solver_editor = right
        right.setEnabled(False)
        lay.addWidget(right, stretch=1)

        self._reload_solver_list()
        return tab

    # --- Presets tab ---

    def _build_presets_tab(self):
        tab = QWidget()
        lay = QHBoxLayout(tab)
        lay.setContentsMargins(8, 8, 8, 8)
        lay.setSpacing(8)

        left = QWidget()
        left.setFixedWidth(200)
        ll = QVBoxLayout(left)
        ll.setContentsMargins(0, 0, 0, 0)
        ll.setSpacing(4)
        ll.addWidget(QLabel('Presets'))
        self.preset_list = QListWidget()
        self.preset_list.setObjectName('presetListWidget')
        self.preset_list.setSortingEnabled(True)
        ll.addWidget(self.preset_list, stretch=1)
        btn_row = QWidget()
        bl = QHBoxLayout(btn_row)
        bl.setContentsMargins(0, 0, 0, 0)
        bl.setSpacing(4)
        self.preset_add_btn = QPushButton('+ Add')
        self.preset_dup_btn = QPushButton('Dup')
        self.preset_del_btn = QPushButton('Delete')
        self.preset_del_btn.setProperty('role', 'warning')
        for b in (self.preset_add_btn, self.preset_dup_btn, self.preset_del_btn):
            b.setFixedHeight(26)
            bl.addWidget(b)
        ll.addWidget(btn_row)
        lay.addWidget(left)

        div = QFrame()
        div.setFrameShape(QFrame.VLine)
        lay.addWidget(div)

        right = QWidget()
        rl = QVBoxLayout(right)
        rl.setContentsMargins(4, 0, 0, 0)
        rl.setSpacing(6)

        self.preset_sub_tabs = QTabWidget()
        self.preset_sub_tabs.setObjectName('presetSubTabs')

        # --- Sub-tab 1: Preset (name/summary/fields/save) ---
        preset_sub = QWidget()
        pl = QVBoxLayout(preset_sub)
        pl.setContentsMargins(8, 8, 8, 8)
        pl.setSpacing(6)

        name_row = QWidget()
        nl = QHBoxLayout(name_row)
        nl.setContentsMargins(0, 0, 0, 0)
        nl.addWidget(self._lbl('Name:', 60))
        self.preset_name_input = QLineEdit()
        self.preset_name_input.installEventFilter(self)
        nl.addWidget(self.preset_name_input, stretch=1)
        pl.addWidget(name_row)

        summary_row = QWidget()
        summary_layout = QHBoxLayout(summary_row)
        summary_layout.setContentsMargins(0, 0, 0, 0)
        summary_layout.addWidget(self._lbl('Summary:', 60))
        self.preset_summary_lbl = QLabel('')
        self.preset_summary_lbl.setObjectName('presetSummaryLabel')
        self.preset_summary_lbl.setProperty('role', 'dim')
        self.preset_summary_lbl.setWordWrap(True)
        summary_layout.addWidget(self.preset_summary_lbl, stretch=1)
        pl.addWidget(summary_row)

        self.preset_solver_cb = QComboBox()
        solver_row = QWidget()
        sl = QHBoxLayout(solver_row)
        sl.setContentsMargins(0, 0, 0, 0)
        sl.addWidget(self._lbl('Solver:', 60))
        sl.addWidget(self.preset_solver_cb, stretch=1)
        self.preset_solver_hint_lbl = QLabel('')
        self.preset_solver_hint_lbl.setObjectName('presetSolverHintLabel')
        self.preset_solver_hint_lbl.setProperty('role', 'dim')
        sl.addWidget(self.preset_solver_hint_lbl)
        pl.addWidget(solver_row)

        fields_header = QHBoxLayout()
        fields_header.setContentsMargins(0, 0, 0, 0)
        fields_header.addWidget(QLabel('Fields:'))
        fields_header.addStretch(1)
        self.preset_field_add_btn = QPushButton('+ Add field')
        self.preset_field_add_btn.setFixedHeight(26)
        self.preset_field_add_btn.setToolTip(
            "Create a new field on the current solver and include it in this preset")
        fields_header.addWidget(self.preset_field_add_btn)
        pl.addLayout(fields_header)

        self.preset_fields_table = QTableWidget(0, 4)
        self.preset_fields_table.setObjectName('presetFieldsTable')
        self.preset_fields_table.setHorizontalHeaderLabels(
            ['Use', 'Field', 'Value', 'Show label'])
        self.preset_fields_table.horizontalHeader().setSectionResizeMode(QHeaderView.Interactive)
        self.preset_fields_table.horizontalHeader().setStretchLastSection(True)
        self.preset_fields_table.setColumnWidth(0, 48)
        self.preset_fields_table.setColumnWidth(1, 160)
        self.preset_fields_table.setColumnWidth(2, 240)
        self.preset_fields_table.setColumnWidth(3, 90)
        self.preset_fields_table.setEditTriggers(QTableWidget.NoEditTriggers)
        self.preset_fields_table.setSelectionBehavior(QTableWidget.SelectRows)
        self.preset_fields_table.installEventFilter(self)
        self.preset_fields_table.itemChanged.connect(self._on_preset_field_item_changed)
        pl.addWidget(self.preset_fields_table, stretch=1)

        self.preset_save_btn = QPushButton('💾  Save preset')
        self.preset_save_btn.setFixedHeight(30)
        self.preset_save_btn.setProperty('role', 'primary')
        self.preset_save_btn.setVisible(False)

        self.preset_sub_tabs.addTab(preset_sub, 'Preset')

        # --- Sub-tab 2: Solver fields (advanced) ---
        solver_sub_scroll = QScrollArea()
        solver_sub_scroll.setWidgetResizable(True)
        solver_sub_scroll.setFrameShape(QFrame.NoFrame)
        self.advanced_solver_panel = self._build_solvers_tab()
        solver_sub_scroll.setWidget(self.advanced_solver_panel)
        self.preset_sub_tabs.addTab(solver_sub_scroll, 'Solver fields')

        rl.addWidget(self.preset_sub_tabs, stretch=1)

        # Back-compat shim: tests/code that called `advanced_solver_btn.click()`
        # to reveal the solver editor now switch to the sub-tab.
        self.advanced_solver_btn = QPushButton('Advanced solver fields')
        self.advanced_solver_btn.setCheckable(True)
        self.advanced_solver_btn.setVisible(False)
        self.advanced_solver_btn.toggled.connect(
            lambda checked: self.preset_sub_tabs.setCurrentIndex(1 if checked else 0))

        self._preset_editor = right
        right.setEnabled(False)
        lay.addWidget(right, stretch=1)

        self._refresh_preset_solver_combo()
        self._reload_preset_list()
        return tab

    def _lbl(self, text, width=None):
        lbl = QLabel(text)
        lbl.setProperty('role', 'accent')
        if width:
            lbl.setFixedWidth(width)
        return lbl

    # --- SSH custom buttons ---

    def _reload_ssh_buttons_table(self):
        self.ssh_buttons_table.setRowCount(0)
        for cmd in self._settings.get('ssh_buttons') or []:
            if isinstance(cmd, dict):
                self._add_ssh_button_row(
                    bool(cmd.get('enabled', True)),
                    str(cmd.get('label') or ''),
                    str(cmd.get('command') or ''),
                )

    def _add_ssh_button_row(self, enabled=True, label='', command=''):
        row = self.ssh_buttons_table.rowCount()
        self.ssh_buttons_table.insertRow(row)
        use_item = QTableWidgetItem('')
        use_item.setFlags(Qt.ItemIsUserCheckable | Qt.ItemIsEnabled | Qt.ItemIsSelectable)
        use_item.setCheckState(Qt.Checked if enabled else Qt.Unchecked)
        self.ssh_buttons_table.setItem(row, 0, use_item)
        self.ssh_buttons_table.setItem(row, 1, QTableWidgetItem(label))
        self.ssh_buttons_table.setItem(row, 2, QTableWidgetItem(command))
        return row

    def _on_ssh_button_add(self):
        row = self._add_ssh_button_row(True, 'My jobs', 'bjobs -a -w -u {user}')
        self.ssh_buttons_table.setCurrentCell(row, 1)
        self.ssh_buttons_table.editItem(self.ssh_buttons_table.item(row, 1))

    def _on_ssh_button_del(self):
        rows = sorted({i.row() for i in self.ssh_buttons_table.selectedIndexes()}, reverse=True)
        for row in rows:
            self.ssh_buttons_table.removeRow(row)

    def _collect_ssh_buttons(self):
        out = []
        for row in range(self.ssh_buttons_table.rowCount()):
            use_item = self.ssh_buttons_table.item(row, 0)
            label_item = self.ssh_buttons_table.item(row, 1)
            command_item = self.ssh_buttons_table.item(row, 2)
            label = (label_item.text() if label_item else '').strip()
            command = (command_item.text() if command_item else '').strip()
            if not label and not command:
                continue
            out.append({
                'enabled': use_item.checkState() == Qt.Checked if use_item else True,
                'label': label,
                'command': command,
            })
        return out

    # ------------------------------------------------------------------ signals

    def _connect_signals(self):
        self.ttm_browse_btn.clicked.connect(self._on_browse_ttm)
        self.ssh_button_add_btn.clicked.connect(self._on_ssh_button_add)
        self.ssh_button_del_btn.clicked.connect(self._on_ssh_button_del)

        self.solver_list.currentItemChanged.connect(self._on_solver_selected)
        self.solver_add_btn.clicked.connect(self._on_solver_add)
        self.solver_del_btn.clicked.connect(self._on_solver_del)
        self.solver_up_btn.clicked.connect(lambda: self._move_solver(-1))
        self.solver_down_btn.clicked.connect(lambda: self._move_solver(+1))
        self.field_add_btn.clicked.connect(self._on_field_add)
        self.field_del_btn.clicked.connect(self._on_field_del)
        self.field_up_btn.clicked.connect(lambda: self._move_field(-1))
        self.field_down_btn.clicked.connect(lambda: self._move_field(+1))
        self.field_table.customContextMenuRequested.connect(self._on_field_table_context_menu)

        self.preset_list.currentItemChanged.connect(self._on_preset_selected)
        self.preset_add_btn.clicked.connect(self._on_preset_add)
        self.preset_dup_btn.clicked.connect(self._on_preset_dup)
        self.preset_del_btn.clicked.connect(self._on_preset_del)
        self.preset_field_add_btn.clicked.connect(self._on_preset_field_add)
        self.preset_solver_cb.currentTextChanged.connect(self._on_preset_solver_changed)

    # ------------------------------------------------------------------ Connection

    def _on_browse_ttm(self):
        from PySide2.QtWidgets import QFileDialog
        path, _ = QFileDialog.getOpenFileName(
            self, 'Select ttpmacro.exe', '', 'Executable (*.exe);;All (*.*)')
        if path:
            self.ttm_input.setText(path)

    # ------------------------------------------------------------------ Solvers

    def _reload_solver_list(self, select_name=None):
        """Reload list — do NOT sort, keep user-defined order."""
        self.solver_list.blockSignals(True)
        self.solver_list.clear()
        for name in self._solvers.keys():
            self.solver_list.addItem(QListWidgetItem(name))
        self.solver_list.blockSignals(False)
        if select_name:
            items = self.solver_list.findItems(select_name, Qt.MatchExactly)
            if items:
                self.solver_list.setCurrentItem(items[0])
                return
        if self.solver_list.count():
            self.solver_list.setCurrentRow(0)
        else:
            self._solver_editor.setEnabled(False)

    def _move_solver(self, delta):
        self._capture_solver_draft()
        r = self.solver_list.currentRow()
        names = list(self._solvers.keys())
        new_r = r + delta
        if r < 0 or new_r < 0 or new_r >= len(names):
            return
        names[r], names[new_r] = names[new_r], names[r]
        self._solvers = {n: self._solvers[n] for n in names}
        self._reload_solver_list(select_name=names[new_r])
        self._refresh_preset_solver_combo()

    def _on_solver_selected(self, current, _prev):
        if _prev:
            self._capture_solver_draft(_prev.text())
        if not current:
            self._solver_editor.setEnabled(False)
            return
        name = current.text()
        self._current_solver_name = name
        solver_def = self._solver_drafts.get(name) or self._solvers.get(name, {})
        self._solver_editor.setEnabled(True)
        self.solver_name_input.setText(solver_def.get('name', name))
        self.solver_label_input.setText(solver_def.get('label', name))
        self._fields_into_table(solver_def.get('fields', []))

    def _capture_solver_draft(self, name=None):
        """Keep unsaved solver edits alive while switching rows in this dialog."""
        name = name or self._current_solver_name
        if not name or not hasattr(self, 'solver_name_input'):
            return
        draft_name = self.solver_name_input.text().strip() or name
        label = self.solver_label_input.text().strip() or draft_name
        self._solver_drafts[name] = {
            'name': draft_name,
            'label': label,
            'fields': self._table_into_fields(),
        }

    def _fields_into_table(self, fields):
        """Set internal data + re-render the table (display only)."""
        self._field_data = [dict(f) for f in fields]
        self._render_field_table()

    def _render_field_table(self):
        self.field_table.setRowCount(0)
        for f in self._field_data:
            r = self.field_table.rowCount()
            self.field_table.insertRow(r)
            default = str(f.get('default', ''))
            display = field_display(f, default) if f.get('type') == 'choice' else default
            self.field_table.setItem(r, 0, QTableWidgetItem(str(f.get('label', f.get('key', '')))))
            self.field_table.setItem(r, 1, QTableWidgetItem(str(f.get('type', 'text'))))
            self.field_table.setItem(r, 2, QTableWidgetItem(default))
            self.field_table.setItem(r, 3, QTableWidgetItem(display))
            self.field_table.setItem(r, 4, QTableWidgetItem('✓' if f.get('required') else ''))
            self.field_table.setItem(r, 5, QTableWidgetItem('✓' if f.get('show_label') else ''))

    def _table_into_fields(self):
        return [dict(f) for f in self._field_data]

    def _on_field_double_click(self, row, _col):
        if row < 0 or row >= len(self._field_data):
            return
        existing = [f.get('key', '') for f in self._field_data]
        updated = edit_field(self, self._field_data[row], existing_keys=existing)
        if updated is not None:
            self._field_data[row] = updated
            self._render_field_table()
            self.field_table.setCurrentCell(row, 0)

    def _on_field_table_context_menu(self, pos):
        row = self.field_table.rowAt(pos.y())
        if row >= 0:
            self.field_table.setCurrentCell(row, 0)

        menu = message_box.make_menu(self, object_name="fieldContextMenu")
        copy_action = menu.addAction('Copy field')
        copy_action.setEnabled(0 <= row < len(self._field_data))
        paste_action = menu.addAction('Paste field')
        paste_action.setEnabled(self._copied_solver_field is not None and self._current_solver_name is not None)

        action = menu.exec_(self.field_table.viewport().mapToGlobal(pos))
        if action == copy_action:
            self._copy_field_row(row)
        elif action == paste_action:
            self._paste_field_row()

    def _copy_field_row(self, row=None):
        row = self.field_table.currentRow() if row is None else row
        if row < 0 or row >= len(self._field_data):
            return False
        self._copied_solver_field = copy.deepcopy(self._field_data[row])
        return True

    def _paste_field_row(self):
        if self._copied_solver_field is None or not self._current_solver_name:
            return False
        field = copy.deepcopy(self._copied_solver_field)
        field['key'] = self._unique_field_key(str(field.get('key') or 'field'))
        insert_at = self.field_table.currentRow()
        if insert_at < 0 or insert_at >= len(self._field_data):
            insert_at = len(self._field_data)
        else:
            insert_at += 1
        self._field_data.insert(insert_at, field)
        self._render_field_table()
        self.field_table.setCurrentCell(insert_at, 0)
        self._capture_solver_draft()
        return True

    def _on_solver_add(self):
        name = self._unique(self._solvers, 'new_solver')
        self._solvers[name] = {'label': name, 'fields': default_solver_fields()}
        self._reload_solver_list(select_name=name)

    def _on_solver_del(self):
        if not self._current_solver_name:
            return
        self._capture_solver_draft()
        used_by = [p for p, pd in self._presets.items()
                   if pd.get('solver') == self._current_solver_name]
        msg = f"Delete solver '{self._current_solver_name}'?"
        if used_by:
            msg += f"\n\nUsed by preset(s): {', '.join(used_by)}"
        r = message_box.question(self, 'Delete solver', msg,
                                 QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if r != QMessageBox.Yes:
            return
        self._solvers.pop(self._current_solver_name, None)
        self._solver_drafts.pop(self._current_solver_name, None)
        self._current_solver_name = None
        self._reload_solver_list()
        self._refresh_preset_solver_combo()

    def _on_solver_save(self):
        if not self._current_solver_name:
            return
        self._capture_solver_draft()
        draft = self._solver_drafts.get(self._current_solver_name, {})
        new_name = self.solver_name_input.text().strip()
        if not new_name:
            message_box.warning(self, 'Error', 'Solver name cannot be empty.')
            return
        label = draft.get('label') or self.solver_label_input.text().strip() or new_name
        fields = normalize_field_defs(draft.get('fields') or self._table_into_fields())
        old_name = self._current_solver_name
        self._solvers.pop(old_name, None)
        self._solvers[new_name] = {'label': label, 'fields': fields}
        self._solver_drafts.pop(old_name, None)
        self._solver_drafts[new_name] = {
            'name': new_name,
            'label': label,
            'fields': [dict(f) for f in fields],
        }
        # Update presets if the solver was renamed
        if old_name != new_name:
            for pd in self._presets.values():
                if pd.get('solver') == old_name:
                    pd['solver'] = new_name
        self._current_solver_name = new_name
        self._reload_solver_list(select_name=new_name)
        self._refresh_preset_solver_combo()
        if self._current_preset_name:
            preset = self._presets.get(self._current_preset_name, {})
            self._render_preset_value_widgets(self.preset_solver_cb.currentText(), preset)
        if hasattr(self, 'preset_summary_lbl'):
            self.preset_summary_lbl.setText(f"Solver '{new_name}' saved.")

    def _on_field_add(self):
        existing = [f.get('key', '') for f in self._field_data]
        new = edit_field(self, None, existing_keys=existing)
        if new is None:
            return
        self._field_data.append(new)
        self._render_field_table()
        self.field_table.setCurrentCell(len(self._field_data) - 1, 0)
        self._capture_solver_draft()

    def _on_field_del(self):
        r = self.field_table.currentRow()
        if 0 <= r < len(self._field_data):
            self._field_data.pop(r)
            self._render_field_table()
            self._capture_solver_draft()

    def _move_field(self, delta):
        r = self.field_table.currentRow()
        new_r = r + delta
        if r < 0 or new_r < 0 or new_r >= len(self._field_data):
            return
        self._field_data[r], self._field_data[new_r] = self._field_data[new_r], self._field_data[r]
        self._render_field_table()
        self.field_table.setCurrentCell(new_r, 0)
        self._capture_solver_draft()

    # ------------------------------------------------------------------ Presets

    def _refresh_preset_solver_combo(self):
        self.preset_solver_cb.blockSignals(True)
        self.preset_solver_cb.clear()
        # Do NOT sort — keep user-defined order like the Solvers tab
        self.preset_solver_cb.addItems(list(self._solvers.keys()))
        self.preset_solver_cb.blockSignals(False)

    def _reload_preset_list(self, select_name=None):
        self.preset_list.blockSignals(True)
        self.preset_list.clear()
        for name in sorted(self._presets.keys()):
            self.preset_list.addItem(QListWidgetItem(name))
        self.preset_list.blockSignals(False)
        if select_name:
            items = self.preset_list.findItems(select_name, Qt.MatchExactly)
            if items:
                self.preset_list.setCurrentItem(items[0])
                return
        if self.preset_list.count():
            self.preset_list.setCurrentRow(0)
        else:
            self._preset_editor.setEnabled(False)
            self._clear_preset_value_widgets()

    def _on_preset_selected(self, current, _prev):
        if _prev:
            self._capture_preset_draft(_prev.text())
        if not current:
            self._preset_editor.setEnabled(False)
            self._clear_preset_value_widgets()
            return
        name = current.text()
        self._current_preset_name = name
        preset = self._presets.get(name, {})
        self._preset_editor.setEnabled(True)
        self.preset_name_input.setText(name)
        solver_name = preset.get('solver', '')
        # Update combo without firing change handler
        self.preset_solver_cb.blockSignals(True)
        idx = self.preset_solver_cb.findText(solver_name)
        if idx >= 0:
            self.preset_solver_cb.setCurrentIndex(idx)
        self.preset_solver_cb.blockSignals(False)
        self._render_preset_value_widgets(solver_name, preset)

    def _clear_preset_value_widgets(self):
        self.preset_fields_table.blockSignals(True)
        self.preset_fields_table.setRowCount(0)
        self.preset_fields_table.blockSignals(False)
        self._preset_value_widgets.clear()
        if hasattr(self, 'preset_summary_lbl'):
            self.preset_summary_lbl.setText('')

    def _render_preset_value_widgets(self, solver_name, preset):
        """Render one checkbox per solver field — preset stores which
        fields it contains, not per-field values."""
        self._rendering_preset = True
        try:
            self._clear_preset_value_widgets()
            solver_def = self._solvers.get(solver_name) or {}
            fields = resolve_fields_for_solver(solver_def)
            active = set(preset.get('fields') or [])
            if hasattr(self, 'preset_solver_hint_lbl'):
                self.preset_solver_hint_lbl.setText(
                    f"Fields below come from solver '{solver_name}'")
            self.preset_fields_table.blockSignals(True)
            for f in fields:
                key = f['key']
                label = str(f.get('label') or key)
                r = self.preset_fields_table.rowCount()
                self.preset_fields_table.insertRow(r)

                use_item = QTableWidgetItem('')
                use_item.setFlags(Qt.ItemIsEnabled | Qt.ItemIsUserCheckable | Qt.ItemIsSelectable)
                use_item.setCheckState(Qt.Checked if key in active else Qt.Unchecked)
                self.preset_fields_table.setItem(r, 0, use_item)

                field_item = QTableWidgetItem(label)
                field_item.setFlags(Qt.ItemIsEnabled | Qt.ItemIsSelectable)
                field_item.setToolTip(f"Depends on solver '{solver_name}'")
                self.preset_fields_table.setItem(r, 1, field_item)

                value_item = QTableWidgetItem(self._summary_value(f))
                value_item.setFlags(Qt.ItemIsEnabled | Qt.ItemIsSelectable)
                self.preset_fields_table.setItem(r, 2, value_item)

                show_item = QTableWidgetItem('')
                show_item.setFlags(Qt.ItemIsEnabled | Qt.ItemIsUserCheckable | Qt.ItemIsSelectable)
                show_item.setCheckState(Qt.Checked if f.get('show_label') else Qt.Unchecked)
                self.preset_fields_table.setItem(r, 3, show_item)

                self._preset_value_widgets[key] = (use_item, f, show_item)
            self.preset_fields_table.blockSignals(False)
            self._refresh_preset_summary()
        finally:
            self.preset_fields_table.blockSignals(False)
            self._rendering_preset = False

    def _summary_value(self, field):
        value = str(field.get('default', ''))
        return field_display(field, value) if field.get('type') == 'choice' else value

    def _refresh_preset_summary(self):
        if not hasattr(self, 'preset_summary_lbl'):
            return
        solver = self.preset_solver_cb.currentText().strip() if hasattr(self, 'preset_solver_cb') else ''
        parts = [solver] if solver else []
        for key, (use_item, field, show_item) in self._preset_value_widgets.items():
            if use_item.checkState() != Qt.Checked:
                continue
            value = self._summary_value(field)
            if show_item.checkState() == Qt.Checked:
                label = str(field.get('label') or key)
                parts.append(f'{label}({value})')
            else:
                parts.append(value)
        summary = ' · '.join(parts) if parts else '(no fields)'
        self.preset_summary_lbl.setText(summary)
        self.preset_summary_lbl.setToolTip(summary)

    def _on_preset_field_item_changed(self, item):
        if item.column() == 3:
            key = self._field_key_for_row(item.row())
            if key:
                _use_item, field, _show_item = self._preset_value_widgets[key]
                show = item.checkState() == Qt.Checked
                field['show_label'] = show
                self._set_solver_field_show_label(key, show)
        self._refresh_preset_summary()
        self._capture_preset_draft()

    def _field_key_for_row(self, row):
        for key, (use_item, _field, show_item) in self._preset_value_widgets.items():
            if use_item.row() == row or show_item.row() == row:
                return key
        return ''

    def _set_solver_field_show_label(self, key, show):
        solver_name = self.preset_solver_cb.currentText().strip()
        solver_def = self._solvers.get(solver_name) or {}
        for f in solver_def.get('fields', []) or []:
            if f.get('key') == key:
                f['show_label'] = bool(show)
                break
        if solver_name == self._current_solver_name:
            self._fields_into_table(solver_def.get('fields', []))

    def _on_preset_solver_changed(self, new_solver):
        if self._rendering_preset:
            return
        if not self._current_preset_name:
            return
        preset = self._presets.get(self._current_preset_name, {})
        old_solver = preset.get('solver', '')
        if new_solver == old_solver:
            return
        r = message_box.question(
            self, 'Change solver',
            f"Change solver: '{old_solver}' -> '{new_solver}'. Reset field values to defaults?",
            QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if r != QMessageBox.Yes:
            self.preset_solver_cb.blockSignals(True)
            idx = self.preset_solver_cb.findText(old_solver)
            if idx >= 0:
                self.preset_solver_cb.setCurrentIndex(idx)
            self.preset_solver_cb.blockSignals(False)
            return
        # Build new preset from defaults
        new_preset = preset_from_solver(new_solver, {**self._settings, 'solvers': self._solvers})
        self._presets[self._current_preset_name] = new_preset
        self._render_preset_value_widgets(new_solver, new_preset)

    def _read_form_into_preset(self, preset):
        preset['fields'] = [key for key, (use_item, _f, _show_item)
                            in self._preset_value_widgets.items()
                            if use_item.checkState() == Qt.Checked]
        # Strip legacy value keys that may still linger on disk.
        for k in list(preset.keys()):
            if k not in ('solver', 'fields'):
                preset.pop(k, None)
        return preset

    def _capture_preset_draft(self, name=None, commit_rename=False):
        if self._rendering_preset:
            return name or self._current_preset_name
        name = name or self._current_preset_name
        if not name or not hasattr(self, 'preset_name_input'):
            return name
        if name not in self._presets:
            return name
        new_name = self.preset_name_input.text().strip() or name
        preset = dict(self._presets.get(name, {}))
        preset['solver'] = self.preset_solver_cb.currentText().strip()
        self._read_form_into_preset(preset)
        if commit_rename and new_name != name:
            self._presets.pop(name, None)
            self._presets[new_name] = preset
            self._current_preset_name = new_name
            return new_name
        self._presets[name] = preset
        return name

    def _on_preset_add(self):
        if not self._solvers:
            message_box.warning(self, 'No solver',
                                'Please create at least one solver first.')
            return
        name = self._unique(self._presets, 'New preset')
        solver = next(iter(self._solvers.keys()))
        self._presets[name] = preset_from_solver(
            solver, {**self._settings, 'solvers': self._solvers})
        self._reload_preset_list(select_name=name)

    def _on_preset_dup(self):
        if not self._current_preset_name:
            return
        src = self._presets.get(self._current_preset_name, {})
        name = self._unique(self._presets, self._current_preset_name + ' copy')
        self._presets[name] = copy.deepcopy(src)
        self._reload_preset_list(select_name=name)

    def _on_preset_del(self):
        if not self._current_preset_name:
            return
        r = message_box.question(
            self, 'Delete preset', f"Delete '{self._current_preset_name}'?",
            QMessageBox.Yes | QMessageBox.No)
        if r != QMessageBox.Yes:
            return
        self._presets.pop(self._current_preset_name, None)
        self._current_preset_name = None
        self._reload_preset_list()

    def _on_preset_save(self):
        new_name = self.preset_name_input.text().strip()
        if not new_name:
            message_box.warning(self, 'Error', 'Preset name cannot be empty.')
            return
        old_name = self._current_preset_name
        preset = dict(self._presets.get(old_name, {}))
        preset['solver'] = self.preset_solver_cb.currentText()
        self._read_form_into_preset(preset)
        preset = normalize_preset(preset, {**self._settings, 'solvers': self._solvers})

        if old_name and old_name != new_name:
            self._presets.pop(old_name, None)
        self._presets[new_name] = preset
        self._current_preset_name = new_name

        # Save with the settings containing the new solvers
        save_presets(self._presets, {**self._settings, 'solvers': self._solvers})
        self._reload_preset_list(select_name=new_name)

    def _on_preset_field_add(self):
        """Create a field on the current solver and include it in this preset."""
        if not self._current_preset_name:
            message_box.warning(self, 'No preset', 'Select a preset first.')
            return
        solver_name = self.preset_solver_cb.currentText().strip()
        solver_def = self._solvers.get(solver_name)
        if not solver_def:
            message_box.warning(self, 'No solver',
                                f"Solver '{solver_name}' not found.")
            return
        existing = [f.get('key', '') for f in solver_def.get('fields', []) or []]
        new_field = edit_field(self, None, existing_keys=existing)
        if new_field is None:
            return
        solver_def.setdefault('fields', []).append(new_field)
        self._solvers[solver_name] = solver_def
        self._add_field_to_current_preset(new_field.get('key', ''))
        if solver_name == self._current_solver_name:
            self._fields_into_table(solver_def.get('fields', []))

    def _add_field_to_current_preset(self, key):
        if not self._current_preset_name:
            return
        preset = self._presets.get(self._current_preset_name, {})
        fields_list = list(preset.get('fields') or [])
        if key in fields_list:
            return
        fields_list.append(key)
        preset['fields'] = fields_list
        preset['solver'] = self.preset_solver_cb.currentText().strip()
        self._presets[self._current_preset_name] = preset
        self._render_preset_value_widgets(preset['solver'], preset)

    def _unique(self, dic, base):
        name = base
        i = 2
        while name in dic:
            name = f'{base} {i}'
            i += 1
        return name

    def _unique_field_key(self, base):
        existing = {str(f.get('key') or '') for f in self._field_data}
        key = base
        if key not in existing:
            return key
        key = f'{base}_copy'
        i = 2
        while key in existing:
            key = f'{base}_copy{i}'
            i += 1
        return key

    # ------------------------------------------------------------------ Apply

    def _effective_solvers_for_dirty_check(self, capture=False):
        if capture:
            self._capture_solver_draft()
        solvers = copy.deepcopy(self._solvers)
        for original_name, draft in self._solver_drafts.items():
            if original_name not in solvers:
                continue
            draft_name = draft.get('name') or original_name
            solvers.pop(original_name, None)
            solvers[draft_name] = {
                'label': draft.get('label') or draft_name,
                'fields': copy.deepcopy(draft.get('fields') or []),
            }
        return solvers

    def _snapshot_settings(self, capture=False):
        s = copy.deepcopy(self._settings)
        solvers = self._effective_solvers_for_dirty_check(capture=capture)
        s.update({
            'server':       self.server_input.text().strip(),
            'user':         self.user_input.text().strip(),
            'password':     self.password_input.text(),
            'ttmacro_path': self.ttm_input.text().strip(),
            'win_prefix':   self.prefix_input.text().strip(),
            'solvers':      solvers,
            'ssh_buttons':  self._collect_ssh_buttons(),
        })
        if s.get('default_solver') not in solvers and solvers:
            s['default_solver'] = next(iter(solvers.keys()))
        return s

    def _dirty_snapshot(self):
        settings = self._snapshot_settings()
        presets = {
            str(name): normalize_preset(preset, settings)
            for name, preset in self._presets.items()
            if str(name).strip() and isinstance(preset, dict)
        }
        return json.dumps(
            {'settings': settings, 'presets': presets},
            sort_keys=True,
            ensure_ascii=True,
            default=str,
        )

    def _has_unsaved_changes(self):
        self._capture_current_drafts()
        return self._dirty_snapshot() != getattr(self, '_original_snapshot', '')

    def _capture_current_drafts(self, commit_preset_rename=False):
        self._capture_solver_draft()
        self._capture_preset_draft(commit_rename=commit_preset_rename)

    def _confirm_discard_or_save(self):
        if not self._has_unsaved_changes():
            return QMessageBox.Discard
        msg = message_box.make(self, 'Save settings?',
                               'Save changes to settings before closing?',
                               QMessageBox.Question,
                               QMessageBox.Save | QMessageBox.Discard | QMessageBox.Cancel,
                               QMessageBox.Save)
        msg.setWindowTitle('Save settings?')
        msg.button(QMessageBox.Discard).setText("Don't Save")
        return msg.exec_()

    def _on_cancel_requested(self):
        self.reject()

    def reject(self):
        choice = self._confirm_discard_or_save()
        if choice == QMessageBox.Cancel:
            return
        if choice == QMessageBox.Save:
            self._on_apply()
            return
        super().reject()

    def closeEvent(self, event):
        choice = self._confirm_discard_or_save()
        if choice == QMessageBox.Cancel:
            event.ignore()
            return
        if choice == QMessageBox.Save:
            self._on_apply()
            event.accept()
            return
        super().closeEvent(event)

    def _on_apply(self):
        self._capture_current_drafts(commit_preset_rename=True)
        self._settings = self._snapshot_settings()
        self._solvers = copy.deepcopy(self._settings.get('solvers') or {})
        self._solver_drafts.clear()
        save_presets(self._presets, self._settings)
        self.settings_applied.emit(self._settings)
        self.accept()
