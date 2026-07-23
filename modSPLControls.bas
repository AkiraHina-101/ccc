Attribute VB_Name = "modSPLControls"
Option Explicit

' SPL-only controls: user-owned shapes/layout; CONFIG owns model state.

Public Sub SyncModelControlsOnly()
    SyncModelToggleButtons False
    LinkChartDataToSeries False
End Sub

Public Sub ToggleDashboardFilter(Optional ByVal shapeName As String = "")
    Dim ws As Worksheet, cfg As Worksheet, shp As Shape, stateCell As Range
    Dim p As Long, payload As String, label As String, oldCalc As XlCalculation, isOn As Boolean
    On Error GoTo fail
    Set ws = Worksheets("SPL"): Set cfg = Worksheets("CONFIG")
    If Len(shapeName) = 0 Then shapeName = CStr(Application.Caller)
    Set shp = ws.Shapes(shapeName): payload = shp.AlternativeText: p = InStr(payload, "|")
    If p < 2 Then Err.Raise vbObjectError + 31, , "Invalid toggle metadata: " & shp.Name
    Set stateCell = cfg.Range(Left$(payload, p - 1)): label = Mid$(payload, p + 1)
    oldCalc = Application.Calculation: Application.Calculation = xlCalculationManual
    isOn = Not ToggleIsEnabled(stateCell.Value2): stateCell.Value2 = isOn
    If Left$(shp.Name, 6) = "cbMdl_" Then
        StyleModelToggle shp, isOn, label
        CalculateModelBlocks ws, label
    Else
        StyleBandToggle shp, isOn
        ApplyBandSeriesVisibility ws, label, isOn
    End If
    Application.Calculation = oldCalc
    Exit Sub
fail:
    On Error Resume Next: Application.Calculation = oldCalc: On Error GoTo 0
    modLog.ReportError "ToggleDashboardFilter", "update control", Err.Number, Err.Description
End Sub

Public Sub SyncBandVisibility()
    Dim ws As Worksheet, cfg As Worksheet
    Set ws = Worksheets("SPL"): Set cfg = Worksheets("CONFIG")
    ApplyBandSeriesVisibility ws, "Narrowband", ToggleIsEnabled(cfg.Range("AO50").Value2)
    ApplyBandSeriesVisibility ws, "Octaveband", ToggleIsEnabled(cfg.Range("AO51").Value2)
End Sub

Public Sub SyncModelToggleButtons(Optional ByVal showMissing As Boolean = True)
    Dim ws As Worksheet, cfg As Worksheet, shp As Shape, target As Range
    Dim r As Long, i As Long, modelName As String, missing As String
    Set ws = Worksheets("SPL"): Set cfg = Worksheets("CONFIG"): cfg.Range("AP3").Value2 = "Enable"
    r = 4: i = 1
    Do While Len(Trim$(CStr(cfg.Cells(r, "AO").Value2))) > 0
        modelName = Trim$(CStr(cfg.Cells(r, "AO").Value2))
        If Len(CStr(cfg.Cells(r, "AP").Value2)) = 0 Then cfg.Cells(r, "AP").Value2 = True
        Set target = NamedSPLCell("plotModelName_" & i)
        If target Is Nothing Then AddMissing missing, "Named Range: plotModelName_" & i Else target.Value2 = modelName
        Set shp = FindShape(ws, "cbMdl_" & i)
        If shp Is Nothing Then
            AddMissing missing, "Shape on SPL: cbMdl_" & i
        Else
            shp.AlternativeText = "$AP$" & r & "|" & modelName: shp.OnAction = "ToggleDashboardFilter"
            StyleModelToggle shp, ToggleIsEnabled(cfg.Cells(r, "AP").Value2), modelName
        End If
        r = r + 1: i = i + 1
    Loop
    If Len(missing) > 0 Then
        Debug.Print "Model toggle map missing:" & missing
        Application.StatusBar = "Model toggle map incomplete. See Immediate Window."
        If showMissing Then MsgBox "Create these objects:" & missing, vbExclamation, "Model toggle map"
    End If
End Sub

Public Sub ApplyConfiguredAxes()
    Dim ws As Worksheet, co As ChartObject
    Set ws = Worksheets("SPL")
    For Each co In ws.ChartObjects
        SetAxis co.Chart.Axes(xlCategory), ws.Range("axXmin"), ws.Range("axXmax"), ws.Range("axXmajor"), ws.Range("axXminor")
        SetAxis co.Chart.Axes(xlValue), ws.Range("axYmin"), ws.Range("axYmax"), ws.Range("axYmajor"), ws.Range("axYminor")
    Next co
