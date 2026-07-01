import os

from PySide2.QtCore import QThread, Signal

from app.logic.heredoc import build_heredoc_str
from app.logic.ssh_status import (
    query_bjobs, run_ssh_command, parse_bjobs, format_ssh_command, SSHStatusError,
)


class SubmitWorker(QThread):
    log_line = Signal(str, str)   # message, tag
    job_done = Signal(dict)       # updated job data dict

    def __init__(self, job_data: dict, settings: dict, registry, parent=None):
        super().__init__(parent)
        self._data = dict(job_data)
        self._s = settings
        self._registry = registry

    def run(self):
        folder = self._data.get('folder_linux', '')
        filename = self._data.get('filename', '')
        uid = self._data.get('uid', '?')

        if not folder or not filename:
            self.log_line.emit(f'[WARN]  #{uid}: folder or filename missing — skipped.', 'warn')
            self._data['status'] = 'Error'
            self.job_done.emit(self._data)
            return

        try:
            heredoc = build_heredoc_str(
                folder, filename,
                self._data.get('solver', self._data.get('command', 'nast')),
                self._data.get('version', '4'),
                self._data.get('amls', 'n'),
                self._data.get('acoustic', 'n'),
                self._data.get('queue', '2'),
                self._data.get('sleep', '0.5'),
            )

            server = self._s.get('server', '')
            if not server:
                raise ValueError('Settings -> Server is not configured.')

            was_alive = self._registry.is_alive(server)
            self._registry.ensure_session(self._s)
            job_path = self._registry.enqueue(server, heredoc)

            note = 'reused TeraTerm' if was_alive else f'opened TeraTerm for {server}'
            self.log_line.emit(
                f'[OK]    #{uid} {filename}  queued → {os.path.basename(job_path)} ({note})',
                'ok')
            self._data['submitted'] = True
            # Status stays 'Upload' until bjobs surfaces the JOBID. Setting
            # 'Running' here would be wrong: TeraTerm has only enqueued the
            # heredoc; the server still needs to upload + bsub.
            self._data['status'] = 'Upload'

        except Exception as e:
            self.log_line.emit(f'[ERR]   #{uid} {filename}: {e}', 'err')
            self._data['status'] = 'Error'

        self.job_done.emit(self._data)


class BjobsPoller(QThread):
    """Periodically SSH into the configured server and run bjobs.

    Emits rows_updated(list) on each successful poll and error_occurred(str) on
    connect/auth/command failure. Stop with stop() — sets a flag and wakes the
    sleep so the thread exits within ~1s.
    """

    rows_updated = Signal(list)
    error_occurred = Signal(str)
    state_changed = Signal(str)  # 'polling' | 'idle' | 'error' | 'stopped'

    def __init__(self, settings_provider, interval_sec=5, parent=None):
        super().__init__(parent)
        self._get_settings = settings_provider
        self._interval = max(1, int(interval_sec))
        self._stop = False

    def set_interval(self, seconds):
        self._interval = max(1, int(seconds))

    def stop(self):
        self._stop = True

    def run(self):
        while not self._stop:
            s = {}
            try:
                s = self._get_settings() or {}
            except Exception:
                s = {}
            host = s.get('server', '')
            user = s.get('user', '')
            password = s.get('password', '')
            if not host or not user:
                self.state_changed.emit('idle')
                self._sleep_with_stop(self._interval)
                continue

            self.state_changed.emit('polling')
            try:
                rows = query_bjobs(host, user, password)
                self.rows_updated.emit(rows)
                self.state_changed.emit('polling')
            except SSHStatusError as e:
                self.error_occurred.emit(str(e))
                self.state_changed.emit('error')

            self._sleep_with_stop(self._interval)
        self.state_changed.emit('stopped')

    def _sleep_with_stop(self, seconds):
        """Sleep `seconds` but wake within 250ms if stop() is called."""
        ticks = max(1, int(seconds * 4))
        for _ in range(ticks):
            if self._stop:
                return
            self.msleep(250)


class SSHCommandWorker(QThread):
    command_done = Signal(str, str, str, list)  # label, command, output, parsed rows
    command_failed = Signal(str, str)           # label, error

    def __init__(self, settings, command_def, parent=None):
        super().__init__(parent)
        self._settings = dict(settings or {})
        self._command_def = dict(command_def or {})

    def run(self):
        label = str(self._command_def.get('label') or 'SSH command')
        template = str(self._command_def.get('command') or '')
        host = self._settings.get('server', '')
        user = self._settings.get('user', '')
        password = self._settings.get('password', '')
        try:
            expanded = format_ssh_command(
                template, host, user,
                input_value=self._command_def.get('input_value', ''),
                selected_jobid=self._command_def.get('selected_jobid', ''))
            out, err, rc = run_ssh_command(
                host, user, password, template,
                input_value=self._command_def.get('input_value', ''),
                selected_jobid=self._command_def.get('selected_jobid', ''))
            text = out
            if err.strip():
                text = (text + '\n' if text else '') + err
            if rc != 0:
                text = (text + '\n' if text else '') + f'[exit {rc}]'
            rows = parse_bjobs(out) if template.strip().startswith('bjobs') else []
            self.command_done.emit(label, expanded, text, rows)
        except SSHStatusError as e:
            self.command_failed.emit(label, str(e))
