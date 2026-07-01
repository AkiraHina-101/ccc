@echo off
rem ============================================================================
rem Clean release local placeholders
rem
rem Edit this file after copying the release folder to another machine.
rem Leave a value blank when the launcher should auto-detect it.
rem Do not put personal-machine paths in source files; keep them here only.
rem ============================================================================

rem [REQUIRED IF AUTO-DETECT FAILS]
rem Full path to python.exe or pythonw.exe on the target machine.
rem Placeholder example:
rem set "PYTHON_EXE=<TARGET_PYTHON_DIR>\python.exe"
set "PYTHON_EXE="

rem [OPTIONAL]
rem Folder containing extra third-party packages not already bundled in libs/.
rem The app always adds .\libs automatically, so normally this can stay blank.
rem Placeholder example:
rem set "EXTRA_LIBS=<TARGET_EXTRA_PYTHON_LIBS_DIR>"
set "EXTRA_LIBS="
