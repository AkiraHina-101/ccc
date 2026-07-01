import sys

from PySide2.QtCore import QObject, Qt
from PySide2.QtGui import QColor, QPalette
from PySide2.QtWidgets import QMessageBox, QMenu


LIGHT_MESSAGE_BOX_QSS = """
QMessageBox {
    background: #FFFFFF;
    color: #111827;
}
QMessageBox QWidget {
    background: #FFFFFF;
    color: #111827;
}
QMessageBox QLabel {
    background: transparent;
    color: #111827;
    font-size: 11px;
}
QMessageBox QPushButton {
    background: #FFFFFF;
    border: 1px solid #C8CDD5;
    border-radius: 2px;
    color: #111827;
    font-size: 10px;
    min-width: 72px;
    min-height: 26px;
    padding: 4px 12px;
}
QMessageBox QPushButton:hover {
    background: #F4F6F8;
    border-color: #1469C2;
    color: #1469C2;
}
QMessageBox QPushButton:default {
    border: 2px solid #1469C2;
    padding: 3px 11px;
}
"""

LIGHT_MENU_QSS = """
QMenu {
    background: #FFFFFF;
    border: 1px solid #C8CDD5;
    padding: 4px 0;
    color: #111827;
}
QMenu::item {
    background: #FFFFFF;
    color: #111827;
    padding: 7px 22px;
    font-size: 11px;
}
QMenu::item:selected {
    background: #1469C2;
    color: #FFFFFF;
}
QMenu::item:disabled {
    background: #FFFFFF;
    color: #9CA3AF;
}
QMenu::separator {
    height: 1px;
    background: #E5E7EB;
    margin: 4px 6px;
}
"""


def _apply_light_palette(widget):
    palette = widget.palette()
    for role in (
        QPalette.Window,
        QPalette.Base,
        QPalette.AlternateBase,
        QPalette.Button,
    ):
        palette.setColor(role, QColor("#FFFFFF"))
    for role in (
        QPalette.WindowText,
        QPalette.Text,
        QPalette.ButtonText,
    ):
        palette.setColor(role, QColor("#111827"))
    widget.setPalette(palette)
    for child in widget.findChildren(QObject):
        if hasattr(child, "setPalette"):
            child.setPalette(palette)


def apply_dark_title_bar(widget):
    if sys.platform != "win32":
        return
    try:
        import ctypes
        hwnd = int(widget.winId())
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


def make(parent, title, text, icon=QMessageBox.NoIcon, buttons=QMessageBox.Ok,
         default_button=QMessageBox.NoButton, object_name="lightMessageBox"):
    msg = QMessageBox(parent)
    msg.setObjectName(object_name)
    msg.setAttribute(Qt.WA_StyledBackground, True)
    msg.setWindowTitle(title)
    msg.setText(text)
    msg.setIcon(icon)
    msg.setStandardButtons(buttons)
    if default_button != QMessageBox.NoButton:
        msg.setDefaultButton(default_button)
    msg.setStyleSheet(LIGHT_MESSAGE_BOX_QSS)
    _apply_light_palette(msg)
    apply_dark_title_bar(msg)
    return msg


def make_menu(parent=None, object_name="lightContextMenu"):
    menu = QMenu(parent)
    menu.setObjectName(object_name)
    menu.setAttribute(Qt.WA_StyledBackground, True)
    menu.setStyleSheet(LIGHT_MENU_QSS)
    _apply_light_palette(menu)
    return menu


def question(parent, title, text, buttons=QMessageBox.Yes | QMessageBox.No,
             default_button=QMessageBox.No):
    msg = make(parent, title, text, QMessageBox.Question, buttons, default_button)
    return msg.exec_()


def warning(parent, title, text, buttons=QMessageBox.Ok,
            default_button=QMessageBox.Ok):
    msg = make(parent, title, text, QMessageBox.Warning, buttons, default_button)
    return msg.exec_()


def information(parent, title, text, buttons=QMessageBox.Ok,
                default_button=QMessageBox.Ok):
    msg = make(parent, title, text, QMessageBox.Information, buttons, default_button)
    return msg.exec_()
