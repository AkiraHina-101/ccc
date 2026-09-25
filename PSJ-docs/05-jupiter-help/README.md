# Jupiter Help files for local AI reference

These are direct copies of the Help folders from the installed Jupiter versions on the source machine. They are included so an AI on another machine can search the local files without depending on the original `C:\Program Files` paths.

## Jupiter 5.0.4

`5.0.4/Help/` contains the user-facing Help references copied from the installation:

- `API_HELP/`: JPT API reference in English and Japanese (`.chm`).
- `BASE_HELP/`: full Jupiter manuals in English and Japanese (`.pdf` and `.chm`).
- `OPTION_HELP/`: option-specific manuals (`.pdf` and `.chm`).
- `WEB_BASE_HELP/`: static PSJ HTML reference, tutorials, commands, utilities, GUI API, and examples. Installer/uninstaller and web-server access-control files are intentionally excluded.

## Jupiter 5.0.1

`5.0.1/Help/WEB_BASE_HELP/` contains the static PSJ HTML documentation. Installer/uninstaller files are intentionally excluded. The Jupiter 5.0.1 installation on the source machine did not contain separate `API_HELP/`, `BASE_HELP/`, or `OPTION_HELP/` folders or CHM/PDF manuals; those are available in the 5.0.4 copy above.

## How the AI should search

1. Start with the version matching the Jupiter instance being controlled.
2. Search `WEB_BASE_HELP/psj/docs/` for method names, command names, parameter names, or task descriptions. The main sections include `psj-command`, `psj-utility`, `psj-gui`, `macro`, and `data-type`.
3. For 5.0.4, consult `API_HELP/` for the JPT API reference and `BASE_HELP/`/`OPTION_HELP/` for application behavior.
4. Treat 5.0.4 documentation as a fallback for 5.0.1 only when no 5.0.1 page exists, and label that version difference.

This folder contains local application Help only. Do not add mechanisms that fetch or install documentation or other components from outside the machine.
