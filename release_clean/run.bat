@echo off
setlocal
cd /d "%~dp0"

rem ============================================================================
rem Edit these two values on the target machine if needed.
rem Use Python 3.9 only.
rem ============================================================================

rem Full path to python.exe. Leave blank to use "py -3.9".
rem Example:
rem set "PYTHON_EXE=<TARGET_PYTHON39_DIR>\python.exe"
set "PYTHON_EXE="

rem Folder that contains target-machine libraries such as PySide2/shiboken2.
rem Leave blank only if Python 3.9 can already import those packages.
rem Example:
rem set "EXTRA_LIBS=<TARGET_PYTHON_LIBS_DIR>"
set "EXTRA_LIBS="

rem Ignore stale values that point to missing local files/folders.
if defined PYTHON_EXE if not exist "%PYTHON_EXE%" set "PYTHON_EXE="
if defined EXTRA_LIBS if not exist "%EXTRA_LIBS%" set "EXTRA_LIBS="

rem Python 3.9 only.
if not defined PYTHON_EXE (
    set "PYTHON_EXE=py -3.9"
)

rem PYTHONPATH = optional target-machine libs + optional local libs.
if defined EXTRA_LIBS (
    set "PYTHONPATH=%~dp0libs;%EXTRA_LIBS%"
) else (
    set "PYTHONPATH=%~dp0libs"
)

echo [INFO] Python executable:
echo %PYTHON_EXE%

echo.
echo [INFO] PYTHONPATH:
echo %PYTHONPATH%

echo.
echo [INFO] Python version:
%PYTHON_EXE% --version
if errorlevel 1 (
    echo.
    echo [ERROR] Python 3.9 could not be started. Edit PYTHON_EXE in run.bat.
    pause
    exit /b 1
)

echo.
echo [INFO] Checking PySide2 and app imports:
%PYTHON_EXE% -X faulthandler -c "import PySide2; from app.ui.main_window import MainWindow; print('PySide2', PySide2.__version__, '/ app import ok')"
if errorlevel 1 (
    echo.
    echo [ERROR] Import failed. Edit EXTRA_LIBS in run.bat.
    pause
    exit /b 1
)

echo.
echo [INFO] Running app:
%PYTHON_EXE% -X faulthandler "%~dp0main.py"

echo.
echo [INFO] Exit code: %errorlevel%
if %errorlevel% neq 0 (
    echo [ERROR] The app exited with an error. See the output above.
)
pause
