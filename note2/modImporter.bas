Attribute VB_Name = "modImporter"
Option Explicit

' Synchronize existing VBA components from the external src folder.

Private Const VBEXT_STD_MODULE As Long = 1
Private Const VBEXT_DOCUMENT As Long = 100

Public Sub SyncImportedModules()
    SyncImportedModulesCore False
End Sub

' Automation-safe entry point: VBA MsgBox is not suppressed by
' Application.DisplayAlerts and would otherwise block a hidden Excel session.
Public Sub SyncImportedModulesSilent()
    SyncImportedModulesCore True
End Sub

Private Sub SyncImportedModulesCore(ByVal silent As Boolean)
    Dim srcDir As String, fileName As String, filePath As String
    Dim compName As String, body As String, sheetName As String
    Dim comp As Object, updated As Long, unchanged As Long, skipped As Long
    Dim sheetUpdated As Long, sheetUnchanged As Long, pendingSelf As Boolean
    Dim skippedNames As String, summary As String

    srcDir = SourceDir()
    If Len(srcDir) = 0 Then
        ReportResult "Sync failed: cannot locate src or release\src.", silent, True
        Exit Sub
    End If

    On Error GoTo Fail
    fileName = Dir(srcDir & "\*.bas")
    Do While Len(fileName) > 0
        filePath = srcDir & "\" & fileName
        body = BasModuleBody(filePath, compName)
        Set comp = StdComponent(compName)
        If comp Is Nothing Then
            skipped = skipped + 1
            AppendName skippedNames, compName
        ElseIf ModuleMatchesBody(comp, body) Then
            unchanged = unchanged + 1
        ElseIf StrComp(compName, "modImporter", vbTextCompare) = 0 Then
            ' Replacing the currently executing module is unsafe. Do not use
            ' Application.OnTime here: a hidden Excel session can show a modal
            ' "cannot run macro" dialog and block automation. modDev owns the
            ' explicit bootstrap macro for this one exceptional component.
            pendingSelf = True
        Else
            ImportStdModule filePath, compName
            updated = updated + 1
        End If
        Set comp = Nothing
        fileName = Dir()
    Loop

    ' Worksheet code is not a .bas component, but it belongs to the same source
    ' sync contract and is safe to update in place when that sheet already exists.
    fileName = Dir(srcDir & "\sht*.txt")
    Do While Len(fileName) > 0
        sheetName = Mid$(fileName, 4, Len(fileName) - 7) ' shtSPL.txt -> SPL
        filePath = srcDir & "\" & fileName
        Set comp = SheetComponent(sheetName)
        If comp Is Nothing Then
            skipped = skipped + 1
            AppendName skippedNames, "sht" & sheetName
        ElseIf ModuleMatchesBody(comp, ReadTextFile(filePath)) Then
            sheetUnchanged = sheetUnchanged + 1
        Else
            LoadSheetCode sheetName, filePath
            sheetUpdated = sheetUpdated + 1
        End If
        Set comp = Nothing
        fileName = Dir()
    Loop

    summary = "Source sync: " & updated & " BAS updated, " & unchanged & _
              " unchanged; " & sheetUpdated & " sheet code updated, " & _
              sheetUnchanged & " unchanged; " & skipped & " new/missing skipped."
    If Len(skippedNames) > 0 Then summary = summary & " Use ImportModule for: " & skippedNames
    If pendingSelf Then summary = summary & _
        " modImporter changed; run UpdateImporterFromSource once."
    ReportResult summary, silent, False
    Exit Sub
Fail:
    ReportResult "Source sync failed " & Err.Number & ": " & Err.Description, silent, True
End Sub

' Select one folder and import every .bas file in it. Existing modules are
' updated in place; files whose module does not yet exist are imported.
Public Sub ImportModule()
    Dim fd As FileDialog, folderPath As String
    Set fd = Application.FileDialog(msoFileDialogFolderPicker)
    fd.Title = "Select a folder containing VBA .bas files"
    If fd.Show <> -1 Then Exit Sub
    folderPath = fd.SelectedItems(1)
    ImportBasFolder folderPath, False
End Sub

