from PySide2.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QLabel, QPushButton,
    QTreeWidget, QTreeWidgetItem, QMenu, QAction,
)
from PySide2.QtGui import QColor, QFont
from PySide2.QtCore import Qt, Signal, QDateTime

STATUS_COLORS = {
    'dark': {
        'Done':    '#7EE787',
        'Running': '#F2CC60',
        'Error':   '#FF7B72',
        'Queued':  '#8AB4FF',
        'Pending': '#CDD6E0',
        'Skip':    '#AAB6C5',
    },
    'light': {
        'Done':    '#1A7F37',
        'Running': '#9A6700',
        'Error':   '#D1242F',
        'Queued':  '#0969DA',
        'Pending': '#374151',
        'Skip':    '#4B5563',
    },
}

# Columns: Job ID | State | Summary | Queue | Submit time
COLUMNS = ['Job ID', 'State', 'Summary', 'Queue', 'Submit time']
HEADER_BUTTON_HEIGHT = 26
COMMAND_SHELF_ROWS = 2
HEADER_BUTTON_WIDTH = 78
HEADER_BUTTON_SPACING = 6
HEADER_BUTTON_WIDTHS = {
    'command': HEADER_BUTTON_WIDTH,
    'more': HEADER_BUTTON_WIDTH,
    'auto': HEADER_BUTTON_WIDTH,
    'refresh': HEADER_BUTTON_WIDTH,
    'clear': HEADER_BUTTON_WIDTH,
}


