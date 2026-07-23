Attribute VB_Name = "modStyle"
Option Explicit

' Chart style commands for PLOT.

' ---------- target selection ----------

' The charts an action applies to: the selected chart, else all on PLOT.
Private Function TargetCharts() As Collection
    Dim c As Collection, co As ChartObject
    Set c = New Collection
    If Not ActiveChart Is Nothing Then
        c.Add ActiveChart
    Else
        For Each co In Worksheets("SPL").ChartObjects
            c.Add co.Chart
        Next co
    End If
    Set TargetCharts = c
End Function

' ---------- series color ----------

' Button: recolor the selected NB/OB series. Without a selected series, asks
' for model and style group (NB / OB / PROJ / ALL).
Public Sub QuickSeriesColor()
    Dim mdl As String, bandKey As String, hex As String, clr As Long

    mdl = ModelOfSelection()
    bandKey = BandOfSelection()
    If Len(mdl) = 0 Then
        mdl = Trim$(InputBox("Model name to recolor (must match CONFIG MODELS):", "Series color"))
        If Len(mdl) = 0 Then Exit Sub
    End If
    If Len(bandKey) = 0 Then
        bandKey = NormalizeBandKey(InputBox("Style group: NB, OB, PROJ or ALL:", "Series color", "ALL"))
        If Len(bandKey) = 0 Then Exit Sub
    End If

    hex = Trim$(InputBox("New color as hex RRGGBB (e.g. C00000 = red):", "Series color", "C00000"))
    If Len(hex) = 0 Then Exit Sub
    If Not TryParseHex(hex, clr) Then
        MsgBox "Invalid hex color: " & hex, vbExclamation
        Exit Sub
    End If

    If Not SetModelBandColorLong(mdl, bandKey, clr) Then
        MsgBox "Model not found in CONFIG MODELS: " & mdl, vbExclamation
    End If
End Sub

' Backward-compatible helper: set all three style-group colors together.
Public Function SetModelColorRGB(ByVal modelName As String, ByVal r As Long, _
                                  ByVal g As Long, ByVal b As Long) As Boolean
    SetModelColorRGB = SetModelBandColorLong(modelName, "ALL", RGB(r, g, b))
End Function

' Testable helper for one CONFIG group: NB, OB, PROJ or ALL.
Public Function SetModelBandColorRGB(ByVal modelName As String, ByVal bandKey As String, _
                                     ByVal r As Long, ByVal g As Long, ByVal b As Long) As Boolean
    SetModelBandColorRGB = SetModelBandColorLong(modelName, NormalizeBandKey(bandKey), RGB(r, g, b))
End Function

' Core: persist the chosen group color and apply live NB/OB series immediately.
Private Function SetModelBandColorLong(ByVal modelName As String, ByVal bandKey As String, _
                                       ByVal clr As Long) As Boolean
    Dim wsCfg As Worksheet, mR0 As Long, mC As Long, j As Long, jHit As Long
    Set wsCfg = Worksheets("CONFIG")
    bandKey = NormalizeBandKey(bandKey)
    If Len(bandKey) = 0 Then Exit Function
    mR0 = wsCfg.Range("hdrModels").Row + 1
    mC = wsCfg.Range("hdrModels").Column

    jHit = 0
    j = 0
    Do While Len(Trim$(wsCfg.Cells(mR0 + j, mC).Value)) > 0
        If StrComp(Trim$(wsCfg.Cells(mR0 + j, mC).Value), modelName, vbTextCompare) = 0 Then
            jHit = j + 1                      ' 1-based model index
            Exit Do
        End If
        j = j + 1
    Loop
    If jHit = 0 Then Exit Function

    ' persist so RebuildDashboard keeps each group's independent color
    If bandKey = "NB" Or bandKey = "ALL" Then _
        wsCfg.Cells(mR0 + jHit - 1, mC + STYLE_NB_COLOR_OFS).Interior.Color = clr
    If bandKey = "OB" Or bandKey = "ALL" Then _
        wsCfg.Cells(mR0 + jHit - 1, mC + STYLE_OB_COLOR_OFS).Interior.Color = clr
    If bandKey = "PROJ" Or bandKey = "ALL" Then _
        wsCfg.Cells(mR0 + jHit - 1, mC + STYLE_PROJ_COLOR_OFS).Interior.Color = clr

    ' Apply by the series name, never by its ordinal position.  Some models
    ' have only one series, so an unqualified series defaults to NB styling.
    RefreshSeriesColors
    modSPLControls.RefreshModelControlColors
    SetModelBandColorLong = True
End Function

