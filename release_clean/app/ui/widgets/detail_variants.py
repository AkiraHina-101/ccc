"""Detail-panel job variants — Phase B.4b full rewrite per Claude Design v2.0.

Each variant is a self-contained QWidget shown inside the central DetailPanel
QStackedWidget. The visual structure is fixed across all three variants:

    +-----------------------------------------------------+
    | detailHeader (typeBadge | detailJobName | banner)   |  fixed 64px
    +-----------------------------------------------------+
    | body  (scrollable)                                  |
    |   - inputs (folder/file/ext/browse)                 |
    |   - PresetChip                                      |
    |   - PresetPanel (solver KV fields, collapsible)     |
    +-----------------------------------------------------+
    | detailFooter (Submit · Preview · Delete · ...)      |  fixed 52px
    +-----------------------------------------------------+

The QSS in `ui/styles/app.qss` picks these up by objectName / `job_type`
property — no inline stylesheet here.

Solver settings render via `SolverFieldsTable` (vertical KVTable layout) and
a `PresetChip` summary line above. Both live in `ui.widgets.solver_fields_table`
and `ui.widgets.helpers` respectively.
"""

import os
from PySide2.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QLabel, QPushButton, QFrame,
    QLineEdit, QComboBox, QCheckBox, QScrollArea, QSizePolicy, QMenu,
    QTableWidget, QTableWidgetItem, QHeaderView, QAbstractItemView,
    QFileDialog, QMessageBox, QInputDialog, QListWidget,
)
from PySide2.QtCore import Signal, Qt, QPoint
from PySide2.QtGui import QColor, QPainter, QPolygon

from app.ui.widgets.helpers import (
    StatusDot, PresetChip, SectionLabel, ElidedLabel, set_qt_property,
)
from app.ui import message_box
from app.ui.widgets.solver_fields_table import SolverFieldsTable
from app.ui.widgets._solver_change import confirm_and_swap
from app.data.presets import load_presets, save_presets
from app.data.field_defs import resolve_fields_for_solver
from app.data.settings import get_solver


# Maps internal status (Pending/Running/...) to QSS-friendly token.
_STATUS_TOKEN = {
    'Pending': 'pending', 'Queued': 'queued', 'Running': 'running',
    'Done': 'done', 'Error': 'error',
    'Upload': 'queued', 'Fail': 'error',
    'Complete': 'done',
}

# Icon / label helpers so every table cell shows the same glyph for a given
# status. Keeps SingleJob / FolderGroup / MultiFolder in sync.
_STATUS_ICON = {
    'Pending':  '·',     # not submitted yet
    'Upload':   '⇧',     # queued in TeraTerm, not yet on LSF
    'Queued':   '⇧',
    'Running':  '…',
    'Done':     '⏱',     # LSF done, checking f06
    'Complete': '✓',
    'Fail':     '✗',
    'Error':    '!',
}
def _show_file_context_menu(owner, viewport, pos, folder_win, filename, emit_cb):
    """Show a right-click menu with View .dat / .f06 / .log actions.

    - `emit_cb` receives (folder_win, target_filename) and is expected to
      route to the Preview tab (same signal path as double-click).
    - .f06 / .log actions are disabled when that companion file doesn't
      exist on disk yet, giving the user a fast visual signal.
    """
    import os
    if not folder_win or not filename:
        return
    stem, _ = os.path.splitext(filename)
    f06_name = f'{stem}.f06'
    log_name = f'{stem}.log'
    menu = QMenu(owner)
    act_dat = menu.addAction(f'View {filename}')
    act_f06 = menu.addAction(f'View {f06_name}')
    act_log = menu.addAction(f'View {log_name}')
    if not os.path.isfile(os.path.join(folder_win, f06_name)):
        act_f06.setEnabled(False)
        act_f06.setText(f'View {f06_name}  (not found)')
    if not os.path.isfile(os.path.join(folder_win, log_name)):
        act_log.setEnabled(False)
        act_log.setText(f'View {log_name}  (not found)')
    chosen = menu.exec_(viewport.mapToGlobal(pos))
    if chosen is act_dat:
        emit_cb(folder_win, filename)
    elif chosen is act_f06:
        emit_cb(folder_win, f06_name)
    elif chosen is act_log:
        emit_cb(folder_win, log_name)


_STATUS_TIP = {
    'Pending':  'Not submitted',
    'Upload':   'Queued in TeraTerm (waiting for bsub)',
    'Queued':   'Queued on LSF',
    'Running':  'Running on LSF',
    'Done':     'LSF DONE — checking .f06',
    'Complete': '.f06 clean — no FATAL',
    'Fail':     '.f06 contains FATAL',
    'Error':    'Error — check terminal',
}

_TYPE_LABEL = {
    'single': 'ONE JOB / ONE FOLDER',
    'folder': 'MANY JOBS / ONE FOLDER',
    'folder_group': 'MANY JOBS / ONE FOLDER',
    'multi': 'ONE JOB / EACH SUBFOLDER',
    'multi_folder': 'ONE JOB / EACH SUBFOLDER',
}

_TYPE_KEY = {
    'single': 'single',
    'folder': 'folder',
    'folder_group': 'folder',
    'multi': 'multi',
    'multi_folder': 'multi',
}


class _RowSubmitButton(QPushButton):
    """Icon-only submit control: paint a real triangle, not a boxed button."""

    def paintEvent(self, event):
        status = self.property('row_status') or 'ready'
        if status == 'ready' and self.isEnabled():
            painter = QPainter(self)
            painter.setRenderHint(QPainter.Antialiasing, True)
            color = "#115132" if self.isDown() else ("#166942" if self.underMouse() else "#1A8050")
            painter.setPen(Qt.NoPen)
            painter.setBrush(QColor(color))
            r = self.rect()
            cx = r.center().x()
            cy = r.center().y()
            tri = QPolygon([
                QPoint(cx - 5, cy - 8),
                QPoint(cx - 5, cy + 8),
                QPoint(cx + 8, cy),
            ])
            painter.drawPolygon(tri)
            painter.end()
            return
        super().paintEvent(event)


# -----------------------------------------------------------------------------
# Shared base
# -----------------------------------------------------------------------------

