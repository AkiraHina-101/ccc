import sys
import os

# Add bundled libs if present (so `import PySide2` resolves to libs/PySide2)
_here = os.path.dirname(os.path.abspath(__file__))
_libs = os.path.join(_here, 'libs')
if os.path.isdir(_libs):
    sys.path.insert(0, _libs)

from PySide2.QtGui import QIcon
from PySide2.QtWidgets import QApplication
from app.ui.main_window import MainWindow


def main():
    app = QApplication(sys.argv)
    app.setApplicationName('Nastran Submitter Pro')
    app.setOrganizationName('NastranTools')

    icon_path = os.path.join(_here, 'app', 'ui', 'assets', 'app_logo.ico')
    if not os.path.isfile(icon_path):
        icon_path = os.path.join(_here, 'app', 'ui', 'assets', 'app_logo.svg')
    if os.path.isfile(icon_path):
        app.setWindowIcon(QIcon(icon_path))

    qss_path = os.path.join(_here, 'app', 'ui', 'styles', 'app.qss')
    if os.path.isfile(qss_path):
        with open(qss_path, 'r', encoding='utf-8') as f:
            app.setStyleSheet(f.read())

    window = MainWindow()
    if os.path.isfile(icon_path):
        window.setWindowIcon(QIcon(icon_path))
    window.show()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()
