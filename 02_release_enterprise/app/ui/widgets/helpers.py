"""Shared helper widgets used by the Phase B master-detail UI.

Defined here so multiple screens (sidebar, detail panel, cards) share one
implementation. No business logic - pure presentation.
"""

from PySide2.QtWidgets import (
    QWidget, QFrame, QHBoxLayout, QLabel, QPushButton, QVBoxLayout,
    QGraphicsOpacityEffect,
)
from PySide2.QtGui import QPainter, QColor
from PySide2.QtCore import Qt, QPropertyAnimation, QEasingCurve


STATUS_COLORS = {
    "pending": "#6B7280",
    "queued":  "#2563EB",
    "running": "#D97706",
    "done":    "#16A34A",
    "error":   "#DC2626",
}

ACCENT_COLORS = {
    "single": "#1469C2",
    "folder": "#1A8050",
    "multi":  "#B06000",
}


def set_qt_property(widget, **props):
    """Set one or more dynamic properties and re-polish the widget."""
    for key, val in props.items():
        widget.setProperty(key, val)
    style = widget.style()
    style.unpolish(widget)
    style.polish(widget)
    widget.update()


class StatusDot(QWidget):
    """Painted circle dot with blink animation for 'running' status."""

    def __init__(self, status: str = "pending", size: int = 8, parent=None):
        super().__init__(parent)
        self._status = status
        self._size = size
        self.setFixedSize(size + 4, size + 4)

        self._effect = QGraphicsOpacityEffect(self)
        self._effect.setOpacity(1.0)
        self.setGraphicsEffect(self._effect)

        self._anim = QPropertyAnimation(self._effect, b"opacity", self)
        self._anim.setDuration(1400)
        self._anim.setStartValue(1.0)
        self._anim.setKeyValueAt(0.5, 0.25)
        self._anim.setEndValue(1.0)
        self._anim.setEasingCurve(QEasingCurve.InOutSine)
        self._anim.setLoopCount(-1)

        if status == "running":
            self._anim.start()

    def status(self) -> str:
        return self._status

    def set_status(self, status: str):
        self._status = status
        if status == "running":
            self._anim.start()
        else:
            self._anim.stop()
            self._effect.setOpacity(1.0)
        self.update()

    def is_blinking(self) -> bool:
        return self._anim.state() == QPropertyAnimation.Running

    def paintEvent(self, event):
        p = QPainter(self)
        p.setRenderHint(QPainter.Antialiasing)
        color = QColor(STATUS_COLORS.get(self._status, "#6B7280"))
        p.setBrush(color)
        p.setPen(Qt.NoPen)
        offset = 2
        p.drawEllipse(offset, offset, self._size, self._size)


class SectionLabel(QLabel):
    """11px/700 uppercase section header."""

    def __init__(self, text: str, parent=None):
        super().__init__(text.upper(), parent)
        self.setObjectName("sectionLabel")
        self.setStyleSheet(
            "font-size: 11px; font-weight:bold; color:#6B7280; "
            "letter-spacing:0.07em; background:transparent;"
        )


class ElidedLabel(QLabel):
    """QLabel that elides its text when it doesn't fit the available width.

    Default elide mode is `Qt.ElideLeft` - keeps the END of the string visible
    (used for folder paths in the sidebar so the user always sees the basename).
    The full text is preserved in `text()` and exposed as a tooltip.
    """

    def __init__(self, text: str = "", elide_mode=Qt.ElideLeft, parent=None):
        super().__init__(parent)
        self._full_text = text
        self._elide_mode = elide_mode
        self.setMinimumWidth(0)
        self.setToolTip(text)
        super().setText(text)

    def setText(self, text: str):
        self._full_text = text or ""
        self.setToolTip(self._full_text)
        self._render_elided()

    def text(self) -> str:
        return self._full_text

    def set_elide_mode(self, mode):
        self._elide_mode = mode
        self._render_elided()

    def resizeEvent(self, event):
        super().resizeEvent(event)
        self._render_elided()

    def _render_elided(self):
        if not self._full_text:
            super().setText("")
            return
        avail = max(0, self.width() - 4)
        elided = self.fontMetrics().elidedText(
            self._full_text, self._elide_mode, avail)
        super().setText(elided)


