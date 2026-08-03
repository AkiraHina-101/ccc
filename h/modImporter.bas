Attribute VB_Name = "modImporter"
Option Explicit

Public Sub ImportModule()
    Dim picker As FileDialog, file As Variant, imported As Long, failed As String
    Set picker = Application.FileDialog(msoFileDialogFilePicker)
    With picker
        .Title = "Select VBA modules to import"
        .AllowMultiSelect = True
        .Filters.Clear
        .Filters.Add "VBA modules", "*.bas"
        If .Show <> -1 Then Exit Sub
        For Each file In .SelectedItems
            If ImportOneBas(CStr(file), failed) Then imported = imported + 1
        Next file
    End With
    MsgBox imported & " module(s) imported." & _
        IIf(failed = "", "", vbCrLf & "Failed:" & failed), _
        IIf(failed = "", vbInformation, vbExclamation), "VBA import"
End Sub

Public Sub ExportAllBas()
    Dim picker As FileDialog, component As Object
    Dim folder As String, path As String, exported As Long
    Set picker = Application.FileDialog(msoFileDialogFolderPicker)
    picker.Title = "Select export folder"
    If picker.Show <> -1 Then Exit Sub
    folder = picker.SelectedItems(1)
    For Each component In ThisWorkbook.VBProject.VBComponents
        If component.Type = 1 Then
            path = folder & "\" & component.Name & ".bas"
            If Len(Dir$(path)) > 0 Then Kill path
            component.Export path
            exported = exported + 1
        End If
    Next component
    MsgBox exported & " module(s) exported.", vbInformation, "VBA export"
End Sub

Private Function ImportOneBas(ByVal path As String, ByRef failed As String) As Boolean
    Dim project As Object, component As Object, fileNumber As Integer
    Dim text As String, line As Variant, value As String, moduleName As String, body As String
    On Error GoTo catch
    If Len(Dir$(path)) = 0 Then Err.Raise vbObjectError + 1, , "File not found"
    fileNumber = FreeFile
    Open path For Binary Access Read As #fileNumber
    If LOF(fileNumber) > 0 Then text = Input$(LOF(fileNumber), fileNumber)
    Close #fileNumber
    For Each line In Split(Replace(text, vbCrLf, vbLf), vbLf)
        value = CStr(line)
        If InStr(1, value, "Attribute VB_Name =", vbTextCompare) > 0 Then
            moduleName = Trim$(Replace(Split(value, "=")(1), """", ""))
        ElseIf StrComp(Left$(LTrim$(value), 10), "Attribute ", vbTextCompare) <> 0 Then
            If body <> "" Then body = body & vbCrLf
            body = body & value
        End If
    Next line
    If moduleName = "" Or body = "" Then Err.Raise vbObjectError + 1, , "Invalid .bas file"
    Set project = ThisWorkbook.VBProject
    On Error Resume Next
    Set component = project.VBComponents(moduleName)
    On Error GoTo catch
    If component Is Nothing Then
        project.VBComponents.Import path
    ElseIf component.Type = 1 Then
        With component.CodeModule
            If .CountOfLines > 0 Then .DeleteLines 1, .CountOfLines
            .AddFromString body
        End With
    Else
        Err.Raise vbObjectError + 2, , moduleName & " is not a standard module"
    End If
    ImportOneBas = True
    Exit Function
catch:
    failed = failed & vbCrLf & "- " & path & ": " & Err.Description
End Function
