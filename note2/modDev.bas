Attribute VB_Name = "modDev"
Option Explicit

' Developer export and importer bootstrap utilities.

Public Sub ExportAllModules(Optional ByVal silent As Boolean = False)
    Dim comp As Object, outDir As String, n As Long
    outDir = DevSourceDir()
    If Dir(outDir, vbDirectory) = "" Then MkDir outDir

    For Each comp In ThisWorkbook.VBProject.VBComponents
        Select Case comp.Type
            Case 1   ' vbext_ct_StdModule
                comp.Export outDir & "\" & comp.Name & ".bas"
                n = n + 1
            Case 100 ' vbext_ct_Document (sheet / ThisWorkbook code)
                If comp.CodeModule.CountOfLines > 0 Then
                    ExportDocCode comp, outDir & "\sht" & DocSheetName(comp) & ".txt"
                    n = n + 1
                End If
        End Select
    Next comp
    If Not silent Then MsgBox n & " modules exported to " & outDir, vbInformation
End Sub

' Bootstrap updater for modImporter. This procedure lives in modDev, so it can
' safely replace modImporter without removing code that is currently executing.
' Run it only when SyncImportedModules reports that modImporter has changed.
Public Sub UpdateImporterFromSource()
    UpdateImporterFromSourceCore False
End Sub

' Automation-safe counterpart to the user-facing macro above.
Public Sub UpdateImporterFromSourceSilent()
    UpdateImporterFromSourceCore True
End Sub

' Keep the user-facing macro parameterless so it appears in Alt+F8.
Private Sub UpdateImporterFromSourceCore(ByVal silent As Boolean)
    Dim sourcePath As String, vbp As Object, comp As Object, cm As Object
    Dim txt As String
    Dim msg As String
    Dim errNum As Long, errDesc As String
    On Error GoTo Fail
    sourcePath = DevSourceDir() & "\modImporter.bas"
    If Dir(sourcePath) = "" Then Err.Raise vbObjectError + 41, , _
        "modImporter source not found: " & sourcePath

    Set vbp = ThisWorkbook.VBProject
    Set comp = vbp.VBComponents("modImporter")
    If comp.Type <> 1 Then Err.Raise vbObjectError + 42, , _
        "modImporter is not a standard module."

    ' Updating the existing CodeModule in place is more stable than removing and
    ' re-importing a VBComponent while Excel is running under automation.
    txt = DevBasModuleBody(sourcePath)
    Set cm = comp.CodeModule
    If cm.CountOfLines > 0 Then cm.DeleteLines 1, cm.CountOfLines
    If Len(txt) > 0 Then cm.AddFromString txt
    msg = "modImporter updated from: " & sourcePath
    modLog.ReportSuccess "UpdateImporterFromSource", msg
    If Not silent Then MsgBox msg, vbInformation
    Exit Sub
Fail:
    errNum = Err.Number: errDesc = Err.Description
    On Error Resume Next
    msg = "modImporter update FAILED " & errNum & ": " & errDesc
    msg = modLog.ReportError("UpdateImporterFromSource", "replace module", _
                             errNum, errDesc)
    If Not silent Then MsgBox msg, vbExclamation
End Sub

' Return importable code from a .bas file, excluding VBComponent metadata lines.
Private Function DevBasModuleBody(ByVal sourcePath As String) As String
    Dim ff As Integer, txt As String, lines() As String, line As Variant
    Dim out As String, trimmed As String
    ff = FreeFile
    Open sourcePath For Binary Access Read As #ff
    If LOF(ff) > 0 Then txt = Input$(LOF(ff), #ff)
    Close #ff

    txt = Replace(txt, vbCrLf, vbLf)
    txt = Replace(txt, vbCr, vbLf)
    lines = Split(txt, vbLf)
    For Each line In lines
        trimmed = LTrim$(CStr(line))
        If StrComp(Left$(trimmed, 10), "Attribute ", vbTextCompare) <> 0 Then
            If Len(out) > 0 Then out = out & vbCrLf
            out = out & CStr(line)
        End If
    Next line
    DevBasModuleBody = out
End Function

' Sheet code is exported as plain text (the build script injects it
' back into the sheet's code module, so no .cls header is wanted).
Private Sub ExportDocCode(comp As Object, ByVal outPath As String)
    Dim ff As Integer
    ff = FreeFile
    Open outPath For Output As #ff
    Print #ff, comp.CodeModule.Lines(1, comp.CodeModule.CountOfLines)
    Close #ff
End Sub

Private Function DocSheetName(comp As Object) As String
    On Error Resume Next
    DocSheetName = comp.Properties("Name").Value   ' tab name (e.g. PLOT)
    If Len(DocSheetName) = 0 Then DocSheetName = comp.Name
End Function

' Use the same source-of-truth location as modImporter for both artifacts.
Private Function DevSourceDir() As String
    Dim base As String
    base = ThisWorkbook.Path
    If Dir(base & "\src", vbDirectory) <> "" Then
        DevSourceDir = base & "\src"
    ElseIf Dir(base & "\release\src", vbDirectory) <> "" Then
        DevSourceDir = base & "\release\src"
    Else
        DevSourceDir = base & "\src"
    End If
End Function