End Sub

Public Function GetModelDisplayColor(ByVal modelIndex As Long) As Long
    Dim cfg As Worksheet, hdr As Range, c As Range
    On Error GoTo fallback
    Set cfg = Worksheets("CONFIG"): Set hdr = cfg.Range("hdrModels")
    If modelIndex < 1 Or Len(Trim$(CStr(hdr.Offset(modelIndex, 0).Value2))) = 0 Then GoTo fallback
    Set c = hdr.Offset(modelIndex, STYLE_NB_COLOR_OFS)
    If c.Interior.ColorIndex <> xlColorIndexNone Then GetModelDisplayColor = c.Interior.Color: Exit Function
fallback:
    GetModelDisplayColor = RGB(96, 112, 126)
End Function

Public Sub RefreshModelControlColors()
    Dim ws As Worksheet, cfg As Worksheet, hdr As Range, shp As Shape, target As Range, i As Long, clr As Long
    Set ws = Worksheets("SPL"): Set cfg = Worksheets("CONFIG"): Set hdr = cfg.Range("hdrModels")
    i = 1
    Do While Len(Trim$(CStr(hdr.Offset(i, 0).Value2))) > 0
        clr = GetModelDisplayColor(i): Set target = NamedSPLCell("plotModelName_" & i)
        If Not target Is Nothing Then target.Font.Color = clr
        Set shp = FindShape(ws, "cbMdl_" & i)
        If Not shp Is Nothing Then StyleModelToggle shp, ToggleIsEnabled(cfg.Cells(i + 3, "AP").Value2), CStr(hdr.Offset(i, 0).Value2)
        i = i + 1
    Loop
End Sub

Private Sub CalculateModelBlocks(ByVal ws As Worksheet, ByVal modelName As String)
    Dim firstCol As Long, lastCol As Long, c As Long, nextCol As Long, lastBlockCol As Long
    firstCol = CLng(Worksheets("CONFIG").Range("AV4").Value2): If firstCol < 1 Then firstCol = 43
    lastCol = ws.Cells(3, ws.Columns.Count).End(xlToLeft).Column
    For c = firstCol To lastCol
        If StrComp(CStr(ws.Cells(3, c).Value2), modelName, vbTextCompare) = 0 Then
            lastBlockCol = lastCol
            For nextCol = c + 1 To lastCol
                If Len(CStr(ws.Cells(3, nextCol).Value2)) > 0 Then
                    lastBlockCol = nextCol - 1
                    Exit For
                End If
            Next nextCol
            ws.Range(ws.Cells(6, c), ws.Cells(234, lastBlockCol)).Calculate
        End If
    Next c
End Sub

Private Sub CalculateBandBlocks(ByVal ws As Worksheet, ByVal bandName As String)
    Dim firstCol As Long, lastCol As Long, c As Long, nextCol As Long
    Dim modelName As String, occurrence As Long, wantedOccurrence As Long
    Dim seen As Object

    ' Each model appears once in the NB block and once in the OB block.
    ' A band toggle only needs to recalculate its own occurrence, not the
    ' complete dashboard result area.
    wantedOccurrence = IIf(InStr(1, bandName, "narrow", vbTextCompare) > 0, 1, 2)
    firstCol = CLng(Worksheets("CONFIG").Range("AV4").Value2)
    If firstCol < 1 Then firstCol = 43
    lastCol = ws.Cells(3, ws.Columns.Count).End(xlToLeft).Column
    Set seen = CreateObject("Scripting.Dictionary")
    seen.CompareMode = vbTextCompare

    For c = firstCol To lastCol
        modelName = Trim$(CStr(ws.Cells(3, c).Value2))
        If Len(modelName) > 0 Then
            If seen.Exists(modelName) Then
                occurrence = CLng(seen(modelName)) + 1
            Else
                occurrence = 1
            End If
            seen(modelName) = occurrence
            If occurrence = wantedOccurrence Then
                nextCol = lastCol + 1
                Dim scanCol As Long
                For scanCol = c + 1 To lastCol
                    If Len(Trim$(CStr(ws.Cells(3, scanCol).Value2))) > 0 Then
                        nextCol = scanCol
                        Exit For
                    End If
                Next scanCol
                ws.Range(ws.Cells(6, c), ws.Cells(234, nextCol - 1)).Calculate
            End If
        End If
    Next c
