import json
import os
import shutil


# Populated by callers (load_settings, load_presets) when a config file
# exists but fails to parse. MainWindow reads this on startup to show a
# warning dialog instead of letting the user wonder why everything reset.
load_errors = []


class JSONLoadError(Exception):
    """Raised when a JSON file exists but cannot be parsed.

    Carries the original path and a short reason so the caller can decide
    whether to abort, ask the user, or fall back to an empty config.
    """

    def __init__(self, path, reason):
        super().__init__(f'{path}: {reason}')
        self.path = path
        self.reason = reason


def load_json(path, strict=False):
    """Load JSON file at `path`.

    Returns {} if the file does not exist.

    If the file exists but parsing fails:
      - strict=True  -> raise JSONLoadError so the caller can warn the user.
      - strict=False -> raise JSONLoadError unless a sibling `.bak` exists,
                       in which case the .bak is tried as a fallback.

    The previous behaviour was to silently swallow all exceptions and return
    {}, which masked corrupt configs and looked like a reset.
    """
    if not os.path.exists(path):
        return {}
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except (OSError, json.JSONDecodeError, UnicodeDecodeError) as e:
        bak = path + '.bak'
        if not strict and os.path.exists(bak):
            try:
                with open(bak, 'r', encoding='utf-8') as f:
                    return json.load(f)
            except Exception:
                pass
        raise JSONLoadError(path, str(e))


def save_json(path, data):
    """Atomically write `data` as JSON to `path`.

    Writes to `<path>.tmp` first, fsyncs, then os.replace() to the final
    path. A crash mid-write therefore leaves either the old file intact or
    the new file complete -- never a half-written file.

    Also keeps a `<path>.bak` snapshot of the previous good content so a
    corrupt write (e.g. disk full, antivirus interfering) does not lose
    everything.
    """
    tmp = path + '.tmp'
    bak = path + '.bak'
    with open(tmp, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        f.flush()
        try:
            os.fsync(f.fileno())
        except OSError:
            pass
    if os.path.exists(path):
        try:
            shutil.copyfile(path, bak)
        except OSError:
            pass
    os.replace(tmp, path)
