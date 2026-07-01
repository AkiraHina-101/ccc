from PySide2.QtWidgets import (
    QMainWindow, QWidget, QStatusBar, QVBoxLayout, QSplitter, QMessageBox,
    QInputDialog,
)
from PySide2.QtCore import Qt, QTimer, QEvent
from PySide2.QtGui import QIcon
import os
import json
import datetime

from app.ui.widgets.toolbar_widget import ToolbarWidget
from app.ui.widgets.job_list_panel import JobListPanel
from app.ui.widgets.detail_panel import DetailPanel
from app.ui.widgets.right_dock import RightDock
from app.ui.widgets.terminal_tab import TerminalTab
from app.ui.widgets.preview_tab import PreviewTab
from app.ui.widgets.queue_tab import QueueTab
from app.ui.widgets.settings_dialog import SettingsDialog
from app.data.settings import load_settings, save_settings, save_queue_cache, load_queue_cache
from app.data.json_io import load_errors as _config_load_errors
from app.logic.terminal_session import TerminalRegistry
from app.ui import message_box
from app.ui.workers import BjobsPoller, SSHCommandWorker, F06CheckWorker


_TYPE_SIDEBAR = {"single": "single", "folder_group": "folder", "multi_folder": "multi"}
_STATUS_SIDEBAR = {
    "Pending": "pending", "Running": "running",
    "Done": "done", "Error": "error", "Queued": "queued",
    "Upload": "queued",  # treat upload visually like a queued/transitional state
    "Fail": "error",
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self._settings, self._cards_data = load_settings()
        self._uid = 0
        self._terminal_registry = TerminalRegistry()
        self._ssh_command_workers = []
        self._pending_main_splitter_sizes = None
        self._pending_active_detail_state = None

        self.setWindowTitle('Nastran Submitter Pro')
        self._apply_window_icon()
        self._apply_dark_title_bar()
        self.resize(1280, 860)
        # 720 lets the user snap-tile the app next to another app on a 1366
        # laptop (half-screen ~683). The UI degrades gracefully below this:
        # sidebar/dock can be collapsed via chevrons, RightDock tabs switch
        # to compact labels, Queue table scrolls horizontally.
        self.setMinimumSize(720, 600)

        self._init_ui()
        self._connect_signals()
        self._restore_state()
        self._load_saved_cards()
        QTimer.singleShot(0, self._restore_deferred_layout_state)
        QTimer.singleShot(120, self._restore_deferred_layout_state)
        self._restore_queue_cache()
        self._seed_seen_jobids_for_reconcile()
        self._start_bjobs_poller()
        # Check RightDock visibility every 2s and slow the poller when hidden.
        # 2s is short enough that the rate-switch feels instant, long enough
        # that the check is essentially free.
        self._visibility_timer = QTimer(self)
        self._visibility_timer.setInterval(2000)
        self._visibility_timer.timeout.connect(self._apply_poll_rate_for_visibility)
        self._visibility_timer.start()
        self.log('[INFO]  Nastran Submitter Pro v5 (PySide2) ready.', 'info')
        self._saved_state_snapshot = self._state_snapshot()
        self._warn_about_config_load_errors()

    def _warn_about_config_load_errors(self):
        if not _config_load_errors:
            return
        details = '\n'.join(f'- {e.path}\n    {e.reason}' for e in _config_load_errors)
        for e in _config_load_errors:
            self.log(f'[WARN]  Config load failed: {e.path}: {e.reason}', 'err')
        QMessageBox.warning(
            self, 'Config file unreadable',
            'Some config files could not be parsed and were ignored.\n'
            'Defaults were used. The original files were NOT modified -- '
            'open them in a text editor to inspect.\n\n' + details)
        _config_load_errors.clear()

    def _apply_window_icon(self):
        import os
        here = os.path.dirname(os.path.abspath(__file__))
        assets_dir = os.path.join(here, 'assets')
        for filename in ('app_logo.ico', 'app_logo.svg'):
            icon_path = os.path.join(assets_dir, filename)
            if os.path.isfile(icon_path):
                self.setWindowIcon(QIcon(icon_path))
                return

    def _apply_dark_title_bar(self, widget=None):
        """Ask Windows to draw the native title bar in dark mode."""
        import sys
        if sys.platform != 'win32':
            return
        try:
            import ctypes
            target = widget or self
            hwnd = int(target.winId())
            value = ctypes.c_int(1)
            # Windows 10 1903+ uses 20. Older builds used 19.
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

    def _init_ui(self):
        central = QWidget()
        self.setCentralWidget(central)
        root = QVBoxLayout(central)
        root.setContentsMargins(0, 0, 0, 0)
        root.setSpacing(0)

        self.toolbar_widget = ToolbarWidget(self)
        root.addWidget(self.toolbar_widget)

        self._main_splitter = QSplitter(Qt.Horizontal)
        self._main_splitter.setHandleWidth(6)
        # setChildrenCollapsible(False) blocks dragging below min width, but
        # we still want explicit collapse via the chevron buttons -- that
        # path goes through _toggle_panel_collapse() which sets sizes directly.
        self._main_splitter.setChildrenCollapsible(False)
        self._main_splitter.setOpaqueResize(True)
        root.addWidget(self._main_splitter, 1)

        self.job_list_panel = JobListPanel(self)
        # Cap the sidebar so it can't grow large enough to crowd the detail
        # panel beyond recognition. Detail is the main work area.
        self.job_list_panel.setMaximumWidth(420)
        self._main_splitter.addWidget(self.job_list_panel)

        self.detail_panel = DetailPanel(self._settings, self)
        self._main_splitter.addWidget(self.detail_panel)

        self._terminal_tab = TerminalTab()
        # Single Preview tab handles both .sh (heredoc) and .dat (any file).
        # Double-click a file in the list to load it; the .sh toolbar button
        # continues to route through show_heredoc().
        self._preview_tab = PreviewTab()
        # Legacy aliases for any code path still holding the old names.
        self._preview_sh_tab = self._preview_tab
        self._preview_dat_tab = self._preview_tab
        self._queue_tab = QueueTab()
        self.right_dock = RightDock(
            self._preview_tab,
            self._queue_tab, self._terminal_tab, self)
        self._main_splitter.addWidget(self.right_dock)
        self._queue_tab.set_custom_commands(self._settings.get('ssh_buttons') or [])
        self._main_splitter.setSizes([240, 740, 300])
        self._main_splitter.setStretchFactor(0, 0)
        self._main_splitter.setStretchFactor(1, 1)
        self._main_splitter.setStretchFactor(2, 0)
        # Re-clamp whenever the user finishes a drag. Without this, the user
        # can hold-drag a handle indefinitely and the only constraint is
        # each panel's own minimumWidth -- which doesn't account for the
        # *combined* minimum across all three.
        self._main_splitter.splitterMoved.connect(self._on_splitter_moved)
        # Remembered widths so collapse->restore returns the panel to the
        # size it had before being hidden, not some hard-coded default.
        self._collapsed_widths = {0: 0, 2: 0}
        # Double-click the handle between two panels to toggle the side
        # panel's collapse state. This is the only way to restore a panel
        # whose own chevron button is now hidden (width 0).
        for handle_idx, side_idx in ((1, 0), (2, 2)):
            handle = self._main_splitter.handle(handle_idx)
            if handle is not None:
                handle.installEventFilter(self)
                handle.setProperty('side_idx', side_idx)
                handle.setToolTip('Double-click to hide/restore this panel')

        self._status_bar = QStatusBar()
        self.setStatusBar(self._status_bar)
        self._status_bar.showMessage('Ready.')

    def resizeEvent(self, event):
        super().resizeEvent(event)
        self._clamp_splitter_sizes()

    def showEvent(self, event):
        super().showEvent(event)
        QTimer.singleShot(0, self._restore_deferred_layout_state)

    def _connect_signals(self):
        # Toolbar
        self.toolbar_widget.add_single_requested.connect(self._on_add_single)
        self.toolbar_widget.add_folder_requested.connect(self._on_add_folder_group)
        self.toolbar_widget.add_multi_requested.connect(self._on_add_multi_folder)
        self.toolbar_widget.submit_all_requested.connect(self._on_submit_all)
        self.toolbar_widget.clear_done_requested.connect(self._on_clear_done)
        self.toolbar_widget.settings_requested.connect(self._on_open_settings)
        self.toolbar_widget.save_requested.connect(self._on_save)

        # Sidebar
        self.job_list_panel.job_selected.connect(self._on_job_selected)
        self.job_list_panel.job_added_requested.connect(self._on_sidebar_add_requested)
        self.job_list_panel.job_deleted_requested.connect(self._on_sidebar_delete_requested)
        self.job_list_panel.status_override_requested.connect(self._on_status_override_requested)
        # Chevron collapse buttons; restoring is done by double-clicking the
        # splitter handle (see eventFilter).
        self.job_list_panel.collapse_btn.clicked.connect(lambda: self._toggle_panel_collapse(0))
        self.right_dock.collapse_btn.clicked.connect(lambda: self._toggle_panel_collapse(2))

        # Detail panel — forwarded card signals
        self.detail_panel.submit_requested.connect(self._on_submit_single)
        self.detail_panel.submit_selected.connect(self._on_submit_folder_group)
        self.detail_panel.submit_all_rows.connect(self._on_submit_rows)
        self.detail_panel.remove_requested.connect(self._on_remove_card)
        self.detail_panel.preview_requested.connect(self._on_preview_file)
        self.detail_panel.preview_sh_requested.connect(self._on_preview_heredoc)
        self.detail_panel.title_changed.connect(self._on_detail_title_changed)

    def _restore_state(self):
        gui = self._settings.get('gui', {})
        geo = gui.get('geometry')
        if geo:
            try:
                self.restoreGeometry(bytes.fromhex(geo))
            except Exception:
                pass
        dock_gui = gui.get('right_dock', {})
        tab = gui.get('active_tab') or dock_gui.get('active_tab', 'terminal')
        self.right_dock.set_active_tab(tab)
        dock_theme = dock_gui.get('theme') or dock_gui.get('terminal_theme')
        if dock_theme:
            self.right_dock.set_theme_mode(dock_theme)
        panels = gui.get('panels', {})
        panel_dock = panels.get('right_dock', {}) if isinstance(panels, dict) else {}
        font_sizes = panel_dock.get('view_font_sizes') or dock_gui.get('view_font_sizes')
        if font_sizes:
            self.right_dock.set_view_font_sizes(font_sizes)
        sizes = self._saved_main_splitter_sizes(gui)
        if isinstance(sizes, list) and len(sizes) == self._main_splitter.count():
            self._pending_main_splitter_sizes = [int(s) for s in sizes]
            try:
                total = self._main_splitter.width() or self.width()
                clamped = self._clamped_splitter_sizes([int(s) for s in sizes], total)
                self._main_splitter.setSizes(clamped)
                self._clamp_splitter_sizes()
            except (TypeError, ValueError):
                pass
        self._pending_active_detail_state = gui.get('panels', {}).get('active_detail', {})

    def _restore_deferred_layout_state(self):
        sizes = self._pending_main_splitter_sizes
        if isinstance(sizes, list) and len(sizes) == self._main_splitter.count():
            total = self._main_splitter.width() or self.width()
            if total > 0:
                clamped = self._clamped_splitter_sizes([int(s) for s in sizes], total)
                self._main_splitter.setSizes(clamped)
        self._apply_active_detail_panel_state()

    def _saved_main_splitter_sizes(self, gui):
        panels = gui.get('panels', {})
        main_splitter = panels.get('main_splitter', {})
        sizes = main_splitter.get('sizes')
        if sizes is not None:
            return sizes
        return gui.get('splitter_sizes')

    def _panel_min_widths(self):
        left = max(0, int(self.job_list_panel.minimumWidth()))
        detail = max(0, int(self.detail_panel.minimumWidth()))
        right = max(0, int(self.right_dock.minimumWidth()))
        return left, detail, right

    def _clamped_splitter_sizes(self, sizes, total_width):
        if len(sizes) != 3 or total_width <= 0:
            return sizes
        out = [max(0, int(s)) for s in sizes]
        min_left, min_detail, min_right = self._panel_min_widths()

        out[0] = max(out[0], min_left)
        out[2] = max(out[2], min_right)

        max_left = max(min_left, total_width - min_detail - min_right)
        if out[0] > max_left:
            excess = out[0] - max_left
            out[0] = max_left
            out[1] += excess

        max_right = max(min_right, total_width - out[0] - min_detail)
        if out[2] > max_right:
            excess = out[2] - max_right
            out[2] = max_right
            out[1] += excess

        out[1] = max(out[1], min_detail)
        total_after = sum(out)
        if total_after != total_width:
            out[1] = max(min_detail, out[1] + (total_width - total_after))
        return out

    def _clamp_splitter_sizes(self):
        if not hasattr(self, '_main_splitter') or self._main_splitter.count() != 3:
            return
        total = self._main_splitter.width()
        if total <= 0:
            return
        sizes = self._main_splitter.sizes()
        clamped = self._clamped_splitter_sizes(sizes, total)
        if clamped != sizes:
            self._main_splitter.setSizes(clamped)

    def _on_splitter_moved(self, *_):
        """Re-clamp after every drag tick. Without this, the only constraint
        is each panel's own minimumWidth, which lets the user squeeze one
        panel until its neighbour is unusable.
        """
        sizes = self._main_splitter.sizes()
        # Skip clamping for panels the user has explicitly collapsed (size 0);
        # they're hidden on purpose and should stay hidden until restored.
        active_idxs = [i for i, s in enumerate(sizes) if s > 0]
        if len(active_idxs) < 3:
            return
        self._clamp_splitter_sizes()

    def eventFilter(self, obj, event):
        if event.type() == QEvent.MouseButtonDblClick:
            side_idx = obj.property('side_idx') if hasattr(obj, 'property') else None
            if side_idx in (0, 2):
                self._toggle_panel_collapse(side_idx)
                return True
        return super().eventFilter(obj, event)

    def _toggle_panel_collapse(self, idx):
        """Collapse/restore the side panel at splitter index `idx`.

        idx=0 hides the sidebar, idx=2 hides the right dock. The detail panel
        (idx=1) is not collapsible -- it's the main work area.

        Remembers the pre-collapse width so the next toggle restores the user's
        previous layout instead of jumping to a default.
        """
        if idx not in (0, 2):
            return
        sizes = self._main_splitter.sizes()
        if sizes[idx] > 0:
            self._collapsed_widths[idx] = sizes[idx]
            sizes[1] += sizes[idx]
            sizes[idx] = 0
            self._main_splitter.setSizes(sizes)
        else:
            restore = self._collapsed_widths.get(idx) or (240 if idx == 0 else 480)
            give = min(restore, sizes[1] - 200)
            if give <= 0:
                give = restore
            sizes[idx] = give
            sizes[1] = max(200, sizes[1] - give)
            self._main_splitter.setSizes(sizes)
            self._clamp_splitter_sizes()

    def _load_saved_cards(self):
        for cd in self._cards_data:
            self._uid = max(self._uid, cd.get('uid', 0))
            self._render_card(cd, select=False)

    def _next_uid(self):
        self._uid += 1
        return self._uid

    # ── Card / job lifecycle ────────────────────────────────────────────

    def _on_add_single(self):
        uid = self._next_uid()
        data = {'type': 'single', 'uid': uid,
                'folder_win': '', 'folder_linux': '', 'filename': '',
                'available_files': [], 'status': 'Pending'}
        self._cards_data.append(data)
        self._render_card(data, select=True)
        self.log(f'[INFO]  Added one job / one folder #{uid}', 'info')

    def _on_add_folder_group(self):
        uid = self._next_uid()
        data = {'type': 'folder_group', 'uid': uid,
                'folder_win': '', 'folder_linux': '', 'files': []}
        self._cards_data.append(data)
        self._render_card(data, select=True)
        self.log(f'[INFO]  Added many jobs / one folder #{uid}', 'info')

    def _on_add_multi_folder(self):
        uid = self._next_uid()
        data = {'type': 'multi_folder', 'uid': uid, 'rows': []}
        self._cards_data.append(data)
        self._render_card(data, select=True)
        self.log(f'[INFO]  Added one job / each subfolder #{uid}', 'info')

    def _on_sidebar_add_requested(self, sidebar_type: str):
        if sidebar_type == "single":
            self._on_add_single()
        elif sidebar_type == "folder":
            self._on_add_folder_group()
        elif sidebar_type == "multi":
            self._on_add_multi_folder()

    def _on_detail_title_changed(self, uid: int, title: str):
        self.job_list_panel.set_job_name(str(uid), title)

    def _on_sidebar_delete_requested(self, uid_str: str):
        try:
            uid = int(uid_str)
        except (TypeError, ValueError):
            return
        self._on_remove_card(uid)

    def _on_status_override_requested(self, uid_str: str, new_status: str):
        # Why: user knows the job's real outcome (admin killed it, server logged
        # out, exit code lost) and needs to correct the card without rerunning.
        try:
            uid = int(uid_str)
        except (TypeError, ValueError):
            return
        card = next((c for c in self._cards_data if c.get('uid') == uid), None)
        if card is None:
            return
        card['status'] = new_status
        # For container cards, propagate to sub-items so badges/queue sync match.
        if card.get('type') == 'folder_group':
            for fi in card.get('files', []):
                if fi.get('submitted'):
                    fi['status'] = new_status
        elif card.get('type') == 'multi_folder':
            for row in card.get('rows', []):
                if row.get('submitted'):
                    row['status'] = new_status
        self.detail_panel.update_status(uid, new_status)
        self.job_list_panel.set_job_status(uid_str, _STATUS_SIDEBAR.get(new_status, 'pending'))
        self.log(f'[INFO]  Status override: card {uid} -> {new_status}', 'info')

    def _render_card(self, data, select: bool = False):
        t = data.get('type')
        if t not in ('single', 'folder_group', 'multi_folder'):
            return

        sidebar_type = _TYPE_SIDEBAR.get(t, "single")
        name = self._derive_job_name(data)
        status = _STATUS_SIDEBAR.get(data.get('status', 'Pending'), "pending")
        row_count = len(data.get('rows', [])) if t == 'multi_folder' else 0

        self.job_list_panel.add_job_item(
            str(data['uid']), name, sidebar_type, status=status, row_count=row_count
        )
        self.detail_panel.show_job(data)
        self._apply_active_detail_panel_state()

        if select:
            self.job_list_panel.select_job(str(data['uid']))

    def _derive_job_name(self, data: dict) -> str:
        import os
        if data.get('type') == 'single':
            folder = data.get('folder_win') or data.get('folder_linux') or ''
            if folder:
                return os.path.basename(folder.replace('\\', '/').rstrip('/'))
            return data.get('filename') or "Select folder"
        if data.get('type') == 'folder_group':
            folder = data.get('folder_win') or data.get('folder_linux') or ''
            if folder:
                return os.path.basename(folder.replace('\\', '/').rstrip('/'))
            return "Select folder"
        return "Select parent folder"

    def _on_job_selected(self, job_id: str):
        try:
            uid = int(job_id)
        except (TypeError, ValueError):
            return
        data = next((c for c in self._cards_data if c.get('uid') == uid), None)
        if data is None:
            return
        self.detail_panel.show_job(data)
        self._apply_active_detail_panel_state()

    def _on_remove_card(self, uid):
        self._cards_data = [c for c in self._cards_data if c.get('uid') != uid]
        self.detail_panel.remove_job(uid)
        self.job_list_panel.remove_job_item(str(uid))
        self.log(f'[INFO]  Removed card #{uid}', 'info')

    # ── Submit ──────────────────────────────────────────────────────────

    def _mark_pending_match(self, entity):
        """Tag an entity (card/file/row dict) at submit time so the next
        bjobs poll can claim a fresh JOBID for it.

        We use a monotonic counter (not wallclock) so claiming is FIFO even
        when multiple submits land in the same millisecond.
        """
        self._submit_seq = getattr(self, '_submit_seq', 0) + 1
        entity['pending_match'] = True
        entity['submit_ts'] = self._submit_seq
        entity['jobid'] = ''

    def _on_submit_single(self, data):
        data['submitted'] = True
        # 'Upload' covers the window between local submit and the first time
        # the JOBID shows up on bjobs (the server is uploading files / waiting
        # for bsub). Once claimed, status flips to Pending/Running per LSF.
        data['status'] = 'Upload'
        self._mark_pending_match(data)
        self._run_job(data)

    def _on_submit_folder_group(self, data, files):
        for fi in files:
            fi['submitted'] = True
            fi['status'] = 'Upload'
            self._mark_pending_match(fi)
            job = dict(data)
            job['filename'] = fi['name']
            self._run_job(job)
        self.detail_panel.update_status(data.get('uid'), data.get('status', 'Pending'))

    def _on_submit_rows(self, rows):
        for row in rows:
            row['submitted'] = True
            row['status'] = 'Upload'
            self._mark_pending_match(row)
            self._run_job(dict(row))

    def _on_job_done(self, data):
        uid = data.get('uid')
        status = data.get('status', 'Pending')
        self.detail_panel.update_status(uid, status)
        self.job_list_panel.set_job_status(str(uid), _STATUS_SIDEBAR.get(status, "pending"))
        self._refresh_queue()

    def _run_job(self, data, folder=None, filename=None):
        from app.ui.workers import SubmitWorker

        if folder is not None:
            data['folder_linux'] = folder
        if filename is not None:
            data['filename'] = filename

        worker = SubmitWorker(data, self._settings, self._terminal_registry, parent=self)
        worker.log_line.connect(self.log)
        worker.job_done.connect(self._on_job_done)
        self._workers = getattr(self, '_workers', [])
        self._workers.append(worker)
        worker.finished.connect(lambda w=worker: self._workers.remove(w) if w in self._workers else None)
        worker.start()

    def _on_submit_all(self):
        # Plan first (dry-run) so the confirmation dialog can quote a real
        # count. Users have hit "Submit all" by accident and flooded the queue
        # — this guard is cheap and stops the worst case.
        plan = []  # list of dicts to submit
        for data in self._cards_data:
            if data.get('skip'):
                continue
            t = data.get('type')
            if t == 'single' and data.get('status') in ('Pending', 'Error'):
                plan.append(dict(data))
            elif t == 'folder_group':
                for fi in data.get('files', []):
                    if fi.get('checked') and fi.get('status') in ('Pending', 'Error'):
                        job = dict(data)
                        job['filename'] = fi['name']
                        plan.append(job)
            elif t == 'multi_folder':
                for row in data.get('rows', []):
                    if row.get('status') in ('Pending', 'Error'):
                        plan.append(dict(row))
        if not plan:
            QMessageBox.information(
                self, 'Submit all',
                'Nothing to submit — no card is Pending/Error.')
            return
        choice = QMessageBox.question(
            self, 'Submit all?',
            f'About to submit {len(plan)} job(s) across every card.\n\nContinue?',
            QMessageBox.Yes | QMessageBox.No,
            QMessageBox.No)
        if choice != QMessageBox.Yes:
            return
        for job in plan:
            self._run_job(job)

    def _refresh_queue(self):
        """Refresh the queue view.

        Priority:
        1. If the user has clicked an SSH command button (e.g. custom bjobs
           filter), re-run THAT command — refresh should update the rows the
           user is currently looking at, not replace them with the default
           poll command.
        2. Otherwise fall back to the bjobs poller (default bjobs_command).
        """
        last = getattr(self, '_last_queue_command', None)
        if last:
            self._on_ssh_command_requested(dict(last))
            return
        poller = getattr(self, '_bjobs_poller', None)
        if poller is None:
            return
        if poller.isRunning():
            poller.set_interval(0)  # cause sleep loop to wake; will reset next iter
            return
        # Auto is off — do a single poll and exit.
        poller._stop = False
        poller.set_run_once(True)
        poller.start()

    # ── LSF status poller ──────────────────────────────────────────────

    # Poller intervals (seconds). Slow rate is used when the RightDock is
    # hidden so we still detect job completion (for desktop notifications)
    # without spamming the server every 5s.
    _POLL_INTERVAL_VISIBLE = 5
    _POLL_INTERVAL_HIDDEN = 30

    def _seed_seen_jobids_for_reconcile(self):
        # Why: without seeding, a card that says "Running" but whose jobid has
        # already rotated out of bjobs history will stay Running forever — the
        # Done-by-disappearance branch in _sync_job_status_from_queue only
        # fires when `jid in seen`, and `seen` starts empty each launch.
        seeded = set()
        for entity, _base in self._iter_submitted_entities():
            jid = entity.get('jobid')
            if jid and str(entity.get('status') or '') not in ('Done', 'Error', 'Fail'):
                seeded.add(str(jid))
        self._seen_jobids = seeded

    def _restore_queue_cache(self):
        """Render the last-saved bjobs result so the Queue tab is populated
        immediately at launch. A status-bar banner makes the staleness
        obvious; it clears once the first live poll arrives.
        """
        rows, saved_at = load_queue_cache()
        if not rows:
            return
        self._queue_tab.refresh(rows)
        if saved_at:
            self._queue_tab.set_status_message(f'Cached data from {saved_at} -- refreshing...')
        else:
            self._queue_tab.set_status_message('Cached data -- refreshing...')
        self._queue_cache_banner_shown = True

    def _start_bjobs_poller(self):
        self._bjobs_poller = BjobsPoller(
            lambda: self._settings,
            interval_sec=self._POLL_INTERVAL_VISIBLE, parent=self)
        self._bjobs_poller.rows_updated.connect(self._on_bjobs_rows)
        self._bjobs_poller.error_occurred.connect(self._on_bjobs_error)
        self._bjobs_poller.state_changed.connect(self._on_bjobs_state)
        self._queue_tab.refresh_requested.connect(self._refresh_queue)
        self._queue_tab.autopoll_toggled.connect(self._on_autopoll_toggled)
        self._queue_tab.ssh_command_requested.connect(self._on_ssh_command_requested)
        self._queue_tab.selection_changed.connect(self._on_queue_selection_changed)
        self._queue_tab.command_buttons_rebuilt.connect(
            lambda: self._update_selection_gated_buttons(self._queue_tab.selected_jobid()))
        # Push persisted column config on first mount.
        self._queue_tab.set_columns(self._settings.get('queue_columns') or [])
        self._detail_fetched_jobids = set()  # per-session dedupe for bjobs -l
        # Nothing selected on startup — apply the initial disabled state to any
        # button that needs {selected_jobid}.
        self._update_selection_gated_buttons('')
        if self._queue_tab.is_autopoll_on():
            self._bjobs_poller.start()

    def _on_queue_selection_changed(self, jobid):
        """Row selection changed → (a) enable/disable {selected_jobid} buttons,
        (b) fetch bjobs -l JOBID lazily if the setting is on and we haven't
        fetched this jobid yet."""
        self._update_selection_gated_buttons(jobid)
        if not jobid:
            return
        if not self._settings.get('queue_detail_on_select', True):
            return
        if jobid in self._detail_fetched_jobids:
            return
        self._detail_fetched_jobids.add(jobid)
        self._on_ssh_command_requested({
            'label': f'bjobs -l {jobid}',
            'command': 'bjobs -l {selected_jobid}',
            'selected_jobid': jobid,
            '_detail_fetch': True,  # marker for done handler
        })

    def _update_selection_gated_buttons(self, jobid):
        """Gray out any command button whose template needs a selected JOBID
        when no row is selected. Keeps user from accidentally issuing bkill
        with an empty jobid.
        """
        has_selection = bool(jobid)
        for btn in getattr(self._queue_tab, 'command_buttons', []) or []:
            tip = btn.toolTip() or ''
            if '{selected_jobid}' in tip:
                btn.setEnabled(has_selection)

    def _apply_poll_rate_for_visibility(self):
        """Slow the poller to 30s when the user has hidden the RightDock,
        speed back up to 5s when it's visible. Status changes still surface
        (for notifications) but at a much lower connection cost.
        """
        poller = getattr(self, '_bjobs_poller', None)
        if poller is None:
            return
        visible = self.right_dock.isVisible() and not self.isMinimized()
        target = self._POLL_INTERVAL_VISIBLE if visible else self._POLL_INTERVAL_HIDDEN
        poller.set_interval(target)

    def _on_bjobs_rows(self, rows):
        self._queue_tab.refresh(rows)
        self._sync_job_status_from_queue(rows)
        # Cache the last successful result so the next launch can render
        # something immediately instead of waiting 5s for the first poll.
        try:
            now_iso = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            save_queue_cache(rows, now_iso)
        except Exception:
            pass
        # Clear the stale-data banner once live data arrives.
        if getattr(self, '_queue_cache_banner_shown', False):
            self._queue_tab.set_status_message('')
            self._queue_cache_banner_shown = False

    def _iter_submitted_entities(self):
        """Yield (entity_dict, basename) for every submitted entity across
        cards/files/rows. Used by status sync to claim JOBIDs and read state.
        """
        for card in self._cards_data:
            ctype = card.get('type')
            if ctype == 'single':
                if card.get('submitted'):
                    base = os.path.basename(str(card.get('filename') or ''))
                    yield card, base
            elif ctype == 'folder_group':
                for fi in card.get('files', []):
                    if fi.get('submitted'):
                        base = os.path.basename(str(fi.get('name') or ''))
                        yield fi, base
            elif ctype == 'multi_folder':
                for row in card.get('rows', []):
                    if row.get('submitted'):
                        base = os.path.basename(str(row.get('filename') or ''))
                        yield row, base

    def _entity_context(self, entity):
        """Locate the parent card + Windows folder for an entity dict.

        For a single-job card the entity IS the card. For folder_group the
        entity is one of card['files'] — filename is on entity, folder is on
        the card. For multi_folder each row has its own folder_win.

        Returns (card_uid, folder_win, filename) or ('', '', '') if the
        entity isn't in _cards_data anymore (deleted between poll and check).
        """
        for card in self._cards_data:
            ctype = card.get('type')
            if ctype == 'single' and card is entity:
                return card.get('uid', ''), card.get('folder_win', ''), card.get('filename', '')
            if ctype == 'folder_group':
                for fi in card.get('files', []):
                    if fi is entity:
                        return card.get('uid', ''), card.get('folder_win', ''), fi.get('name', '')
            if ctype == 'multi_folder':
                for row in card.get('rows', []):
                    if row is entity:
                        return card.get('uid', ''), row.get('folder_win', ''), row.get('filename', '')
        return '', '', ''

    def _sync_job_status_from_queue(self, rows):
        """Match each submitted entity to a bjobs row by JOBID, claiming
        new JOBIDs FIFO when a pending entity has a matching filename.

        Why: matching purely by filename is wrong when the same .dat lives
        in multiple subfolders (very common in this app's multi-folder
        flow). Once an entity owns a JOBID, subsequent polls update its
        status by exact JOBID lookup -- no more substring guessing.
        """
        current_jobids = {str(r.get('jobid', '')) for r in rows if r.get('jobid')}
        seen = getattr(self, '_seen_jobids', set())
        new_jobids = current_jobids - seen
        rows_by_jobid = {str(r['jobid']): r for r in rows if r.get('jobid')}

        # 1. Try to claim a new JOBID for each pending entity, FIFO by submit_ts.
        pending = []
        for entity, base in self._iter_submitted_entities():
            if entity.get('jobid'):
                continue
            # Legacy entries (saved before this code) lack pending_match but
            # still need claiming on first sync; treat them as pending.
            if not entity.get('pending_match') and 'submit_ts' in entity:
                continue
            if base:
                pending.append((entity.get('submit_ts', 0), base, entity))
        pending.sort(key=lambda t: t[0])

        # New rows sorted by JOBID ascending (LSF assigns ids monotonically,
        # so this approximates submit order on the server side).
        new_rows = sorted(
            (r for r in rows if str(r.get('jobid', '')) in new_jobids),
            key=lambda r: str(r.get('jobid', '')))
        claimed = set()
        for _, base, entity in pending:
            for row in new_rows:
                jid = str(row.get('jobid', ''))
                if jid in claimed:
                    continue
                name = str(row.get('name') or '')
                if name == base or base in name:
                    entity['jobid'] = jid
                    entity['pending_match'] = False
                    claimed.add(jid)
                    break

        # 2. Update status for every entity that owns a JOBID.
        # When a previously-seen JOBID disappears from bjobs (LSF rotated it
        # out of the history window), the job has finished. We assume Done;
        # the user can flip it to Error/Fail manually if they know better.
        changed = False
        notifications = []  # (title, body) collected here, fired after the loop
        for entity, base in self._iter_submitted_entities():
            jid = entity.get('jobid')
            if not jid:
                continue
            jid_s = str(jid)
            row = rows_by_jobid.get(jid_s)
            old_state = entity.get('status') or ''
            if row:
                state = row.get('state') or row.get('status') or ''
                if state and old_state != state:
                    entity['status'] = state
                    changed = True
                    if state in ('Done', 'Error') and old_state in ('Pending', 'Running', 'Upload'):
                        notifications.append((
                            f'Job {jid_s} {state.lower()}',
                            f'{base or "(no name)"} — {state}'))
                        if state == 'Done':
                            self._schedule_f06_check(entity)
            else:
                # JOBID no longer returned by bjobs. If we previously saw it,
                # treat it as finished. If we never saw it (claimed and gone in
                # the same window), don't guess.
                if jid_s in seen and old_state not in ('Done', 'Error', 'Fail', 'Complete'):
                    entity['status'] = 'Done'
                    changed = True
                    notifications.append((
                        f'Job {jid_s} done',
                        f'{base or "(no name)"} — finished (rotated out of bjobs)'))
                    self._schedule_f06_check(entity)

        self._seen_jobids = current_jobids

        if changed:
            for card in self._cards_data:
                self.detail_panel.update_status(card.get('uid'), card.get('status', 'Pending'))

        for title, body in notifications:
            self._notify_job_finished(title, body)

    def _schedule_f06_check(self, entity):
        """Spawn an F06CheckWorker for a freshly-Done entity.

        We keep worker refs on self so QThread instances stay alive. The
        result slot decides Complete/Fail; if the .f06 isn't on the share
        yet ('Done' returned) we simply leave the entity at 'Done' — next
        poll cycle that finds the JOBID still missing will re-schedule.
        """
        uid, folder_win, filename = self._entity_context(entity)
        if not folder_win or not filename:
            return
        pending = getattr(self, '_f06_workers', {})
        key = (uid, filename)
        # Dedupe: don't spawn a second checker while one is already reading.
        if key in pending:
            return
        worker = F06CheckWorker(uid, filename, folder_win, parent=self)
        worker.result_ready.connect(self._on_f06_check_done)
        worker.finished.connect(lambda k=key: self._f06_workers.pop(k, None))
        pending[key] = worker
        self._f06_workers = pending
        worker.start()

    def _on_f06_check_done(self, uid, filename, folder_win, status, reason):
        """Apply Complete/Fail (or stay Done) to whichever entity matches."""
        target = None
        for card in self._cards_data:
            if card.get('uid') != uid:
                continue
            ctype = card.get('type')
            if ctype == 'single' and card.get('filename') == filename:
                target = card
                break
            if ctype == 'folder_group':
                for fi in card.get('files', []):
                    if fi.get('name') == filename:
                        target = fi
                        break
                if target:
                    break
            if ctype == 'multi_folder':
                for row in card.get('rows', []):
                    if row.get('filename') == filename and row.get('folder_win') == folder_win:
                        target = row
                        break
                if target:
                    break
        if target is None:
            return
        cur = target.get('status') or ''
        # Only overwrite Done — user or a later bjobs update may have moved
        # the entity onward already.
        if cur != 'Done':
            return
        target['status'] = status
        self.log(f'[INFO]  {filename}: {reason}',
                 'ok' if status == 'Complete' else ('err' if status == 'Fail' else 'info'))
        for card in self._cards_data:
            self.detail_panel.update_status(card.get('uid'), card.get('status', 'Pending'))

    def _notify_job_finished(self, title, body):
        """Show a Windows toast for a job state transition. We fall back to a
        status-bar log if the desktop-notification path is unavailable -- the
        user still sees a record in the terminal pane.
        """
        self.log(f'[NOTIF] {title}: {body}', 'info')
        try:
            from PySide2.QtWidgets import QSystemTrayIcon
            tray = getattr(self, '_tray', None)
            if tray is None:
                tray = QSystemTrayIcon(self.windowIcon(), self)
                tray.setToolTip('Nastran Submitter')
                tray.show()
                self._tray = tray
            tray.showMessage(title, body, QSystemTrayIcon.Information, 5000)
        except Exception:
            pass

    def _on_bjobs_error(self, message):
        self._queue_tab.set_status_message(f'Error: {message}')
        self.log(f'[ERR]   bjobs poll: {message}', 'err')

    def _on_bjobs_state(self, state):
        if state == 'polling':
            return
        if state == 'idle':
            self._queue_tab.set_status_message('Idle — server/user not configured')

    def _on_ssh_command_requested(self, command_def):
        command_def = dict(command_def or {})
        label = str(command_def.get('label') or 'SSH command')
        command = str(command_def.get('command') or '')
        # Do NOT auto-switch to Terminal — user wants to stay on Queue and see
        # the bjobs-style output land in the queue tree. Output still lands in
        # Terminal log; they can switch manually if they want the raw text.
        is_detail_fetch = bool(command_def.get('_detail_fetch'))
        if '{selected_jobid}' in command:
            jobid = command_def.get('selected_jobid') or self._queue_tab.selected_jobid()
            if not jobid:
                self._queue_tab.set_status_message('Select a queue row with Job ID first')
                self.log(f'[ERR]   {label}: select a queue row with Job ID first', 'err')
                return
            # Only bkill-style destructive commands get the in-flight lock +
            # confirmation. Detail fetches (bjobs -l) fire silently.
            is_destructive = command.strip().startswith('bkill')
            if is_destructive:
                in_flight = getattr(self, '_kill_in_flight', set())
                if jobid in in_flight:
                    self.log(f'[INFO]  {label}: already running for job {jobid}', 'info')
                    self._queue_tab.set_status_message(
                        f'{label} already running for job {jobid}')
                    return
                choice = QMessageBox.question(
                    self, 'Kill job?',
                    f'Run this command?\n\nbkill {jobid}',
                    QMessageBox.Yes | QMessageBox.No,
                    QMessageBox.No)
                if choice != QMessageBox.Yes:
                    return
                in_flight.add(jobid)
                self._kill_in_flight = in_flight
            command_def['selected_jobid'] = jobid
        if '{input}' in command:
            value, ok = QInputDialog.getText(
                self, label, 'Input value (for example JOBID):')
            if not ok:
                return
            value = (value or '').strip()
            reason = self._reject_ssh_input(value)
            if reason:
                self.log(f'[ERR]   {label}: input rejected -- {reason}', 'err')
                QMessageBox.warning(
                    self, 'Invalid input',
                    f'{reason}\n\n'
                    'Allowed: a single JOBID or short token, no newlines or '
                    'shell metacharacters.')
                return
            command_def['input_value'] = value
        self._ssh_cmd_seq = getattr(self, '_ssh_cmd_seq', 0) + 1
        seq = self._ssh_cmd_seq
        self.log(f'[CMD #{seq}] {label}: running...', 'cmd')
        # Remember this command so the Queue Refresh button can re-run it
        # instead of falling back to the default bjobs_command (which would
        # wipe the rows the user just fetched via an SSH command button).
        # Detail fetches (bjobs -l JOBID) don't count — they enrich a single
        # row, they're not what the user is "looking at" in the queue tree.
        if command.strip().startswith('bjobs') and not is_detail_fetch and '{selected_jobid}' not in command:
            self._last_queue_command = dict(command_def)
        worker = SSHCommandWorker(self._settings, command_def, parent=self)
        worker._seq = seq  # carried back to log slots so concurrent commands stay distinguishable
        worker._jobid_lock = command_def.get('selected_jobid', '')  # released on finish
        worker.command_done.connect(
            lambda lbl, cmd, out, rws, w=worker: self._on_ssh_command_done(w._seq, lbl, cmd, out, rws))
        worker.command_failed.connect(
            lambda lbl, msg, w=worker: self._on_ssh_command_failed(w._seq, lbl, msg))
        worker.finished.connect(lambda w=worker: self._remove_ssh_command_worker(w))
        self._ssh_command_workers.append(worker)
        worker.start()

    # Characters that could turn a single SSH command into multiple commands
    # or otherwise change its meaning on the remote shell. The template itself
    # is trusted (user-authored in Settings); the {input} value is whatever the
    # user types or pastes at runtime, so it must be conservatively filtered.
    _SSH_INPUT_FORBIDDEN = set('\n\r\t;&|`$<>(){}\'"\\')

    def _reject_ssh_input(self, value):
        """Return a human-readable rejection reason, or '' if value is safe.

        Designed to be conservative -- false positives (rejecting a value that
        would have worked) are preferable to false negatives. JOBIDs and short
        tokens are all that custom commands need at the moment.
        """
        if not value:
            return 'Input is empty.'
        if len(value) > 200:
            return 'Input is too long (>200 chars).'
        bad = sorted({c for c in value if c in self._SSH_INPUT_FORBIDDEN})
        if bad:
            shown = ' '.join(repr(c) for c in bad)
            return f'Input contains forbidden characters: {shown}'
        return ''

    def _remove_ssh_command_worker(self, worker):
        if worker in self._ssh_command_workers:
            self._ssh_command_workers.remove(worker)
        jid = getattr(worker, '_jobid_lock', '')
        if jid:
            self._kill_in_flight.discard(jid)

    def _on_ssh_command_done(self, seq, label, command, output, rows):
        text = output.strip() or '(no output)'
        self.log(f'[CMD #{seq}] {label}: {command}', 'cmd')
        self.log(f'[OK #{seq}]  {label}\n{text}', 'ok')
        if not rows:
            return
        # `bjobs -l` is a detail enrichment — merge extras into the row cache
        # instead of replacing the whole queue view. Short-format bjobs is
        # still a full refresh.
        cmd_str = str(command or '')
        is_long = ' -l ' in ' ' + cmd_str + ' ' or cmd_str.strip().startswith('bjobs -l')
        if is_long:
            for r in rows:
                jid = str(r.get('jobid', ''))
                if jid:
                    self._queue_tab.merge_row_details(jid, r)
        else:
            self._queue_tab.refresh(rows)
            self._sync_job_status_from_queue(rows)

    def _on_ssh_command_failed(self, seq, label, message):
        self.log(f'[ERR #{seq}] {label}: {message}', 'err')
        self._queue_tab.set_status_message(f'Error: {message}')

    def _on_autopoll_toggled(self, on):
        poller = getattr(self, '_bjobs_poller', None)
        if poller is None:
            return
        if on and not poller.isRunning():
            poller._stop = False
            poller.set_interval(5)
            poller.start()
        elif not on and poller.isRunning():
            poller.stop()

    def _on_clear_done(self):
        done_uids = []
        for cd in self._cards_data:
            if cd['type'] == 'single' and cd.get('status') == 'Done':
                done_uids.append(cd['uid'])
            elif cd['type'] in ('folder_group', 'multi_folder'):
                items = cd.get('files', cd.get('rows', []))
                if items and all(i.get('status') == 'Done' for i in items):
                    done_uids.append(cd['uid'])
        for uid in done_uids:
            self._on_remove_card(uid)
        self.log(f'[INFO]  Cleared {len(done_uids)} done cards.', 'info')

    def _on_preview_file(self, win_folder, filename):
        self._preview_tab.load_file(win_folder, filename)
        self.right_dock.set_active_tab("preview")

    def _on_preview_heredoc(self, text):
        self._preview_tab.show_heredoc(text)
        self.right_dock.set_active_tab("preview")

    # ── Settings ────────────────────────────────────────────────────────

    def _on_open_settings(self):
        dlg = SettingsDialog(self._settings, parent=self)
        dlg.settings_applied.connect(self._on_settings_applied)
        dlg.exec_()

    def _on_settings_applied(self, new_settings):
        self._settings.update(new_settings)
        self.detail_panel.set_settings(self._settings)
        self._queue_tab.set_custom_commands(self._settings.get('ssh_buttons') or [])
        self._queue_tab.set_columns(self._settings.get('queue_columns') or [])
        self._on_save()
        self.log('[INFO]  Settings saved.', 'info')

    # ── Save ────────────────────────────────────────────────────────────

    def _on_save(self):
        panel_state = self._panel_state()
        self._settings['gui'] = {
            'geometry': self.saveGeometry().toHex().data().decode(),
            'active_tab': self.right_dock.active_tab(),
            'splitter_sizes': panel_state['main_splitter']['sizes'],
            'panels': panel_state,
            'window': {
                'width': self.width(),
                'height': self.height(),
                'is_maximized': self.isMaximized(),
            },
            'right_dock': {
                'active_tab': self.right_dock.active_tab(),
                'theme': self.right_dock.theme_mode(),
                'terminal_theme': self.right_dock.theme_mode(),
                'view_font_sizes': self.right_dock.view_font_sizes(),
            },
        }
        save_settings(self._settings, self._cards_data)
        self._saved_state_snapshot = self._state_snapshot()
        self.set_status('Saved')

    def _panel_state(self):
        sizes = [int(s) for s in self._main_splitter.sizes()]
        names = ['job_list_panel', 'detail_panel', 'right_dock']
        panel_widths = {name: sizes[i] for i, name in enumerate(names) if i < len(sizes)}
        return {
            'main_splitter': {
                'orientation': 'horizontal',
                'sizes': sizes,
                'panel_widths': panel_widths,
            },
            'job_list_panel': {
                'width': self.job_list_panel.width(),
            },
            'detail_panel': {
                'width': self.detail_panel.width(),
            },
            'right_dock': {
                'width': self.right_dock.width(),
                'height': self.right_dock.height(),
                'active_tab': self.right_dock.active_tab(),
                'theme': self.right_dock.theme_mode(),
                'terminal_theme': self.right_dock.theme_mode(),
                'view_font_sizes': self.right_dock.view_font_sizes(),
            },
            'active_detail': self._active_detail_panel_state(),
        }

    def _active_detail_panel_state(self):
        state = {}
        card = self.detail_panel.currentWidget()
        if card is None:
            return state
        for attr in ('files_table', 'rows_table'):
            table = getattr(card, attr, None)
            if table is None:
                continue
            state[attr] = {
                'width': table.width(),
                'height': table.height(),
                'columns': [table.columnWidth(i) for i in range(table.columnCount())],
            }
        return state

    def _apply_active_detail_panel_state(self):
        state = self._pending_active_detail_state or {}
        if not isinstance(state, dict):
            return
        card = self.detail_panel.currentWidget()
        if card is None:
            return
        for attr in ('files_table', 'rows_table'):
            table = getattr(card, attr, None)
            table_state = state.get(attr)
            if table is None or not isinstance(table_state, dict):
                continue
            columns = table_state.get('columns')
            if isinstance(columns, list):
                for i, width in enumerate(columns[:table.columnCount()]):
                    try:
                        if attr == 'rows_table' and i == 4:
                            width = max(56, min(int(width), 56))
                        elif attr == 'rows_table' and i == 5:
                            width = max(56, min(int(width), 56))
                        table.setColumnWidth(i, int(width))
                    except (TypeError, ValueError):
                        pass

    def _state_snapshot(self):
        state = {
            'settings': self._settings,
            'cards': self._cards_data,
            'gui': {
                'geometry': self.saveGeometry().toHex().data().decode(),
                'window': {
                    'width': self.width(),
                    'height': self.height(),
                    'is_maximized': self.isMaximized(),
                },
                'panels': self._panel_state(),
                'active_tab': self.right_dock.active_tab(),
                'right_dock_theme': self.right_dock.theme_mode(),
            },
        }
        return json.dumps(state, sort_keys=True, ensure_ascii=True, default=str)

    def _has_unsaved_changes(self):
        return self._state_snapshot() != getattr(self, '_saved_state_snapshot', '')

    # ── Logging ─────────────────────────────────────────────────────────

    def log(self, msg, tag=''):
        self._terminal_tab.append_log(msg, tag)

    def set_status(self, msg):
        self._status_bar.showMessage(f'  {msg}')

    def closeEvent(self, event):
        choice = self._confirm_save_on_close()
        if choice == QMessageBox.Cancel:
            event.ignore()
            return
        if choice == QMessageBox.Save:
            try:
                self._on_save()
            except Exception:
                pass
        try:
            self._terminal_registry.cleanup()
        except Exception:
            pass
        try:
            poller = getattr(self, '_bjobs_poller', None)
            if poller is not None and poller.isRunning():
                poller.stop()
                poller.wait(2000)
        except Exception:
            pass
        super().closeEvent(event)

    def _confirm_save_on_close(self):
        if not self._has_unsaved_changes():
            return QMessageBox.Discard
        msg = message_box.make(
            self,
            'Save before exit?',
            'Save current jobs, panel sizes, and window state before closing?',
            QMessageBox.Question,
            QMessageBox.Save | QMessageBox.Discard | QMessageBox.Cancel,
            QMessageBox.Save,
            object_name='saveConfirmDialog',
        )
        msg.button(QMessageBox.Discard).setText("Don't Save")
        return msg.exec_()
