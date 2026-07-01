"""Paramiko-based LSF job status poller.

Runs `bjobs` on the remote host over SSH and returns parsed rows.
Pure logic — no PySide2 imports, no UI.

State mapping (LSF native -> internal canonical):
  PEND, PSUSP                 -> Pending
  RUN, USUSP, SSUSP, PROV     -> Running
  DONE                        -> Done
  EXIT, ZOMBI, UNKWN          -> Error
  anything else               -> raw upper-cased token

We invoke `bjobs -a -w -u <user>` (-a: include finished within history window,
-w: wide / un-truncated, -u: filter to this user). We do not pass -noheader
because some sites' LSF builds reject it; instead we drop the first line
ourselves when it looks like a header.
"""

import socket
import os
import shlex
import json
import subprocess
import sys

from app.data.settings import PROJECT_ROOT


KNOWN_HOSTS_FILE = os.path.join(PROJECT_ROOT, 'nastran_known_hosts')


LSF_STATE_MAP = {
    'PEND':  'Pending',
    'PSUSP': 'Pending',
    'RUN':   'Running',
    'USUSP': 'Running',
    'SSUSP': 'Running',
    'PROV':  'Running',
    'WAIT':  'Pending',
    'DONE':  'Done',
    'EXIT':  'Error',
    'ZOMBI': 'Error',
    'UNKWN': 'Error',
}


class PinningMissingHostKeyPolicy:
    """Trust the first host key, then persist it for future verification.

    This is safer than Paramiko's AutoAddPolicy because keys are written to a
    project-local known_hosts file and later changes are rejected by Paramiko's
    normal host-key checking.
    """

    def missing_host_key(self, client, hostname, key):
        client._host_keys.add(hostname, key.get_name(), key)
        client.save_host_keys(KNOWN_HOSTS_FILE)


def normalize_state(raw):
    """Map an LSF STAT token to one of {Pending,Running,Done,Error} or the raw token."""
    if not raw:
        return 'Pending'
    key = str(raw).strip().upper()
    return LSF_STATE_MAP.get(key, key)


def parse_bjobs(stdout):
    """Parse `bjobs -a -w -u <user>` output.

    Expected columns (LSF default wide format):
        JOBID  USER  STAT  QUEUE  FROM_HOST  EXEC_HOST  JOB_NAME  SUBMIT_TIME

    SUBMIT_TIME itself contains spaces (e.g. "Jun 16 10:23"); JOB_NAME may
    also contain spaces. We split off the first 7 whitespace tokens then
    treat the remainder as a single SUBMIT_TIME string. If JOB_NAME has a
    space, fall back to a 6-token split and merge name + time heuristically
    is not attempted — we accept that JOB_NAME may absorb the leading token
    of the time. Names with spaces are rare and the row is still useful.

    Returns a list of dicts with keys:
        jobid, user, state, queue, from_host, exec_host, name, submit_time, raw_state
    """
    rows = []
    if not stdout:
        return rows

    lines = [ln.rstrip() for ln in stdout.splitlines() if ln.strip()]
    # Drop banner / header / no-job lines.
    filtered = []
    for ln in lines:
        stripped = ln.strip()
        head = stripped.split()[0] if stripped.split() else ''
        if head == 'JOBID':
            continue
        if 'No unfinished job found' in stripped:
            continue
        if 'No job found' in stripped:
            continue
        filtered.append(ln)

    for ln in filtered:
        parts = ln.split(None, 7)
        if len(parts) < 7:
            continue
        jobid_token = parts[0]
        # Real LSF jobid is numeric, or numeric with array index like 123[1].
        # If the first token isn't shaped like a jobid, this line is bjobs
        # usage/help output (or another banner) — skip it.
        jobid_core = jobid_token.split('[', 1)[0]
        if not jobid_core.isdigit():
            continue
        jobid     = parts[0]
        user      = parts[1]
        raw_state = parts[2]
        queue     = parts[3]
        from_host = parts[4]
        exec_host = parts[5]
        name      = parts[6]
        submit_time = parts[7] if len(parts) > 7 else ''
        rows.append({
            'jobid':       jobid,
            'user':        user,
            'state':       normalize_state(raw_state),
            'raw_state':   raw_state.upper(),
            'queue':       queue,
            'from_host':   from_host,
            'exec_host':   exec_host,
            'name':        name,
            'submit_time': submit_time,
        })
    return rows