class QueueTab(QWidget):
    refresh_requested = Signal()
    autopoll_toggled = Signal(bool)
    ssh_command_requested = Signal(dict)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._theme_mode = 'dark'
        self._rows = []
        # Job IDs the user has explicitly dismissed via Clear done. We hide
        # them from render even when the next bjobs poll still returns them
        # (LSF keeps DONE jobs in its history window for ~1h).
        self._dismissed_jobids = set()
        self._custom_commands = []
        self._view_font_size = 10
        self._init_ui()
        self._connect_signals()
        self.set_theme_mode('dark')

    def _init_ui(self):
        self.setObjectName('queueTab')
        self.setAttribute(Qt.WA_StyledBackground, True)
        self._layout_main = QVBoxLayout(self)
        self._layout_main.setContentsMargins(0, 0, 0, 0)
        self._layout_main.setSpacing(0)

        self.status_lbl = QLabel('')
        self.status_lbl.setObjectName('queueStatusLbl')
        self.status_lbl.setVisible(False)

        # Row 1: realtime queue controls.
        self.header = QWidget()
        self.header.setObjectName('queueHeader')
        self.header.setAttribute(Qt.WA_StyledBackground, True)
        self.header.setFixedHeight(34)
        header_layout = QHBoxLayout(self.header)
        header_layout.setContentsMargins(10, 0, 8, 0)
        header_layout.setSpacing(6)
        self.controls_title_lbl = QLabel('QUEUE CONTROLS')
        self.controls_title_lbl.setObjectName('queueSectionTitle')
        self.controls_title_lbl.setFixedWidth(104)
        header_layout.addWidget(self.controls_title_lbl, 0, Qt.AlignVCenter)

        self.autopoll_btn = QPushButton('Auto: on')
        self.autopoll_btn.setObjectName('queueAutopollBtn')
        self.autopoll_btn.setCheckable(True)
        self.autopoll_btn.setChecked(True)
        self.autopoll_btn.setFixedSize(HEADER_BUTTON_WIDTHS['auto'], HEADER_BUTTON_HEIGHT)
        header_layout.addWidget(self.autopoll_btn, 0, Qt.AlignVCenter)

        self.refresh_btn = QPushButton('Refresh')
        self.refresh_btn.setObjectName('queueRefreshBtn')
        self.refresh_btn.setFixedSize(HEADER_BUTTON_WIDTHS['refresh'], HEADER_BUTTON_HEIGHT)
        header_layout.addWidget(self.refresh_btn, 0, Qt.AlignVCenter)

        self.clear_done_btn = QPushButton('Clear done')
        self.clear_done_btn.setObjectName('queueClearDoneBtn')
        self.clear_done_btn.setFixedSize(HEADER_BUTTON_WIDTHS['clear'], HEADER_BUTTON_HEIGHT)
        header_layout.addWidget(self.clear_done_btn, 0, Qt.AlignVCenter)

        header_layout.addStretch()

        self._layout_main.addWidget(self.header)

        # Row 2: custom command shelf. Up to two rows, extras go under More.
        self.command_shelf = QWidget()
        self.command_shelf.setObjectName('queueCommandShelf')
        self.command_shelf.setAttribute(Qt.WA_StyledBackground, True)
        shelf_outer = QHBoxLayout(self.command_shelf)
        shelf_outer.setContentsMargins(10, 5, 8, 5)
        shelf_outer.setSpacing(8)
        self.commands_title_lbl = QLabel('SSH COMMANDS')
        self.commands_title_lbl.setObjectName('queueSectionTitle')
        self.commands_title_lbl.setFixedWidth(104)
        shelf_outer.addWidget(self.commands_title_lbl, 0, Qt.AlignTop)
        shelf_layout = QVBoxLayout()
        shelf_layout.setContentsMargins(0, 0, 0, 0)
        shelf_layout.setSpacing(4)
        shelf_outer.addLayout(shelf_layout, 1)
        self.command_rows = []
        for _ in range(COMMAND_SHELF_ROWS):
            row_widget = QWidget()
            row_layout = QHBoxLayout(row_widget)
            row_layout.setContentsMargins(0, 0, 0, 0)
            row_layout.setSpacing(6)
            row_layout.addStretch()
            shelf_layout.addWidget(row_widget)
            self.command_rows.append(row_layout)

        self.command_buttons = []
        self.more_btn = QPushButton('More')
        self.more_btn.setObjectName('queueMoreBtn')
        self.more_btn.setFixedSize(HEADER_BUTTON_WIDTHS['more'], HEADER_BUTTON_HEIGHT)
        self.more_menu = QMenu(self.more_btn)
        self.more_btn.setMenu(self.more_menu)
        self.more_btn.setVisible(False)
        self._layout_main.addWidget(self.command_shelf)

        # Tree
        self.tree = QTreeWidget()
        self.tree.setObjectName('queueTree')
        self.tree.setColumnCount(len(COLUMNS))
        self.tree.setHeaderLabels(COLUMNS)
        self.tree.setAlternatingRowColors(True)
        self.tree.setRootIsDecorated(False)
        self.tree.setSortingEnabled(False)
        self.tree.setFont(QFont('Segoe UI', self._view_font_size))
        self.tree.header().setFont(QFont('Segoe UI', self._view_font_size))
        self.tree.header().setDefaultAlignment(Qt.AlignCenter)

        header_view = self.tree.header()
        # setStretchLastSection=False keeps Submit time at its set width
        # instead of letting it absorb all leftover space; combined with the
        # always-on horizontal scrollbar this means narrow widths just scroll
        # right rather than squeezing the visible columns.
        header_view.setStretchLastSection(False)
        self.tree.setHorizontalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        self.tree.setHorizontalScrollMode(self.tree.ScrollPerPixel)
        header_view.resizeSection(0, 90)   # Job ID
        header_view.resizeSection(1, 80)   # State
        header_view.resizeSection(2, 220)  # Summary
        header_view.resizeSection(3, 120)  # Queue
        header_view.resizeSection(4, 140)  # Submit time

        self._layout_main.addWidget(self.tree)
        self.setLayout(self._layout_main)
        self.set_custom_commands([])

    def _connect_signals(self):
        self.clear_done_btn.clicked.connect(self._on_clear_done)
        self.refresh_btn.clicked.connect(self._on_refresh_clicked)
        self.autopoll_btn.toggled.connect(self._on_autopoll_toggled)

    # ---- Public API ----------------------------------------------------------

    def refresh(self, rows):
        self._rows = list(rows)
        self._render()

    def set_status_message(self, text):
        """Show a short live message next to the title (errors, polling state)."""
        self.status_lbl.setText(text or '')

    def is_autopoll_on(self):
        return self.autopoll_btn.isChecked()

    def set_autopoll(self, on):
        self.autopoll_btn.setChecked(bool(on))

    def selected_jobid(self):
        item = self.tree.currentItem()
        if item is None:
            return ''
        return str(item.text(0) or '').strip()

    def set_custom_commands(self, commands):
        self._custom_commands = list(commands or [])
        self._rebuild_command_buttons()

    def _commands_per_row(self):
        margins = self.command_shelf.layout().contentsMargins()
        available = (
            self.command_shelf.width()
            - margins.left() - margins.right()
            - self.commands_title_lbl.width()
            - self.command_shelf.layout().spacing()
        )
        step = HEADER_BUTTON_WIDTH + HEADER_BUTTON_SPACING
        return max(1, available // step)

    def _rebuild_command_buttons(self):
        for btn in self.command_buttons:
            parent_layout = btn.parentWidget().layout() if btn.parentWidget() else None
            if parent_layout is not None:
                parent_layout.removeWidget(btn)
            btn.deleteLater()
        self.command_buttons = []
        self.more_menu.clear()

        enabled_commands = []
        for cmd in self._custom_commands:
            if not isinstance(cmd, dict) or not cmd.get('enabled', True):
                continue
            label = str(cmd.get('label') or '').strip()
            command = str(cmd.get('command') or '').strip()
            if not label or not command:
                continue
            enabled_commands.append(dict(cmd))

        if self.more_btn.parentWidget() is not None:
            parent_layout = self.more_btn.parentWidget().layout()
            if parent_layout is not None:
                parent_layout.removeWidget(self.more_btn)
        self.more_btn.setParent(None)

        per_row = self._commands_per_row()
        max_inline = max(1, per_row * COMMAND_SHELF_ROWS)
        inline_limit = max_inline if len(enabled_commands) <= max_inline else max(1, max_inline - 1)

        for cmd in enabled_commands[:inline_limit]:
            label = str(cmd.get('label') or '').strip()
            command = str(cmd.get('command') or '').strip()
            btn = QPushButton(label)
            btn.setObjectName('queueCommandBtn')
            btn.setFixedSize(HEADER_BUTTON_WIDTHS['command'], HEADER_BUTTON_HEIGHT)
            btn.setToolTip(command)
            btn.clicked.connect(lambda _=False, c=dict(cmd): self.ssh_command_requested.emit(c))
            row_idx = len(self.command_buttons) // per_row
            row_layout = self.command_rows[min(row_idx, len(self.command_rows) - 1)]
            insert_at = max(0, row_layout.count() - 1)
            row_layout.insertWidget(insert_at, btn, 0, Qt.AlignVCenter)
            self.command_buttons.append(btn)

        for cmd in enabled_commands[inline_limit:]:
            label = str(cmd.get('label') or '').strip()
            command = str(cmd.get('command') or '').strip()
            action = QAction(label, self.more_menu)
            action.setToolTip(command)
            action.triggered.connect(lambda _=False, c=dict(cmd): self.ssh_command_requested.emit(c))
            self.more_menu.addAction(action)
        self.more_btn.setVisible(bool(self.more_menu.actions()))
        if self.more_menu.actions():
            row_idx = min((len(self.command_buttons)) // per_row, len(self.command_rows) - 1)
            row_layout = self.command_rows[row_idx]
            insert_at = max(0, row_layout.count() - 1)
            row_layout.insertWidget(insert_at, self.more_btn, 0, Qt.AlignVCenter)
        self.command_shelf.setVisible(bool(enabled_commands))

    def resizeEvent(self, event):
        super().resizeEvent(event)
        self._rebuild_command_buttons()

    # ---- Render --------------------------------------------------------------

    def _render(self):
        self.tree.clear()
        colors = STATUS_COLORS[self._theme_mode]
        # Garbage-collect dismissed entries: once LSF stops returning a jobid
        # we no longer need to remember we dismissed it.
        if self._dismissed_jobids:
            current = {str(r.get('jobid', '')) for r in self._rows}
            self._dismissed_jobids &= current
        for row in self._rows:
            if str(row.get('jobid', '')) in self._dismissed_jobids:
                continue
            state = row.get('state') or row.get('status') or 'Pending'
            item = QTreeWidgetItem([
                str(row.get('jobid', row.get('id', ''))),
                state,
                row.get('summary') or row.get('name', ''),
                row.get('queue', ''),
                row.get('submit_time', ''),
            ])
            color = QColor(colors.get(state, colors['Pending']))
            for col in range(len(COLUMNS)):
                item.setForeground(col, color)
            self.tree.addTopLevelItem(item)

    def set_theme_mode(self, mode):
        if mode not in ('dark', 'light'):
            return
        self._theme_mode = mode
        widgets = (
            self, self.header, self.command_shelf, self.controls_title_lbl,
            self.commands_title_lbl, self.status_lbl,
            self.clear_done_btn, self.refresh_btn, self.autopoll_btn, self.tree,
            self.more_btn, *self.command_buttons,
        )
        for widget in widgets:
            widget.setProperty('theme', mode)
            self._repolish(widget)
        self._render()

    def theme_mode(self):
        return self._theme_mode

    def set_view_font_delta(self, delta):
        self.set_view_font_size(self._view_font_size + int(delta))

    def set_view_font_size(self, size):
        self._view_font_size = max(8, min(24, int(size)))
        font = QFont('Segoe UI', self._view_font_size)
        self.tree.setFont(font)
        self.tree.header().setFont(font)
        self._render()

    def view_font_size(self):
        return self._view_font_size

    def _repolish(self, widget):
        widget.style().unpolish(widget)
        widget.style().polish(widget)
        widget.update()

    # ---- Slots ---------------------------------------------------------------

    def _on_clear_done(self):
        # Remember the jobids the user wants hidden. Subsequent polls will
        # still receive them from LSF, but _render() filters them out until
        # LSF rotates them out of its history window.
        for row in self._rows:
            state = row.get('state') or row.get('status') or 'Pending'
            if state == 'Done':
                jobid = str(row.get('jobid', ''))
                if jobid:
                    self._dismissed_jobids.add(jobid)
        self._render()

    def _on_refresh_clicked(self):
        self.refresh_requested.emit()

    def _on_autopoll_toggled(self, checked):
        self.autopoll_btn.setText('Auto: on' if checked else 'Auto: off')
        self.autopoll_toggled.emit(bool(checked))