class _BaseJobDetail(QWidget):
    """Header + scrollable body + footer skeleton shared by all variants.

    Subclasses build their own body content by overriding `_build_body()`.
    Each variant keeps a `submit_btn`, `remove_btn`, `get_data()`, `set_status()`
    to remain drop-in compatible with the previous card API surface.
    """

    remove_requested     = Signal(int)
    preview_requested    = Signal(str, str)
    preview_sh_requested = Signal(str)
    title_changed        = Signal(int, str)

    JOB_TYPE_KEY = 'single'   # override in subclass
    SUBMIT_LABEL = 'Submit'

    def __init__(self, data: dict, settings: dict = None, parent=None):
        super().__init__(parent)
        self._data = data
        self._settings = settings or {}
        self.setObjectName("detailPanelContent")
        self._init_ui()
        self._connect_signals()

    # -- layout --

    def _init_ui(self):
        root = QVBoxLayout(self)
        root.setContentsMargins(0, 0, 0, 0)
        root.setSpacing(0)

        root.addWidget(self._build_header())
        root.addWidget(self._build_status_banner())
        # Build footer first so submit_btn exists before body refresh logic
        # that needs to update its text (e.g. "Submit (n)").
        footer = self._build_footer()
        body_scroll = self._build_body_scroll()
        root.addWidget(body_scroll, 1)
        root.addWidget(footer)

        self._refresh_header()

    def _build_header(self):
        self.header = QWidget()
        self.header.setObjectName("detailHeader")
        self.header.setAttribute(Qt.WA_StyledBackground, True)
        self.header.setFixedHeight(44)
        set_qt_property(self.header, job_type=self.JOB_TYPE_KEY)

        h = QHBoxLayout(self.header)
        h.setContentsMargins(16, 0, 16, 0)
        h.setSpacing(10)

        self.status_dot = StatusDot(
            _STATUS_TOKEN.get(self._data.get('status', 'Pending'), 'pending'), size=10)
        h.addWidget(self.status_dot, 0, Qt.AlignVCenter)

        self.type_badge = QLabel(_TYPE_LABEL.get(self.JOB_TYPE_KEY, ''))
        self.type_badge.setObjectName("typeBadge")
        set_qt_property(self.type_badge, job_type=self.JOB_TYPE_KEY)
        self.type_badge.setAlignment(Qt.AlignCenter)
        h.addWidget(self.type_badge, 0, Qt.AlignVCenter)

        self.job_name_lbl = QLabel(self._derive_title())
        self.job_name_lbl.setObjectName("detailJobName")
        set_qt_property(self.job_name_lbl, job_type=self.JOB_TYPE_KEY)
        h.addWidget(self.job_name_lbl, 1, Qt.AlignVCenter)

        self.skip_chk = QCheckBox("Skip")
        self.skip_chk.setChecked(bool(self._data.get('skip', False)))
        self.skip_chk.setParent(self.header)
        self.skip_chk.setVisible(False)

        return self.header

    def _build_status_banner(self):
        """Banner shown below the header for Running / Error states."""
        self.status_banner = QWidget()
        self.status_banner.setObjectName("statusBanner")
        self.status_banner.setAttribute(Qt.WA_StyledBackground, True)
        self.status_banner.setFixedHeight(28)
        self.status_banner.setVisible(False)

        bl = QHBoxLayout(self.status_banner)
        bl.setContentsMargins(16, 0, 16, 0)
        bl.setSpacing(8)
        self.status_banner_lbl = QLabel("")
        bl.addWidget(self.status_banner_lbl, 1, Qt.AlignVCenter)
        return self.status_banner

    # Subclasses can set this to False so their body fills the viewport
    # (last widget gets the stretch instead of a trailing spacer).
    BODY_ENDS_WITH_STRETCH = True

    def _build_body_scroll(self):
        self.body = QWidget()
        self.body.setObjectName("detailBody")
        self.body.setAttribute(Qt.WA_StyledBackground, True)
        self.body_layout = QVBoxLayout(self.body)
        self.body_layout.setContentsMargins(10, 10, 10, 10)
        self.body_layout.setSpacing(8)

        self._build_body()
        if self.BODY_ENDS_WITH_STRETCH:
            self.body_layout.addStretch(1)

        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QFrame.NoFrame)
        scroll.setWidget(self.body)
        return scroll

    def _build_footer(self):
        self.footer = QWidget()
        self.footer.setObjectName("detailFooter")
        self.footer.setAttribute(Qt.WA_StyledBackground, True)
        self.footer.setFixedHeight(48)
        f = QHBoxLayout(self.footer)
        f.setContentsMargins(16, 8, 12, 8)
        f.setSpacing(8)

        self._build_footer_left(f)
        f.addStretch(1)
        self._build_footer_right(f)
        return self.footer

    def _build_footer_left(self, layout):
        """Subclass hook for secondary footer actions (Preview .sh, all/none…)."""
        pass

    def _build_footer_right(self, layout):
        # Delete button preserved as attribute for API/test compat; sidebar
        # button now handles user-facing deletion. Not added to layout.
        self.remove_btn = QPushButton("✕ Delete")
        self.remove_btn.setObjectName("deleteBtn")
        self.remove_btn.setParent(self.footer)
        self.remove_btn.setVisible(False)

        self.submit_btn = QPushButton(self.SUBMIT_LABEL)
        self.submit_btn.setObjectName("cardSubmitBtn")
        set_qt_property(self.submit_btn, job_type=self.JOB_TYPE_KEY, status="")
        self.submit_btn.setMinimumSize(120, 32)
        layout.addWidget(self.submit_btn)

    def _build_body(self):
        """Subclasses must override."""
        raise NotImplementedError

    # -- signals shared --

    def _connect_signals(self):
        self.remove_btn.clicked.connect(
            lambda: self.remove_requested.emit(self._data['uid']))
        self.skip_chk.toggled.connect(lambda v: self._data.update({'skip': v}))
        self._connect_signals_extra()

    def _connect_signals_extra(self):
        """Subclass hook for additional wiring."""
        pass

    # -- public API --

    def get_data(self) -> dict:
        return self._data

    def set_data(self, data: dict):
        self._data = data
        self._refresh_header()
        self._refresh_body()

    def set_status(self, status: str):
        self._data['status'] = status
        token = _STATUS_TOKEN.get(status, 'pending')
        self.status_dot.set_status(token)
        set_qt_property(self.submit_btn, status=token if token in ('running', 'done') else '')

        if status == 'Running':
            self.status_banner_lbl.setText("⏳  Running…")
            set_qt_property(self.status_banner, status="running")
            self.status_banner.setVisible(True)
            self.submit_btn.setText("⏳ Running…")
        elif status == 'Upload':
            self.status_banner_lbl.setText("⇧  Queued in TeraTerm — awaiting bsub…")
            set_qt_property(self.status_banner, status="queued")
            self.status_banner.setVisible(True)
            self.submit_btn.setText("⇧ Queued…")
        elif status in ('Error', 'Fail'):
            msg = ("✗  Fail — .f06 contains FATAL"
                   if status == 'Fail'
                   else "⚠  Error — see terminal for details")
            self.status_banner_lbl.setText(msg)
            set_qt_property(self.status_banner, status="error")
            self.status_banner.setVisible(True)
            self.submit_btn.setText(self.SUBMIT_LABEL)
        elif status == 'Done':
            self.status_banner_lbl.setText("⏱  LSF DONE — checking .f06…")
            set_qt_property(self.status_banner, status="running")
            self.status_banner.setVisible(True)
            self.submit_btn.setText("⏱ Done")
        elif status == 'Complete':
            self.status_banner.setVisible(False)
            self.submit_btn.setText("✓ Complete")
        else:
            self.status_banner.setVisible(False)
            self.submit_btn.setText(self.SUBMIT_LABEL)

    def _build_row_submit_button(self, item):
        status = item.get('status', 'Pending')
        icon = _STATUS_ICON.get(status, '')
        tip = _STATUS_TIP.get(status, status)
        # Only Pending / Error are user-actionable (re-submit); everything
        # else is in-flight or terminal.
        is_ready = status in ('Pending', 'Error')
        # Show a play triangle for Ready to make "clickable" unambiguous —
        # separate from the informational icon used for in-flight states.
        display = '▶' if is_ready else icon
        btn = _RowSubmitButton(display)
        btn.setMinimumSize(24, 24)
        btn.setMaximumSize(28, 28)
        btn.setFocusPolicy(Qt.NoFocus)
        btn.setEnabled(is_ready)
        btn.setToolTip('Submit' if is_ready else tip)
        btn.setCursor(Qt.PointingHandCursor)
        set_qt_property(btn, row_status=_STATUS_TOKEN.get(status, 'pending'))
        return btn

    # -- helpers --

    def _refresh_preset_chip(self):
        """Sync preset UI (legacy chip + new toolbar) from solver state."""
        table = getattr(self, 'preset_panel', None)
        if table is None:
            return
        name = self._data.get('preset') or 'default'
        summary = table.preset_summary()

        chip = getattr(self, 'preset_chip', None)
        if chip is not None:
            chip.update_preset(name, summary)

        info_lbl = getattr(self, 'preset_info_lbl', None)
        if info_lbl is not None:
            info_lbl.setText(summary)

        combo = getattr(self, 'preset_combo', None)
        if combo is not None and combo.count() and combo.currentText() != name:
            items = [combo.itemText(i) for i in range(combo.count())]
            if name in items:
                combo.blockSignals(True)
                combo.setCurrentText(name)
                combo.blockSignals(False)

    def _build_preset_toolbar(self, with_preview: bool = True,
                              toolbar_preview_sh: bool = True,
                              with_summary: bool = True) -> QWidget:
        """Build a two-row preset toolbar.

        Row 1: [Preset ⌄] [Save as] [preview actions] [⌃ Hide]
        Row 2: [presetInfoLabel — full-width elided summary]

        Sits inside the SOLVER SETTINGS section, replaces the old PresetChip
        + footer Save/Preview buttons. Subclass is responsible for adding the
        returned widget to its body layout AFTER `self.preset_panel` exists,
        then wiring signals in `_connect_signals_extra`.
        """
        bar = QWidget()
        bar.setObjectName("presetToolbar")
        self.preset_toolbar = bar
        bar.setAttribute(Qt.WA_StyledBackground, True)
        bar.setProperty("job_type", self.JOB_TYPE_KEY)
        outer = QVBoxLayout(bar)
        outer.setContentsMargins(8, 6, 8, 6)
        outer.setSpacing(4)

        # --- Row 1: controls ---
        row1 = QWidget()
        bl = QHBoxLayout(row1)
        bl.setContentsMargins(0, 0, 0, 0)
        bl.setSpacing(8)

        self.preset_combo = QComboBox()
        self.preset_combo.setObjectName("presetCombo")
        self.preset_combo.setMinimumWidth(150)
        self.preset_combo.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Fixed)
        if hasattr(self, 'preset_panel'):
            names = self.preset_panel.get_presets_list()
            if names:
                self.preset_combo.addItems(names)
                current = self._data.get('preset') or 'default'
                if current in names:
                    self.preset_combo.setCurrentText(current)
            else:
                self.preset_combo.addItem("(no presets)")
                self.preset_combo.setEnabled(False)
        bl.addWidget(self.preset_combo, 1)

        self.save_as_btn = QPushButton("Save as")
        self.save_as_btn.setObjectName("presetSaveAsBtn")
        self.save_as_btn.setMinimumWidth(98)
        bl.addWidget(self.save_as_btn)

        if with_preview:
            if toolbar_preview_sh:
                self.preview_sh_toolbar_btn = QPushButton("Preview .sh")
                self.preview_sh_toolbar_btn.setObjectName("presetPreviewBtn")
                self.preview_sh_toolbar_btn.setToolTip("Preview .sh")
                self.preview_sh_toolbar_btn.setMinimumWidth(88)
                bl.addWidget(self.preview_sh_toolbar_btn)
            else:
                self.preview_sh_toolbar_btn = None
            self.preview_dat_toolbar_btn = None
            self.preview_btn = self.preview_sh_toolbar_btn
        else:
            self.preview_sh_toolbar_btn = None
            self.preview_dat_toolbar_btn = None
            self.preview_btn = None

        self.toggle_settings_btn = QPushButton()
        self.toggle_settings_btn.setObjectName("presetToggleBtn")
        self.toggle_settings_btn.setToolTip("Show / hide preset settings")
        self.toggle_settings_btn.setMinimumWidth(86)
        self._refresh_toggle_btn_text()
        self.toggle_settings_btn.clicked.connect(self._on_toggle_settings)
        bl.addWidget(self.toggle_settings_btn)

        outer.addWidget(row1)

        if with_summary:
            # --- Row 2: summary (full width, elided) ---
            self.preset_info_lbl = ElidedLabel("", elide_mode=Qt.ElideRight)
            self.preset_info_lbl.setObjectName("presetInfoLabel")
            self.preset_info_lbl.setProperty("monospace", "true")
            self.preset_info_lbl.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Preferred)
            outer.addWidget(self.preset_info_lbl)
        else:
            self.preset_info_lbl = None

        return bar

    def _refresh_toggle_btn_text(self):
        if not hasattr(self, 'toggle_settings_btn') or self.toggle_settings_btn is None:
            return
        panel = getattr(self, 'preset_panel', None)
        collapsed = bool(panel.is_collapsed()) if panel is not None else True
        self.toggle_settings_btn.setText("⌄ Show" if collapsed else "⌃ Hide")

    def _on_toggle_settings(self):
        panel = getattr(self, 'preset_panel', None)
        if panel is None:
            return
        panel.toggle_collapsed()
        self._refresh_toggle_btn_text()

    def _on_preset_combo_changed(self, name: str):
        if not name or name.startswith("(") or name.endswith(")"):
            return
        if hasattr(self, 'preset_panel'):
            self.preset_panel.apply_preset(name)

    def _on_preset_saved(self, name: str):
        """Refresh preset_combo after PresetPanel writes a new preset to disk.

        Without this the dropdown keeps its stale snapshot from card init and
        the just-saved preset stays invisible until app restart.
        """
        combo = getattr(self, 'preset_combo', None)
        if combo is None:
            return
        names = self.preset_panel.get_presets_list() if hasattr(self, 'preset_panel') else []
        combo.blockSignals(True)
        combo.clear()
        if names:
            combo.addItems(names)
            combo.setEnabled(True)
            if name in names:
                combo.setCurrentText(name)
        else:
            combo.addItem('(no presets)')
            combo.setEnabled(False)
        combo.blockSignals(False)

    def _prompt_save_as_new(self, fields):
        name, ok = QInputDialog.getText(self, 'Save preset as', 'Preset name:')
        name = (name or '').strip()
        if not ok or not name:
            return
        presets = load_presets(self._settings)
        if name in presets:
            r = message_box.question(
                self, 'Overwrite?',
                f"Preset '{name}' already exists. Overwrite?",
                QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            if r != QMessageBox.Yes:
                return
        preset = {
            'solver': self._data.get('solver', ''),
            'fields': list(fields),
        }
        presets[name] = preset
        save_presets(presets, self._settings)
        self._data['preset'] = name
        self.preset_panel._presets = presets
        if hasattr(self, 'preset_combo'):
            self.preset_combo.blockSignals(True)
            self.preset_combo.clear()
            self.preset_combo.addItems(list(presets.keys()))
            self.preset_combo.setCurrentText(name)
            self.preset_combo.blockSignals(False)
        message_box.information(self, 'Saved', f"Preset '{name}' saved.")

    def _derive_title(self) -> str:
        folder = (self._data.get('folder_win')
                  or self._data.get('folder_linux')
                  or self._data.get('parent_folder_win')
                  or self._data.get('parent_folder_linux')
                  or '')
        if folder:
            return os.path.basename(folder.replace('\\', '/').rstrip('/'))
        if self.JOB_TYPE_KEY == 'multi':
            return "Select parent folder"
        if self.JOB_TYPE_KEY == 'folder':
            return "Select folder"
        return self._data.get('filename') or "Select folder"

    def _refresh_header(self):
        title = self._derive_title()
        self.job_name_lbl.setText(title)
        uid = self._data.get('uid')
        if uid is not None:
            sidebar_label = self._derive_sidebar_label()
            try:
                self.title_changed.emit(int(uid), sidebar_label)
            except (TypeError, ValueError):
                pass

    def _derive_sidebar_label(self) -> str:
        """Full folder path for sidebar (rendered with ElideLeft when narrow).

        Falls back to the compact header title if no folder is set yet.
        """
        folder = (self._data.get('folder_win')
                  or self._data.get('folder_linux')
                  or self._data.get('parent_folder_win')
                  or self._data.get('parent_folder_linux')
                  or '')
        if folder:
            return folder.replace('\\', '/')
        return self._derive_title()

    def _refresh_body(self):
        """Subclasses may override to refresh body widgets when data changes."""
        pass


# -----------------------------------------------------------------------------
# Single
# -----------------------------------------------------------------------------

class SingleJobDetail(_BaseJobDetail):
    submit_requested = Signal(dict)

    JOB_TYPE_KEY = 'single'

    def _build_body(self):
        # Gather-files section — collect INCLUDE-referenced files from a
        # scattered source folder into the submit folder before submit.
        self._build_gather_section()

        # Folder row
        folder_row = QHBoxLayout()
        folder_row.setSpacing(6)
        folder_lbl = QLabel("Folder")
        folder_lbl.setFixedWidth(60)
        folder_row.addWidget(folder_lbl)
        self.folder_edit = QLineEdit(self._data.get('folder_linux', ''))
        self.folder_edit.setProperty("monospace", "true")
        self.folder_edit.setPlaceholderText("Click Browse to select a folder…")
        # Long paths are common (deep build folders); tooltip = full path so
        # the user doesn't have to scroll inside the input to read it.
        self.folder_edit.setToolTip(self.folder_edit.text())
        self.folder_edit.textChanged.connect(self.folder_edit.setToolTip)
        folder_row.addWidget(self.folder_edit, 1)
        self.browse_btn = QPushButton("📂 Browse")
        folder_row.addWidget(self.browse_btn)
        self.body_layout.addLayout(folder_row)

        # File row
        file_row = QHBoxLayout()
        file_row.setSpacing(6)
        file_lbl = QLabel("File")
        file_lbl.setFixedWidth(60)
        file_row.addWidget(file_lbl)
        self.file_combo = QComboBox()
        self.file_combo.setProperty("monospace", "true")
        file_row.addWidget(self.file_combo, 1)
        self.ext_combo = QComboBox()
        self.ext_combo.addItems(['.dat', '.bdf', '.nas', '.inp', '*'])
        self.ext_combo.setFixedWidth(72)
        fn = self._data.get('filename', '')
        if fn:
            for ext in ['.dat', '.bdf', '.nas', '.inp']:
                if fn.lower().endswith(ext):
                    self.ext_combo.setCurrentText(ext)
                    break
        file_row.addWidget(self.ext_combo)
        self.file_count_lbl = QLabel("")
        self.file_count_lbl.setObjectName("hintLabel")
        file_row.addWidget(self.file_count_lbl)
        self.view_btn = QPushButton("View")
        file_row.addWidget(self.view_btn)
        self.body_layout.addLayout(file_row)

        # Solver settings — section label + preset toolbar + KV table
        self.body_layout.addWidget(SectionLabel("Solver settings"))
        is_collapsed = bool(self._data.get('settings_collapsed', True))
        self.preset_panel = SolverFieldsTable(
            self._data, self._settings, collapsed=is_collapsed)
        self.body_layout.addWidget(self._build_preset_toolbar(with_preview=True))
        self.body_layout.addWidget(self.preset_panel)

        self._refresh_preset_chip()
        self._update_file_combo()

    def _build_footer_left(self, layout):
        # Save preset + Preview live on the SOLVER SETTINGS toolbar.
        # toggle_settings_btn is built by _build_preset_toolbar and shown there.
        pass

    def _connect_signals_extra(self):
        self.submit_btn.clicked.connect(
            lambda: self.submit_requested.emit(self._data))
        self.view_btn.clicked.connect(
            lambda: self.preview_requested.emit(
                self._data.get('folder_win', ''), self.file_combo.currentText()))
        self.browse_btn.clicked.connect(self._on_browse_clicked)
        self.file_combo.currentTextChanged.connect(self._on_file_changed)
        self.ext_combo.currentTextChanged.connect(self._update_file_combo)
        self.folder_edit.textChanged.connect(self._on_folder_input_changed)
        self.preset_panel.solver_change_requested.connect(self._on_solver_change_requested)
        self.preset_panel.preset_saved.connect(self._on_preset_saved)
        self.preset_panel.values_changed.connect(self._on_preset_values_changed)
        # New SOLVER SETTINGS toolbar wiring
        self.preset_combo.currentTextChanged.connect(self._on_preset_combo_changed)
        self.save_as_btn.clicked.connect(self.preset_panel.save_preset)
        if self.preview_sh_toolbar_btn is not None:
            self.preview_sh_toolbar_btn.clicked.connect(self._on_preview_sh_clicked)
        if self.preview_dat_toolbar_btn is not None:
            self.preview_dat_toolbar_btn.clicked.connect(
                lambda: self.preview_requested.emit(
                    self._data.get('folder_win', ''), self.file_combo.currentText()))

    # -- slots --

    def _on_preset_values_changed(self):
        fn = self._data.get('filename', '')
        items = [self.file_combo.itemText(i) for i in range(self.file_combo.count())]
        if fn and fn in items and self.file_combo.currentText() != fn:
            self.file_combo.blockSignals(True)
            self.file_combo.setCurrentText(fn)
            self.file_combo.blockSignals(False)
        self._refresh_header()
        self._refresh_preset_chip()

    def _on_solver_change_requested(self, new_solver):
        confirm_and_swap(self, self._data, self._settings,
                         self.preset_panel, new_solver)

    def _update_file_combo(self):
        try:
            self.file_combo.currentTextChanged.disconnect(self._on_file_changed)
        except (RuntimeError, TypeError):
            pass
        try:
            self.file_combo.clear()
            available = self._data.get('available_files', [])
            ext_filter = self.ext_combo.currentText().lower()
            if ext_filter == '*':
                filtered = list(available)
            else:
                filtered = [f for f in available if f.lower().endswith(ext_filter)]

            if not available:
                self.file_combo.addItem('(choose folder first)')
                self.file_combo.setEnabled(False)
            elif not filtered:
                self.file_combo.addItem(f'(no {ext_filter} files)')
                self.file_combo.setEnabled(False)
            else:
                self.file_combo.setEnabled(True)
                self.file_combo.addItems(filtered)
                cur = self._data.get('filename', '')
                if cur in filtered:
                    self.file_combo.setCurrentText(cur)
                else:
                    self.file_combo.setCurrentIndex(0)
                    self._data['filename'] = self.file_combo.currentText()
            self.file_count_lbl.setText(
                f"{len(filtered)} files" if available else "")
            self.preset_panel.update_filename_field(self._data.get('filename', ''))
        finally:
            self.file_combo.currentTextChanged.connect(self._on_file_changed)

    def _on_browse_clicked(self):
        folder = QFileDialog.getExistingDirectory(self, 'Select folder')
        if not folder:
            return
        from app.logic.path_utils import to_linux, list_dat
        linux = to_linux(folder, self._settings.get('win_prefix', ''))
        files = list_dat(folder)
        self._data['folder_win'] = folder
        self._data['folder_linux'] = linux
        self._data['available_files'] = files
        self.folder_edit.setText(linux)
        self._update_file_combo()
        self._refresh_header()

    def _on_file_changed(self, filename):
        if filename.startswith('(') and filename.endswith(')'):
            return
        self._data['filename'] = filename
        self._refresh_header()
        self.preset_panel.update_filename_field(filename)

    def _on_folder_input_changed(self, text):
        self._data['folder_linux'] = text
        self._refresh_header()

    def _on_preview_sh_clicked(self):
        self.preset_panel._flush()
        folder = self._data.get('folder_linux', '')
        filename = self._data.get('filename', '')
        if not folder or not filename:
            self.preview_sh_requested.emit('# No folder or file selected.')
            return
        try:
            from app.logic.heredoc import build_heredoc_str
            # Pass full data+settings so custom heredoc_input fields (Comment,
            # etc.) show up in the preview, not just the 5 built-in fields.
            text = build_heredoc_str(folder, filename, self._data, self._settings)
            self.preview_sh_requested.emit(text)
        except Exception as e:
            self.preview_sh_requested.emit(f'# Error building heredoc:\n# {e}')

    # -- gather files ----------------------------------------------------

    def _build_gather_section(self):
        self.body_layout.addWidget(SectionLabel("Gather files"))

        # Row: Source path
        row = QHBoxLayout()
        row.setSpacing(6)
        src_lbl = QLabel("Source")
        src_lbl.setFixedWidth(60)
        row.addWidget(src_lbl)
        self.gather_source_edit = QLineEdit(self._data.get('gather_source', ''))
        self.gather_source_edit.setProperty("monospace", "true")
        self.gather_source_edit.setPlaceholderText(
            "Folder to browse / to gather INCLUDE files from")
        self.gather_source_edit.setToolTip(self.gather_source_edit.text())
        self.gather_source_edit.textChanged.connect(self.gather_source_edit.setToolTip)
        self.gather_source_edit.textChanged.connect(self._on_gather_source_changed)
        row.addWidget(self.gather_source_edit, 1)
        self.gather_browse_btn = QPushButton("📂 Browse")
        row.addWidget(self.gather_browse_btn)
        self.gather_validate_btn = QPushButton("🔍 Validate")
        self.gather_validate_btn.setToolTip(
            "Parse INCLUDE/ASSIGN in the selected .dat and mark which files "
            "are already in the submit folder vs gatherable from source")
        row.addWidget(self.gather_validate_btn)
        self.gather_copy_missing_btn = QPushButton("📋 Copy missing")
        self.gather_copy_missing_btn.setEnabled(False)
        self.gather_copy_missing_btn.setToolTip(
            "Copy every INCLUDE/ASSIGN file found in source into the submit folder")
        row.addWidget(self.gather_copy_missing_btn)
        self.body_layout.addLayout(row)

        # Row: status chips — one cell per counter, distinct visually so the
        # user can scan them at a glance instead of parsing a run-on string.
        chips_row = QHBoxLayout()
        chips_row.setSpacing(6)
        self.gather_chip_required   = self._make_gather_chip('required',   '—')
        self.gather_chip_in_submit  = self._make_gather_chip('in submit',  '—')
        self.gather_chip_gatherable = self._make_gather_chip('gatherable', '—')
        self.gather_chip_missing    = self._make_gather_chip('missing',    '—')
        self.gather_chip_userfile   = self._make_gather_chip('USERFILE',   '—', warn=True)
        self.gather_chip_userfile.setVisible(False)
        for chip in (self.gather_chip_required, self.gather_chip_in_submit,
                     self.gather_chip_gatherable, self.gather_chip_missing,
                     self.gather_chip_userfile):
            chips_row.addWidget(chip)
        chips_row.addStretch(1)
        self.body_layout.addLayout(chips_row)

        # Optional extension filter — the user only cares about a handful of
        # extensions (.dat, .bdf, .inc, ...) at any time; showing the whole
        # tree is noisy. Comma / space separated.
        ext_row = QHBoxLayout()
        ext_row.setContentsMargins(0, 0, 0, 0)
        ext_row.addWidget(QLabel('Show only:'))
        self.gather_ext_filter = QLineEdit(self._data.get('gather_ext_filter', ''))
        self.gather_ext_filter.setPlaceholderText('.dat, .bdf, .inc  (blank = all)')
        self.gather_ext_filter.setClearButtonEnabled(True)
        ext_row.addWidget(self.gather_ext_filter, 1)
        self.body_layout.addLayout(ext_row)

        # Two-panel file browser: LEFT = source, RIGHT = submit folder (swap
        # from previous layout per user request; arrow direction now points
        # right, matching "push from source into submit").
        # Uses QSplitter so the two lists can be resized by dragging; each
        # panel can shrink independently.
        from PySide2.QtWidgets import QSplitter
        panels_wrap = QHBoxLayout()
        panels_wrap.setSpacing(6)

        self.gather_splitter = QSplitter(Qt.Horizontal)
        self.gather_splitter.setChildrenCollapsible(False)

        left_widget = QWidget()
        left_col = QVBoxLayout(left_widget)
        left_col.setContentsMargins(0, 0, 0, 0)
        left_col.setSpacing(2)
        left_col.addWidget(QLabel('Source folder (recursive)'))
        self.gather_source_list = QListWidget()
        self.gather_source_list.setSelectionMode(QAbstractItemView.ExtendedSelection)
        # Lower minimum so the user can shrink the gather section on smaller
        # screens; upper size is unbounded — grows with the card.
        self.gather_source_list.setMinimumHeight(80)
        left_col.addWidget(self.gather_source_list)
        self.gather_splitter.addWidget(left_widget)

        mid_widget = QWidget()
        mid_col = QVBoxLayout(mid_widget)
        mid_col.setContentsMargins(4, 0, 4, 0)
        mid_col.setSpacing(6)
        mid_col.addStretch(1)
        self.gather_copy_selected_btn = QPushButton('Add >')
        self.gather_copy_selected_btn.setToolTip(
            'Copy the file(s) selected in the source panel into the submit folder')
        self.gather_copy_selected_btn.setFixedSize(72, 34)
        _f = self.gather_copy_selected_btn.font()
        _f.setPointSize(11)
        _f.setBold(True)
        self.gather_copy_selected_btn.setFont(_f)
        mid_col.addWidget(self.gather_copy_selected_btn)
        self.gather_refresh_btn = QPushButton('Refresh')
        self.gather_refresh_btn.setToolTip('Rescan both folders')
        self.gather_refresh_btn.setFixedSize(72, 30)
        _f2 = self.gather_refresh_btn.font()
        _f2.setPointSize(10)
        self.gather_refresh_btn.setFont(_f2)
        mid_col.addWidget(self.gather_refresh_btn)
        mid_col.addStretch(1)
        # Mid column keeps a fixed narrow width in the splitter.
        mid_widget.setFixedWidth(84)
        self.gather_splitter.addWidget(mid_widget)
        self.gather_splitter.setStretchFactor(1, 0)

        right_widget = QWidget()
        right_col = QVBoxLayout(right_widget)
        right_col.setContentsMargins(0, 0, 0, 0)
        right_col.setSpacing(2)
        right_col.addWidget(QLabel('Submit folder'))
        self.gather_dest_list = QListWidget()
        self.gather_dest_list.setSelectionMode(QAbstractItemView.ExtendedSelection)
        self.gather_dest_list.setMinimumHeight(80)
        right_col.addWidget(self.gather_dest_list)
        self.gather_splitter.addWidget(right_widget)

        self.gather_splitter.setStretchFactor(0, 1)
        self.gather_splitter.setStretchFactor(2, 1)
        # Reasonable starting split — user's drag persists in-session.
        self.gather_splitter.setSizes([300, 84, 300])

        panels_wrap.addWidget(self.gather_splitter)
        self.body_layout.addLayout(panels_wrap)

        self.gather_browse_btn.clicked.connect(self._on_gather_browse_clicked)
        self.gather_validate_btn.clicked.connect(self._on_gather_validate_clicked)
        self.gather_copy_missing_btn.clicked.connect(self._on_gather_copy_clicked)
        self.gather_copy_selected_btn.clicked.connect(self._on_gather_copy_selected_clicked)
        self.gather_refresh_btn.clicked.connect(self._on_gather_refresh_clicked)
        self.gather_ext_filter.textChanged.connect(self._on_gather_ext_filter_changed)

        # Names of files just copied into the submit folder (this session).
        # They stay highlighted until the user hits Refresh so it's obvious
        # what changed in the panel and still needs to be uploaded to server.
        self._recently_added_names = set()

        # Populate panels immediately so the user sees folder contents even
        # before picking a .dat / running Validate.
        self._refresh_gather_panels()

    def _make_gather_chip(self, label, value, warn=False):
        """Compact cell showing 'label: value' — used for the count row."""
        chip = QLabel(f'{label}: {value}')
        chip.setObjectName('gatherChipWarn' if warn else 'gatherChip')
        chip.setStyleSheet(
            'QLabel { border: 1px solid #4A5568; border-radius: 4px; '
            'padding: 2px 8px; background: #22272E; color: #E6EDF3; }'
            if not warn else
            'QLabel { border: 1px solid #B34C4C; border-radius: 4px; '
            'padding: 2px 8px; background: #3A1C1C; color: #FFB4B4; }'
        )
        chip.setMinimumWidth(80)
        chip.setAlignment(Qt.AlignCenter)
        chip._label = label
        return chip

    def _set_gather_chip(self, chip, value):
        chip.setText(f'{chip._label}: {value}')

    def _on_gather_browse_clicked(self):
        start = self._data.get('gather_source', '') or self._data.get('folder_win', '')
        folder = QFileDialog.getExistingDirectory(self, 'Select source folder', start)
        if not folder:
            return
        self.gather_source_edit.setText(folder)
        self._refresh_gather_panels()

    def _on_gather_source_changed(self, text):
        self._data['gather_source'] = text

    def _gather_dest_dat_path(self):
        """Where the .dat we're scanning lives on the local Windows disk."""
        folder = self._data.get('folder_win', '')
        filename = self._data.get('filename', '')
        if not folder or not filename:
            return None
        path = os.path.join(folder, filename)
        if not os.path.isfile(path):
            return None
        return path

    def _on_gather_validate_clicked(self):
        # Validate is now just a re-scan — the two panels + chips update in one
        # pass. Keeping the button separate from Refresh so the user sees a
        # dedicated "check my .dat" action.
        self._refresh_gather_panels()

    def _on_gather_refresh_clicked(self):
        # Refresh implicitly acknowledges the recently-added highlights — the
        # user has seen them and now wants a clean rescan.
        self._recently_added_names.clear()
        self._refresh_gather_panels()

    def _refresh_gather_panels(self):
        """Rescan both folders and repaint panels + status chips.

        Runs gather_report only when a .dat is available; otherwise just lists
        raw folder contents so the user can push arbitrary files across.
        """
        from app.logic.file_gather import gather_report

        source = self._data.get('gather_source', '').strip()
        dest = self._data.get('folder_win', '')
        dat_path = self._gather_dest_dat_path()

        report = None
        if dat_path:
            report = gather_report(dat_path, source, dest)
            self._last_gather_report = report
        else:
            self._last_gather_report = None

        self._populate_dest_list(dest, report)
        self._populate_source_list(source, report)
        self._update_gather_chips(report, source, dat_path)

    def _gather_ext_filter_set(self):
        """Parse the ext filter input into a set of lowercased extensions
        (with leading dot). Empty result → show everything.
        """
        raw = (self._data.get('gather_ext_filter') or '').strip()
        if not raw:
            return set()
        exts = set()
        for tok in raw.replace(',', ' ').split():
            tok = tok.strip().lower()
            if not tok:
                continue
            if not tok.startswith('.'):
                tok = '.' + tok
            exts.add(tok)
        return exts

    def _passes_ext_filter(self, name, ext_set):
        if not ext_set:
            return True
        ext = os.path.splitext(name)[1].lower()
        return ext in ext_set

    def _populate_dest_list(self, dest, report):
        from PySide2.QtWidgets import QListWidgetItem
        from PySide2.QtGui import QBrush, QColor
        self.gather_dest_list.clear()
        if not dest or not os.path.isdir(dest):
            item = QListWidgetItem('(submit folder not set)')
            item.setForeground(QBrush(QColor('#AAB6C5')))
            self.gather_dest_list.addItem(item)
            return
        required_lower = set()
        if report:
            required_lower = {n.lower() for n in report.get('required', [])}
        recent = {n.lower() for n in self._recently_added_names}
        ext_set = self._gather_ext_filter_set()
        # Colors: green if it's a required file present (Complete for INCLUDE),
        # amber if just-added and not yet on server, plain for everything else.
        COL_REQUIRED = QColor('#3FB950')   # green — matches required set
        COL_RECENT   = QColor('#F2CC60')   # amber
        BG_REQUIRED  = QColor(63, 185, 80, 40)   # subtle green wash
        BG_RECENT    = QColor(242, 204, 96, 55)  # subtle amber wash
        for name in sorted(os.listdir(dest)):
            path = os.path.join(dest, name)
            if not os.path.isfile(path):
                continue
            if not self._passes_ext_filter(name, ext_set):
                continue
            is_required = name.lower() in required_lower
            is_recent = name.lower() in recent
            prefix = '✓ ' if is_required else '   '
            marker = '★ ' if is_recent else ''
            item = QListWidgetItem(f'{prefix}{marker}{name}')
            if is_recent:
                item.setForeground(QBrush(COL_RECENT))
                item.setBackground(QBrush(BG_RECENT))
                item.setToolTip('Recently added — not yet uploaded to server')
            elif is_required:
                item.setForeground(QBrush(COL_REQUIRED))
                item.setBackground(QBrush(BG_REQUIRED))
                item.setToolTip('Required by the .dat — already in submit folder')
            self.gather_dest_list.addItem(item)

    def _populate_source_list(self, source, report):
        from PySide2.QtWidgets import QListWidgetItem
        from PySide2.QtGui import QBrush, QColor
        self.gather_source_list.clear()
        self._source_index = {}  # display_text -> absolute path
        if not source or not os.path.isdir(source):
            item = QListWidgetItem('(pick a source folder)')
            item.setForeground(QBrush(QColor('#AAB6C5')))
            self.gather_source_list.addItem(item)
            return
        gatherable_lower = set()
        required_lower = set()
        in_submit_lower = set()
        if report:
            gatherable_lower = {
                n.lower() for n, p in (report.get('source_paths') or {}).items() if p
            }
            required_lower = {n.lower() for n in report.get('required', [])}
            in_submit_lower = {n.lower() for n, s in (report.get('status') or {}).items() if s == 'ok'}
        ext_set = self._gather_ext_filter_set()
        entries = []
        for root, _dirs, files in os.walk(source):
            for f in files:
                if not self._passes_ext_filter(f, ext_set):
                    continue
                rel = os.path.relpath(os.path.join(root, f), source)
                entries.append((rel, os.path.join(root, f)))
        entries.sort(key=lambda t: t[0].lower())
        # Palette:
        #   green  — required by .dat AND already in submit (nothing to do)
        #   amber  — required by .dat AND NOT in submit (push me!)
        #   dim    — not required
        COL_HAVE    = QColor('#3FB950')
        BG_HAVE     = QColor(63, 185, 80, 40)
        COL_MISSING = QColor('#F2CC60')
        BG_MISSING  = QColor(242, 204, 96, 55)
        COL_DIM     = QColor('#8B95A5')
        for rel, abs_path in entries:
            base = os.path.basename(rel).lower()
            is_gatherable = base in gatherable_lower       # required + missing in submit
            is_already_in = base in in_submit_lower        # required + already present
            is_required = base in required_lower
            if is_gatherable:
                prefix = '➜ '   # push me
            elif is_already_in:
                prefix = '✓ '
            else:
                prefix = '   '
            display = f'{prefix}{rel}'
            item = QListWidgetItem(display)
            if is_gatherable:
                item.setForeground(QBrush(COL_MISSING))
                item.setBackground(QBrush(BG_MISSING))
                item.setToolTip('Referenced by .dat — click "Add >" to push into submit folder')
            elif is_already_in:
                item.setForeground(QBrush(COL_HAVE))
                item.setBackground(QBrush(BG_HAVE))
                item.setToolTip('Already in submit folder')
            elif not is_required:
                item.setForeground(QBrush(COL_DIM))
            self.gather_source_list.addItem(item)
            self._source_index[display] = abs_path

    def _on_gather_ext_filter_changed(self, text):
        self._data['gather_ext_filter'] = text
        self._refresh_gather_panels()

    def _update_gather_chips(self, report, source, dat_path):
        if not report:
            # No .dat picked → hide counters that only make sense with a report.
            self._set_gather_chip(self.gather_chip_required, '—')
            self._set_gather_chip(self.gather_chip_in_submit, '—')
            self._set_gather_chip(self.gather_chip_gatherable, '—')
            self._set_gather_chip(self.gather_chip_missing, '—')
            self.gather_chip_userfile.setVisible(False)
            self.gather_copy_missing_btn.setEnabled(False)
            return
        required = report['required']
        status = report['status']
        source_paths = report.get('source_paths') or {}
        userfile_status = report.get('userfile_status') or {}

        in_submit = sum(1 for s in status.values() if s == 'ok')
        missing = [n for n, s in status.items() if s == 'missing']
        gatherable = [n for n in missing if source_paths.get(n)]
        missing_anywhere = [n for n in missing if not source_paths.get(n)]
        userfile_mismatches = [n for n, s in userfile_status.items() if s != 'ok']

        self._set_gather_chip(self.gather_chip_required, str(len(required)))
        self._set_gather_chip(self.gather_chip_in_submit, str(in_submit))
        self._set_gather_chip(self.gather_chip_gatherable, str(len(gatherable)))
        self._set_gather_chip(self.gather_chip_missing, str(len(missing_anywhere)))
        if userfile_mismatches:
            self._set_gather_chip(self.gather_chip_userfile,
                                  f'{len(userfile_mismatches)} name mismatch')
            self.gather_chip_userfile.setVisible(True)
        else:
            self.gather_chip_userfile.setVisible(False)

        self.gather_copy_missing_btn.setEnabled(bool(gatherable))

    def _on_gather_copy_clicked(self):
        """Copy every gatherable INCLUDE/ASSIGN file into the submit folder."""
        from app.logic.file_gather import copy_to_dest
        report = getattr(self, '_last_gather_report', None)
        if not report:
            return
        source_paths = report.get('source_paths') or {}
        to_copy = {n: p for n, p in source_paths.items() if p}
        if not to_copy:
            return
        dest = self._data.get('folder_win', '')
        copied, failed = copy_to_dest(to_copy, dest)
        self._recently_added_names.update(copied)
        self._refresh_gather_panels()
        if failed:
            msg = "\n".join(f"  {n}: {reason}" for n, reason in failed)
            QMessageBox.warning(
                self, 'Some files could not be copied',
                f"Copied {len(copied)} file(s).\nFailed:\n{msg}")

    def _on_gather_copy_selected_clicked(self):
        """Copy the row(s) the user picked in the source panel to the submit folder."""
        from app.logic.file_gather import copy_to_dest
        dest = self._data.get('folder_win', '')
        if not dest:
            QMessageBox.warning(
                self, 'No submit folder',
                'Pick a submit folder first — nowhere to copy to.')
            return
        items = self.gather_source_list.selectedItems()
        if not items:
            return
        to_copy = {}
        for it in items:
            abs_path = getattr(self, '_source_index', {}).get(it.text())
            if not abs_path:
                continue
            to_copy[os.path.basename(abs_path)] = abs_path
        if not to_copy:
            return

        # Duplicate handling. Silently skipping would leave the user with a
        # stale file and no signal — ask explicitly.
        existing = [n for n in to_copy if os.path.exists(os.path.join(dest, n))]
        overwrite = False
        if existing:
            preview = ', '.join(existing[:5]) + (' …' if len(existing) > 5 else '')
            box = QMessageBox(self)
            box.setWindowTitle('File already exists')
            box.setText(
                f'{len(existing)} file(s) with the same name already in submit folder:\n\n{preview}')
            box.setInformativeText('Overwrite them, or skip and copy only the new ones?')
            overwrite_btn = box.addButton('Overwrite all', QMessageBox.AcceptRole)
            skip_btn = box.addButton('Skip existing', QMessageBox.DestructiveRole)
            cancel_btn = box.addButton('Cancel', QMessageBox.RejectRole)
            box.setDefaultButton(skip_btn)
            box.exec_()
            clicked = box.clickedButton()
            if clicked is cancel_btn:
                return
            overwrite = clicked is overwrite_btn
            if not overwrite:
                # Drop existing from the copy plan so the caller reports the
                # right count instead of the silent "already-satisfied" path.
                to_copy = {n: p for n, p in to_copy.items() if n not in existing}
                if not to_copy:
                    return
        copied, failed = copy_to_dest(to_copy, dest, overwrite=overwrite)
        self._recently_added_names.update(copied)
        self._refresh_gather_panels()
        if failed:
            msg = "\n".join(f"  {n}: {reason}" for n, reason in failed)
            QMessageBox.warning(
                self, 'Some files could not be copied',
                f"Copied {len(copied)} file(s).\nFailed:\n{msg}")


# -----------------------------------------------------------------------------
# Folder Group
# -----------------------------------------------------------------------------

class FolderGroupDetail(_BaseJobDetail):
    submit_selected = Signal(dict, list)

    JOB_TYPE_KEY = 'folder'
    SUBMIT_LABEL = "Submit all (0)"
    BODY_ENDS_WITH_STRETCH = False   # Let files_table fill the viewport

    def _build_body(self):
        # Folder row
        folder_row = QHBoxLayout()
        folder_row.setSpacing(6)
        folder_lbl = QLabel("Folder")
        folder_lbl.setFixedWidth(60)
        folder_row.addWidget(folder_lbl)
        self.folder_edit = QLineEdit(self._data.get('folder_linux', ''))
        self.folder_edit.setProperty("monospace", "true")
        self.folder_edit.setPlaceholderText("Click Browse to select a folder…")
        # Long paths are common (deep build folders); tooltip = full path so
        # the user doesn't have to scroll inside the input to read it.
        self.folder_edit.setToolTip(self.folder_edit.text())
        self.folder_edit.textChanged.connect(self.folder_edit.setToolTip)
        folder_row.addWidget(self.folder_edit, 1)
        self.browse_btn = QPushButton("📂 Browse")
        folder_row.addWidget(self.browse_btn)
        self.body_layout.addLayout(folder_row)

        # Solver settings — label + preset toolbar + KV table
        self.body_layout.addWidget(SectionLabel("Solver settings"))
        is_collapsed = bool(self._data.get('settings_collapsed', True))
        self.preset_panel = SolverFieldsTable(
            self._data, self._settings, collapsed=is_collapsed)
        # Folder Group also shows Preview (previews 1st checked file heredoc)
        self.body_layout.addWidget(self._build_preset_toolbar(
            with_preview=True, toolbar_preview_sh=False))
        self.body_layout.addWidget(self.preset_panel)
        self._refresh_preset_chip()

        # Files header — section label + extension dropdown + count
        files_header = QHBoxLayout()
        files_header.setSpacing(6)
        files_header.addWidget(SectionLabel("Files"))
        self.ext_combo = QComboBox()
        self.ext_combo.setObjectName("filesExtCombo")
        self.ext_combo.setMinimumWidth(110)
        files_header.addWidget(self.ext_combo)
        files_header.addStretch(1)
        self.files_count_lbl = QLabel("0 / 0 files")
        self.files_count_lbl.setObjectName("hintLabel")
        files_header.addWidget(self.files_count_lbl)
        self.body_layout.addLayout(files_header)

        # Files table — 4 cols: [?] Filename | Status | Submit
        self.files_table = QTableWidget(0, 4)
        self.files_table.setObjectName("filesTable")
        self.files_table.setHorizontalHeaderLabels(
            ["", "Filename", "Status", "Run"])
        self.files_table.setAlternatingRowColors(True)
        self.files_table.setSelectionBehavior(QAbstractItemView.SelectRows)
        self.files_table.setEditTriggers(QAbstractItemView.NoEditTriggers)
        self.files_table.verticalHeader().setVisible(False)
        hdr = self.files_table.horizontalHeader()
        hdr.setSectionResizeMode(0, QHeaderView.Fixed)
        hdr.setSectionResizeMode(1, QHeaderView.Stretch)
        hdr.setSectionResizeMode(2, QHeaderView.Fixed)
        hdr.setSectionResizeMode(3, QHeaderView.Fixed)
        self.files_table.setColumnWidth(0, 40)
        self.files_table.setColumnWidth(2, 120)
        self.files_table.setColumnWidth(3, 64)
        self.files_table.setMinimumWidth(540)
        self.files_table.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        self.files_table.setContextMenuPolicy(Qt.CustomContextMenu)
        # stretch=1 lets the table fill the remaining vertical space; scroll bar
        # appears only when content (rows) exceeds the viewport.
        self.body_layout.addWidget(self.files_table, 1)

        self._refresh_ext_combo()
        self._refresh_files_table()

    def _build_footer_left(self, layout):
        # Save/Load preset + Settings toggle live on SOLVER SETTINGS toolbar.
        pass

    def _build_footer_right(self, layout):
        self.remove_btn = QPushButton("✕ Delete")
        self.remove_btn.setObjectName("deleteBtn")
        self.remove_btn.setParent(self.footer)
        self.remove_btn.setVisible(False)

        self.preview_sh_all_btn = QPushButton("Preview all .sh")
        self.preview_sh_all_btn.setObjectName("presetPreviewBtn")
        self.preview_sh_all_btn.setToolTip("Preview one combined .sh for all checked files")
        self.preview_sh_all_btn.setFixedSize(120, 30)
        layout.addWidget(self.preview_sh_all_btn, 0, Qt.AlignVCenter)

        self.submit_btn = QPushButton(self.SUBMIT_LABEL)
        self.submit_btn.setObjectName("cardSubmitBtn")
        set_qt_property(self.submit_btn, job_type=self.JOB_TYPE_KEY, status="")
        self.submit_btn.setFixedSize(120, 30)
        layout.addWidget(self.submit_btn, 0, Qt.AlignVCenter)

    def _connect_signals_extra(self):
        self.submit_btn.clicked.connect(self._on_submit_selected)
        self.browse_btn.clicked.connect(self._on_browse_clicked)
        self.ext_combo.currentTextChanged.connect(self._refresh_files_table)
        self.folder_edit.textChanged.connect(self._on_folder_input_changed)
        self.preset_panel.solver_change_requested.connect(self._on_solver_change_requested)
        self.preset_panel.preset_saved.connect(self._on_preset_saved)
        self.preset_panel.values_changed.connect(self._refresh_preset_chip)
        # New SOLVER SETTINGS toolbar
        self.preset_combo.currentTextChanged.connect(self._on_preset_combo_changed)
        self.save_as_btn.clicked.connect(self.preset_panel.save_preset)
        self.preview_sh_all_btn.clicked.connect(self._on_preview_sh_clicked)
        self.files_table.cellClicked.connect(self._on_file_row_clicked)
        # Double-click a file row → open it in the Preview tab. Uses the same
        # signal as the toolbar "Preview .dat" button.
        self.files_table.cellDoubleClicked.connect(self._on_file_row_double_clicked)
        self.files_table.customContextMenuRequested.connect(self._on_files_context_menu)

    def _on_preview_sh_clicked(self):
        """Toolbar Preview .sh — build heredoc for ALL checked files (concat)."""
        self.preset_panel._flush()
        ext = self.ext_combo.currentText().lower() if hasattr(self, 'ext_combo') else ''
        checked = [fi for fi in self._data.get('files', [])
                   if fi.get('checked')
                   and (not ext.startswith('.') or fi['name'].lower().endswith(ext))]
        if not checked:
            self.preview_sh_requested.emit(
                '# No file selected — check at least one file to preview heredoc.')
            return
        folder = self._data.get('folder_linux', '')
        parts = []
        for fi in checked:
            parts.append(self._build_heredoc_safe(folder, fi['name']))
        sep = '\n\n# ' + ('-' * 60) + '\n\n'
        self.preview_sh_requested.emit(sep.join(parts))

    def _preview_sh_for_file(self, filename: str):
        """Per-row Preview .sh — build heredoc for a single file."""
        self.preset_panel._flush()
        folder = self._data.get('folder_linux', '')
        self.preview_sh_requested.emit(self._build_heredoc_safe(folder, filename))

    def _on_file_row_clicked(self, row, column):
        return

    def _on_file_row_double_clicked(self, row, column):
        shown = self._shown_files()
        if row < 0 or row >= len(shown):
            return
        self.preview_requested.emit(self._data.get('folder_win', ''), shown[row]['name'])

    def _on_files_context_menu(self, pos):
        """Right-click on a file row → open .dat / .f06 / .log in Preview.

        .f06 and .log are only enabled when the file exists in the folder;
        that way the user gets a clear signal instead of a "cannot read"
        placeholder in the preview pane.
        """
        row = self.files_table.rowAt(pos.y())
        shown = self._shown_files()
        if row < 0 or row >= len(shown):
            return
        folder_win = self._data.get('folder_win', '')
        filename = shown[row]['name']
        _show_file_context_menu(self, self.files_table.viewport(), pos,
                                folder_win, filename,
                                self.preview_requested.emit)

    def _shown_files(self):
        ext = self.ext_combo.currentText().lower() if hasattr(self, 'ext_combo') else ''
        files = self._data.get('files', [])
        return [fi for fi in files
                if not ext.startswith('.') or fi['name'].lower().endswith(ext)]

    def _selected_file(self):
        row = self.files_table.currentRow()
        shown = self._shown_files()
        if row < 0 or row >= len(shown):
            return None
        return shown[row]

    def _preview_sh_for_selected_file(self):
        fi = self._selected_file()
        if not fi:
            return
        self._preview_sh_for_file(fi['name'])

    def _preview_dat_for_selected_file(self):
        fi = self._selected_file()
        if not fi:
            return
        self.preview_requested.emit(self._data.get('folder_win', ''), fi['name'])

    def _build_heredoc_safe(self, folder: str, filename: str) -> str:
        try:
            from app.logic.heredoc import build_heredoc_str
            return build_heredoc_str(folder, filename, self._data, self._settings)
        except Exception as e:
            return f"# Preview failed for {filename}: {e}"

    def _on_preview_dat_clicked(self):
        ext = self.ext_combo.currentText().lower() if hasattr(self, 'ext_combo') else ''
        files = self._data.get('files', [])
        if ext.startswith('.'):
            files = [fi for fi in files if fi['name'].lower().endswith(ext)]
        checked = [fi for fi in files if fi.get('checked')]
        target = checked[0] if checked else (files[0] if files else None)
        if target is None:
            return
        self.preview_requested.emit(
            self._data.get('folder_win', ''), target['name'])

    # -- slots --

    def _on_solver_change_requested(self, new_solver):
        confirm_and_swap(self, self._data, self._settings,
                         self.preset_panel, new_solver)

    def _on_folder_input_changed(self, text):
        self._data['folder_linux'] = text
        self._refresh_header()

    def _on_browse_clicked(self):
        folder = QFileDialog.getExistingDirectory(self, 'Select folder')
        if not folder:
            return
        from app.logic.path_utils import to_linux, list_dat
        linux = to_linux(folder, self._settings.get('win_prefix', ''))
        files = list_dat(folder)
        self._data['folder_win'] = folder
        self._data['folder_linux'] = linux
        self._data['files'] = [{'name': f, 'checked': True, 'status': 'Pending'}
                                for f in files]
        self.folder_edit.setText(linux)
        self._refresh_ext_combo()
        self._refresh_header()
        self._refresh_files_table()

    def _refresh_ext_combo(self):
        """Populate ext dropdown with extensions actually present in folder."""
        files = self._data.get('files', [])
        exts = sorted({os.path.splitext(fi['name'])[1].lower()
                       for fi in files if os.path.splitext(fi['name'])[1]})
        self.ext_combo.blockSignals(True)
        self.ext_combo.clear()
        if not exts:
            self.ext_combo.addItem('(no files)')
            self.ext_combo.setEnabled(False)
        else:
            self.ext_combo.setEnabled(True)
            self.ext_combo.addItems(exts)
            if '.dat' in exts:
                self.ext_combo.setCurrentText('.dat')
            else:
                self.ext_combo.setCurrentIndex(0)
        self.ext_combo.blockSignals(False)

    def _check_all(self):
        for fi in self._data.get('files', []):
            fi['checked'] = True
        self._refresh_files_table()

    def _uncheck_all(self):
        for fi in self._data.get('files', []):
            fi['checked'] = False
        self._refresh_files_table()

    def _visible_files(self):
        ext = self.ext_combo.currentText().lower() if hasattr(self, 'ext_combo') else ''
        files = self._data.get('files', [])
        if ext.startswith('.'):
            return files, [fi for fi in files if fi['name'].lower().endswith(ext)]
        return files, list(files)

    def _update_files_counter(self):
        """Update Submit button + count label without touching table rows.

        Used when a checkbox toggles: rebuilding the table clears scroll
        position, which is jarring when the user is deep in a long list.
        """
        files, shown = self._visible_files()
        selected = sum(1 for fi in shown if fi.get('checked'))
        self.submit_btn.setText(f"Submit all ({selected})")
        self.submit_btn.setEnabled(selected > 0)
        self.files_count_lbl.setText(f"{len(shown)} / {len(files)} files")

    def _refresh_files_table(self):
        files, shown = self._visible_files()
        # Count checked among the CURRENTLY VISIBLE extension subset.
        # Submit handler also filters by visible ext so the count matches what
        # the user will actually submit.
        selected = sum(1 for fi in shown if fi.get('checked'))

        self.submit_btn.setText(f"Submit all ({selected})")
        self.submit_btn.setEnabled(selected > 0)
        self.files_count_lbl.setText(f"{len(shown)} / {len(files)} files")

        self.files_table.setRowCount(0)
        for fi in shown:
            r = self.files_table.rowCount()
            self.files_table.insertRow(r)
            self.files_table.setRowHeight(r, 44)

            # Checkbox cell (centered)
            chk = QCheckBox()
            chk.setChecked(fi.get('checked', True))
            chk.toggled.connect(lambda v, f=fi: self._on_file_checked(f, v))
            cell = QWidget()
            cl = QHBoxLayout(cell)
            cl.setContentsMargins(0, 0, 0, 0)
            cl.setAlignment(Qt.AlignCenter)
            cl.addWidget(chk)
            self.files_table.setCellWidget(r, 0, cell)

            name_item = QTableWidgetItem(fi['name'])
            self.files_table.setItem(r, 1, name_item)

            st = fi.get('status', 'Pending')
            icon = _STATUS_ICON.get(st, '')
            status_item = QTableWidgetItem(f'{icon} {st}' if icon else st)
            status_item.setTextAlignment(Qt.AlignCenter)
            status_item.setToolTip(_STATUS_TIP.get(st, st))
            self.files_table.setItem(r, 2, status_item)

            submit_row_btn = self._build_row_submit_button(fi)
            submit_row_btn.setObjectName("batchRowSubmitBtn")
            submit_row_btn.clicked.connect(
                lambda *_, f=fi: self.submit_selected.emit(self._data, [f]))
            self.files_table.setCellWidget(r, 3, self._wrap_table_cell(submit_row_btn))

    @staticmethod
    def _wrap_table_cell(widget) -> QWidget:
        """Wrap a button in a centered cell so it doesn't stretch oddly."""
        cell = QWidget()
        cl = QHBoxLayout(cell)
        cl.setContentsMargins(4, 2, 4, 2)
        cl.setAlignment(Qt.AlignCenter)
        cl.addWidget(widget)
        return cell

    def _on_file_checked(self, fi, value):
        fi['checked'] = value
        # Do NOT rebuild the table — that resets the scroll bar to the top,
        # which is jarring when the user is toggling a checkbox halfway down a
        # long list. Only the counter/button state depends on this toggle.
        self._update_files_counter()

    def _on_submit_selected(self):
        ext = self.ext_combo.currentText().lower() if hasattr(self, 'ext_combo') else ''
        checked = [fi for fi in self._data.get('files', [])
                   if fi.get('checked')
                   and fi.get('status') in ('Pending', 'Error')
                   and (not ext.startswith('.') or fi['name'].lower().endswith(ext))]
        if not checked:
            return
        choice = QMessageBox.question(
            self, 'Submit all files?',
            f'About to submit {len(checked)} file(s) from this folder.\n\nContinue?',
            QMessageBox.Yes | QMessageBox.No,
            QMessageBox.No)
        if choice != QMessageBox.Yes:
            return
        self.submit_selected.emit(self._data, checked)


# -----------------------------------------------------------------------------
# Multi Folder
# -----------------------------------------------------------------------------

class MultiFolderDetail(_BaseJobDetail):
    submit_all_rows = Signal(list)

    JOB_TYPE_KEY = 'multi'
    SUBMIT_LABEL = "Submit all"
    BODY_ENDS_WITH_STRETCH = False   # Let rows_table fill the viewport

    _STATUS_COLOR = {
        'pending': '#6B7280', 'queued': '#2563EB', 'running': '#D97706',
        'done': '#16A34A', 'error': '#DC2626',
    }

    def _build_body(self):
        self._selected_row_idx = -1

        # -- PARENT FOLDER section -------------------------------------
        self.body_layout.addWidget(SectionLabel("Parent folder"))

        parent_row = QHBoxLayout()
        parent_row.setSpacing(6)
        self.parent_folder_edit = QLineEdit(self._data.get('parent_folder_linux', ''))
        self.parent_folder_edit.setProperty("monospace", "true")
        self.parent_folder_edit.setPlaceholderText("Click Browse to select parent folder…")
        # Tooltip = full path so the user can read it without scrolling inside.
        self.parent_folder_edit.setToolTip(self.parent_folder_edit.text())
        self.parent_folder_edit.textChanged.connect(self.parent_folder_edit.setToolTip)
        parent_row.addWidget(self.parent_folder_edit, 1)
        self.parent_browse_btn = QPushButton("📂 Browse")
        self.parent_browse_btn.setObjectName("multiParentBrowseBtn")
        parent_row.addWidget(self.parent_browse_btn)
        self.body_layout.addLayout(parent_row)

        self.parent_helper_lbl = QLabel("Sub-folders will be listed from this directory")
        self.parent_helper_lbl.setObjectName("multiHelperLabel")
        self.body_layout.addWidget(self.parent_helper_lbl)

        # -- SOLVER SETTINGS (bound to selected row) --------------------
        self.body_layout.addWidget(SectionLabel("Solver settings"))
        # Seed a stub data dict so the panel can render the toolbar; the actual
        # row data is bound via set_data() when a row is selected.
        self._panel_stub = {'solver': self._settings.get('default_solver', 'nast'),
                            'settings_collapsed': True}
        self.preset_panel = SolverFieldsTable(
            self._panel_stub, self._settings, collapsed=True)
        self.body_layout.addWidget(self._build_preset_toolbar(
            with_preview=False, with_summary=False))
        self.body_layout.addWidget(self.preset_panel)
        # Empty state until a row is selected.
        self.preset_panel.set_data(None)
        self._set_panel_enabled(False)
        self._refresh_preset_chip()

        # -- JOBS — N ROWS section -------------------------------------
        jobs_header_row = QHBoxLayout()
        jobs_header_row.setSpacing(6)
        jobs_header_row.addWidget(SectionLabel("Jobs"))
        self.jobs_count_lbl = QLabel("— 0 ROWS")
        self.jobs_count_lbl.setObjectName("multiJobsCount")
        jobs_header_row.addWidget(self.jobs_count_lbl)
        self.ext_combo = QComboBox()
        self.ext_combo.setObjectName("filesExtCombo")
        self.ext_combo.setMinimumWidth(110)
        jobs_header_row.addWidget(self.ext_combo)
        jobs_header_row.addStretch(1)
        self.body_layout.addLayout(jobs_header_row)

        self.rows_table = QTableWidget(0, 6)
        self.rows_table.setObjectName("multiJobsTable")
        self.rows_table.setHorizontalHeaderLabels(
            ["SUB-FOLDER", "PRESET", "FILE .DAT", "STATUS", "Run", "Delete"])
        hdr = self.rows_table.horizontalHeader()
        hdr.setSectionsMovable(False)
        hdr.setStretchLastSection(False)
        hdr.setMinimumSectionSize(16)
        hdr.setSectionResizeMode(0, QHeaderView.Interactive)
        hdr.setSectionResizeMode(1, QHeaderView.Interactive)
        hdr.setSectionResizeMode(2, QHeaderView.Stretch)
        hdr.setSectionResizeMode(3, QHeaderView.Fixed)
        hdr.setSectionResizeMode(4, QHeaderView.Fixed)
        hdr.setSectionResizeMode(5, QHeaderView.Fixed)
        self.rows_table.setColumnWidth(0, 220)
        self.rows_table.setColumnWidth(1, 160)
        self.rows_table.setColumnWidth(2, 280)
        self.rows_table.setColumnWidth(3, 130)
        self.rows_table.setColumnWidth(4, 56)
        self.rows_table.setColumnWidth(5, 56)
        self.rows_table.setMinimumWidth(750)
        self.rows_table.verticalHeader().setVisible(False)
        self.rows_table.setAlternatingRowColors(True)
        self.rows_table.setSelectionBehavior(QAbstractItemView.SelectRows)
        self.rows_table.setEditTriggers(QAbstractItemView.NoEditTriggers)
        self.rows_table.setShowGrid(False)
        self.rows_table.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        self.rows_table.setContextMenuPolicy(Qt.CustomContextMenu)
        self.body_layout.addWidget(self.rows_table, 1)

        self.add_row_btn = QPushButton("+ Add job")
        self.add_row_btn.setObjectName("multiAddRowBtn")
        self.add_row_btn.setFixedHeight(34)
        self.add_row_btn.setParent(self)
        self.add_row_btn.setVisible(False)

        self._refresh_subfolder_list()
        self._refresh_ext_combo()
        self._apply_current_ext_to_rows()
        self._refresh_rows_table()

    def _build_footer_left(self, layout):
        pass

    def _build_footer_right(self, layout):
        self.remove_btn = QPushButton("✕ Delete")
        self.remove_btn.setObjectName("deleteBtn")
        self.remove_btn.setParent(self.footer)
        self.remove_btn.setVisible(False)

        self.preview_sh_all_btn = QPushButton("Preview all .sh")
        self.preview_sh_all_btn.setObjectName("presetPreviewBtn")
        self.preview_sh_all_btn.setToolTip("Preview one combined .sh for all valid rows")
        self.preview_sh_all_btn.setFixedSize(120, 30)
        layout.addWidget(self.preview_sh_all_btn, 0, Qt.AlignVCenter)

        self.submit_btn = QPushButton(self.SUBMIT_LABEL)
        self.submit_btn.setObjectName("cardSubmitBtn")
        set_qt_property(self.submit_btn, job_type=self.JOB_TYPE_KEY, status="")
        self.submit_btn.setFixedSize(120, 30)
        layout.addWidget(self.submit_btn, 0, Qt.AlignVCenter)

    def _connect_signals_extra(self):
        self.submit_btn.clicked.connect(self._on_submit_all)
        self.preview_sh_all_btn.clicked.connect(self._on_preview_sh_all)
        self.add_row_btn.clicked.connect(self._on_add_row)
        self.parent_browse_btn.clicked.connect(self._on_browse_parent)
        self.parent_folder_edit.textChanged.connect(self._on_parent_text_changed)
        self.ext_combo.currentTextChanged.connect(self._on_ext_changed)
        self.rows_table.itemSelectionChanged.connect(self._on_row_selection_changed)
        self.rows_table.cellClicked.connect(self._on_row_clicked)
        self.rows_table.cellDoubleClicked.connect(self._on_row_double_clicked)
        self.rows_table.customContextMenuRequested.connect(self._on_rows_context_menu)
        self.preset_combo.currentTextChanged.connect(self._on_panel_preset_combo_changed)
        self.save_as_btn.clicked.connect(self.preset_panel.save_preset)
        self.preset_panel.solver_change_requested.connect(self._on_solver_change_requested)
        self.preset_panel.preset_saved.connect(self._on_preset_saved)
        self.preset_panel.values_changed.connect(self._on_panel_values_changed)

    # -- selected-row binding --

    def _on_row_selection_changed(self):
        sel = self.rows_table.selectedItems()
        if not sel:
            self._bind_panel_to_row(-1)
            return
        row = sel[0].row()
        self._bind_panel_to_row(row)

    def _on_row_clicked(self, row, column):
        self._bind_panel_to_row(row)
        return

    def _on_row_double_clicked(self, row, column):
        rows = self._data.get('rows', [])
        if row < 0 or row >= len(rows):
            return
        rd = rows[row]
        folder_win = rd.get('folder_win', '')
        filename = rd.get('filename', '')
        if folder_win and filename:
            self.preview_requested.emit(folder_win, filename)

    def _on_rows_context_menu(self, pos):
        row = self.rows_table.rowAt(pos.y())
        rows = self._data.get('rows', [])
        if row < 0 or row >= len(rows):
            return
        rd = rows[row]
        _show_file_context_menu(self, self.rows_table.viewport(), pos,
                                rd.get('folder_win', ''), rd.get('filename', ''),
                                self.preview_requested.emit)

    def _bind_panel_to_row(self, idx: int):
        rows = self._data.get('rows', [])
        if idx < 0 or idx >= len(rows):
            self._selected_row_idx = -1
            self.preset_panel.set_data(None)
            self._set_panel_enabled(False)
            self._refresh_preset_chip()
            return
        self._selected_row_idx = idx
        rd = rows[idx]
        rd['settings_collapsed'] = self._data.get(
            'settings_collapsed', self.preset_panel.is_collapsed())
        self.preset_panel.set_data(rd, self._settings)
        self._set_panel_enabled(True)
        self._sync_preset_combo_to_row(rd)
        self._refresh_preset_chip()
        self._refresh_toggle_btn_text()

    def _on_toggle_settings(self):
        panel = getattr(self, 'preset_panel', None)
        if panel is None:
            return
        collapsed = panel.toggle_collapsed()
        self._data['settings_collapsed'] = collapsed
        if 0 <= self._selected_row_idx < len(self._data.get('rows', [])):
            self._data['rows'][self._selected_row_idx]['settings_collapsed'] = collapsed
        self._refresh_toggle_btn_text()

    def _set_panel_enabled(self, on: bool):
        for w in (self.preset_combo, self.save_as_btn, self.toggle_settings_btn):
            if w is not None:
                w.setEnabled(bool(on))

    def _sync_preset_combo_to_row(self, rd: dict):
        name = rd.get('preset') or ''
        if not name:
            return
        items = [self.preset_combo.itemText(i) for i in range(self.preset_combo.count())]
        if name in items:
            self.preset_combo.blockSignals(True)
            self.preset_combo.setCurrentText(name)
            self.preset_combo.blockSignals(False)

    def _on_panel_preset_combo_changed(self, name: str):
        if self._selected_row_idx < 0:
            return
        if not name or name.startswith('(') or name.endswith(')'):
            return
        self.preset_panel.apply_preset(name)
        rd = self._data['rows'][self._selected_row_idx]
        rd['preset'] = name
        self._refresh_rows_table()
        # _refresh_rows_table rebuilds widgets — re-select the same row.
        self.rows_table.selectRow(self._selected_row_idx)

    def _on_panel_values_changed(self):
        if self._selected_row_idx < 0:
            return
        self._refresh_preset_chip()

    def _refresh_preset_chip(self):
        """Override base: in Multi the preset belongs to the selected row, not
        the card. Without a row, show the placeholder summary."""
        table = getattr(self, 'preset_panel', None)
        if table is None:
            return
        rd = (self._data.get('rows') or [None])[self._selected_row_idx] \
            if 0 <= self._selected_row_idx < len(self._data.get('rows', [])) else None
        name = (rd.get('preset') if rd else '') or ''
        summary = table.preset_summary() if rd is not None else ''
        info_lbl = getattr(self, 'preset_info_lbl', None)
        if info_lbl is not None:
            info_lbl.setText(summary if rd is not None else '')
        combo = getattr(self, 'preset_combo', None)
        if combo is not None and name and combo.count() and combo.currentText() != name:
            items = [combo.itemText(i) for i in range(combo.count())]
            if name in items:
                combo.blockSignals(True)
                combo.setCurrentText(name)
                combo.blockSignals(False)

    def _on_solver_change_requested(self, new_solver):
        if self._selected_row_idx < 0:
            return
        rd = self._data['rows'][self._selected_row_idx]
        confirm_and_swap(self, rd, self._settings,
                         self.preset_panel, new_solver)

    def _on_parent_text_changed(self, text):
        self._data['parent_folder_linux'] = text
        self._refresh_header()

    # -- parent folder --

    def _on_browse_parent(self):
        folder = QFileDialog.getExistingDirectory(self, 'Select parent folder')
        if not folder:
            return
        from app.logic.path_utils import to_linux
        linux = to_linux(folder, self._settings.get('win_prefix', ''))
        self._data['parent_folder_win'] = folder
        self._data['parent_folder_linux'] = linux
        self.parent_folder_edit.blockSignals(True)
        self.parent_folder_edit.setText(linux)
        self.parent_folder_edit.blockSignals(False)
        self._refresh_subfolder_list()
        self._refresh_ext_combo()
        self._apply_current_ext_to_rows()
        self._refresh_rows_table()
        self._refresh_header()

    def _list_subfolders(self):
        parent_win = self._data.get('parent_folder_win', '')
        if not parent_win or not os.path.isdir(parent_win):
            return []
        try:
            return sorted([d for d in os.listdir(parent_win)
                           if os.path.isdir(os.path.join(parent_win, d))])
        except OSError:
            return []

    def _refresh_subfolder_list(self):
        subs = self._list_subfolders()
        self._data['_subfolders_cache'] = subs
        n = len(subs)
        if n == 0:
            self.parent_helper_lbl.setText(
                "Sub-folders will be listed from this directory")
        else:
            self.parent_helper_lbl.setText(
                f"Sub-folders will be listed from this directory · {n} sub-folders found")
        self._sync_rows_to_subfolders(subs)

    def _default_row_for_subfolder(self, subfolder):
        default_solver = self._settings.get('default_solver', 'nast')
        solver_def = get_solver(self._settings, default_solver) or {}
        preset_names = sorted(load_presets(self._settings).keys())
        default_preset = 'default' if 'default' in preset_names else (
            preset_names[0] if preset_names else 'default')
        parent_win = self._data.get('parent_folder_win', '')
        parent_linux = self._data.get('parent_folder_linux', '')
        row = {
            'subfolder': subfolder,
            'folder_win': os.path.join(parent_win, subfolder) if parent_win else '',
            'folder_linux': ((parent_linux.rstrip('/') + '/' + subfolder)
                             if parent_linux else ''),
            'filename': '',
            'available_files': [],
            'preset': default_preset,
            'status': 'Pending',
            'solver': default_solver,
            'settings_collapsed': self._data.get('settings_collapsed', True),
        }
        from app.logic.path_utils import list_dat
        if row['folder_win']:
            files = list_dat(row['folder_win'])
            row['available_files'] = files
            row['filename'] = self._pick_file_for_current_ext(files)
        for f in resolve_fields_for_solver(solver_def, self._settings):
            key = f.get('key')
            if key and key not in row:
                row[key] = str(f.get('default', ''))
        return row

    def _sync_rows_to_subfolders(self, subfolders):
        if not subfolders:
            return
        rows = self._data.setdefault('rows', [])
        existing = {r.get('subfolder') for r in rows if r.get('subfolder')}
        for sub in subfolders:
            if sub not in existing:
                rows.append(self._default_row_for_subfolder(sub))

    def _available_exts(self):
        rows = self._data.get('rows', [])
        exts = set()
        for rd in rows:
            files = list(rd.get('available_files') or [])
            if not files and rd.get('folder_win') and os.path.isdir(rd.get('folder_win')):
                from app.logic.path_utils import list_dat
                files = list_dat(rd['folder_win'])
                rd['available_files'] = files
            for name in files:
                ext = os.path.splitext(name)[1].lower()
                if ext:
                    exts.add(ext)
        return sorted(exts)

    def _refresh_ext_combo(self):
        current = self.ext_combo.currentText() if hasattr(self, 'ext_combo') else ''
        exts = self._available_exts()
        self.ext_combo.blockSignals(True)
        self.ext_combo.clear()
        if not exts:
            self.ext_combo.addItem('(no files)')
            self.ext_combo.setEnabled(False)
        else:
            self.ext_combo.setEnabled(True)
            self.ext_combo.addItems(exts)
            if current in exts:
                self.ext_combo.setCurrentText(current)
            elif '.dat' in exts:
                self.ext_combo.setCurrentText('.dat')
            else:
                self.ext_combo.setCurrentIndex(0)
        self.ext_combo.blockSignals(False)

    def _current_ext(self):
        ext = self.ext_combo.currentText().lower() if hasattr(self, 'ext_combo') else ''
        return ext if ext.startswith('.') else ''

    def _pick_file_for_current_ext(self, files):
        if not files:
            return ''
        ext = self._current_ext()
        if ext:
            matches = [f for f in files if f.lower().endswith(ext)]
            return matches[0] if matches else ''
        return files[0]

    def _apply_current_ext_to_rows(self):
        for rd in self._data.get('rows', []):
            files = list(rd.get('available_files') or [])
            if files:
                rd['filename'] = self._pick_file_for_current_ext(files)

    def _on_ext_changed(self, _text):
        self._apply_current_ext_to_rows()
        self._refresh_rows_table()

    # -- rows --

    def _on_add_row(self):
        # Seed the row with solver defaults from the current default solver so
        # the per-row settings panel has values to show / submit can use.
        default_solver = self._settings.get('default_solver', 'nast')
        solver_def = get_solver(self._settings, default_solver) or {}
        seeded = {'subfolder': '', 'folder_win': '', 'folder_linux': '',
                  'filename': '', 'available_files': [],
                  'preset': 'default', 'status': 'Pending',
                  'solver': default_solver,
                  'settings_collapsed': self._data.get('settings_collapsed', True)}
        for f in resolve_fields_for_solver(solver_def, self._settings):
            key = f.get('key')
            if key and key not in seeded:
                seeded[key] = str(f.get('default', ''))
        self._data.setdefault('rows', []).append(seeded)
        self._refresh_rows_table()
        # Auto-select the new row so the settings panel rebinds to it.
        new_idx = len(self._data['rows']) - 1
        self.rows_table.selectRow(new_idx)
        self._bind_panel_to_row(new_idx)

    def _refresh_rows_table(self):
        rows = self._data.get('rows', [])
        subfolders = self._data.get('_subfolders_cache', []) or []
        self.rows_table.setRowCount(0)
        n = len(rows)
        self.jobs_count_lbl.setText(f"— {n} ROW{'S' if n != 1 else ''}")

        for rd in rows:
            r = self.rows_table.rowCount()
            self.rows_table.insertRow(r)
            self.rows_table.setRowHeight(r, 44)
            # Sentinel items so selectRow() fires itemSelectionChanged even
            # though every cell is replaced with a cellWidget below.
            for c in range(self.rows_table.columnCount()):
                self.rows_table.setItem(r, c, QTableWidgetItem(''))

            # -- Col 0 — Sub-folder dropdown --
            sub_combo = QComboBox()
            if subfolders:
                sub_combo.addItem("(select sub-folder…)")
                sub_combo.addItems(subfolders)
                cur = rd.get('subfolder', '')
                if cur and cur in subfolders:
                    sub_combo.setCurrentText(cur)
            else:
                sub_combo.addItem("(set parent folder first)")
                sub_combo.setEnabled(False)
            if rd.get('status') == 'Error':
                sub_combo.setProperty("row_status", "error")
                set_qt_property(sub_combo, row_status="error")
            sub_combo.currentTextChanged.connect(
                lambda t, x=rd, c=sub_combo: self._on_subfolder_changed(x, t, c))
            self.rows_table.setCellWidget(r, 0, self._wrap_cell(sub_combo, 6))

            # -- Col 1 — Preset dropdown (same QComboBox style as Batch) --
            preset_combo = QComboBox()
            preset_combo.setObjectName("presetCombo")
            preset_names = sorted(load_presets(self._settings).keys())
            if preset_names:
                preset_combo.addItems(preset_names)
                cur = rd.get('preset') or ''
                if cur in preset_names:
                    preset_combo.setCurrentText(cur)
                else:
                    rd['preset'] = preset_combo.currentText()
            else:
                preset_combo.addItem("(no presets)")
                preset_combo.setEnabled(False)
            preset_combo.currentTextChanged.connect(
                lambda t, x=rd: self._on_row_preset_changed(x, t))
            self.rows_table.setCellWidget(r, 1, self._wrap_cell(preset_combo, 6))

            # -- Col 2 — File .dat label --
            fname = rd.get('filename') or '(auto-detect from sub-folder)'
            fname_lbl = QLabel(fname)
            fname_lbl.setObjectName("multiFileLabel")
            fname_lbl.setProperty("has_file", bool(rd.get('filename')))
            self.rows_table.setCellWidget(r, 2, self._wrap_cell(fname_lbl, 10))

            # -- Col 3 — Status (dot + text) --
            status_cell = QWidget()
            sl = QHBoxLayout(status_cell)
            sl.setContentsMargins(8, 0, 8, 0)
            sl.setSpacing(6)
            token = _STATUS_TOKEN.get(rd.get('status', 'Pending'), 'pending')
            dot = StatusDot(token, size=8)
            sl.addWidget(dot)
            st_name = rd.get('status', 'Pending')
            icon = _STATUS_ICON.get(st_name, '')
            status_text = QLabel(f'{icon} {st_name}' if icon else st_name)
            status_text.setToolTip(_STATUS_TIP.get(st_name, st_name))
            color = self._STATUS_COLOR.get(token, '#6B7280')
            status_text.setStyleSheet(
                f"font-size: 12px; color:{color}; background:transparent;")
            sl.addWidget(status_text)
            sl.addStretch(1)
            self.rows_table.setCellWidget(r, 3, status_cell)

            # -- Col 4 — Submit (same enablement rule as Batch: status-based) --
            submit_row_btn = self._build_row_submit_button(rd)
            submit_row_btn.setObjectName("batchRowSubmitBtn")
            submit_row_btn.setToolTip("Submit this row")
            submit_row_btn.clicked.connect(
                lambda *_, x=rd: self._on_submit_row_clicked(x))
            self.rows_table.setCellWidget(r, 4, self._wrap_action_cell(submit_row_btn))

            # -- Col 5 — Delete × (own column) --
            del_btn = QPushButton("×")
            del_btn.setObjectName("multiRowDeleteBtn")
            # 22x24 was tiny on high-DPI; 28x26 keeps it visually subtle while
            # giving the click target enough surface for trackpad / 4K monitor.
            del_btn.setFixedSize(28, 26)
            del_btn.setFocusPolicy(Qt.NoFocus)
            del_btn.setToolTip("Remove row")
            del_btn.clicked.connect(lambda *_, x=rd: self._on_delete_row(x))
            self.rows_table.setCellWidget(
                r, 5, self._wrap_action_cell(del_btn, margins=(0, 0, 2, 0),
                                             alignment=Qt.AlignCenter))

        self.submit_btn.setEnabled(bool(rows))
        if rows and self._selected_row_idx < 0:
            self.rows_table.selectRow(0)
            self._bind_panel_to_row(0)

    def _wrap_cell(self, w, left_pad=6):
        cell = QWidget()
        cl = QHBoxLayout(cell)
        cl.setContentsMargins(left_pad, 4, 6, 4)
        cl.setSpacing(0)
        cl.addWidget(w)
        return cell

    @staticmethod
    def _wrap_action_cell(widget, margins=(0, 2, 0, 2), alignment=Qt.AlignCenter):
        """Centered wrap identical to FolderGroupDetail._wrap_table_cell so
        action buttons (Preview/Submit/Delete) line up exactly like Batch."""
        cell = QWidget()
        cl = QHBoxLayout(cell)
        cl.setContentsMargins(*margins)
        cl.setAlignment(alignment)
        cl.addWidget(widget)
        return cell

    def _preset_btn_label(self, rd) -> str:
        name = rd.get('preset', 'default')
        solver = rd.get('solver') or self._data.get('solver') or ''
        if solver:
            return f"  {name}    {solver}  ->"
        return f"  {name}  ->"

    def _on_subfolder_changed(self, rd, text, combo):
        if not text or (text.startswith("(") and text.endswith(")")):
            return
        parent_win = self._data.get('parent_folder_win', '')
        parent_linux = self._data.get('parent_folder_linux', '')
        if not parent_win:
            return
        rd['subfolder'] = text
        rd['folder_win'] = os.path.join(parent_win, text)
        rd['folder_linux'] = ((parent_linux.rstrip('/') + '/' + text)
                              if parent_linux else '')
        from app.logic.path_utils import list_dat
        files = list_dat(rd['folder_win'])
        rd['available_files'] = files
        self._refresh_ext_combo()
        rd['filename'] = self._pick_file_for_current_ext(files)
        if rd.get('status') == 'Error':
            rd['status'] = 'Pending'
        self._refresh_rows_table()

    def _on_preset_clicked(self, rd, btn):
        presets = self._settings.get('presets', {})
        menu = QMenu(self)
        if not presets:
            act = menu.addAction("(no presets — open Settings to add)")
            act.setEnabled(False)
        else:
            for name in sorted(presets.keys()):
                act = menu.addAction(name)
                act.triggered.connect(
                    lambda _checked=False, n=name, x=rd, b=btn:
                        self._set_row_preset(x, n, b))
        menu.exec_(btn.mapToGlobal(QPoint(0, btn.height())))

    def _set_row_preset(self, rd, name, btn):
        rd['preset'] = name
        btn.setText(self._preset_btn_label(rd))

    def _on_row_preset_changed(self, rd, name):
        if not name or name.startswith('('):
            return
        rd['preset'] = name

    def _on_delete_row(self, rd):
        self._data['rows'] = [r for r in self._data.get('rows', [])
                              if r is not rd]
        self._refresh_rows_table()

    def _on_submit_row_clicked(self, rd):
        if not rd.get('folder_linux') or not rd.get('filename'):
            message_box.warning(
                self, 'Row not ready',
                "Pick a sub-folder that contains a .dat file before submitting.")
            return
        self.submit_all_rows.emit([rd])

    def _preview_sh_for_row(self, rd):
        folder = rd.get('folder_linux', '')
        filename = rd.get('filename', '')
        if not folder or not filename:
            self.preview_sh_requested.emit(
                '# Row has no folder/file — pick a sub-folder first.')
            return
        merged = dict(self._data)
        merged.update({k: rd[k] for k in
                       ('folder_linux', 'filename', 'preset', 'solver')
                       if k in rd})
        try:
            from app.logic.heredoc import build_heredoc_str
            text = build_heredoc_str(folder, filename, merged, self._settings)
        except Exception as e:
            text = f"# Preview failed for {filename}: {e}"
        self.preview_sh_requested.emit(text)

    def _selected_row_data(self):
        row = self.rows_table.currentRow()
        rows = self._data.get('rows', [])
        if row < 0 or row >= len(rows):
            return None
        return rows[row]

    def _preview_sh_for_selected_row(self):
        rd = self._selected_row_data()
        if rd:
            self._preview_sh_for_row(rd)

    def _preview_dat_for_selected_row(self):
        rd = self._selected_row_data()
        if rd and rd.get('folder_win') and rd.get('filename'):
            self.preview_requested.emit(rd.get('folder_win', ''), rd.get('filename', ''))

    def _on_preview_sh_all(self):
        rows = [r for r in self._data.get('rows', [])
                if r.get('folder_linux') and r.get('filename')]
        if not rows:
            self.preview_sh_requested.emit(
                '# No valid rows — pick folders and .dat files first.')
            return
        parts = []
        for rd in rows:
            folder = rd.get('folder_linux', '')
            filename = rd.get('filename', '')
            merged = dict(self._data)
            merged.update({k: rd[k] for k in
                           ('folder_linux', 'filename', 'preset', 'solver')
                           if k in rd})
            try:
                from app.logic.heredoc import build_heredoc_str
                parts.append(build_heredoc_str(folder, filename, merged, self._settings))
            except Exception as e:
                parts.append(f"# Preview failed for {filename}: {e}")
        sep = '\n\n# ' + ('-' * 60) + '\n\n'
        self.preview_sh_requested.emit(sep.join(parts))

    def _on_submit_all(self):
        pending = [r for r in self._data.get('rows', [])
                   if r.get('status') in ('Pending', 'Error')
                   and r.get('folder_linux') and r.get('filename')]
        if not pending:
            return
        choice = QMessageBox.question(
            self, 'Submit all rows?',
            f'About to submit {len(pending)} row(s) from this multi-folder.\n\nContinue?',
            QMessageBox.Yes | QMessageBox.No,
            QMessageBox.No)
        if choice != QMessageBox.Yes:
            return
        self.submit_all_rows.emit(pending)
