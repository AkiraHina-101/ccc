HEREDOC_INPUT_FIELDS = [
    'filename', 'version', 'amls', 'acoustic', 'queue',
]


def build_heredoc_str(folder, filename, solver, version=None, amls=None,
                      acoustic=None, queue=None, sleep=None, field_order=None):
    if isinstance(solver, dict):
        data = solver
        settings = version if isinstance(version, dict) else {}
        solver_name = data.get('solver') or data.get('command') or settings.get('default_solver') or 'nast'
        version = data.get('version', '4')
        amls = data.get('amls', 'n')
        acoustic = data.get('acoustic', 'n')
        queue = data.get('queue', '2')
        sleep = data.get('sleep', '0.5')
        field_order = data.get('field_order') or field_order
        solver = solver_name
    vals = {
        'filename': filename,
        'version': str(version),
        'amls': amls if amls is not None else 'n',
        'acoustic': acoustic if acoustic is not None else 'n',
        'queue': str(queue if queue is not None else '2'),
    }
    order = [k for k in (field_order or HEREDOC_INPUT_FIELDS)
             if k in vals and k != 'solver']
    for k in HEREDOC_INPUT_FIELDS:
        if k not in order:
            order.append(k)
    return "\n".join([
        f"cd {folder.rstrip('/')}",
        f"{solver}<<!",
        *[str(vals[k]) for k in order],
        "!",
        f"sleep {sleep or '0.5'}",
    ])


def build_ttl(server, user, password, heredoc_str):
    pw = password.replace("'", "\\'")
    lines = [
        "; Nastran Submit Macro - auto-generated",
        f"msg = '{server}'",
        "strconcat msg ':22 /ssh /auth=password /user='",
        f"strconcat msg '{user}'",
        "strconcat msg ' /passwd='",
        f"strconcat msg '{pw}'",
        "connect msg", "", "wait '$' '#' '>'", "",
    ]
    for ln in heredoc_str.splitlines():
        lines.append(f"sendln '{ln.replace(chr(39), chr(92)+chr(39))}'")
    lines += ["", "wait '$' '#' '>'"]
    return "\n".join(lines)
