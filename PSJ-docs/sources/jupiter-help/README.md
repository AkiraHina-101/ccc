# Jupiter Help files for local AI reference

These are local copies of Jupiter Help for AI search. Synchronization metadata is in `../../reference/source-sync-manifest.json`; the consolidated catalog is `../../reference/API-CATALOG.md`. Additional searchable sources are `../documentation-exe/`, `../chm/`, and `../pdf/`.

Privacy cleanup on 2026-10-15 replaced examples containing the local Windows account name with `USERNAME` in copied text and generated API pages. The `sha256` fields record the sanitized copies; `source_sha256` preserves the original source checksum for changed files. The installed source files were not modified.

## Jupiter 5.0.4

`5.0.4/Help/` contains the installed user-facing Help references:

- `API_HELP/`: JPT API reference in English and Japanese (`.chm`).
- `BASE_HELP/`: full Jupiter manuals in English and Japanese (`.pdf` and `.chm`).
- `OPTION_HELP/`: option-specific manuals (`.pdf` and `.chm`).
- `WEB_BASE_HELP/`: static PSJ HTML reference, tutorials, commands, utilities, GUI API, and examples.

## Jupiter 5.0.1

`5.0.1/Help/WEB_BASE_HELP/` contains the static PSJ HTML documentation. This installation had no separate `API_HELP/`, `BASE_HELP/`, or `OPTION_HELP/` folders; use the 5.0.4 manuals only as a clearly labeled fallback.

## How the AI should search

1. Start with the version matching the Jupiter instance.
2. Search `WEB_BASE_HELP/psj/docs/` for method names, command names, parameters, or tasks. Main sections include `psj-command`, `psj-utility`, `psj-gui`, `macro`, and `data-type`.
3. For 5.0.4, consult `API_HELP/` for JPT API reference and `BASE_HELP/`/`OPTION_HELP/` for application behavior.
4. Treat 5.0.4 documentation as a fallback for 5.0.1 only when no 5.0.1 page exists, and label the version difference.

This folder contains local application Help only. Do not add mechanisms that fetch or install documentation or other components from outside the machine.
