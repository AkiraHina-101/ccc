Attribute VB_Name = "modRangePaste"
Option Explicit

' Ctrl+C a source range, select one destination cell, then run this macro.
' Excel performs the normal relative-reference shift. External workbook
' qualifiers are then removed only from formulas in the pasted range.
Public Sub ApplyRangePaste()
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