' Reapply CONFIG styling to all SPL series.  A series named "M1 NB" maps to
' the M1 Narrowband columns; "M1 OB" maps to Octaveband.  A one-series model
' (for example "M1") defaults to its Narrowband style.
Public Sub RefreshSeriesColors()
    Dim wsCfg As Worksheet, co As ChartObject, ser As Series
    Set wsCfg = Worksheets("CONFIG")
    For Each co In Worksheets("SPL").ChartObjects
        For Each ser In co.Chart.SeriesCollection
            ApplyConfiguredSeriesStyle wsCfg, ser
        Next ser
    Next co
    modSPLControls.RefreshModelControlColors
End Sub

Private Sub ApplyConfiguredSeriesStyle(ByVal wsCfg As Worksheet, ByVal ser As Series)
    Dim modelName As String, bandKey As String, styleRow As Long, styleCol As Long
    Dim colorCell As Range, dashValue As Variant, weightValue As Variant, clr As Long
    ParseSeriesStyleKey CStr(ser.Name), modelName, bandKey
    styleRow = ModelStyleRow(wsCfg, modelName)
    If styleRow = 0 Then Exit Sub

    styleCol = wsCfg.Range("hdrModels").Column + _
               IIf(bandKey = "OB", STYLE_OB_COLOR_OFS, STYLE_NB_COLOR_OFS)
    Set colorCell = wsCfg.Cells(styleRow, styleCol)
    If colorCell.Interior.ColorIndex = xlColorIndexNone And bandKey = "OB" Then _
        Set colorCell = wsCfg.Cells(styleRow, wsCfg.Range("hdrModels").Column + STYLE_NB_COLOR_OFS)
    If colorCell.Interior.ColorIndex = xlColorIndexNone Then
        clr = RGB(96, 112, 126)
    Else
        clr = colorCell.Interior.Color
    End If

    dashValue = wsCfg.Cells(styleRow, styleCol + 1).Value2
    weightValue = wsCfg.Cells(styleRow, styleCol + 2).Value2
    On Error Resume Next
    ser.Format.Line.ForeColor.RGB = clr
    If IsNumeric(dashValue) And CLng(dashValue) > 0 Then ser.Format.Line.DashStyle = CLng(dashValue)
    If IsNumeric(weightValue) And CSng(weightValue) > 0 Then ser.Format.Line.Weight = CSng(weightValue)
    On Error GoTo 0
End Sub

Private Sub ParseSeriesStyleKey(ByVal seriesName As String, ByRef modelName As String, _
                                ByRef bandKey As String)
    Dim p As Long, suffix As String
    seriesName = Trim$(seriesName): bandKey = "NB": modelName = seriesName
    p = InStrRev(seriesName, " ")
    If p > 1 Then
        suffix = NormalizeBandKey(Mid$(seriesName, p + 1))
        If suffix = "NB" Or suffix = "OB" Then
            modelName = Trim$(Left$(seriesName, p - 1))
            bandKey = suffix
        End If
    End If
End Sub

Private Function ModelStyleRow(ByVal wsCfg As Worksheet, ByVal modelName As String) As Long
    Dim r As Long, modelCol As Long
    modelCol = wsCfg.Range("hdrModels").Column
    r = wsCfg.Range("hdrModels").Row + 1
    Do While Len(Trim$(CStr(wsCfg.Cells(r, modelCol).Value2))) > 0
        If StrComp(Trim$(CStr(wsCfg.Cells(r, modelCol).Value2)), modelName, vbTextCompare) = 0 Then
            ModelStyleRow = r
            Exit Function
        End If
        r = r + 1
    Loop
End Function

' Map the current selection (a Series) back to its model name via the
' NB/OB legend label "MODEL NB" / "MODEL OB" in CONFIG technical state.
Private Function ModelOfSelection() As String
    Dim nm As String, p As Long
    nm = SelectionSeriesName()
    If Len(nm) = 0 Then Exit Function
    p = InStrRev(nm, " ")
    If p > 1 Then ModelOfSelection = Left$(nm, p - 1) Else ModelOfSelection = nm
End Function

Private Function BandOfSelection() As String
    Dim nm As String, p As Long
    nm = SelectionSeriesName()
    If Len(nm) = 0 Then Exit Function
    p = InStrRev(nm, " ")
    If p > 0 Then BandOfSelection = NormalizeBandKey(Mid$(nm, p + 1))
End Function

Private Function SelectionSeriesName() As String
    Dim s As Series
    On Error Resume Next
    Set s = Selection
    If Not s Is Nothing Then SelectionSeriesName = CStr(s.Name)
    On Error GoTo 0
End Function

Private Function NormalizeBandKey(ByVal s As String) As String
    Select Case UCase$(Trim$(s))
        Case "NB", "NARROW", "NARROWBAND", "NARROW_BAND": NormalizeBandKey = "NB"
        Case "OB", "OCTAVE", "OCTAVEBAND", "OCTAVE_BAND": NormalizeBandKey = "OB"
        Case "PROJ", "PROJECTION", "PROJECTION_LINE": NormalizeBandKey = "PROJ"
        Case "ALL": NormalizeBandKey = "ALL"
    End Select