class PresetChip(QFrame):
    """Compact preset summary: name | divider | summary | Change button."""

    def __init__(self, preset_name: str, summary: str, job_type: str = "single", parent=None):
        super().__init__(parent)
        self.setObjectName("presetChip")
        self.setProperty("job_type", job_type)
        self.setFixedHeight(36)

        layout = QHBoxLayout(self)
        layout.setContentsMargins(10, 5, 10, 5)
        layout.setSpacing(6)

        accent = ACCENT_COLORS.get(job_type, "#1469C2")

        self.name_label = QLabel(preset_name)
        self.name_label.setStyleSheet(
            f"font-size: 11px; font-weight:bold; color:{accent}; background:transparent;"
        )
        layout.addWidget(self.name_label)

        sep = QFrame()
        sep.setFrameShape(QFrame.VLine)
        sep.setFixedWidth(1)
        sep.setStyleSheet("background: rgba(0,0,0,0.15); border:none;")
        layout.addWidget(sep)

        self.summary_label = QLabel(summary)
        self.summary_label.setStyleSheet(
            "font-size: 11px; color:#374151; "
            "font-family:Consolas,'Courier New',monospace; background:transparent;"
        )
        layout.addWidget(self.summary_label, 1)

        self.change_btn = QPushButton("Change")
        self.change_btn.setObjectName("changePresetBtn")
        self.change_btn.setFixedHeight(22)
        layout.addWidget(self.change_btn)

    def update_preset(self, name: str, summary: str):
        self.name_label.setText(name)
        self.summary_label.setText(summary)

    def set_job_type(self, job_type: str):
        set_qt_property(self, job_type=job_type)
        accent = ACCENT_COLORS.get(job_type, "#1469C2")
        self.name_label.setStyleSheet(
            f"font-size: 11px; font-weight:bold; color:{accent}; background:transparent;"
        )


class KVRow(QWidget):
    """One row of a key-value table: label cell | value widget."""

    def __init__(self, key: str, value_widget: QWidget,
                 border_bottom: bool = True, parent=None):
        super().__init__(parent)
        self.setMinimumHeight(32)
        self._layout = QHBoxLayout(self)
        self._layout.setContentsMargins(0, 0, 0, 0)
        self._layout.setSpacing(0)

        self.key_cell = QWidget()
        self.key_cell.setObjectName("kvKeyCell")
        self.key_cell.setFixedWidth(96)
        kl = QHBoxLayout(self.key_cell)
        kl.setContentsMargins(10, 0, 10, 0)
        self.key_label = QLabel(key)
        self.key_label.setStyleSheet(
            "font-family:Consolas,'Courier New',monospace; "
            "font-size: 11px; color:#4B5768;"
        )
        kl.addWidget(self.key_label)
        self._layout.addWidget(self.key_cell)

        self.val_cell = QWidget()
        self.val_cell.setObjectName("kvValueCell")
        vl = QHBoxLayout(self.val_cell)
        vl.setContentsMargins(6, 3, 6, 3)
        vl.addWidget(value_widget)
        self.value_widget = value_widget
        self._layout.addWidget(self.val_cell, 1)

        if border_bottom:
            self.setStyleSheet("border-bottom: 1px solid #E8EBF2;")


class KVTable(QFrame):
    """Vertical stack of KVRow - replacement for the old SettingsStrip."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setObjectName("kvTable")
        self._layout = QVBoxLayout(self)
        self._layout.setContentsMargins(0, 0, 0, 0)
        self._layout.setSpacing(0)
        self._rows = []

    def add_row(self, key: str, value_widget: QWidget, border_bottom: bool = True) -> KVRow:
        row = KVRow(key, value_widget, border_bottom=border_bottom, parent=self)
        self._layout.addWidget(row)
        self._rows.append(row)
        return row

    def clear(self):
        for row in self._rows:
            row.setParent(None)
            row.deleteLater()
        self._rows = []

    def row_count(self) -> int:
        return len(self._rows)