End Sub

Private Sub ApplyBandSeriesVisibility(ByVal ws As Worksheet, ByVal bandName As String, _
                                      ByVal enabled As Boolean)
    Dim co As ChartObject, ser As Series, suffix As String, seriesName As String
    suffix = IIf(InStr(1, bandName, "narrow", vbTextCompare) > 0, " NB", " OB")
    For Each co In ws.ChartObjects
        For Each ser In co.Chart.SeriesCollection
            On Error Resume Next
            seriesName = CStr(ser.Name)
            If StrComp(Right$(seriesName, Len(suffix)), suffix, vbTextCompare) = 0 Then _
                ser.Format.Line.Visible = IIf(enabled, msoTrue, msoFalse)
            On Error GoTo 0
        Next ser
    Next co
End Sub

Private Sub StyleModelToggle(ByVal shp As Shape, ByVal enabled As Boolean, ByVal modelName As String)
    ' Model buttons communicate state only by fill colour: model colour = shown,
    ' grey = hidden.  Labels are separate user-owned cells, never button text.
    StyleToggle shp, enabled, GetModelDisplayColor(Val(Mid$(shp.Name, 7))), ""
End Sub

Private Sub StyleBandToggle(ByVal shp As Shape, ByVal enabled As Boolean)
    ' Band buttons also use colour only; do not show a check mark or square glyph.
    StyleToggle shp, enabled, RGB(42, 126, 76), ""
End Sub

Private Sub StyleToggle(ByVal shp As Shape, ByVal enabled As Boolean, ByVal accent As Long, ByVal caption As String)
    With shp
        .Fill.Solid: .Fill.ForeColor.RGB = IIf(enabled, accent, RGB(205, 209, 214))
        .Line.ForeColor.RGB = IIf(enabled, accent, RGB(205, 209, 214))
        .TextFrame2.TextRange.Text = caption
        .TextFrame2.TextRange.Font.Fill.ForeColor.RGB = IIf(enabled, vbWhite, RGB(92, 96, 101))
        .TextFrame2.TextRange.Font.Name = UI_FONT_NAME
        .TextFrame2.TextRange.Font.Bold = msoTrue
        .TextFrame2.TextRange.ParagraphFormat.Alignment = msoAlignCenter
    End With
End Sub

Private Sub SetAxis(ByVal ax As Axis, ByVal lo As Range, ByVal hi As Range, ByVal major As Range, ByVal minor As Range)
    On Error Resume Next
    ax.MinimumScaleIsAuto = True: ax.MaximumScaleIsAuto = True: ax.MajorUnitIsAuto = True: ax.MinorUnitIsAuto = True
    If IsNumeric(lo.Value2) And Len(lo.Value2 & "") > 0 Then ax.MinimumScale = lo.Value2
    If IsNumeric(hi.Value2) And Len(hi.Value2 & "") > 0 Then ax.MaximumScale = hi.Value2
    If IsNumeric(major.Value2) And major.Value2 > 0 Then ax.MajorUnit = major.Value2
    If IsNumeric(minor.Value2) And minor.Value2 > 0 Then ax.MinorUnit = minor.Value2
End Sub

Private Function NamedSPLCell(ByVal nameText As String) As Range
    On Error Resume Next: Set NamedSPLCell = ThisWorkbook.Names(nameText).RefersToRange.Cells(1, 1): On Error GoTo 0
    If Not NamedSPLCell Is Nothing Then If NamedSPLCell.Parent.Name <> "SPL" Then Set NamedSPLCell = Nothing
End Function

Private Function FindShape(ByVal ws As Worksheet, ByVal shapeName As String) As Shape
    On Error Resume Next: Set FindShape = ws.Shapes(shapeName): On Error GoTo 0
End Function

Private Function ToggleIsEnabled(ByVal value As Variant) As Boolean
    On Error Resume Next: ToggleIsEnabled = CBool(value): On Error GoTo 0
End Function

Private Sub AddMissing(ByRef text As String, ByVal item As String)
    If InStr(1, text, item, vbTextCompare) = 0 Then text = text & vbCrLf & "- " & item
End Sub
