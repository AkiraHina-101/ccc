"""Gather files referenced by a Nastran .dat from a source folder to the
submit folder, with validation.

Why this exists: the submit pipeline only works if every file referenced via
`INCLUDE` in the main .dat actually lives next to the .dat in the submit
folder. Users currently copy files by hand from scattered project folders —
this module automates the copy and surfaces missing/extra files before submit.

Pure Python, no PySide2. Only this module talks to disk for the gather step;
the UI calls these functions and shows results.
"""
from __future__ import annotations

import os
import re
import shutil
from typing import Dict, List, Tuple


# Nastran INCLUDE syntax we accept (case-insensitive):
#   INCLUDE 'file.bdf' / "file.bdf" / file.bdf
_INCLUDE_RE = re.compile(
    r"""^\s*INCLUDE\s+
        (?:'([^']+)' | "([^"]+)" | (\S+))
    """,
    re.IGNORECASE | re.VERBOSE,
)

# ASSIGN <KEYWORD>='file', ... — only INPUTT2/INPUTT4 reference INPUT files
# that must already exist in the submit folder. USERFILE is an OUTPUT (the
# run creates it) — we treat it separately: only sanity-check that its name
# is consistent with the .dat basename.
_ASSIGN_RE = re.compile(
    r"""^\s*ASSIGN\s+(\w+)\s*=\s*
        (?:'([^']+)' | "([^"]+)" | (\S+?))
        (?=[\s,]|$)
    """,
    re.IGNORECASE | re.VERBOSE,
)

_ASSIGN_INPUT_KEYWORDS = {'INPUTT2', 'INPUTT4'}
_ASSIGN_OUTPUT_KEYWORDS = {'USERFILE'}


def _read_lines(dat_path: str) -> List[str]:
    try:
        with open(dat_path, 'r', encoding='utf-8', errors='replace') as f:
            return f.readlines()
    except (OSError, IOError):
        return []


def _strip_comment(line: str) -> str:
    # Anything after `$` is a Nastran comment.
    i = line.find('$')
    return line if i < 0 else line[:i]


def _basename(ref: str) -> str:
    return os.path.basename(ref.replace('\\', '/').strip())


def parse_dat_refs(dat_path: str) -> Dict[str, List[str]]:
    """Scan a Nastran .dat and return categorized file references.

    Returns:
      {
        'required': [...basenames...],   # INCLUDE + ASSIGN INPUTT2/INPUTT4
        'userfiles': [...basenames...],  # ASSIGN USERFILE (outputs)
      }

    Only the immediate .dat is parsed (1-level — decision 2026-06-21). Lines
    starting with `$` and inline trailing-`$` comments are skipped. Path
    prefixes inside refs are stripped to basenames — every gathered file
    lands next to the .dat in the submit folder anyway.
    """
    required: List[str] = []
    userfiles: List[str] = []
    seen_req = set()
    seen_user = set()

    for raw in _read_lines(dat_path):
        line = _strip_comment(raw.rstrip('\r\n'))
        if not line.strip():
            continue

        m = _INCLUDE_RE.match(line)
        if m:
            name = _basename(m.group(1) or m.group(2) or m.group(3) or '')
            if name and name not in seen_req:
                seen_req.add(name)
                required.append(name)
            continue

        m = _ASSIGN_RE.match(line)
        if m:
            keyword = m.group(1).upper()
            name = _basename(m.group(2) or m.group(3) or m.group(4) or '')
            if not name:
                continue
            if keyword in _ASSIGN_INPUT_KEYWORDS and name not in seen_req:
                seen_req.add(name)
                required.append(name)
            elif keyword in _ASSIGN_OUTPUT_KEYWORDS and name not in seen_user:
                seen_user.add(name)
                userfiles.append(name)

    return {'required': required, 'userfiles': userfiles}


def parse_includes(dat_path: str) -> List[str]:
    """Back-compat shim: returns only the `required` list. New code should
    use `parse_dat_refs()` directly so it can also surface USERFILE checks.
    """
    return parse_dat_refs(dat_path)['required']