Public Function ImportBasFolder(ByVal folderPath As String, _
                                Optional ByVal silent As Boolean = False) As Boolean
    Dim fileName As String, filePath As String, compName As String, body As String
    Dim comp As Object, added As Long, updated As Long, unchanged As Long
    Dim summary As String

    folderPath = Trim$(folderPath)
    If Len(folderPath) = 0 Or Dir(folderPath, vbDirectory) = "" Then
        ReportResult "Import failed: select a valid folder.", silent, True
        Exit Function
    End If

    On Error GoTo Fail
    fileName = Dir(folderPath & "\*.bas")
    Do While Len(fileName) > 0
        filePath = folderPath & "\" & fileName
        body = BasModuleBody(filePath, compName)
        Set comp = StdComponent(compName)
        If comp Is Nothing Then
            ThisWorkbook.VBProject.VBComponents.Import filePath
            added = added + 1
        ElseIf ModuleMatchesBody(comp, body) Then
            unchanged = unchanged + 1
        Else
            ReplaceStdModuleBody comp, body
            updated = updated + 1
        End If
        Set comp = Nothing
        fileName = Dir()
    Loop

    summary = "VBA folder import: " & added & " added, " & updated & _
              " updated, " & unchanged & " unchanged."
    ReportResult summary, silent, False
    ImportBasFolder = True
    Exit Function
Fail:
    ReportResult "VBA folder import failed " & Err.Number & ": " & Err.Description, _
                 silent, True
End Function

' Testable/non-interactive form of ImportModule. Unlike SyncImportedModules,
' this is allowed to add a brand-new standard module.
Public Function ImportModuleByName(ByVal nm As String, _
                                   Optional ByVal silent As Boolean = False) As Boolean
    Dim srcDir As String, filePath As String, compName As String, body As String
    srcDir = SourceDir()
    If Len(srcDir) = 0 Then
        ReportResult "Import failed: cannot locate src or release\src.", silent, True
        Exit Function
    End If
    nm = Trim$(nm)
    If Len(nm) = 0 Then Exit Function

    On Error GoTo Fail
    filePath = srcDir & "\" & nm & ".bas"
    If Dir(filePath) <> "" Then
        body = BasModuleBody(filePath, compName)
        If StrComp(compName, "modImporter", vbTextCompare) = 0 Then
            ReportResult "Run UpdateImporterFromSource to update modImporter safely.", _
                         silent, False
            Exit Function
        Else
            ImportStdModule filePath, compName
            ReportResult "Imported standard module: " & compName, silent, False
        End If
        ImportModuleByName = True
    Else
        filePath = srcDir & "\sht" & nm & ".txt"
        If Dir(filePath) <> "" Then
            LoadSheetCode nm, filePath
            ReportResult "Loaded worksheet code into: " & nm, silent, False
            ImportModuleByName = True
        Else
            ReportResult "Not found: " & nm & ".bas or sht" & nm & ".txt", silent, True
        End If
    End If
    Exit Function
Fail:
    ReportResult "Import failed " & Err.Number & ": " & Err.Description, silent, True
End Function

' Replace a standard module. The caller guarantees this is not the currently
' executing modImporter component.
Private Sub ImportStdModule(ByVal filePath As String, ByVal compName As String)
    Dim vbp As Object
    Set vbp = ThisWorkbook.VBProject
    RemoveStdComponent vbp, compName
    vbp.VBComponents.Import filePath
End Sub

Private Sub ReplaceStdModuleBody(ByVal comp As Object, ByVal body As String)
    Dim cm As Object
    Set cm = comp.CodeModule
    If cm.CountOfLines > 0 Then cm.DeleteLines 1, cm.CountOfLines
    If Len(body) > 0 Then cm.AddFromString body
End Sub

Private Sub LoadSheetCode(ByVal sheetName As String, ByVal filePath As String)
    Dim comp As Object, cm As Object, txt As String
    Set comp = SheetComponent(sheetName)
    If comp Is Nothing Then Err.Raise vbObjectError, , "Worksheet not found: " & sheetName
    txt = ReadTextFile(filePath)
    Set cm = comp.CodeModule
    If cm.CountOfLines > 0 Then cm.DeleteLines 1, cm.CountOfLines
    If Len(txt) > 0 Then cm.AddFromString txt
End Sub

Private Sub RemoveStdComponent(ByVal vbp As Object, ByVal compName As String)
    Dim comp As Object
    On Error Resume Next
    Set comp = vbp.VBComponents(compName)
    On Error GoTo 0
    If Not comp Is Nothing Then
        If comp.Type = VBEXT_STD_MODULE Then vbp.VBComponents.Remove comp
    End If
End Sub

Private Function StdComponent(ByVal compName As String) As Object
    Dim comp As Object
    On Error Resume Next
    Set comp = ThisWorkbook.VBProject.VBComponents(compName)
    On Error GoTo 0
    If Not comp Is Nothing Then
        If comp.Type = VBEXT_STD_MODULE Then Set StdComponent = comp
    End If
End Function

Private Function SheetComponent(ByVal sheetName As String) As Object
    Dim comp As Object, tabName As String
    For Each comp In ThisWorkbook.VBProject.VBComponents
        If comp.Type = VBEXT_DOCUMENT Then
            tabName = ""
            On Error Resume Next
            tabName = comp.Properties("Name").Value
            On Error GoTo 0
            If StrComp(tabName, sheetName, vbTextCompare) = 0 Then
                Set SheetComponent = comp
                Exit Function
            End If
        End If
    Next comp
