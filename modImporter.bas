Attribute VB_Name = "modImporter"
Option Explicit

Public Sub ImportModule()
    Dim picker As FileDialog, file As Variant, imported As Long, failed As String
    Set picker = Application.FileDialog(msoFileDialogFilePicker)
    With picker
        .Title = "Select VBA modules or worksheet code to import"
        .AllowMultiSelect = True
        .Filters.Clear
        .Filters.Add "VBA code", "*.bas;*.txt"
        If .Show <> -1 Then Exit Sub
        For Each file In .SelectedItems
            If ImportOneCodeFile(CStr(file), failed) Then imported = imported + 1
        Next file
    End With
    MsgBox imported & " VBA file(s) imported." & _
        IIf(failed = "", "", vbCrLf & "Failed:" & failed), _
        IIf(failed = "", vbInformation, vbExclamation), "VBA import"
End Sub

Public Function ImportCodeFile(ByVal path As String, _
                               Optional ByVal silent As Boolean = False) As Boolean
    Dim failed As String
    ImportCodeFile = ImportOneCodeFile(path, failed)
    If Not silent Then
        If ImportCodeFile Then
            MsgBox "VBA file imported: " & path, vbInformation, "VBA import"
        Else
            MsgBox "Import failed:" & failed, vbExclamation, "VBA import"
        End If
    End If
End Function

Private Function ImportOneCodeFile(ByVal path As String, ByRef failed As String) As Boolean
    Dim extension As String
    extension = LCase$(Mid$(path, InStrRev(path, ".")))
    If extension = ".bas" Then
        ImportOneCodeFile = ImportOneBas(path, failed)
    ElseIf extension = ".txt" Then
        ImportOneCodeFile = ImportOneSheetText(path, failed)
    Else
        failed = failed & vbCrLf & "- " & path & ": Unsupported file type"
    End If
End Function

Public Sub ExportAllBas()
    Dim picker As FileDialog
    Dim folder As String
    Set picker = Application.FileDialog(msoFileDialogFolderPicker)
    picker.Title = "Select folder for VBA modules and worksheet code"
    If picker.Show <> -1 Then Exit Sub
    folder = picker.SelectedItems(1)
    ExportAllVbaToFolder folder, False
End Sub

Public Function ExportAllVbaToFolder(ByVal folder As String, _
                                     Optional ByVal silent As Boolean = False) As Boolean
    Dim component As Object, ws As Worksheet
    Dim path As String, standardCount As Long, sheetCount As Long
    Dim fileNumber As Integer, body As String
    On Error GoTo catch

    folder = Trim$(folder)
    If Len(folder) = 0 Or Len(Dir$(folder, vbDirectory)) = 0 Then
        Err.Raise vbObjectError + 4, "ExportAllVbaToFolder", "Invalid export folder"
    End If

    For Each component In ThisWorkbook.VBProject.VBComponents
        If component.Type = 1 Then
            path = folder & "\" & component.Name & ".bas"
            If Len(Dir$(path)) > 0 Then Kill path
            component.Export path
            standardCount = standardCount + 1
        End If
    Next component

    For Each ws In ThisWorkbook.Worksheets
        Set component = ThisWorkbook.VBProject.VBComponents(ws.CodeName)
        If component.CodeModule.CountOfLines > 0 Then
            body = component.CodeModule.Lines(1, component.CodeModule.CountOfLines)
            path = folder & "\sht" & ws.Name & ".txt"
            If Len(Dir$(path)) > 0 Then Kill path
            fileNumber = FreeFile
            Open path For Output As #fileNumber
            Print #fileNumber, body;
            Close #fileNumber
            fileNumber = 0
            sheetCount = sheetCount + 1
        End If
    Next ws

    If Not silent Then
        MsgBox standardCount & " standard module(s) and " & sheetCount & _
               " worksheet code file(s) exported.", vbInformation, "VBA export"
    End If
    ExportAllVbaToFolder = True
    Exit Function
catch:
    On Error Resume Next
    If fileNumber > 0 Then Close #fileNumber
    On Error GoTo 0
    If Not silent Then MsgBox "Export failed: " & Err.Description, vbExclamation, "VBA export"
End Function

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

Private Function ImportOneSheetText(ByVal path As String, ByRef failed As String) As Boolean
    Dim project As Object, component As Object, targetSheet As Worksheet
    Dim fileNumber As Integer, text As String, body As String
    Dim fileName As String, sheetKey As String
    On Error GoTo catch

    If Len(Dir$(path)) = 0 Then Err.Raise vbObjectError + 1, , "File not found"
    fileName = Mid$(path, InStrRev(path, "\") + 1)
    sheetKey = Left$(fileName, Len(fileName) - 4)
    If StrComp(Left$(sheetKey, 3), "sht", vbTextCompare) = 0 Then _
        sheetKey = Mid$(sheetKey, 4)

    Set targetSheet = WorksheetFromImportName(sheetKey)
    If targetSheet Is Nothing Then
        Err.Raise vbObjectError + 3, , _
                  "Worksheet not found for " & fileName & _
                  ". Name the file sht<worksheet name>.txt."
    End If

    fileNumber = FreeFile
    Open path For Binary Access Read As #fileNumber
    If LOF(fileNumber) > 0 Then text = Input$(LOF(fileNumber), fileNumber)
    Close #fileNumber
    body = CodeBodyWithoutAttributes(text)
    If Len(Trim$(body)) = 0 Then Err.Raise vbObjectError + 1, , "Empty worksheet code file"

    Set project = ThisWorkbook.VBProject
    Set component = project.VBComponents(targetSheet.CodeName)
    With component.CodeModule
        If .CountOfLines > 0 Then .DeleteLines 1, .CountOfLines
        .AddFromString body
    End With
    ImportOneSheetText = True
    Exit Function
catch:
    On Error Resume Next
    If fileNumber > 0 Then Close #fileNumber
    On Error GoTo 0
    failed = failed & vbCrLf & "- " & path & ": " & Err.Description
End Function

Private Function WorksheetFromImportName(ByVal sheetKey As String) As Worksheet
    Dim ws As Worksheet
    On Error Resume Next
    Set WorksheetFromImportName = ThisWorkbook.Worksheets(sheetKey)
    On Error GoTo 0
    If Not WorksheetFromImportName Is Nothing Then Exit Function

    For Each ws In ThisWorkbook.Worksheets
        If StrComp(ws.CodeName, sheetKey, vbTextCompare) = 0 Or _
           StrComp(ws.CodeName, "sht" & sheetKey, vbTextCompare) = 0 Then
            Set WorksheetFromImportName = ws
            Exit Function
        End If
    Next ws
End Function

Private Function CodeBodyWithoutAttributes(ByVal text As String) As String
    Dim line As Variant, value As String, body As String
    For Each line In Split(Replace(text, vbCrLf, vbLf), vbLf)
        value = CStr(line)
        If StrComp(Left$(LTrim$(value), 10), "Attribute ", vbTextCompare) <> 0 Then
            If body <> "" Then body = body & vbCrLf
            body = body & value
        End If
    Next line
    CodeBodyWithoutAttributes = body
End Function


