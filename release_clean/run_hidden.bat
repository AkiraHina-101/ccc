@echo off
setlocal
cd /d "%~dp0"

rem ============================================================================
rem Edit these two values on the target machine if needed.
rem Use Python 3.9 only.
rem ============================================================================

rem Full path to pythonw.exe or python.exe. Leave blank to use "py -3.9".
rem Example:
rem set "PYTHON_EXE=<TARGET_PYTHON39_DIR>\pythonw.exe"
set "PYTHON_EXE="

rem Folder that contains target-machine libraries such as PySide2/shiboken2.
rem Leave blank only if Python 3.9 can already import those packages.
rem Example:
rem set "EXTRA_LIBS=<TARGET_PYTHON_LIBS_DIR>"
set "EXTRA_LIBS="

if defined PYTHON_EXE if not exist "%PYTHON_EXE%" set "PYTHON_EXE="
if defined EXTRA_LIBS if not exist "%EXTRA_LIBS%" set "EXTRA_LIBS="

if not defined PYTHON_EXE (
    set "PYTHON_EXE=py -3.9"
)

if defined EXTRA_LIBS (
    set "PYTHONPATH=%~dp0libs;%EXTRA_LIBS%"
) else (
    set "PYTHONPATH=%~dp0libs"
)

rem Prefer pythonw.exe when PYTHON_EXE is a real python.exe path.
set "PYTHONW_EXE="
for %%P in ("%PYTHON_EXE%") do if /i "%%~nxP"=="python.exe" if exist "%%~dpPpythonw.exe" set "PYTHONW_EXE=%%~dpPpythonw.exe"
if defined PYTHONW_EXE (
    start "" "%PYTHONW_EXE%" "%~dp0main.py"
    exit /b 0
)

start "" %PYTHON_EXE% "%~dp0main.py"
