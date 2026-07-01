"""Sidebar listing all jobs (master pane of master-detail layout).

Pure presentation — holds no business state besides job_id ? item mapping.
MainWindow owns the job dict and pushes updates via `add_job_item` /
`update_job_item_status` / `remove_job_item`.
"""

from PySide2.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QLabel, QPushButton,
    QListWidget, QListWidgetItem, QMenu,
)
from PySide2.QtCore import Qt, Signal

from app.ui.widgets.helpers import StatusDot, STATUS_COLORS, ElidedLabel


_TYPE_LABEL = {
    "single": "One job / one folder",
    "folder": "Many jobs / one folder",
    "multi": "One job / each subfolder",
}


class JobListItemWidget(QWidget):
    """Row widget inside the QListWidget: status dot + name + type badge + status text."""

    def __init__(self, job_name: str, job_type: str, status: str = "pending",
                 row_count: int = 0, parent=None):
        super().__init__(parent)
        self._job_name = job_name
        self._job_type = job_type
        self._status = status
        self._row_count = row_count
        self._init_ui()

    def _init_ui(self):
        root = QVBoxLayout(self)
        root.setContentsMargins(14, 10, 14, 10)
        root.setSpacing(3)

        # Line 1: basename (bold, large)
        self.name_lbl = ElidedLabel(
            self._derive_basename(self._job_name), elide_mode=Qt.ElideRight)
        self.name_lbl.setObjectName("jobName")
        self.name_lbl.setProperty("job_type", self._job_type)
        self.name_lbl.setProperty("context", "sidebar")
        self.name_lbl.setToolTip(self._job_name)
        root.addWidget(self.name_lbl)

        # Line 2: parent path (smaller, gray, elide-left to keep last segments)
        self.path_lbl = ElidedLabel(
            self._derive_parent(self._job_name), elide_mode=Qt.ElideLeft)
        self.path_lbl.setObjectName("jobPath")
        self.path_lbl.setProperty("context", "sidebar")
        self.path_lbl.setToolTip(self._job_name)
        root.addWidget(self.path_lbl)

        row2 = QHBoxLayout()
        row2.setSpacing(8)
        row2.setContentsMargins(0, 0, 0, 0)

        badge_text = _TYPE_LABEL.get(self._job_type, self._job_type)
        if self._job_type == "multi" and self._row_count:
            badge_text = f"One job / each subfolder · {self._row_count} jobs"
        self.type_badge = ElidedLabel(badge_text, elide_mode=Qt.ElideRight)
        self.type_badge.setObjectName("typeBadge")
        self.type_badge.setProperty("job_type", self._job_type)
        self.type_badge.setMaximumWidth(150)
        row2.addWidget(self.type_badge)
        row2.addStretch(1)

        self.status_dot = StatusDot(self._status, size=9)
        row2.addWidget(self.status_dot)

        self.status_lbl = QLabel(self._status.capitalize())
        color = STATUS_COLORS.get(self._status, "#6B7280")
        self.status_lbl.setStyleSheet(
            f"font-size: 11px; color:{color}; background:transparent;"
        )
        row2.addWidget(self.status_lbl)
        root.addLayout(row2)

    def set_status(self, status: str):
        self._status = status
        color = STATUS_COLORS.get(status, "#6B7280")
        self.status_dot.set_status(status)
        self.status_lbl.setText(status.capitalize())
        self.status_lbl.setStyleSheet(
            f"font-size: 11px; color:{color}; background:transparent;"
        )

    def set_name(self, name: str):
        self._job_name = name
        self.name_lbl.setText(self._derive_basename(name))
        self.path_lbl.setText(self._derive_parent(name))
        self.name_lbl.setToolTip(name)
        self.path_lbl.setToolTip(name)

    @staticmethod
    def _derive_basename(full: str) -> str:
        if not full:
            return ""
        clean = full.replace("\\", "/").rstrip("/")
        return clean.rsplit("/", 1)[-1] if "/" in clean else clean

    @staticmethod
    def _derive_parent(full: str) -> str:
        if not full:
            return ""
        clean = full.replace("\\", "/").rstrip("/")
        if "/" not in clean:
            return ""
        return clean.rsplit("/", 1)[0]

    def set_row_count(self, n: int):
        self._row_count = n
        if self._job_type == "multi":
            self.type_badge.setText(f"One job / each subfolder · {n} jobs")


