Attribute VB_Name = "modResultAxes"
Option Explicit

Private Const SH_THIRD As String = "THIRD_OCTAVE"
Private Const SH_OVERALL As String = "OVERALL"

Public Sub EnsureResultAxisScaleControls(Optional ByVal silent As Boolean = False)
    Dim messageText As String
    On Error GoTo fail
    EnsureSheetAxisScale ThisWorkbook.Worksheets(SH_THIRD), "third", "X3"
    EnsureSheetAxisScale ThisWorkbook.Worksheets(SH_OVERALL), "overall", "AB5"
    Exit Sub
fail:
    messageText = modLog.ReportError("EnsureResultAxisScaleControls", _
        "ensure result Y-axis scale controls", Err.Number, Err.Description)
    If silent Then Err.Raise Err.Number, "EnsureResultAxisScaleControls", Err.Description
    MsgBox messageText, vbExclamation, "AXIS SCALE"
End Sub

Public Sub ApplyResultAxisScale(ByVal ws As Worksheet)
    Dim prefixText As String, co As ChartObject
    If ws Is Nothing Then Exit Sub
    prefixText = ResultAxisPrefix(ws.Name)
    If Len(prefixText) = 0 Then Exit Sub
    For Each co In ws.ChartObjects
        ApplyOneValueAxis co.Chart.Axes(xlValue), _
                          NamedValue(prefixText & "AxYmin"), _
                          NamedValue(prefixText & "AxYmax"), _
                          NamedValue(prefixText & "AxYmajor"), _
                          NamedValue(prefixText & "AxYminor")
    Next co
End Sub

Private Sub EnsureSheetAxisScale(ByVal ws As Worksheet, ByVal prefixText As String, _
                                 ByVal firstInputAddress As String)
    Dim namesText As Variant, rowOffset As Long, inputCell As Range
    Dim co As ChartObject, ax As Axis
    Dim wasNew As Boolean
    namesText = Array("AxYmin", "AxYmax", "AxYmajor", "AxYminor")
    For rowOffset = LBound(namesText) To UBound(namesText)
        Set inputCell = ws.Range(firstInputAddress).Offset(rowOffset, 0)
        wasNew = EnsureName(prefixText & CStr(namesText(rowOffset)), inputCell)
        If wasNew Then
            Set co = Nothing
            On Error Resume Next
            Set co = ws.ChartObjects(1)
            If Not co Is Nothing Then Set ax = co.Chart.Axes(xlValue)
            On Error GoTo 0
            If Not ax Is Nothing Then inputCell.Value2 = AxisSetting(ax, rowOffset)
        End If
    Next rowOffset
End Sub

Private Function EnsureName(ByVal nameText As String, ByVal target As Range) As Boolean
    Dim nm As Name
    On Error Resume Next
    Set nm = ThisWorkbook.Names(nameText)
    On Error GoTo 0
    If nm Is Nothing Then
        ThisWorkbook.Names.Add Name:=nameText, RefersTo:="='" & _
            Replace(target.Parent.Name, "'", "''") & "'!" & target.Address
        EnsureName = True
    Else
        nm.RefersTo = "='" & Replace(target.Parent.Name, "'", "''") & "'!" & target.Address
    End If
End Function

Private Function AxisSetting(ByVal ax As Axis, ByVal settingIndex As Long) As Variant
    On Error Resume Next
    Select Case settingIndex
        Case 0: AxisSetting = ax.MinimumScale
        Case 1: AxisSetting = ax.MaximumScale
        Case 2: AxisSetting = ax.MajorUnit
        Case 3: AxisSetting = ax.MinorUnit
    End Select
    On Error GoTo 0
End Function

Private Function NamedValue(ByVal nameText As String) As Variant
    On Error Resume Next
    NamedValue = ThisWorkbook.Names(nameText).RefersToRange.Value2
    On Error GoTo 0
End Function

Private Sub ApplyOneValueAxis(ByVal ax As Axis, ByVal minV As Variant, ByVal maxV As Variant, _
                              ByVal majorV As Variant, ByVal minorV As Variant)
    If IsNumeric(minV) And Len(minV & "") > 0 And _
       IsNumeric(maxV) And Len(maxV & "") > 0 Then
        If CDbl(minV) >= CDbl(maxV) Then Exit Sub
    End If
    On Error Resume Next
    ax.MinimumScaleIsAuto = True
    ax.MaximumScaleIsAuto = True
    ax.MajorUnitIsAuto = True
    ax.MinorUnitIsAuto = True
    If IsNumeric(minV) And Len(minV & "") > 0 Then ax.MinimumScale = CDbl(minV)
    If IsNumeric(maxV) And Len(maxV & "") > 0 Then ax.MaximumScale = CDbl(maxV)
    If IsNumeric(majorV) And Len(majorV & "") > 0 And CDbl(majorV) > 0 Then ax.MajorUnit = CDbl(majorV)
    If IsNumeric(minorV) And Len(minorV & "") > 0 And CDbl(minorV) > 0 Then ax.MinorUnit = CDbl(minorV)
    On Error GoTo 0
End Sub

Private Function ResultAxisPrefix(ByVal sheetName As String) As String
    Select Case sheetName
        Case SH_THIRD: ResultAxisPrefix = "third"
        Case SH_OVERALL: ResultAxisPrefix = "overall"
    End Select
End Function
