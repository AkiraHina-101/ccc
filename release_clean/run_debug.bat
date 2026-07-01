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

if defined EXTRA_LIBS (
    set "PYTHONPATH=%~dp0libs;%EXTRA_LIBS%"
) else (
    set "PYTHONPATH=%~dp0libs"
)

echo [INFO] Current folder:
cd

echo.
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
    echo [ERROR] Python could not be started. Check PYTHON_EXE in paths.bat or PATH.
    pause
    exit /b 1
)

echo.
echo [INFO] Checking PySide2 and app imports:
%PYTHON_EXE% -X faulthandler -c "import PySide2; from app.ui.main_window import MainWindow; print('PySide2', PySide2.__version__, '/ app import ok')"
if errorlevel 1 (
    echo.
    echo [ERROR] Import failed. Check PYTHONPATH, libs/, paths.bat, and the error above.
    pause
    exit /b 1
)

echo.
echo [INFO] Checking app file:
if not exist "main.py" (
    echo [ERROR] main.py was not found in this folder.
    pause
    exit /b 1
)

echo.
echo [INFO] Running app:
%PYTHON_EXE% -X faulthandler "main.py"

echo.
echo [INFO] Exit code: %errorlevel%
if %errorlevel% neq 0 (
    echo [ERROR] The app exited with an error. See the output above.
)
pause
