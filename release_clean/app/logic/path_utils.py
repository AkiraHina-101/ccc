import os


def to_linux(win_path, prefix):
    p = win_path.replace('\\', '/')
    pfx = prefix.replace('\\', '/').rstrip('/')
    if pfx and p.lower().startswith(pfx.lower()):
        p = p[len(pfx):]
    elif p.startswith('//'):
        parts = p.lstrip('/').split('/', 1)
        p = parts[1] if len(parts) > 1 else ''
    return '/' + p.lstrip('/')


def list_dat(win_path):
    try:
        return sorted([
            f for f in os.listdir(win_path)
            if f.lower().endswith(('.dat', '.bdf', '.nas', '.inp'))
        ])
    except Exception:
        return []