def parse_bjobs_long(stdout):
    """Parse `bjobs -l [JOBID]` (LSF long/verbose format).

    LSF -l output is a block of `Key <value>[, Key2 <value2>, ...]` pairs
    spread across multiple lines, with occasional free-form lines (resource
    request, execution history). We extract the `Key <value>` pairs into a
    flat dict. Values are stripped; keys are lowercased with spaces replaced
    by underscores so they can be used as row['key_name'].

    Returns list[dict] — one dict per job block found (usually 1 when a single
    JOBID was passed).
    """
    import re
    if not stdout:
        return []

    text = str(stdout).replace('\r\n', '\n')
    # Job blocks start with a line beginning with "Job <"; split on that.
    blocks = re.split(r'\n(?=Job <\d)', text.strip())

    kv_re = re.compile(r'([A-Za-z][A-Za-z0-9 _/\-\.]*?)\s*<([^<>]*)>')

    def _norm_key(k):
        return re.sub(r'[^a-z0-9]+', '_', k.strip().lower()).strip('_')

    rows = []
    for block in blocks:
        if not block.strip():
            continue
        d = {}
        for key, val in kv_re.findall(block):
            nk = _norm_key(key)
            if not nk:
                continue
            # First occurrence wins for repeated keys (LSF prints Status
            # multiple times as job transitions; the first is current).
            if nk not in d:
                d[nk] = val.strip()
        if not d.get('job'):
            continue
        # Copy canonical fields to the same names parse_bjobs uses so callers
        # can merge dicts without special-casing.
        d['jobid'] = d.get('job', '')
        if 'status' in d:
            d['state'] = normalize_state(d['status'])
            d['raw_state'] = d['status'].upper()
        if 'user' not in d and 'user_name' in d:
            d['user'] = d['user_name']
        rows.append(d)
    return rows


def _connect_client(paramiko, host, user, password, port=22, timeout=10):
    client = paramiko.SSHClient()
    if os.path.exists(KNOWN_HOSTS_FILE):
        client.load_host_keys(KNOWN_HOSTS_FILE)
    client.set_missing_host_key_policy(PinningMissingHostKeyPolicy())
    client.connect(
        hostname=host,
        port=int(port or 22),
        username=user,
        password=password or '',
        timeout=timeout,
        banner_timeout=timeout,
        auth_timeout=timeout,
        allow_agent=False,
        look_for_keys=False,
    )
    return client


def _format_command_template(template, host, user, input_value='', selected_jobid=''):
    command = str(template or '')
    command = command.replace('{server}', shlex.quote(str(host or '')))
    command = command.replace('{host}', shlex.quote(str(host or '')))
    command = command.replace('{user}', shlex.quote(str(user or '')))
    command = command.replace('{input}', shlex.quote(str(input_value or '')))
    command = command.replace('{selected_jobid}', shlex.quote(str(selected_jobid or '')))
    return command


def format_ssh_command(command, host, user, input_value='', selected_jobid=''):
    """Return the exact shell command after app placeholders are expanded."""
    return _format_command_template(
        command, host, user, input_value=input_value,
        selected_jobid=selected_jobid).strip()


def run_ssh_command(host, user, password, command, port=22, timeout=30,
                    input_value='', selected_jobid='', python38_exe='',
                    python38_libs=''):
    """Run one configured SSH command and return (stdout, stderr, rc)."""
    if not host:
        raise SSHStatusError('Server host is empty')
    if not user:
        raise SSHStatusError('SSH user is empty')
    cmd = format_ssh_command(
        command, host, user, input_value=input_value,
        selected_jobid=selected_jobid)
    if not cmd:
        raise SSHStatusError('SSH command is empty')
    if python38_exe:
        result = _run_ssh_worker(
            'run_command', python38_exe, python38_libs,
            host=host, user=user, password=password, port=port,
            timeout=timeout, command=command, input_value=input_value,
            selected_jobid=selected_jobid)
        return result.get('stdout', ''), result.get('stderr', ''), int(result.get('rc', 0))
    try:
        import paramiko
    except ImportError as e:
        raise SSHStatusError(f'paramiko not available: {e}')
    try:
        client = _connect_client(paramiko, host, user, password, port=port, timeout=timeout)
    except paramiko.BadHostKeyException:
        raise SSHStatusError(
            f'Host key for {host} changed. Connection blocked; '
            f'check {KNOWN_HOSTS_FILE}.')
    except paramiko.AuthenticationException:
        raise SSHStatusError('Authentication failed (check user/password)')
    except (socket.timeout, socket.gaierror) as e:
        raise SSHStatusError(f'Cannot reach {host}: {e}')
    except paramiko.SSHException as e:
        raise SSHStatusError(f'SSH error: {e}')

    try:
        stdin, stdout, stderr = client.exec_command(cmd, timeout=timeout)
        out = stdout.read().decode('utf-8', errors='replace')
        err = stderr.read().decode('utf-8', errors='replace')
        rc = stdout.channel.recv_exit_status()
        return out, err, rc
    except Exception as e:
        raise SSHStatusError(f'Failed to run command: {e}')
    finally:
        try:
            client.close()
        except Exception:
            pass


