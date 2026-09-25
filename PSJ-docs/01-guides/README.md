# 03 — PSJ Record

## Runtime entry points

The root contains scripts that must be discoverable by the VSCode extension:
`record.py`, `send.py`, `insert_selection.py`, `insert_visibility.py`, and
`recorded.py`. Keep them at this level.

| Folder | Purpose |
| --- | --- |
| `vscode-extension/` | Local VSCode status-bar extension source. |
| `jupiterutils/` | Extracted TechnoStar package; do not modify. |
| `.vscode/` | Jupiter interpreter and task configuration. |
| `.claude/`, `.agents/` | Agent configuration and commands. |
| `examples/` | Standalone PSJ examples. |
| `support/docs/` | PSJ documentation and playbook. |
| `support/helpers/` | Documentation helpers. |
| `support/reference/` | Reference examples and documentation executable. |
| `support/scripts/` | Offline/support scripts and sample macro. |
| `support/workspace/` | Workspace map and migration history. |

Open `PSJ-Jupiter.code-workspace` for this project only, or
`PSJ.code-workspace` for all three projects.
