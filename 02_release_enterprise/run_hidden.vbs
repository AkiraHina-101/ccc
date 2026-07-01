' ============================================================================
' run_hidden.vbs - launches the app with no console window.
'
' For enterprise deployment, prefer editing paths.bat and launching run.bat.
' If this hidden launcher is used directly, edit only the placeholders below.
' Leave values blank to use auto-detected portable Python.
' ============================================================================

Dim PYTHON_EXE
' Placeholder example:
' PYTHON_EXE = "<TARGET_PYTHON_DIR>\pythonw.exe"
PYTHON_EXE = ""

Dim EXTRA_LIBS
' Placeholder example:
' EXTRA_LIBS = "<TARGET_EXTRA_PYTHON_LIBS_DIR>"
EXTRA_LIBS = ""

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

appDir = fso.GetParentFolderName(WScript.ScriptFullName)
shell.CurrentDirectory = appDir

If EXTRA_LIBS <> "" And Not fso.FolderExists(EXTRA_LIBS) Then
    EXTRA_LIBS = ""
End If

Dim pyPath
pyPath = appDir & "\libs"
If EXTRA_LIBS <> "" Then
    pyPath = pyPath & ";" & EXTRA_LIBS
End If
shell.Environment("Process")("PYTHONPATH") = pyPath

If PYTHON_EXE <> "" And Not fso.FileExists(PYTHON_EXE) Then
    PYTHON_EXE = ""
End If

If PYTHON_EXE = "" Then
    parentDir = fso.GetParentFolderName(appDir)
    Dim candidates
    candidates = Array( _
        parentDir & "\python3.8.10\pythonw.exe", _
        parentDir & "\00-Other_Tool\python3.8.10\pythonw.exe", _
        parentDir & "\python3.8.10\python.exe", _
        parentDir & "\00-Other_Tool\python3.8.10\python.exe" _
    )
    Dim i
    For i = 0 To UBound(candidates)
        If fso.FileExists(candidates(i)) Then
            PYTHON_EXE = candidates(i)
            Exit For
        End If
    Next
End If

If PYTHON_EXE <> "" And fso.FileExists(PYTHON_EXE) Then
    shell.Run """" & PYTHON_EXE & """ main.py", 0, False
Else
    shell.Run "py -3.9 main.py", 0, False
End If