def validate_userfiles(dat_path: str, userfiles: List[str]) -> Dict[str, str]:
    """Verify each USERFILE name is consistent with the .dat basename.

    Rule: USERFILE name should start with the .dat stem (case-insensitive).
    Catches the common bug where a user renames the .dat but forgets to
    update USERFILE inside, so the output collides with another job's CSV.

    Returns {name: 'ok'|'mismatch'}.
    """
    stem = os.path.splitext(os.path.basename(dat_path))[0].lower()
    result: Dict[str, str] = {}
    for name in userfiles:
        result[name] = 'ok' if name.lower().startswith(stem) else 'mismatch'
    return result


def validate_files(dest_folder: str, required: List[str]) -> Dict[str, str]:
    """For each required filename, return 'ok' if present in dest_folder,
    else 'missing'. Lookup is case-insensitive on Windows behavior but the
    returned key matches the input casing.
    """
    if not dest_folder or not os.path.isdir(dest_folder):
        return {name: 'missing' for name in required}
    try:
        existing = {n.lower(): n for n in os.listdir(dest_folder)}
    except OSError:
        return {name: 'missing' for name in required}
    result: Dict[str, str] = {}
    for name in required:
        result[name] = 'ok' if name.lower() in existing else 'missing'
    return result


def find_in_source(source_folder: str, names: List[str]) -> Dict[str, str]:
    """For each name, return the absolute source path if found (recursively
    inside source_folder), or empty string if not found. First match wins —
    if the same basename lives in multiple subfolders the shallowest match
    is preferred (top-down walk).
    """
    if not source_folder or not os.path.isdir(source_folder):
        return {name: '' for name in names}
    wanted = {n.lower(): n for n in names}
    result: Dict[str, str] = {n: '' for n in names}
    for root, _dirs, files in os.walk(source_folder):
        for f in files:
            key = f.lower()
            if key in wanted and not result[wanted[key]]:
                result[wanted[key]] = os.path.join(root, f)
        if all(result.values()):
            break
    return result


def copy_to_dest(
    source_paths: Dict[str, str],
    dest_folder: str,
    overwrite: bool = False,
) -> Tuple[List[str], List[Tuple[str, str]]]:
    """Copy each (name -> source_path) into dest_folder.

    Returns (copied_names, failed). `failed` is a list of (name, reason).
    Entries with empty source_path are reported as failed with reason
    'not found in source'. Existing files are skipped unless overwrite=True.
    """
    copied: List[str] = []
    failed: List[Tuple[str, str]] = []
    if not os.path.isdir(dest_folder):
        try:
            os.makedirs(dest_folder, exist_ok=True)
        except OSError as e:
            return [], [(n, f'dest unreachable: {e}') for n in source_paths]

    for name, src in source_paths.items():
        if not src:
            failed.append((name, 'not found in source'))
            continue
        dst = os.path.join(dest_folder, name)
        if os.path.exists(dst) and not overwrite:
            # Idempotent: treat as already-satisfied, not failure.
            copied.append(name)
            continue
        try:
            shutil.copy2(src, dst)
            copied.append(name)
        except (OSError, shutil.SameFileError) as e:
            failed.append((name, str(e)))
    return copied, failed


def gather_report(
    dat_path: str,
    source_folder: str,
    dest_folder: str,
) -> dict:
    """One-shot helper: parse refs, check dest, locate missing in source.

    Returns a dict with keys:
      - required: list of basenames (INCLUDE + ASSIGN INPUTT2/INPUTT4)
      - status: name -> 'ok' | 'missing' (vs dest folder)
      - source_paths: name -> absolute source path or '' if not found
      - missing_in_source: list of names absent from both dest and source
      - userfiles: list of ASSIGN USERFILE basenames (outputs)
      - userfile_status: name -> 'ok' | 'mismatch' (name vs .dat stem)
    """
    refs = parse_dat_refs(dat_path)
    required = refs['required']
    userfiles = refs['userfiles']
    status = validate_files(dest_folder, required)
    missing = [n for n, st in status.items() if st == 'missing']
    source_paths = find_in_source(source_folder, missing) if missing else {}
    missing_in_source = [n for n in missing if not source_paths.get(n)]
    userfile_status = validate_userfiles(dat_path, userfiles)
    return {
        'required': required,
        'status': status,
        'source_paths': source_paths,
        'missing_in_source': missing_in_source,
        'userfiles': userfiles,
        'userfile_status': userfile_status,
    }
