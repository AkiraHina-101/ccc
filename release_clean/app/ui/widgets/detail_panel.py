"""DetailPanel — center pane of the master-detail layout.

Phase B.4 (skeleton). Holds one card widget per active job_id and swaps
which one is shown via a QStackedWidget. Re-uses the existing `SingleCard`,
`FolderGroupCard`, `MultiFolderCard` widgets so logic stays intact while we
migrate the surrounding shell. The full Claude Design rewrite of card
internals is queued as B.4b for the next session — see PHASE_B_PROGRESS.md.

Signals are forwarded from the underlying cards verbatim so MainWindow only
connects to one source.
"""

from PySide2.QtWidgets import QStackedWidget, QWidget, QLabel, QVBoxLayout, QSizePolicy
from PySide2.QtCore import Signal, Qt

from app.ui.widgets.detail_variants import (
    SingleJobDetail, FolderGroupDetail, MultiFolderDetail,
)


_TYPE_TO_CLASS = {
    "single":       SingleJobDetail,
    "folder":       FolderGroupDetail,
    "folder_group": FolderGroupDetail,
    "multi":        MultiFolderDetail,
    "multi_folder": MultiFolderDetail,
}


class _EmptyState(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setObjectName("detailEmpty")
        layout = QVBoxLayout(self)
        layout.setAlignment(Qt.AlignCenter)
        msg = QLabel("Select a job from the sidebar, or click + Add to create one.")
        msg.setAlignment(Qt.AlignCenter)
        msg.setStyleSheet("color: #6B7280; font-size: 11px;")
        layout.addWidget(msg)


class DetailPanel(QStackedWidget):
    submit_requested      = Signal(dict)
    submit_selected       = Signal(dict, list)
    submit_all_rows       = Signal(list)
    remove_requested      = Signal(int)
    preview_requested     = Signal(str, str)
    preview_sh_requested  = Signal(str)
    title_changed         = Signal(int, str)

    def __init__(self, settings: dict = None, parent=None):
        super().__init__(parent)
        self.setObjectName("detailPanel")
        self.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        # 360px allows snap-tiled usage. Card content uses scroll areas, so
        # narrower than ideal still works -- tables get horizontal scrollbars
        # and the preset toolbar wraps. The 580 floor was preventing the user
        # from snap-tiling at all.
        self.setMinimumWidth(360)
        self._settings = settings or {}
        self._cards = {}            # uid -> card widget
        self._current_uid = None

        self._empty = _EmptyState(self)
        self.addWidget(self._empty)
        self.setCurrentWidget(self._empty)

    # -- public API -----------------------------------------------------

    def set_settings(self, settings: dict):
        self._settings = settings or {}

    def show_job(self, data: dict):
        """Display the detail view for `data['uid']`, building one if needed."""
        uid = data["uid"]
        job_type = data.get("type", "single")
        card = self._cards.get(uid)
        if card is None:
            card = self._build_card(data, job_type)
            self._cards[uid] = card
            self.addWidget(card)
        self.setCurrentWidget(card)
        self._current_uid = uid

    def clear_selection(self):
        self.setCurrentWidget(self._empty)
        self._current_uid = None

    def remove_job(self, uid: int) -> bool:
        card = self._cards.pop(uid, None)
        if card is None:
            return False
        self.removeWidget(card)
        card.deleteLater()
        if self._current_uid == uid:
            self.clear_selection()
        return True

    def get_card(self, uid: int):
        return self._cards.get(uid)

    def current_uid(self):
        return self._current_uid

    def update_status(self, uid: int, status: str):
        card = self._cards.get(uid)
        if card and hasattr(card, "set_status"):
            card.set_status(status)

    # -- internal -------------------------------------------------------

    def _build_card(self, data: dict, job_type: str):
        cls = _TYPE_TO_CLASS.get(job_type, SingleJobDetail)
        card = cls(data, self._settings)
        self._wire_card(card, job_type)
        return card

    def _wire_card(self, card, job_type: str):
        if hasattr(card, "submit_requested"):
            card.submit_requested.connect(self.submit_requested)
        if hasattr(card, "remove_requested"):
            card.remove_requested.connect(self.remove_requested)
        if hasattr(card, "preview_requested"):
            card.preview_requested.connect(self.preview_requested)
        if hasattr(card, "preview_sh_requested"):
            card.preview_sh_requested.connect(self.preview_sh_requested)
        if hasattr(card, "submit_all_rows"):
            card.submit_all_rows.connect(self.submit_all_rows)
        if hasattr(card, "submit_selected"):
            card.submit_selected.connect(self.submit_selected)
        if hasattr(card, "title_changed"):
            card.title_changed.connect(self.title_changed)
