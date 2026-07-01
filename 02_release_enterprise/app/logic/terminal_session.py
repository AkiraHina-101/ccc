"""Manage per-server TeraTerm listener sessions.

Model:
- Each server has one TeraTerm window running a looping macro listener.
- The listener polls the queue dir, reads `*.job` files, sends them, deletes
  the file, and repeats.
- App side writes heredoc text to the queue. A listener lock with heartbeat
  lets app restarts reuse an already-open TeraTerm window.
"""

import json
import os
import re
import subprocess
import tempfile
import time


LOCK_FILENAME = 'listener.lock'
LOCK_FRESH_SECONDS = 10


def _slug(s):
    return re.sub(r'[^A-Za-z0-9_.-]+', '_', str(s)).strip('_') or 'unknown'


def _lock_path(queue_dir):
    return os.path.join(queue_dir, LOCK_FILENAME)


def _read_fresh_lock(queue_dir, now=None):
    """Return lock data when queue_dir has a fresh listener heartbeat."""
    path = _lock_path(queue_dir)
    if now is None:
        now = time.time()
    try:
        with open(path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        heartbeat = float(data.get('heartbeat', 0))
    except Exception:
        return None
    if now - heartbeat <= LOCK_FRESH_SECONDS:
        return data
    return None


def _write_lock(queue_dir, pid=0, now=None):
    os.makedirs(queue_dir, exist_ok=True)
    if now is None:
        now = time.time()
    path = _lock_path(queue_dir)
    tmp = path + '.tmp'
    with open(tmp, 'w', encoding='utf-8') as f:
        json.dump({'pid': int(pid or 0), 'heartbeat': float(now)}, f)
    os.replace(tmp, path)
    return path


def build_listener_ttl(server, user, password, queue_dir):
    """Generate TTL macro that connects then loops polling the queue."""
    pw = str(password).replace("'", "\\'")
    qd = str(queue_dir).replace('\\', '\\\\')
    lock = str(_lock_path(queue_dir)).replace('\\', '\\\\')
    pattern = qd + '\\\\*.job'
    return "\n".join([
        '; Nastran Submitter listener - auto-generated',
        f'; Server: {server}',
        '',
        f"msg = '{server}'",
        "strconcat msg ':22 /ssh /auth=password /user='",
        f"strconcat msg '{user}'",
        "strconcat msg ' /passwd='",
        f"strconcat msg '{pw}'",
        'connect msg',
        '',
        f"settitle 'Nastran Submit - {server}'",
        "wait '$' '#' '>'",
        '',
        ':mainloop',
        "  gettime hb '%s'",
        f"  fileopen lockfh '{lock}' 1",
        '  sprintf2 lockline \'{"pid":0,"heartbeat":%s}\' hb',
        '  filewriteln lockfh lockline',
        '  fileclose lockfh',
        '',
        f"  findfirst dh '{pattern}' fname",
        '  if dh < 0 then',
        '    mpause 300',
        '    goto mainloop',
        '  endif',
        '  findclose dh',
        '',
        f"  sprintf2 jobpath '{qd}\\\\%s' fname",
        '  fileopen fh jobpath 0',
        '  :sendloop',
        '    filereadln fh line',
        '    if result <> 0 goto senddone',
        '    sendln line',
        '    goto sendloop',
        '  :senddone',
        '  fileclose fh',
        '',
        "  wait '$' '#' '>'",
        '  filedelete jobpath',
        '',
        '  goto mainloop',
        '',
    ])


class TerminalRegistry:
    """Track one TeraTerm listener per server. Reuse it on the next submit."""

    def __init__(self):
        # server -> {'popen', 'queue_dir', 'next_seq', 'external'}
        self._sessions = {}

    def is_alive(self, server):
        s = self._sessions.get(server)
        if not s:
            return False
        popen = s.get('popen')
        if popen is None:
            if _read_fresh_lock(s['queue_dir']):
                return True
            del self._sessions[server]
            return False
        if popen.poll() is not None:
            if _read_fresh_lock(s['queue_dir']):
                s['popen'] = None
                s['external'] = True
                return True
            del self._sessions[server]
            return False
        return True

    def ensure_session(self, settings, popen_factory=subprocess.Popen):
        """Ensure a listener exists for settings['server']. Returns queue_dir."""
        server = settings.get('server', '')
        if not server:
            raise ValueError('Settings.server is empty')
        if self.is_alive(server):
            return self._sessions[server]['queue_dir']

        ttmacro = settings.get('ttmacro_path', '')
        if not os.path.isfile(ttmacro):
            raise FileNotFoundError(f'ttpmacro.exe not found: {ttmacro}')

        queue_dir = os.path.join(tempfile.gettempdir(), f'nastran_q_{_slug(server)}')
        os.makedirs(queue_dir, exist_ok=True)
        if _read_fresh_lock(queue_dir):
            self._sessions[server] = {
                'popen': None,
                'queue_dir': queue_dir,
                'next_seq': 1,
                'external': True,
            }
            return queue_dir

        ttl_path = os.path.join(queue_dir, 'listener.ttl')
        ttl = build_listener_ttl(
            server,
            settings.get('user', ''),
            settings.get('password', ''),
            queue_dir,
        )
        with open(ttl_path, 'w', encoding='utf-8') as f:
            f.write(ttl)

        popen = popen_factory([ttmacro, ttl_path])
        _write_lock(queue_dir, getattr(popen, 'pid', 0))
        self._sessions[server] = {
            'popen': popen,
            'queue_dir': queue_dir,
            'next_seq': 1,
            'external': False,
        }
        return queue_dir

    def enqueue(self, server, heredoc_text):
        """Atomically write a numbered job file into queue_dir. Returns the file path."""
        s = self._sessions.get(server)
        if not s:
            raise RuntimeError(f'No active session for server {server!r}')
        seq = s['next_seq']
        s['next_seq'] = seq + 1
        path = os.path.join(s['queue_dir'], f'{seq:06d}.job')
        tmp = path + '.tmp'
        with open(tmp, 'w', encoding='utf-8') as f:
            f.write(heredoc_text)
        os.replace(tmp, path)
        return path

    def cleanup(self):
        """Terminate listeners owned by this app and leave external ones alone."""
        for entry in list(self._sessions.values()):
            if entry.get('external'):
                continue
            try:
                entry['popen'].terminate()
            except Exception:
                pass
            try:
                os.remove(_lock_path(entry['queue_dir']))
            except OSError:
                pass
        self._sessions.clear()