class JobListPanel(QWidget):
    """Sidebar — header (count + add), QListWidget, footer (status summary)."""

    job_selected = Signal(str)
    job_added_requested = Signal(str)   # emits job_type
    job_deleted_requested = Signal(str)  # emits job_id
    status_override_requested = Signal(str, str)  # emits (job_id, new_status)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._init_ui()
        self._connect_signals()

    def _init_ui(self):
        self.setObjectName("jobListPanel")
        self.setAttribute(Qt.WA_StyledBackground, True)
        # 160px keeps the sidebar usable when the user snap-tiles the app
        # next to another window. Below this, card labels become too clipped
        # to read; user should collapse it via the chevron instead.
        self.setMinimumWidth(160)

        root = QVBoxLayout(self)
        root.setContentsMargins(0, 0, 0, 0)
        root.setSpacing(0)

        header = QWidget()
        header.setObjectName("sidebarHeader")
        header.setAttribute(Qt.WA_StyledBackground, True)
        header.setFixedHeight(44)
        hl = QHBoxLayout(header)
        hl.setContentsMargins(12, 0, 12, 0)

        # Chevron at the left of the header: collapses the sidebar so the
        # detail panel can use its full width. Wired by MainWindow.
        self.collapse_btn = QPushButton('«')  # left-pointing: "push me away"
        self.collapse_btn.setObjectName('sidebarCollapseBtn')
        self.collapse_btn.setFixedSize(28, 24)
        self.collapse_btn.setToolTip('Hide this panel (detail gets full width)')
        hl.addWidget(self.collapse_btn)

        self.jobs_count_label = QLabel("Jobs (0)")
        hl.addWidget(self.jobs_count_label, 1)

        self.delete_job_btn = QPushButton("🗑  Delete")
        self.delete_job_btn.setObjectName("deleteJobBtn")
        self.delete_job_btn.setFixedHeight(30)
        self.delete_job_btn.setEnabled(False)
        self.delete_job_btn.setToolTip("Delete the selected job")
        hl.addWidget(self.delete_job_btn)
        root.addWidget(header)

        self.job_list = QListWidget()
        self.job_list.setObjectName("jobListWidget")
        self.job_list.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.job_list.setSpacing(0)
        root.addWidget(self.job_list, 1)

        footer = QWidget()
        footer.setObjectName("sidebarFooter")
        footer.setAttribute(Qt.WA_StyledBackground, True)
        fl = QVBoxLayout(footer)
        fl.setContentsMargins(12, 10, 12, 10)
        fl.setSpacing(4)

        self.count_labels = {}
        for status, color, display in [
            ("running", "#D97706", "Running"),
            ("pending", "#374151", "Pending"),
            ("done",    "#16A34A", "Done"),
            ("error",   "#DC2626", "Error"),
        ]:
            row = QHBoxLayout()
            row.setSpacing(0)
            lbl = QLabel(display)
            lbl.setStyleSheet("font-size: 11px; color:#6B7280; background:transparent;")
            val = QLabel("0")
            val.setStyleSheet(
                f"font-size: 11px; font-weight:600; color:{color}; background:transparent;"
            )
            self.count_labels[status] = val
            row.addWidget(lbl)
            row.addStretch()
            row.addWidget(val)
            fl.addLayout(row)
        root.addWidget(footer)

    def _connect_signals(self):
        self.job_list.currentItemChanged.connect(self._on_current_item_changed)
        self.delete_job_btn.clicked.connect(self._on_delete_clicked)
        self.job_list.setContextMenuPolicy(Qt.CustomContextMenu)
        self.job_list.customContextMenuRequested.connect(self._on_context_menu)

    def _on_context_menu(self, pos):
        # Why: LSF can mark a job Done while user knows it actually failed
        # (admin killed it outside bjobs, exit code lost when rotated out).
        # Manual override lets user correct the card without re-submitting.
        item = self.job_list.itemAt(pos)
        if item is None:
            return
        job_id = item.data(Qt.UserRole)
        if not job_id:
            return
        menu = QMenu(self.job_list)
        act_done = menu.addAction('Mark as Done')
        act_fail = menu.addAction('Mark as Failed')
        act_reset = menu.addAction('Reset to Pending')
        chosen = menu.exec_(self.job_list.viewport().mapToGlobal(pos))
        if chosen is None:
            return
        mapping = {act_done: 'Done', act_fail: 'Fail', act_reset: 'Pending'}
        self.status_override_requested.emit(str(job_id), mapping[chosen])

    def _on_current_item_changed(self, current, _previous):
        self.delete_job_btn.setEnabled(current is not None)
        if current is None:
            return
        job_id = current.data(Qt.UserRole)
        if job_id:
            self.job_selected.emit(job_id)

    def _on_delete_clicked(self):
        current = self.job_list.currentItem()
        if current is None:
            return
        job_id = current.data(Qt.UserRole)
        if job_id:
            self.job_deleted_requested.emit(str(job_id))

    # -- public API -----------------------------------------------------

    def add_job_item(self, job_id: str, job_name: str, job_type: str,
                     status: str = "pending", row_count: int = 0) -> QListWidgetItem:
        item = QListWidgetItem(self.job_list)
        item.setData(Qt.UserRole, job_id)
        widget = JobListItemWidget(job_name, job_type, status, row_count)
        item.setSizeHint(widget.sizeHint())
        self.job_list.setItemWidget(item, widget)
        self._refresh_job_count()
        return item

    def remove_job_item(self, job_id: str) -> bool:
        for i in range(self.job_list.count()):
            item = self.job_list.item(i)
            if item.data(Qt.UserRole) == job_id:
                self.job_list.takeItem(i)
                self._refresh_job_count()
                return True
        return False

    def get_item_widget(self, job_id: str):
        for i in range(self.job_list.count()):
            item = self.job_list.item(i)
            if item.data(Qt.UserRole) == job_id:
                return self.job_list.itemWidget(item)
        return None

    def set_job_status(self, job_id: str, status: str):
        widget = self.get_item_widget(job_id)
        if widget:
            widget.set_status(status)

    def set_job_name(self, job_id: str, name: str):
        widget = self.get_item_widget(job_id)
        if widget:
            widget.set_name(name)

    def update_counts(self, counts: dict):
        for status, lbl in self.count_labels.items():
            lbl.setText(str(counts.get(status, 0)))

    def select_job(self, job_id: str):
        for i in range(self.job_list.count()):
            item = self.job_list.item(i)
            if item.data(Qt.UserRole) == job_id:
                self.job_list.setCurrentItem(item)
                return True
        return False

    def job_count(self) -> int:
        return self.job_list.count()

    def _refresh_job_count(self):
        self.jobs_count_label.setText(f"Jobs ({self.job_list.count()})")