End Function

' Read the source module name from Attribute VB_Name and return only the body
' visible through CodeModule (Attribute lines are hidden by the VBE object model).
Private Function BasModuleBody(ByVal filePath As String, ByRef compName As String) As String
    Dim txt As String, lines() As String, i As Long, line As String, out As String
    Dim q1 As Long, q2 As Long
    txt = Replace(ReadTextFile(filePath), vbCrLf, vbLf)
    txt = Replace(txt, vbCr, vbLf)
    lines = Split(txt, vbLf)
    compName = Mid$(filePath, InStrRev(filePath, "\") + 1)
    If LCase$(Right$(compName, 4)) = ".bas" Then compName = Left$(compName, Len(compName) - 4)
    For i = LBound(lines) To UBound(lines)
        line = lines(i)
        If LCase$(Left$(Trim$(line), 10)) = "attribute " Then
            If InStr(1, line, "VB_Name", vbTextCompare) > 0 Then
                q1 = InStr(line, """"): q2 = InStrRev(line, """")
                If q2 > q1 Then compName = Mid$(line, q1 + 1, q2 - q1 - 1)
            End If
        Else
            If Len(out) > 0 Then out = out & vbLf
            out = out & line
        End If
    Next i
    BasModuleBody = out
End Function

Private Function ModuleMatchesBody(ByVal comp As Object, ByVal sourceBody As String) As Boolean
    Dim currentBody As String
    If comp.CodeModule.CountOfLines > 0 Then _
        currentBody = comp.CodeModule.Lines(1, comp.CodeModule.CountOfLines)
    ModuleMatchesBody = (NormalizeCode(currentBody) = NormalizeCode(sourceBody))
End Function

Private Function NormalizeCode(ByVal txt As String) As String
    Dim lines() As String, i As Long, last As Long, out As String
    txt = Replace(txt, vbCrLf, vbLf)
    txt = Replace(txt, vbCr, vbLf)
    lines = Split(txt, vbLf)
    last = UBound(lines)
    Do While last >= LBound(lines) And Len(Trim$(lines(last))) = 0
        last = last - 1
    Loop
    For i = LBound(lines) To last
        If i > LBound(lines) Then out = out & vbLf
        out = out & CanonicalizeCodeLine(RTrim$(lines(i)))
    Next i
    NormalizeCode = out
End Function

' The VBE canonicalizes identifier/keyword capitalization when code is imported.
' Compare code case-insensitively outside string literals and comments, while
' still detecting a case-only change inside user-facing text.
Private Function CanonicalizeCodeLine(ByVal line As String) As String
    Dim i As Long, ch As String, out As String, inString As Boolean
    i = 1
    Do While i <= Len(line)
        ch = Mid$(line, i, 1)
        If ch = """" Then
            out = out & ch
            If inString And i < Len(line) And Mid$(line, i + 1, 1) = """" Then
                out = out & """"
                i = i + 1
            Else
                inString = Not inString
            End If
        ElseIf Not inString And ch = "'" Then
            out = out & Mid$(line, i)
            Exit Do
        ElseIf inString Then
            out = out & ch
        Else
            out = out & LCase$(ch)
        End If
        i = i + 1
    Loop
    CanonicalizeCodeLine = out
End Function

Private Function ReadTextFile(ByVal filePath As String) As String
    Dim ff As Integer
    ff = FreeFile
    Open filePath For Binary Access Read As #ff
    If LOF(ff) > 0 Then ReadTextFile = Input$(LOF(ff), #ff)
    Close #ff
End Function

Private Sub AppendName(ByRef listText As String, ByVal nm As String)
    If Len(listText) > 0 Then listText = listText & ", "
    listText = listText & nm
End Sub

Private Sub ReportResult(ByVal msg As String, ByVal silent As Boolean, ByVal isError As Boolean)
    Dim shown As String
    If isError Then
        shown = modLog.ReportError("VbaSourceSync", "update source", _
                                   vbObjectError + 70, msg)
    Else
        modLog.ReportSuccess "VbaSourceSync", msg
        shown = msg
    End If
    If Not silent Then MsgBox shown, IIf(isError, vbExclamation, vbInformation)
End Sub

' Release workbook: <path>\src. Root workbook: <path>\release\src.
Private Function SourceDir() As String
    Dim base As String
    base = ThisWorkbook.Path
    If Dir(base & "\src", vbDirectory) <> "" Then
        SourceDir = base & "\src"
    ElseIf Dir(base & "\release\src", vbDirectory) <> "" Then
        SourceDir = base & "\release\src"
    ElseIf Dir(base & "\*.bas") <> "" Then
        SourceDir = base
    End If
End Function
