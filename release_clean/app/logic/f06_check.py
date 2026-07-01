"""Post-run classification of a Nastran job.

After LSF reports the job DONE we still need to check the .f06 output to know
whether the run finished cleanly or hit a FATAL. This module owns that check.

Layer: pure logic. No PySide2 imports. All paths are Windows paths that point
into the same folder as the input .dat (the user's mounted share of the
Linux run tree).

Contract:
    classify_finished(folder_win, filename) -> ('Complete' | 'Fail' | 'Done', reason)

    'Complete' : .f06 exists AND does not contain 'FATAL' anywhere.
    'Fail'     : .f06 exists AND contains 'FATAL' (case-insensitive).
    'Done'     : .f06 does not exist yet. The output hasn't landed on the share
                 or Nastran hasn't written it. Caller can retry later.
    reason     : human-readable one-liner for the log.
"""

import os


FATAL_TOKEN = 'FATAL'


def _output_path(folder_win, filename, ext):
    """Swap the input .dat extension for the requested one; keep folder."""
    if not folder_win or not filename:
        return ''
    stem, _cur = os.path.splitext(filename)
    return os.path.join(folder_win, f'{stem}{ext}')


def f06_path(folder_win, filename):
    return _output_path(folder_win, filename, '.f06')


def log_path(folder_win, filename):
    return _output_path(folder_win, filename, '.log')


def classify_finished(folder_win, filename):
    """Return (status, reason). See module docstring for status values."""
    path = f06_path(folder_win, filename)
    if not path:
        return 'Done', 'No folder/filename to check'
    if not os.path.isfile(path):
        return 'Done', f'{os.path.basename(path)} not found yet'
    try:
        # Scan in chunks so a huge .f06 doesn't spike memory. FATAL messages
        # in Nastran are ASCII and word-aligned, so a substring match on each
        # chunk is safe — the token can't straddle a chunk boundary if we
        # keep the last N bytes as overlap.
        overlap = len(FATAL_TOKEN)
        tail = b''
        with open(path, 'rb') as fh:
            while True:
                chunk = fh.read(1 << 20)  # 1 MiB
                if not chunk:
                    break
                buf = tail + chunk
                if FATAL_TOKEN.encode('ascii') in buf.upper():
                    return 'Fail', f'FATAL found in {os.path.basename(path)}'
                tail = buf[-overlap:]
    except OSError as e:
        return 'Done', f'Cannot read {os.path.basename(path)}: {e}'
    return 'Complete', f'{os.path.basename(path)} clean'