def query_bjobs(host, user, password, port=22, timeout=10, command=None,
                python38_exe='', python38_libs=''):
    """Open a Paramiko SSH session, run bjobs, return parsed rows.

    Raises:
        SSHStatusError on connect/auth/command failure with a short message.
    """
    if not host:
        raise SSHStatusError('Server host is empty')
    if not user:
        raise SSHStatusError('SSH user is empty')

    if python38_exe:
        result = _run_ssh_worker(
            'query_bjobs', python38_exe, python38_libs,
            host=host, user=user, password=password, port=port,
            timeout=timeout, command=command)
        return result.get('rows') or []

    try:
        import paramiko
    except ImportError as e:
        raise SSHStatusError(f'paramiko not available: {e}')

    cmd = command or 'bjobs -u {user}'
    cmd = _format_command_template(cmd, host, user)

    try:
        client = _connect_client(paramiko, host, user, password, port=port, timeout=timeout)
    except paramiko.BadHostKeyException:
        raise SSHStatusError(
            f'Host key for {host} changed. Connection blocked; '
            f'check {KNOWN_HOSTS_FILE}.')
    except paramiko.AuthenticationException:
        raise SSHStatusError('Authentication failed (check user/password)')
    except (socket.timeout, socket.gaierror) as e:
        raise SSHStatusError(f'Cannot reach {host}: {e}')
    except paramiko.SSHException as e:
        raise SSHStatusError(f'SSH error: {e}')

    try:
        stdin, stdout, stderr = client.exec_command(cmd, timeout=timeout)
        out = stdout.read().decode('utf-8', errors='replace')
        err = stderr.read().decode('utf-8', errors='replace')
        rc = stdout.channel.recv_exit_status()
    except Exception as e:
        client.close()
        raise SSHStatusError(f'Failed to run bjobs: {e}')
    finally:
        try:
            client.close()
        except Exception:
            pass

    if rc != 0 and not out.strip():
        msg = err.strip() or f'bjobs exited {rc}'
        raise SSHStatusError(msg)

    return parse_bjobs(out)


class SSHStatusError(Exception):
    """Raised when bjobs query fails (connect, auth, or command error)."""
    pass


def _run_ssh_worker(action, python38_exe, python38_libs='', **payload):
    """Run SSH work in a separate Python 3.8 process.

    This lets the main UI run on another Python version while Paramiko and its
    native dependencies stay isolated in the Python 3.8 process.
    """
    exe = str(python38_exe or '').strip().strip('"')
    if not exe:
        raise SSHStatusError('PYTHON38_EXE is empty')
    if not os.path.isfile(exe):
        raise SSHStatusError(f'PYTHON38_EXE not found: {exe}')

    worker = os.path.join(os.path.dirname(__file__), 'ssh_worker_py38.py')
    env = os.environ.copy()
    py_path = [PROJECT_ROOT]
    libs = str(python38_libs or '').strip().strip('"')
    if libs:
        if not os.path.isdir(libs):
            raise SSHStatusError(f'PYTHON38_LIBS not found: {libs}')
        py_path.insert(0, libs)
    if env.get('PYTHONPATH'):
        py_path.append(env['PYTHONPATH'])
    env['PYTHONPATH'] = os.pathsep.join(py_path)

    data = dict(payload)
    data['action'] = action
    data['known_hosts_file'] = KNOWN_HOSTS_FILE
    try:
        proc = subprocess.run(
            [exe, worker],
            input=json.dumps(data),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding='utf-8',
            errors='replace',
            cwd=PROJECT_ROOT,
            env=env,
            timeout=max(int(payload.get('timeout') or 10) + 15, 30),
        )
    except subprocess.TimeoutExpired:
        raise SSHStatusError('Python 3.8 SSH worker timed out')
    except OSError as e:
        raise SSHStatusError(f'Cannot start Python 3.8 SSH worker: {e}')

    if proc.returncode != 0 and not proc.stdout.strip():
        msg = proc.stderr.strip() or f'Python 3.8 SSH worker exited {proc.returncode}'
        raise SSHStatusError(msg)

    try:
        result = json.loads(proc.stdout.strip() or '{}')
    except ValueError:
        detail = proc.stderr.strip() or proc.stdout.strip()
        raise SSHStatusError(f'Invalid Python 3.8 SSH worker output: {detail}')

    if not result.get('ok'):
        raise SSHStatusError(str(result.get('error') or 'Python 3.8 SSH worker failed'))
    return result


def _worker_main():
    """Entry point for ssh_worker_py38.py."""
    payload = json.loads(sys.stdin.read() or '{}')
    action = payload.get('action')
    global KNOWN_HOSTS_FILE
    if payload.get('known_hosts_file'):
        KNOWN_HOSTS_FILE = str(payload.get('known_hosts_file'))

    host = payload.get('host') or ''
    user = payload.get('user') or ''
    password = payload.get('password') or ''
    port = int(payload.get('port') or 22)
    timeout = int(payload.get('timeout') or 10)

    if action == 'query_bjobs':
        rows = query_bjobs(
            host, user, password, port=port, timeout=timeout,
            command=payload.get('command'), python38_exe='')
        return {'ok': True, 'rows': rows}

    if action == 'run_command':
        out, err, rc = run_ssh_command(
            host, user, password, payload.get('command') or '',
            port=port, timeout=timeout,
            input_value=payload.get('input_value') or '',
            selected_jobid=payload.get('selected_jobid') or '',
            python38_exe='')
        return {'ok': True, 'stdout': out, 'stderr': err, 'rc': rc}

    raise SSHStatusError(f'Unknown SSH worker action: {action}')


if __name__ == '__main__':
    try:
        print(json.dumps(_worker_main()))
    except Exception as e:
        print(json.dumps({'ok': False, 'error': str(e)}))
        sys.exit(1)