End Function

' ---------- gridlines ----------

Public Sub ToggleGridlinesX()
    CycleGridlines xlCategory
End Sub

Public Sub ToggleGridlinesY()
    CycleGridlines xlValue
End Sub

Private Function ActiveSheetCharts() As Collection
    Dim result As New Collection, ws As Worksheet, co As ChartObject
    On Error GoTo done
    Set ws = Application.ActiveSheet
    If Not ws.Parent Is ThisWorkbook Then GoTo done
    If ws.Name <> "SPL" Then GoTo done
    For Each co In ws.ChartObjects
        result.Add co.Chart
    Next co
done:
    Set ActiveSheetCharts = result
End Function

' Cycle the target charts through: none -> major -> major+minor -> none,
' using the FIRST target chart's current state to pick the next state.
Private Sub CycleGridlines(ByVal axType As Long)
    Dim charts As Collection, ch As Variant, ax As Axis
    Dim wantMajor As Boolean, wantMinor As Boolean, hasMajor As Boolean, hasMinor As Boolean
    Set charts = ActiveSheetCharts()
    If charts.Count = 0 Then Exit Sub

    On Error Resume Next
    Set ax = charts(1).Axes(axType)
    hasMajor = ax.HasMajorGridlines
    hasMinor = ax.HasMinorGridlines
    On Error GoTo 0

    If Not hasMajor And Not hasMinor Then
        wantMajor = True: wantMinor = False
    ElseIf hasMajor And Not hasMinor Then
        wantMajor = True: wantMinor = True
    Else
        wantMajor = False: wantMinor = False
    End If

    ApplyGridlines (axType = xlValue), wantMajor, wantMinor
End Sub

' Testable: set gridline visibility on target charts. isY selects the
' value (Y) axis; otherwise the category (X) axis.
Public Sub ApplyGridlines(ByVal isY As Boolean, ByVal major As Boolean, ByVal minor As Boolean)
    Dim ch As Variant, ax As Axis, axType As Long
    axType = IIf(isY, xlValue, xlCategory)
    For Each ch In ActiveSheetCharts()
        On Error Resume Next
        Set ax = ch.Axes(axType)
        ax.HasMajorGridlines = major
        ax.HasMinorGridlines = minor
        On Error GoTo 0
    Next ch
End Sub

' ---------- axis scale ----------

Public Sub SetAxisScale()
    Dim axS As String, isY As Boolean
    axS = UCase$(Trim$(InputBox("Which axis? X or Y:", "Axis scale", "Y")))
    If axS <> "X" And axS <> "Y" Then Exit Sub
    isY = (axS = "Y")

    Dim mn As String, mx As String, maj As String, mnr As String
    mn = Trim$(InputBox("Minimum (blank = auto):", "Axis scale"))
    mx = Trim$(InputBox("Maximum (blank = auto):", "Axis scale"))
    maj = Trim$(InputBox("Major unit (blank = auto):", "Axis scale"))
    mnr = Trim$(InputBox("Minor unit (blank = auto):", "Axis scale"))

    ApplyAxisScale isY, mn, mx, maj, mnr
End Sub

' Persist scale inputs into the CONFIG X/Y table, then apply to all charts.
' Blank/non-numeric means "auto" for that setting.
Public Sub ApplyAxisScale(ByVal isY As Boolean, ByVal minV As String, ByVal maxV As String, _
                          ByVal majV As String, ByVal minorV As String)
    Dim prefix As String
    prefix = IIf(isY, "axY", "axX")
    WriteScaleValue Worksheets("SPL").Range(prefix & "min"), minV
    WriteScaleValue Worksheets("SPL").Range(prefix & "max"), maxV
    WriteScaleValue Worksheets("SPL").Range(prefix & "major"), majV
    WriteScaleValue Worksheets("SPL").Range(prefix & "minor"), minorV
    modSPLControls.ApplyConfiguredAxes
End Sub

Private Sub WriteScaleValue(cell As Range, ByVal s As String)
    If IsNumeric(s) And Len(Trim$(s)) > 0 Then
        cell.Value = CDbl(s)
    Else
        cell.ClearContents
    End If
End Sub

' ---------- helpers ----------

' Parse "RRGGBB" (optionally #-prefixed) into a VBA color long (BGR order).
Private Function TryParseHex(ByVal hex As String, ByRef clr As Long) As Boolean
    Dim r As Long, g As Long, b As Long
    hex = Replace(hex, "#", "")
    If Len(hex) <> 6 Then Exit Function
    If Not (hex Like "[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]") Then Exit Function
    r = CLng("&H" & Mid$(hex, 1, 2))
    g = CLng("&H" & Mid$(hex, 3, 2))
    b = CLng("&H" & Mid$(hex, 5, 2))
    clr = RGB(r, g, b)
    TryParseHex = True
End Function
