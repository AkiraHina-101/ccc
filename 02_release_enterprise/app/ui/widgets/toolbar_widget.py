"""Top toolbar for the master-detail layout."""

from PySide2.QtWidgets import (
    QWidget, QHBoxLayout, QLabel, QPushButton, QFrame, QMenu, QAction, QStyle,
)
from PySide2.QtCore import Signal, Qt
from PySide2.QtCore import QSize


class ToolbarWidget(QWidget):
    add_single_requested = Signal()
    add_folder_requested = Signal()
    add_multi_requested = Signal()
    submit_all_requested = Signal()
    clear_done_requested = Signal()
    settings_requested = Signal()
    save_requested = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._init_ui()
        self._connect_signals()

    def _init_ui(self):
        self.setObjectName("toolbar")
        self.setAttribute(Qt.WA_StyledBackground, True)
        self.setFixedHeight(44)

        layout = QHBoxLayout(self)
        layout.setContentsMargins(12, 0, 12, 0)
        layout.setSpacing(4)

        self.app_label = QLabel("SUBMIT")
        self.app_label.setObjectName("appLabel")
        layout.addWidget(self.app_label)

        layout.addWidget(self._make_divider())

        self.add_job_btn = QPushButton("+ Add job")
        self.add_job_btn.setObjectName("addJobToolbarBtn")
        self.add_job_btn.setIcon(self.style().standardIcon(QStyle.SP_FileDialogNewFolder))
        self.add_job_btn.setIconSize(QSize(14, 14))
        self._add_menu = QMenu(self.add_job_btn)
        self.add_single_action = QAction("One job / one folder", self._add_menu)
        self.add_single_action.setToolTip("One folder contains one job file")
        self.add_folder_action = QAction("Many jobs / one folder", self._add_menu)
        self.add_folder_action.setToolTip("One folder contains many job files")
        self.add_multi_action = QAction("One job / each subfolder", self._add_menu)
        self.add_multi_action.setToolTip(
            "One parent folder contains subfolders; each subfolder has one job")
        self._add_menu.addAction(self.add_single_action)
        self._add_menu.addAction(self.add_folder_action)
        self._add_menu.addAction(self.add_multi_action)
        self.add_job_btn.setMenu(self._add_menu)
        layout.addWidget(self.add_job_btn)

        self.submit_all_btn = QPushButton("Submit all")
        self.submit_all_btn.setObjectName("submitAllBtn")
        self.submit_all_btn.setVisible(False)

        self.clear_done_btn = QPushButton("Clear done")
        self.clear_done_btn.setObjectName("toolbarBtn")
        self.clear_done_btn.setVisible(False)

        layout.addStretch(1)

        self.settings_btn = QPushButton("Settings")
        self.settings_btn.setObjectName("toolbarBtn")
        self.settings_btn.setIcon(self.style().standardIcon(QStyle.SP_FileDialogDetailedView))
        self.settings_btn.setIconSize(QSize(14, 14))
        layout.addWidget(self.settings_btn)

        self.save_btn = QPushButton("Save")
        self.save_btn.setObjectName("toolbarBtn")
        self.save_btn.setIcon(self.style().standardIcon(QStyle.SP_DialogSaveButton))
        self.save_btn.setIconSize(QSize(14, 14))
        layout.addWidget(self.save_btn)

    def _connect_signals(self):
        self.add_single_action.triggered.connect(self.add_single_requested)
        self.add_folder_action.triggered.connect(self.add_folder_requested)
        self.add_multi_action.triggered.connect(self.add_multi_requested)
        self.submit_all_btn.clicked.connect(self.submit_all_requested)
        self.clear_done_btn.clicked.connect(self.clear_done_requested)
        self.settings_btn.clicked.connect(self.settings_requested)
        self.save_btn.clicked.connect(self.save_requested)

    def _make_divider(self) -> QFrame:
        div = QFrame()
        div.setObjectName("toolbarDiv")
        div.setFixedSize(1, 24)
        return div
