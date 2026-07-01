import os
from app.data.json_io import load_json, save_json, JSONLoadError, load_errors

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SETTINGS_FILE    = os.path.join(PROJECT_ROOT, 'nastran_settings.json')
PRESETS_FILE     = os.path.join(PROJECT_ROOT, 'nastran_presets.json')
QUEUE_CACHE_FILE = os.path.join(PROJECT_ROOT, 'nastran_queue_cache.json')
TTL_FILE         = os.path.join(PROJECT_ROOT, 'ssh2login.ttl')

DEFAULT_VERSIONS = [
    "1  nastran v2014.0_i8", "2  nastran v2017.1.2",
    "3  nastran v2018.2.1",  "4  nastran v2019.1",
    "5  nastran v2021.2",
]
DEFAULT_QUEUES = [
    "1  nast16m - large   no-limit  16core",
    "2  nast16  - middle  2h-limit  16core",
    "3  nast16l - large   no-limit  16core",
]

CORE_FIELD_KEYS = {'filename', 'sleep'}
HEREDOC_INPUT_FIELDS = ['filename', 'version', 'amls', 'acoustic', 'queue']

DEFAULT_SSH_BUTTONS = [
    {'enabled': True, 'label': 'Kill job', 'command': 'bkill {selected_jobid}'},
    {'enabled': True, 'label': 'nast16m', 'command': 'bjobs -u all -q nast16m'},
    {'enabled': True, 'label': 'Disk', 'command': 'fstv_util'},
]


def _default_solver_fields():
    """Default sub-fields for every solver. Used for migration and to seed new solvers."""
    from app.logic.parse_utils import numbered_choices, choice_list
    return [
        {'key': 'version', 'label': 'Ver', 'type': 'choice',
         'role': 'heredoc_input', 'default': '4', 'required': True,
         'show_label': False,
         'choices': numbered_choices(DEFAULT_VERSIONS)},
        {'key': 'queue', 'label': 'Queue', 'type': 'choice',
         'role': 'heredoc_input', 'default': '2', 'required': True,
         'show_label': False,
         'choices': numbered_choices(DEFAULT_QUEUES)},
        {'key': 'amls', 'label': 'AMLS', 'type': 'choice',
         'role': 'heredoc_input', 'default': 'n', 'required': False,
         'show_label': True,
         'choices': choice_list(['n', 'y'])},
        {'key': 'acoustic', 'label': 'Acous', 'type': 'choice',
         'role': 'heredoc_input', 'default': 'n', 'required': False,
         'show_label': True,
         'choices': choice_list(['n', 'y'])},
        {'key': 'sleep', 'label': 'Sleep', 'type': 'text',
         'role': 'sleep', 'default': '0.5', 'required': False,
         'show_label': True,
         'choices': []},
    ]


def _default_solvers():
    fields = _default_solver_fields()
    return {
        'nast':  {'label': 'Nastran (nast)',  'fields': [dict(f) for f in fields]},
        'nastc': {'label': 'Nastran (nastc)', 'fields': [dict(f) for f in fields]},
    }


DEFAULT_SETTINGS = {
    'server': '', 'user': '', 'password': '',
    'ttmacro_path': '',
    'python38_exe': '',
    'python38_libs': '',
    'win_prefix': '',
    'versions': list(DEFAULT_VERSIONS),
    'queues':   list(DEFAULT_QUEUES),
    'amls_options': ['n', 'y'],
    'acoustic_options': ['n', 'y'],
    'solvers': _default_solvers(),
    'default_solver': 'nast',
    'default_delay': '0.5',
    'default_preset': '',
    'ssh_buttons': [dict(x) for x in DEFAULT_SSH_BUTTONS],
    'bjobs_command': 'bjobs -u {user}',
    # Queue columns. `key` matches a field in the row dict (populated by
    # parse_bjobs and enriched by parse_bjobs_long on row-selection). Core
    # columns (jobid, state) are always shown even if the user disables them
    # in settings (they'd have no way to select a row otherwise). Extras can
    # be toggled in Settings -> Queue columns.
    'queue_columns': [
        {'key': 'jobid',       'label': 'Job ID',      'enabled': True,  'width': 90},
        {'key': 'state',       'label': 'State',       'enabled': True,  'width': 80},
        {'key': 'name',        'label': 'Summary',     'enabled': True,  'width': 220},
        {'key': 'queue',       'label': 'Queue',       'enabled': True,  'width': 120},
        {'key': 'submit_time', 'label': 'Submit time', 'enabled': True,  'width': 140},
        # bjobs -l enrichments (fetched when user selects a row). Off by
        # default; user turns them on in Settings.
        {'key': 'exec_host',   'label': 'Exec host',   'enabled': False, 'width': 140},
        {'key': 'cwd',         'label': 'CWD',         'enabled': False, 'width': 260},
        {'key': 'command',     'label': 'Command',     'enabled': False, 'width': 220},
        {'key': 'run_limit',   'label': 'Run limit',   'enabled': False, 'width': 100},
        {'key': 'resource_requirement', 'label': 'Resource req', 'enabled': False, 'width': 200},
        {'key': 'cpu_time',    'label': 'CPU time',    'enabled': False, 'width': 100},
        {'key': 'started_on',  'label': 'Started',     'enabled': False, 'width': 140},
        {'key': 'from_host',   'label': 'From host',   'enabled': False, 'width': 120},
        {'key': 'project',     'label': 'Project',     'enabled': False, 'width': 100},
    ],
    'queue_detail_on_select': True,  # fetch bjobs -l JOBID when a row is clicked
    'gui': {},
}

