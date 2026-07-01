from PySide2.QtWidgets import QPushButton, QStyle
from PySide2.QtCore import QSize


class IconButton(QPushButton):
    def __init__(self, text='', icon_name='', role='normal', parent=None):
        super().__init__(text, parent)
        self.setProperty('role', role)
        self.setFixedHeight(28)
        self.setCursor(__import__('PySide2.QtCore', fromlist=['Qt']).Qt.PointingHandCursor)
        
        if icon_name:
            style = self.style()
            icon_map = {
                'add': QStyle.SP_FileDialogNewFolder,
                'play': QStyle.SP_MediaPlay,
                'clear': QStyle.SP_DialogResetButton,
                'settings': QStyle.SP_FileDialogListView,
                'save': QStyle.SP_DialogSaveButton,
                'folder': QStyle.SP_DirIcon,
                'view': QStyle.SP_FileDialogContentsView,
                'close': QStyle.SP_TitleBarCloseButton,
                'find': QStyle.SP_FileDialogInfoView,
            }
            pixmap = icon_map.get(icon_name)
            if pixmap is not None:
                icon = style.standardIcon(pixmap)
                self.setIcon(icon)
                self.setIconSize(QSize(14, 14))

        self.style().unpolish(self)
        self.style().polish(self)
