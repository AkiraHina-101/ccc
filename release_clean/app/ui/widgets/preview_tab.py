from PySide2.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QLabel, QPlainTextEdit, QPushButton, QSizePolicy,
)
from PySide2.QtGui import QFont, QTextCharFormat, QColor, QTextCursor, QTextDocument
from PySide2.QtCore import Qt

from app.data.settings import NASTRAN_KW

_PREVIEW_MAXLINE = 600

COLORS = {
    'dark': {
        'lnum':    '#AAB6C5',
        'comment': '#7EE787',
        'keyword': '#8AB4FF',
        'default': '#F8FAFC',
    },
    'light': {
        'lnum':    '#4B5563',
        'comment': '#1A7F37',
        'keyword': '#0969DA',
        'default': '#111827',
    },
}


class PreviewTab(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._loaded_path = ''
        self._theme_mode = 'dark'
        self._view_mode = 'message'
        self._message_text = '(no file selected)'
        self._preview_lines = []
        self._heredoc_text = ''
        self._view_font_size = 10
        self._init_ui()
        self.set_theme_mode('dark')

    def _init_ui(self):
        self.setObjectName('previewTab')
        self.setAttribute(Qt.WA_StyledBackground, True)
        self._layout_main = QVBoxLayout(self)
        self._layout_main.setContentsMargins(0, 0, 0, 0)
        self._layout_main.setSpacing(0)

        # Header
        self.header = QWidget()
        self.header.setObjectName('previewHeader')
        self.header.setAttribute(Qt.WA_StyledBackground, True)
        self.header.setFixedHeight(32)
        header_layout = QHBoxLayout(self.header)
        header_layout.setContentsMargins(8, 0, 8, 0)

        self.title_lbl = QLabel('(no file selected)')
        self.title_lbl.setProperty('role', 'accent')
        self.title_lbl.setFont(QFont('Consolas', 9))
        header_layout.addWidget(self.title_lbl, stretch=1)

        self.info_lbl = QLabel('')
        self.info_lbl.setProperty('role', 'dim')
        self.info_lbl.setFont(QFont('Segoe UI', 8))
        header_layout.addWidget(self.info_lbl)

        # "Next FATAL" — only visible when a .f06 is being previewed. Jumps
        # the cursor to the next case-insensitive match of FATAL and scrolls
        # it into view. Wraps around at end of file.
        self.next_fatal_btn = QPushButton('Next FATAL')
        self.next_fatal_btn.setObjectName('previewNextFatalBtn')
        self.next_fatal_btn.setToolTip('Jump to the next FATAL occurrence (wraps at end)')
        self.next_fatal_btn.setVisible(False)
        self.next_fatal_btn.clicked.connect(self._on_next_fatal)
        header_layout.addWidget(self.next_fatal_btn)

        self._layout_main.addWidget(self.header)

        # Content
        self.text_view = QPlainTextEdit()
        self.text_view.setObjectName('previewText')
        self.text_view.setReadOnly(True)
        self.text_view.setFont(QFont('Consolas', self._view_font_size))
        self.text_view.setLineWrapMode(QPlainTextEdit.NoWrap)
        self.text_view.setMinimumWidth(0)
        self.text_view.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        self._layout_main.addWidget(self.text_view)

        self.setLayout(self._layout_main)

    def load_file(self, win_folder, filename):
        import os
        fpath = os.path.join(win_folder, filename) if win_folder and filename else ''
        if fpath and fpath == self._loaded_path:
            return

        self.title_lbl.setText(filename or '(no file selected)')
        self.info_lbl.setText('')

        if not fpath:
            self._show_message('(no file selected)')
            self._loaded_path = ''
            return

        try:
            with open(fpath, 'r', encoding='utf-8', errors='replace') as fh:
                all_lines = fh.readlines()
        except Exception as ex:
            self._show_message(f'Cannot read:\n{ex}')
            self._loaded_path = fpath
            return

        self._loaded_path = fpath
        total = len(all_lines)
        self._preview_lines = all_lines[:_PREVIEW_MAXLINE]
        shown = len(self._preview_lines)
        suffix = f'  (showing {shown}/{total})' if total > shown else ''
        self.info_lbl.setText(f'{total} lines{suffix}')
        self._view_mode = 'file'
        # Only expose "Next FATAL" when the file could plausibly have one —
        # currently that means .f06 (Nastran result deck). Extend the tuple
        # if other output formats gain the same convention.
        is_f06 = fpath.lower().endswith('.f06')
        self.next_fatal_btn.setVisible(is_f06)
        self._render_file_lines()

    def _render_file_lines(self):
        self.text_view.clear()
        cursor = self.text_view.textCursor()
        for i, line in enumerate(self._preview_lines, 1):
            self._insert_line(cursor, i, line.rstrip('\n'))
        self.text_view.setTextCursor(cursor)
        self.text_view.moveCursor(self.text_view.textCursor().Start)

    def show_heredoc(self, text):
        self.title_lbl.setText('generated submit script (.sh preview)')
        self._heredoc_text = text
        self._view_mode = 'heredoc'
        lines = self._heredoc_text.splitlines()
        self.info_lbl.setText(f'{len(lines)} lines')
        self._loaded_path = ''
        self.next_fatal_btn.setVisible(False)
        self._render_heredoc()

    def _on_next_fatal(self):
        """Move the cursor to the next case-insensitive `FATAL` match.

        Uses QTextEdit.find() which advances from the current cursor position;
        when the search fails we reset to the top of the document and try
        again so the button wraps around instead of getting stuck at EOF.
        """
        flags = QTextDocument.FindFlag(0)  # case-insensitive (no CaseSensitive bit)
        found = self.text_view.find('FATAL', flags)
        if not found:
            cursor = self.text_view.textCursor()
            cursor.movePosition(QTextCursor.Start)
            self.text_view.setTextCursor(cursor)
            found = self.text_view.find('FATAL', flags)
        if found:
            self.text_view.ensureCursorVisible()
            self.info_lbl.setText(self.info_lbl.text().split('  ·')[0] + '  · FATAL match')
        else:
            self.info_lbl.setText(self.info_lbl.text().split('  ·')[0] + '  · no FATAL')

    def _render_heredoc(self):
        lines = self._heredoc_text.splitlines()
        self.text_view.clear()
        cursor = self.text_view.textCursor()
        colors = COLORS[self._theme_mode]
        for i, line in enumerate(lines, 1):
            fmt_lnum = QTextCharFormat()
            fmt_lnum.setForeground(QColor(colors['lnum']))
            cursor.insertText(f'{i:5d} | ', fmt_lnum)
            tag = 'comment' if line.lstrip().startswith('#') else 'keyword'
            fmt = QTextCharFormat()
            fmt.setForeground(QColor(colors[tag]))
            cursor.insertText(line + '\n', fmt)
        self.text_view.setTextCursor(cursor)

    def _show_message(self, msg):
        self._view_mode = 'message'
        self._message_text = msg
        self.next_fatal_btn.setVisible(False)
        self.text_view.clear()
        cursor = self.text_view.textCursor()
        fmt = QTextCharFormat()
        fmt.setForeground(QColor(COLORS[self._theme_mode]['comment']))
        cursor.insertText(msg, fmt)
        self.text_view.setTextCursor(cursor)

    def _insert_line(self, cursor, lineno, text):
        colors = COLORS[self._theme_mode]
        fmt_lnum = QTextCharFormat()
        fmt_lnum.setForeground(QColor(colors['lnum']))
        cursor.insertText(f'{lineno:5d} | ', fmt_lnum)

        stripped = text.lstrip()
        if stripped.startswith('$'):
            fmt = QTextCharFormat()
            fmt.setForeground(QColor(colors['comment']))
            cursor.insertText(text + '\n', fmt)
        else:
            first = stripped.split()[0].upper() if stripped.split() else ''
            color = colors['keyword'] if first in NASTRAN_KW else colors['default']
            fmt = QTextCharFormat()
            fmt.setForeground(QColor(color))
            cursor.insertText(text + '\n', fmt)

    def set_theme_mode(self, mode):
        if mode not in ('dark', 'light'):
            return
        self._theme_mode = mode
        for widget in (self, self.header, self.title_lbl, self.info_lbl, self.text_view):
            widget.setProperty('theme', mode)
            self._repolish(widget)
        if self._view_mode == 'file':
            self._render_file_lines()
        elif self._view_mode == 'heredoc':
            self._render_heredoc()
        else:
            self._show_message(self._message_text)

    def theme_mode(self):
        return self._theme_mode

    def set_view_font_delta(self, delta):
        self.set_view_font_size(self._view_font_size + int(delta))

    def set_view_font_size(self, size):
        self._view_font_size = max(8, min(24, int(size)))
        self.text_view.setFont(QFont('Consolas', self._view_font_size))
        if self._view_mode == 'file':
            self._render_file_lines()
        elif self._view_mode == 'heredoc':
            self._render_heredoc()
        else:
            self._show_message(self._message_text)

    def view_font_size(self):
        return self._view_font_size

    def _repolish(self, widget):
        widget.style().unpolish(widget)
        widget.style().polish(widget)
        widget.update()