NASTRAN_KW = {
    'SOL','CEND','BEGIN','ENDDATA','SUBCASE','SUBTITLE','TITLE','ECHO',
    'SPC','SPC1','FORCE','MOMENT','LOAD','PARAM','GRID','GRDSET',
    'CBAR','CROD','CBEAM','CQUAD4','CTRIA3','CHEXA','CPENTA','CTETRA',
    'MAT1','MAT2','MAT8','PBAR','PBARL','PSHELL','PROD','PBEAM',
    'CONM2','RBE2','RBE3','MPC','MPCD','EIGRL','EIGR',
}


def _migrate_commands_to_solvers(s):
    """Legacy file has 'commands' / 'default_command' -> build 'solvers' from it.

    Why: avoid data loss on upgrade. Each command name -> one solver with the 6 default fields.
    Always strip the old keys after merging so the new file does not mix schemas.
    """
    if not (isinstance(s.get('solvers'), dict) and s['solvers']):
        commands = s.get('commands') or ['nast', 'nastc']
        fields = _default_solver_fields()
        s['solvers'] = {
            str(name): {'label': str(name), 'fields': [dict(f) for f in fields]}
            for name in commands
        }
        s['default_solver'] = str(s.get('default_command') or commands[0])
    s.pop('commands', None)
    s.pop('default_command', None)
    s.pop('field_library', None)
    s.pop('theme', None)
    return s


def _migrate_solver_fields(s):
    defaults = {f['key']: f for f in _default_solver_fields()}
    for solver_def in (s.get('solvers') or {}).values():
        if not isinstance(solver_def, dict):
            continue
        migrated = []
        for field in solver_def.get('fields', []) or []:
            if not isinstance(field, dict):
                continue
            key = str(field.get('key', '')).strip()
            if not key or key == 'forecast_time':
                continue
            if 'show_label' not in field:
                field['show_label'] = bool(defaults.get(key, {}).get('show_label', False))
            field.pop('note', None)
            migrated.append(field)
        solver_def['fields'] = migrated or [dict(f) for f in _default_solver_fields()]
    s.pop('default_note', None)
    return s


def get_solver(settings, name):
    """Return solver_def dict, or None if it does not exist."""
    solvers = settings.get('solvers') or {}
    if name in solvers:
        return solvers[name]
    return None


def load_settings():
    try:
        raw = load_json(SETTINGS_FILE)
    except JSONLoadError as e:
        load_errors.append(e)
        raw = {}
    s = dict(DEFAULT_SETTINGS)
    if 'settings' in raw:
        s.update(raw['settings'])
        s['queues'] = [
            q.replace('â€"', '-').replace('–', '-')
            for q in s.get('queues', [])
        ]
    s = _migrate_commands_to_solvers(s)
    s = _migrate_solver_fields(s)
    # Seed queue_columns / queue_detail_on_select on files saved before the
    # column-toggle feature landed. Preserve user tweaks if already present.
    if 'queue_columns' not in s or not isinstance(s.get('queue_columns'), list):
        s['queue_columns'] = [dict(c) for c in DEFAULT_SETTINGS['queue_columns']]
    else:
        known_keys = {c['key'] for c in s['queue_columns']}
        for default_col in DEFAULT_SETTINGS['queue_columns']:
            if default_col['key'] not in known_keys:
                s['queue_columns'].append(dict(default_col))
    if 'queue_detail_on_select' not in s:
        s['queue_detail_on_select'] = True
    cards = raw.get('cards', [])
    return s, cards


def save_settings(settings, cards):
    save_json(SETTINGS_FILE, {'settings': settings, 'cards': cards})


def save_queue_cache(rows, saved_at_iso):
    """Persist the last successful bjobs result so the next launch can
    show something immediately instead of an empty table for 5s.
    """
    try:
        save_json(QUEUE_CACHE_FILE, {'saved_at': saved_at_iso, 'rows': list(rows or [])})
    except OSError:
        pass


def load_queue_cache():
    """Return (rows, saved_at_iso). Returns ([], '') if cache is missing
    or unreadable -- the caller should fall back to an empty queue.
    """
    try:
        raw = load_json(QUEUE_CACHE_FILE)
    except JSONLoadError as e:
        load_errors.append(e)
        raw = {}
    if not isinstance(raw, dict):
        return [], ''
    rows = raw.get('rows') or []
    if not isinstance(rows, list):
        rows = []
    return rows, str(raw.get('saved_at') or '')
