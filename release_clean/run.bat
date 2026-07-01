@echo off
setlocal
cd /d "%~dp0"

rem Load PYTHON_EXE + EXTRA_LIBS from paths.bat (edit that file, not this one).
if exist "%~dp0paths.bat" call "%~dp0paths.bat"

rem Ignore stale paths.bat values that point to missing local files.
if defined PYTHON_EXE if not exist "%PYTHON_EXE%" set "PYTHON_EXE="
if defined EXTRA_LIBS if not exist "%EXTRA_LIBS%" set "EXTRA_LIBS="

rem Auto-detect fallback if paths.bat left PYTHON_EXE blank or unusable.
if not defined PYTHON_EXE (
    if exist "%~dp0..\python3.8.10\python.exe" (
        set "PYTHON_EXE=%~dp0..\python3.8.10\python.exe"
    ) else if exist "%~dp0..\00-Other_Tool\python3.8.10\python.exe" (
        set "PYTHON_EXE=%~dp0..\00-Other_Tool\python3.8.10\python.exe"
    ) else (
        py -3.9 --version >nul 2>&1
        if not errorlevel 1 (
            set "PYTHON_EXE=py -3.9"
        ) else (
            py -3.8 --version >nul 2>&1
            if not errorlevel 1 (
                set "PYTHON_EXE=py -3.8"
            ) else (
                set "PYTHON_EXE=python"
            )
        )
    )
)

rem PYTHONPATH = project libs + optional EXTRA_LIBS (for paramiko etc).
if defined EXTRA_LIBS (
    set "PYTHONPATH=%~dp0libs;%EXTRA_LIBS%"
) else (
    set "PYTHONPATH=%~dp0libs"
)

rem Prefer pythonw.exe (no console window) when PYTHON_EXE points at a real file.
set "PYTHONW_EXE="
for %%P in ("%PYTHON_EXE%") do if /i "%%~nxP"=="python.exe" if exist "%%~dpPpythonw.exe" set "PYTHONW_EXE=%%~dpPpythonw.exe"
if defined PYTHONW_EXE if exist "%PYTHONW_EXE%" (
    start "" "%PYTHONW_EXE%" "%~dp0main.py"
    exit /b 0
)

%PYTHON_EXE% main.py
