"""RightDock â€” single-pane right side bar with QStackedWidget + custom tab bar.

Replaces 3 separate QDockWidgets (Terminal/Preview/Queue). Layout per
Claude Design v2.0:

    +----------------------------+
    | dockTabBar (30px)          |
    |   [Preview .dat] [Queue] [Terminal]
    +----------------------------+
    | QStackedWidget             |
    |   index 0: PreviewTab      |
    |   index 1: QueueTab        |
    |   index 2: TerminalTab     |
    | dockBottomBar              |
    |   [Light/Dark]             |
    +----------------------------+
"""

from PySide2.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QStackedWidget, QPushButton,
    QSizePolicy,
)
from PySide2.QtCore import Qt, Signal


_TAB_NAMES = ("preview", "queue", "terminal")
# Legacy: session files saved before the merge referenced separate SH/DAT
# tabs; map both to the single Preview tab.
_LEGACY_ALIAS = {"preview_sh": "preview", "preview_dat": "preview"}


# _FontSizeButton removed — replaced by two dedicated A- / A+ buttons.
# Left/right-click on the same button was too easy to miss (users routinely
# expected left-click to mean "bigger" and got the opposite).


class RightDock(QWidget):
    """Four-tab pane attached to the right side of MainWindow."""

    tab_changed = Signal(str)   # 'preview' | 'queue' | 'terminal'

    def __init__(self, preview_tab: QWidget,
                 queue_tab: QWidget, terminal_tab: QWidget, parent=None):
        super().__init__(parent)
        self._preview = preview_tab
        self._queue = queue_tab
        self._terminal = terminal_tab
        self._theme_mode = "dark"
        self._init_ui()
        self._connect_signals()
        self.set_theme_mode("dark")
        self.set_active_tab("terminal")

    def _init_ui(self):
        self.setObjectName("rightDock")
        self.setAttribute(Qt.WA_StyledBackground, True)
        # 280px is the floor. Below this the tab labels switch to compact
        # form (SH / DAT / Q / Term) and the Queue tree scrolls horizontally.
        # The user can snap-tile the whole app, so we degrade gracefully
        # rather than refuse to shrink.
        self.setMinimumWidth(280)
        self.setSizePolicy(QSizePolicy.Preferred, QSizePolicy.Expanding)

        root = QVBoxLayout(self)
        root.setContentsMargins(0, 0, 0, 0)
        root.setSpacing(0)

        self.tab_bar = QWidget()
        self.tab_bar.setObjectName("dockTabBar")
        self.tab_bar.setAttribute(Qt.WA_StyledBackground, True)
        self.tab_bar.setFixedHeight(30)
        tbl = QHBoxLayout(self.tab_bar)
        tbl.setContentsMargins(0, 0, 0, 0)
        tbl.setSpacing(0)

        # Tab labels carry both a full and compact form. resizeEvent picks
        # whichever fits the current dock width, so the user can snap-tile
        # the whole app narrow without the labels getting chopped.
        self._tab_labels = []  # [(button, full, compact)]

        self.preview_btn = QPushButton("Preview")
        self.preview_btn.setCheckable(True)
        tbl.addWidget(self.preview_btn, 1)
        self._tab_labels.append((self.preview_btn, 'Preview', 'Prev'))

        self.queue_btn = QPushButton("Queue")
        self.queue_btn.setCheckable(True)
        tbl.addWidget(self.queue_btn, 1)
        self._tab_labels.append((self.queue_btn, 'Queue', 'Q'))

        self.terminal_btn = QPushButton("Terminal")
        self.terminal_btn.setObjectName("terminalTabBtn")
        self.terminal_btn.setCheckable(True)
        tbl.addWidget(self.terminal_btn, 1)
        self._tab_labels.append((self.terminal_btn, 'Terminal', 'Term'))

        root.addWidget(self.tab_bar)

        # Queue controls + SSH commands bar. Reparented from QueueTab so the
        # user can access Refresh/Auto/Clear done + SSH command buttons no
        # matter which tab (Preview/Queue/Terminal) is active.
        for shelf in ('header', 'command_shelf'):
            widget = getattr(self._queue, shelf, None)
            if widget is not None:
                root.addWidget(widget)

        self.stack = QStackedWidget()
        self.stack.addWidget(self._preview)   # 0
        self.stack.addWidget(self._queue)     # 1
        self.stack.addWidget(self._terminal)  # 2
        root.addWidget(self.stack, 1)

        self.bottom_bar = QWidget()
        self.bottom_bar.setObjectName("dockBottomBar")
        self.bottom_bar.setAttribute(Qt.WA_StyledBackground, True)
        self.bottom_bar.setFixedHeight(48)
        bottom_layout = QHBoxLayout(self.bottom_bar)
        bottom_layout.setContentsMargins(8, 8, 8, 8)
        bottom_layout.setSpacing(6)
        # Chevron at the left edge of the bottom bar: collapses the whole
        # RightDock so the user can give the detail panel full width.
        # Wired by MainWindow (it owns the splitter).
        self.collapse_btn = QPushButton('»')  # right-pointing double-angle: "push me away"
        self.collapse_btn.setObjectName('dockCollapseBtn')
        self.collapse_btn.setFixedSize(32, 24)
        self.collapse_btn.setToolTip('Hide this panel (detail gets full width)')
        bottom_layout.addWidget(self.collapse_btn)

        bottom_layout.addStretch()

        # Split font-size control into two labeled buttons (A- / A+) so the
        # click semantics are obvious. Older singleton `font_btn` referenced
        # by set_theme_mode() is kept as an alias to font_smaller_btn.
        self.font_smaller_btn = QPushButton("A−")
        self.font_smaller_btn.setObjectName("dockFontBtn")
        self.font_smaller_btn.setFixedSize(30, 24)
        self.font_smaller_btn.setToolTip("Smaller view text")
        bottom_layout.addWidget(self.font_smaller_btn)
        self.font_larger_btn = QPushButton("A+")
        self.font_larger_btn.setObjectName("dockFontBtn")
        self.font_larger_btn.setFixedSize(30, 24)
        self.font_larger_btn.setToolTip("Larger view text")
        bottom_layout.addWidget(self.font_larger_btn)
        self.font_btn = self.font_smaller_btn  # legacy attr — theme code still touches it

        self.theme_btn = QPushButton("Light")
        self.theme_btn.setObjectName("dockThemeBtn")
        self.theme_btn.setCheckable(True)
        self.theme_btn.setFixedHeight(24)
        self.theme_btn.setToolTip("Switch dock tabs to light mode")
        bottom_layout.addWidget(self.theme_btn)

        root.addWidget(self.bottom_bar)

    # Width threshold below which the tab labels switch from full ("Preview
    # .sh") to compact (".sh"). 360px / 4 buttons = 90px each; below this we
    # can't fit "Preview .sh" without clipping.
    _COMPACT_TABS_WIDTH = 360

    def resizeEvent(self, event):
        super().resizeEvent(event)
        compact = self.width() < self._COMPACT_TABS_WIDTH
        for btn, full, short in self._tab_labels:
            target = short if compact else full
            if btn.text() != target:
                btn.setText(target)
                btn.setToolTip(full)
        # command_shelf was reparented from QueueTab to us; its per-row button
        # count depends on width, so trigger a rebuild whenever the dock resizes.
        rebuild = getattr(self._queue, '_rebuild_command_buttons', None)
        if callable(rebuild):
            rebuild()

    def _connect_signals(self):
        self.preview_btn.clicked.connect(lambda *_: self.set_active_tab("preview"))
        self.queue_btn.clicked.connect(lambda *_: self.set_active_tab("queue"))
        self.terminal_btn.clicked.connect(lambda *_: self.set_active_tab("terminal"))
        self.theme_btn.clicked.connect(self._on_theme_clicked)
        self.font_smaller_btn.clicked.connect(lambda *_: self.adjust_view_font_size(-1))
        self.font_larger_btn.clicked.connect(lambda *_: self.adjust_view_font_size(1))

    # â”€â”€ public API â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

    def set_active_tab(self, name: str):
        name = _LEGACY_ALIAS.get(name, name)
        if name not in _TAB_NAMES:
            return
        idx = _TAB_NAMES.index(name)
        self.stack.setCurrentIndex(idx)
        self.preview_btn.setChecked(name == "preview")
        self.queue_btn.setChecked(name == "queue")
        self.terminal_btn.setChecked(name == "terminal")
        self.tab_changed.emit(name)

    def active_tab(self) -> str:
        return _TAB_NAMES[self.stack.currentIndex()]

    def set_theme_mode(self, mode: str):
        if mode not in ("dark", "light"):
            return
        self._theme_mode = mode
        self.theme_btn.setChecked(mode == "light")
        self.theme_btn.setText("Dark" if mode == "light" else "Light")
        self.theme_btn.setToolTip(
            "Switch dock tabs to dark mode" if mode == "light"
            else "Switch dock tabs to light mode"
        )
        for widget in (
            self, self.tab_bar, self.bottom_bar, self.stack,
            self.preview_btn,
            self.queue_btn, self.terminal_btn,
            self.font_smaller_btn, self.font_larger_btn, self.theme_btn,
        ):
            widget.setProperty("theme", mode)
            self._repolish(widget)
        for tab in (self._preview, self._queue, self._terminal):
            if hasattr(tab, "set_theme_mode"):
                tab.set_theme_mode(mode)

    def theme_mode(self) -> str:
        return self._theme_mode

    def adjust_view_font_size(self, delta: int):
        for tab in (self._preview, self._queue, self._terminal):
            if hasattr(tab, "set_view_font_delta"):
                tab.set_view_font_delta(delta)

    def view_font_sizes(self) -> dict:
        tabs = {
            "preview": self._preview,
            "queue": self._queue,
            "terminal": self._terminal,
        }
        return {
            name: tab.view_font_size()
            for name, tab in tabs.items()
            if hasattr(tab, "view_font_size")
        }

    def set_view_font_sizes(self, sizes: dict):
        if not isinstance(sizes, dict):
            return
        tabs = {
            "preview": self._preview,
            "preview_sh": self._preview,   # legacy
            "preview_dat": self._preview,  # legacy
            "queue": self._queue,
            "terminal": self._terminal,
        }
        for name, size in sizes.items():
            tab = tabs.get(name)
            if tab is None or not hasattr(tab, "set_view_font_size"):
                continue
            try:
                tab.set_view_font_size(int(size))
            except (TypeError, ValueError):
                pass

    def _on_theme_clicked(self, *_):
        self.set_theme_mode("light" if self.theme_btn.isChecked() else "dark")

    def _repolish(self, widget):
        widget.style().unpolish(widget)
        widget.style().polish(widget)
        widget.update()

    def preview_tab(self):
        return self._preview

    # Legacy accessors kept so any older caller keeps working.
    def preview_sh_tab(self):
        return self._preview

    def preview_dat_tab(self):
        return self._preview

    def queue_tab(self):
        return self._queue

    def terminal_tab(self):
        return self._terminal
