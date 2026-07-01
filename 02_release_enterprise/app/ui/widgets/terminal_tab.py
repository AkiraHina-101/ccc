from PySide2.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QPlainTextEdit,
    QComboBox, QLabel, QPushButton, QSizePolicy, QFileDialog,
)
from PySide2.QtGui import QTextCharFormat, QColor, QFont
from PySide2.QtCore import Qt


TAG_COLORS = {
    'dark': {
        'ok':   '#3fb950',
        'err':  '#ff7b72',
        'warn': '#d29922',
        'info': '#79c0ff',
        'cmd':  '#e5c07b',
        'ts':   '#AAB6C5',
        'dim':  '#CDD6E0',
        'text': '#F8FAFC',
    },
    'light': {
        'ok':   '#1A8050',
        'err':  '#D1242F',
        'warn': '#9A6700',
        'info': '#0969DA',
        'cmd':  '#7C4A03',
        'ts':   '#4B5563',
        'dim':  '#374151',
        'text': '#111827',
    },
}


class TerminalTab(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._lines = []
        self._theme_mode = 'dark'
        self._view_font_size = 10
        self._init_ui()
        self._connect_signals()
        self.set_theme_mode('dark')

    def _init_ui(self):
        self.setObjectName('terminalTab')
        self.setAttribute(Qt.WA_StyledBackground, True)
        self._layout_main = QVBoxLayout(self)
        self._layout_main.setContentsMargins(0, 0, 0, 0)
        self._layout_main.setSpacing(0)

        # Header bar
        self.header = QWidget()
        self.header.setObjectName('terminalHeader')
        self.header.setAttribute(Qt.WA_StyledBackground, True)
        self.header.setFixedHeight(32)
        self.header.setProperty('role', 'tab-header')
        header_layout = QHBoxLayout(self.header)
        header_layout.setContentsMargins(8, 0, 8, 0)
        header_layout.setSpacing(6)

        self.title_lbl = QLabel('Log')
        self.title_lbl.setProperty('role', 'info')
        font = self.title_lbl.font()
        font.setBold(True)
        self.title_lbl.setFont(font)
        header_layout.addWidget(self.title_lbl)
        header_layout.addStretch()

        self.filter_cb = QComboBox()
        self.filter_cb.addItem('All jobs')
        self.filter_cb.setFixedWidth(140)
        self.filter_cb.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
        header_layout.addWidget(self.filter_cb)

        self.clear_btn = QPushButton('Clear')
        self.clear_btn.setFixedHeight(24)
        header_layout.addWidget(self.clear_btn)

        self.copy_btn = QPushButton('Copy')
        self.copy_btn.setFixedHeight(24)
        header_layout.addWidget(self.copy_btn)

        self._layout_main.addWidget(self.header)

        # Log output
        self.log_output = QPlainTextEdit()
        self.log_output.setObjectName("terminalOutput")
        self.log_output.setReadOnly(True)
        self.log_output.setFont(QFont('Consolas', self._view_font_size))
        self.log_output.setLineWrapMode(QPlainTextEdit.NoWrap)
        self.log_output.setMinimumWidth(0)
        self.log_output.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        self._layout_main.addWidget(self.log_output)

        self.setLayout(self._layout_main)

    def _connect_signals(self):
        self.clear_btn.clicked.connect(self.clear)
        self.copy_btn.clicked.connect(self._on_copy_clicked)
        self.filter_cb.currentTextChanged.connect(self._render)

    def append_log(self, msg, tag=''):
        from datetime import datetime
        ts = datetime.now().strftime('%H:%M:%S')
        job = None
        if '#' in msg:
            try:
                tail = msg.split('#', 1)[1]
                job = 'Job #' + ''.join(ch for ch in tail if ch.isdigit())
            except Exception:
                job = None
        self._lines.append((ts, msg, tag, job))
        self._update_filter_options()
        self._render()

    def clear(self):
        self._lines.clear()
        self.log_output.clear()

    def _update_filter_options(self):
        jobs = sorted({j for *_, j in self._lines if j})
        current = self.filter_cb.currentText()
        self.filter_cb.blockSignals(True)
        self.filter_cb.clear()
        self.filter_cb.addItem('All jobs')
        for j in jobs:
            self.filter_cb.addItem(j)
        idx = self.filter_cb.findText(current)
        self.filter_cb.setCurrentIndex(max(0, idx))
        self.filter_cb.blockSignals(False)

    def _render(self):
        wanted = self.filter_cb.currentText()
        self.log_output.clear()
        cursor = self.log_output.textCursor()
        colors = TAG_COLORS[self._theme_mode]
        for ts, msg, tag, job in self._lines:
            if wanted != 'All jobs' and job != wanted:
                continue
            fmt_ts = QTextCharFormat()
            fmt_ts.setForeground(QColor(colors.get('ts', '#6B7280')))
            cursor.insertText(f'{ts}  ', fmt_ts)
            fmt_msg = QTextCharFormat()
            color = colors.get(tag, colors['text'])
            fmt_msg.setForeground(QColor(color))
            cursor.insertText(msg + '\n', fmt_msg)
        self.log_output.setTextCursor(cursor)
        self.log_output.ensureCursorVisible()

    def set_theme_mode(self, mode):
        if mode not in ('dark', 'light'):
            return
        self._theme_mode = mode
        for widget in (self, self.header, self.title_lbl, self.filter_cb,
                       self.clear_btn, self.copy_btn, self.log_output):
            widget.setProperty('theme', mode)
            self._repolish(widget)
        self._render()

    def theme_mode(self):
        return self._theme_mode

    def set_view_font_delta(self, delta):
        self.set_view_font_size(self._view_font_size + int(delta))

    def set_view_font_size(self, size):
        self._view_font_size = max(8, min(24, int(size)))
        self.log_output.setFont(QFont('Consolas', self._view_font_size))
        self._render()

    def view_font_size(self):
        return self._view_font_size

    def _repolish(self, widget):
        widget.style().unpolish(widget)
        widget.style().polish(widget)
        widget.update()

    def _on_copy_clicked(self):
        text = self.log_output.toPlainText()
        from PySide2.QtWidgets import QApplication
        QApplication.clipboard().setText(text)

    def save_to_file(self):
        path, _ = QFileDialog.getSaveFileName(self, 'Save log', '', 'Text (*.txt)')
        if path:
            with open(path, 'w', encoding='utf-8') as f:
                f.write(self.log_output.toPlainText())
