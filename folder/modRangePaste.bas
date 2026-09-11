Attribute VB_Name = "modRangePaste"
Option Explicit

' Ctrl+C a source range, select one destination cell, then run this macro.
' Excel performs the normal relative-reference shift. External workbook
' qualifiers are then removed only from formulas in the pasted range.
Public Sub ApplyRangePaste()
    Dim sourceRange As Range, destination As Range

    Set sourceRange = PickPasteRange( _
        "Step 1 of 2: Select or drag the source range, then click OK.", _
        "Apply Paste - Source")
    If sourceRange Is Nothing Then Exit Sub
    If sourceRange.Areas.Count > 1 Then
        MsgBox "Select one continuous source range.", vbExclamation, "Apply Paste"
        Exit Sub
    End If

    sourceRange.Copy
    Set destination = PickPasteRange( _
        "Step 2 of 2: Select the top-left destination cell, then click OK.", _
        "Apply Paste - Destination")
    If destination Is Nothing Then
        Application.CutCopyMode = False
        Exit Sub
    End If
    Set destination = destination.Cells(1, 1)
    destination.Parent.Parent.Activate
    destination.Parent.Activate
    destination.Select
    ApplyRangePasteCore False
End Sub

Public Sub ApplyRangePasteSilent()
    ApplyRangePasteCore True
End Sub

Private Sub ApplyRangePasteCore(ByVal silent As Boolean)
    Dim destination As Range, pastedRange As Range
    Dim previousEvents As Boolean, previousScreenUpdating As Boolean
    Dim cleanedCount As Long
    Dim errorText As String

    If TypeName(Selection) <> "Range" Then
        If Not silent Then _
            MsgBox "Select one destination cell before running Apply Paste.", _
                   vbExclamation, "Apply Paste"
        Exit Sub
    End If

    Set destination = ActiveCell
    previousEvents = Application.EnableEvents
    previousScreenUpdating = Application.ScreenUpdating
    On Error GoTo failed
    Application.EnableEvents = False
    Application.ScreenUpdating = False

    destination.Select
    destination.Parent.Paste
    If TypeName(Selection) = "Range" Then
        Set pastedRange = Selection
    Else
        Set pastedRange = destination
    End If
    cleanedCount = RemoveSourceWorkbookLinks(pastedRange)

finished:
    Application.EnableEvents = previousEvents
    Application.ScreenUpdating = previousScreenUpdating
    Application.CutCopyMode = False
    If Not pastedRange Is Nothing Then pastedRange.Select
    If Err.Number = 0 And Not silent Then
        MsgBox "Paste complete. " & cleanedCount & _
               " pasted formula(s) were converted to internal workbook references.", _
               vbInformation, "Apply Paste"
    End If
    Exit Sub

failed:
    errorText = Err.Description
    Application.EnableEvents = previousEvents
    Application.ScreenUpdating = previousScreenUpdating
    Application.CutCopyMode = False
    If silent Then
        Err.Raise vbObjectError + 901, "ApplyRangePaste", errorText
    Else
        MsgBox "Nothing could be pasted from the clipboard. Copy the source range " & _
               "with Ctrl+C, select one destination cell, and try again." & _
               IIf(Len(errorText) = 0, "", vbCrLf & vbCrLf & errorText), _
               vbExclamation, "Apply Paste"
    End If
End Sub

Private Function PickPasteRange(ByVal promptText As String, _
                                ByVal titleText As String) As Range
    On Error Resume Next
    Set PickPasteRange = Application.InputBox( _
        Prompt:=promptText, Title:=titleText, Type:=8)
    On Error GoTo 0
End Function

Private Function RemoveSourceWorkbookLinks(ByVal target As Range) As Long
    Dim formulas As Range, cell As Range
    Dim oldFormula As String, newFormula As String

    On Error Resume Next
    Set formulas = target.SpecialCells(xlCellTypeFormulas)
    On Error GoTo 0
    If formulas Is Nothing Then Exit Function

    For Each cell In formulas.Cells
        oldFormula = CStr(cell.Formula)
        newFormula = InternalFormula(oldFormula)
        If StrComp(oldFormula, newFormula, vbBinaryCompare) <> 0 Then
            cell.Formula = newFormula
            RemoveSourceWorkbookLinks = RemoveSourceWorkbookLinks + 1
        End If
    Next cell
End Function

Private Function InternalFormula(ByVal formulaText As String) As String
    Dim expression As Object
    Set expression = CreateObject("VBScript.RegExp")
    expression.Global = True
    expression.IgnoreCase = True

    ' 'C:\folder\[Source.xlsm]Sheet'!A1 becomes 'Sheet'!A1.
    expression.Pattern = "'[^']*\[[^\]]+\.(xlsx|xlsm|xlsb|xls)\]([^']+)'!"
    formulaText = expression.Replace(formulaText, "'$2'!")

    ' [Source.xlsm]Sheet!A1 becomes Sheet!A1.
    expression.Pattern = "\[[^\]]+\.(xlsx|xlsm|xlsb|xls)\]"
    formulaText = expression.Replace(formulaText, "")

    InternalFormula = formulaText
End Function
