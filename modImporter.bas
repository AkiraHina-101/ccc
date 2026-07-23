Attribute VB_Name = "modImporter"
Option Explicit

' Interactive VBA importer. Select one or more .bas files; each selected
' standard module replaces the module with the same Attribute VB_Name.
Public Sub ImportModule()
    Dim picker As FileDialog, item As Variant, imported As Long, failed As String
    Set picker = Application.FileDialog(msoFileDialogFilePicker)
    With picker
        .Title = "Select VBA modules to import"
        .AllowMultiSelect = True
        .Filters.Clear
        .Filters.Add "VBA standard modules", "*.bas"
        If .Show <> -1 Then Exit Sub
        For Each item In .SelectedItems
            If ImportBasFile(CStr(item), failed) Then imported = imported + 1
        Next item
    End With
    If Len(failed) = 0 Then
        MsgBox imported & " module(s) imported.", vbInformation, "VBA import"
    Else
        MsgBox imported & " module(s) imported." & vbCrLf & "Failed:" & failed, vbExclamation, "VBA import"
    End If
End Sub

' Export every standard VBA module as a .bas file to a folder selected by user.
Public Sub ExportAllBas()
    Dim picker As FileDialog, folderPath As String, comp As Object, filePath As String, count As Long
    Set picker = Application.FileDialog(msoFileDialogFolderPicker)
    picker.Title = "Select folder for VBA module export"
    If picker.Show <> -1 Then Exit Sub
    folderPath = picker.SelectedItems(1)
    For Each comp In ThisWorkbook.VBProject.VBComponents
        If comp.Type = 1 Then
            filePath = folderPath & "\" & comp.Name & ".bas"
            If Dir(filePath) <> "" Then Kill filePath
            comp.Export filePath
            count = count + 1
        End If
    Next comp
    MsgBox count & " .bas module(s) exported.", vbInformation, "VBA export"
End Sub

Private Function ImportBasFile(ByVal filePath As String, ByRef failed As String) As Boolean
    Dim vbp As Object, comp As Object, moduleName As String, body As String
    On Error GoTo fail
    moduleName = BasModuleName(filePath)
    body = BasBody(filePath)
    If Len(moduleName) = 0 Or Len(body) = 0 Then Err.Raise vbObjectError + 1, , "Invalid .bas file"
    Set vbp = ThisWorkbook.VBProject
    On Error Resume Next: Set comp = vbp.VBComponents(moduleName): On Error GoTo fail
    If comp Is Nothing Then
        vbp.VBComponents.Import filePath
    ElseIf comp.Type = 1 Then
        comp.CodeModule.DeleteLines 1, comp.CodeModule.CountOfLines
        comp.CodeModule.AddFromString body
    Else
        Err.Raise vbObjectError + 2, , moduleName & " is not a standard module"
    End If
    ImportBasFile = True
    Exit Function
fail:
    failed = failed & vbCrLf & "- " & filePath & ": " & Err.Description
End Function

Private Function BasModuleName(ByVal filePath As String) As String
    Dim text As String, line As Variant
    text = ReadText(filePath)
    For Each line In Split(Replace(text, vbCrLf, vbLf), vbLf)
        If InStr(1, CStr(line), "Attribute VB_Name =", vbTextCompare) > 0 Then
            BasModuleName = Replace(Split(CStr(line), "=")(1), """", "")
            BasModuleName = Trim$(BasModuleName)
            Exit Function
        End If
    Next line
End Function

Private Function BasBody(ByVal filePath As String) As String
    Dim text As String, line As Variant, result As String
    text = ReadText(filePath)
    For Each line In Split(Replace(text, vbCrLf, vbLf), vbLf)
        If StrComp(Left$(LTrim$(CStr(line)), 10), "Attribute ", vbTextCompare) <> 0 Then
            result = result & IIf(Len(result) = 0, "", vbCrLf) & CStr(line)
        End If
    Next line
    BasBody = result
End Function

Private Function ReadText(ByVal filePath As String) As String
    Dim f As Integer
    f = FreeFile
    Open filePath For Binary Access Read As #f
    If LOF(f) > 0 Then ReadText = Input$(LOF(f), #f)
    Close #f
End Function
