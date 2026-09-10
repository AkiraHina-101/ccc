Attribute VB_Name = "modSidebar"
Option Explicit

' Applies the active sheet's A4 zoom and positions it at the top-left view.
' Ap dung zoom tu A4 cua sheet dang dung va dua view ve goc tren trai.
Public Sub FitView()
    If Application.ActiveWindow Is Nothing Then Exit Sub
    On Error GoTo fail
    ApplySheetZoom SheetZoomValue()
    Application.ActiveWindow.ScrollRow = 1
    Application.ActiveWindow.ScrollColumn = 1
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Fit view"
End Sub

' Changes zoom using the active sheet's A4 as its independent control.
' Doi zoom va luu rieng vao A4 cua sheet dang dung.
Public Sub ChangeViewZoom()
    If TypeName(Application.Caller) <> "String" Then Exit Sub
    Select Case CStr(Application.Caller)
        Case "sbZoomUp": ZoomIn
        Case "sbZoomDown": ZoomOut
    End Select
End Sub

' Increases zoom by five percent and writes the actual value to active-sheet A4.
Public Sub ZoomIn()
    If Application.ActiveWindow Is Nothing Then Exit Sub
    ApplySheetZoom Application.Min(400, SheetZoomValue() + 5)
End Sub

' Decreases zoom by five percent and writes the actual value to active-sheet A4.
Public Sub ZoomOut()
    If Application.ActiveWindow Is Nothing Then Exit Sub
    ApplySheetZoom Application.Max(10, SheetZoomValue() - 5)
End Sub

Private Function SheetZoomValue() As Long
    Dim ws As Worksheet
    Dim value As Variant, rawValue As String
    Set ws = Application.ActiveSheet
    value = ws.Range("A4").Value2
    rawValue = Trim$(CStr(value))
    If Right$(rawValue, 1) = "%" Then
        rawValue = Trim$(Left$(rawValue, Len(rawValue) - 1))
        If IsNumeric(rawValue) Then value = CDbl(rawValue)
    ElseIf IsNumeric(value) Then
        If CDbl(value) > 0 And CDbl(value) < 1 Then value = CDbl(value) * 100
    Else
        value = Application.ActiveWindow.Zoom
    End If
    SheetZoomValue = Application.Max(10, Application.Min(400, CLng(value)))
End Function

Private Sub ApplySheetZoom(ByVal zoomValue As Long)
    If Application.ActiveWindow Is Nothing Then Exit Sub
    Application.ActiveWindow.Zoom = zoomValue
    WriteZoomToActiveSheet Application.ActiveWindow.Zoom
End Sub

Private Sub WriteZoomToActiveSheet(ByVal zoomValue As Long)
    Dim ws As Worksheet
    Set ws = Application.ActiveSheet
    With ws.Range("A4")
        .Value2 = Application.Max(10, Application.Min(400, CLng(zoomValue))) / 100
        .NumberFormat = "0%"
    End With
End Sub

' Keeps existing sidebar grid button assignments working.
' Giu macro da gan cho cac nut Grid X/Y hien co.
Public Sub ToggleGridlines()
    If TypeName(Application.Caller) <> "String" Then Exit Sub
    Select Case CStr(Application.Caller)
        Case "sbGridX": ToggleChartGridX
        Case "sbGridY": ToggleChartGridY
    End Select
End Sub

' Cycles the selected chart's primary X-axis gridlines.
' Doi luoi truc X chinh cua chart dang chon.
Public Sub ToggleChartGridX()
    CycleSelectedGrid xlCategory
End Sub

' Cycles the selected chart's primary Y-axis gridlines.
' Doi luoi truc Y chinh cua chart dang chon.
Public Sub ToggleChartGridY()
    CycleSelectedGrid xlValue
End Sub

' Applies the selected chart's next grid state to its same-prefix group.
Private Sub CycleSelectedGrid(ByVal axisType As XlAxisType)
    Dim sourceChart As Chart, targetChart As Chart, targetAxis As Axis
    Dim chartObject As chartObject, prefix As String
    Dim showMajor As Boolean, showMinor As Boolean

    On Error GoTo fail
    Set sourceChart = SelectedChart()
    If sourceChart Is Nothing Then Exit Sub
    If Not sourceChart.HasAxis(axisType, xlPrimary) Then
        MsgBox "The selected chart has no requested axis.", vbInformation, "Grid"
        Exit Sub
    End If
    Set targetAxis = sourceChart.Axes(axisType, xlPrimary)
    If Not targetAxis.HasMajorGridlines Then
        showMajor = True
    ElseIf Not targetAxis.HasMinorGridlines Then
        showMajor = True
        showMinor = True
    End If
    prefix = ChartNamePrefix(sourceChart.Parent.Name)
    For Each chartObject In Application.ActiveSheet.ChartObjects
        If ChartNamePrefix(chartObject.Name) = prefix Then
            Set targetChart = chartObject.Chart
            If targetChart.HasAxis(axisType, xlPrimary) Then
                Set targetAxis = targetChart.Axes(axisType, xlPrimary)
                targetAxis.HasMajorGridlines = showMajor
                targetAxis.HasMinorGridlines = showMinor
            End If
        End If
    Next chartObject
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Grid"
End Sub

' Centers chart and axis titles for the selected chart's same-prefix group.
Public Sub MiddleChartTitles()
    Dim sourceChart As Chart, chartObject As chartObject, prefix As String

    On Error GoTo fail
    Set sourceChart = SelectedChart()
    If sourceChart Is Nothing Then Exit Sub
    prefix = ChartNamePrefix(sourceChart.Parent.Name)
    For Each chartObject In Application.ActiveSheet.ChartObjects
        If ChartNamePrefix(chartObject.Name) = prefix Then _
            CenterTitles chartObject.Chart
    Next chartObject
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Middle title"
End Sub

' Requires an explicitly selected chart, including a selected chart element.
' Bat buoc chon chart hoac thanh phan cua chart truoc khi thao tac.
Private Function SelectedChart() As Chart
    If Not Application.ActiveChart Is Nothing Then
        Select Case TypeName(Application.Selection)
            Case "ChartObject", "ChartArea", "PlotArea", "Series", "Point", _
                 "Axis", "Gridlines", "ChartTitle", "AxisTitle", "Legend", _
                 "LegendEntry", "DataLabel", "DataLabels", "Trendline", "ErrorBars", "Chart"
                Set SelectedChart = Application.ActiveChart
                Exit Function
        End Select
    End If
    MsgBox "Select one chart first.", vbInformation, "Chart selection"
End Function

' Uses the selected chart as source and syncs every same-prefix chart
' on the active worksheet. Example: chOverallMulti_1 -> chOverallMulti_*.
Public Sub SyncChartAppearance()
    Dim sourceChart As Chart, targetChart As Chart
    Dim sourceObject As chartObject, targetObject As chartObject
    Dim chartObject As chartObject, prefix As String

    On Error GoTo fail
    Set sourceChart = SelectedChart()
    If sourceChart Is Nothing Then Exit Sub
    Set sourceObject = sourceChart.Parent
    prefix = ChartNamePrefix(sourceObject.Name)
    For Each chartObject In Application.ActiveSheet.ChartObjects
        If ChartNamePrefix(chartObject.Name) = prefix And _
           chartObject.Name <> sourceObject.Name Then
            Set targetObject = chartObject
            Set targetChart = targetObject.Chart
            targetObject.Width = sourceObject.Width
            targetObject.Height = sourceObject.Height
            targetObject.RoundedCorners = sourceObject.RoundedCorners
            SyncOneChart sourceChart, targetChart
        End If
    Next chartObject
    sourceObject.Activate
    Exit Sub
fail:
    MsgBox "Could not synchronize the chart group." & vbCrLf & _
           Err.Description, vbExclamation, "SYNC"
End Sub

' Removes a trailing numeric suffix beginning with the last underscore.
Private Function ChartNamePrefix(ByVal chartName As String) As String
    Dim splitAt As Long, suffix As String
    splitAt = InStrRev(chartName, "_")
    If splitAt > 1 Then
        suffix = Mid$(chartName, splitAt + 1)
        If Len(suffix) > 0 And IsNumeric(suffix) Then
            ChartNamePrefix = Left$(chartName, splitAt - 1)
            Exit Function
        End If
    End If
    ChartNamePrefix = chartName
End Function

' Copies the chart, plot and axis appearance required by Sync.
' Dong bo ChartArea, PlotArea, truc va major/minor gridline.
Private Sub SyncOneChart(ByVal sourceChart As Chart, _
                         ByVal targetChart As Chart)
    Dim axisType As Variant
    Dim groupIndex As Long
    Dim seriesIndex As Long
    Dim sourceChartType As Long
    Dim pass As Long

    sourceChartType = CLng(sourceChart.ChartType)

    CopyFill sourceChart.ChartArea.Format.Fill, targetChart.ChartArea.Format.Fill
    CopyLine sourceChart.ChartArea.Format.line, targetChart.ChartArea.Format.line
    CopyFill sourceChart.PlotArea.Format.Fill, targetChart.PlotArea.Format.Fill
    CopyLine sourceChart.PlotArea.Format.line, targetChart.PlotArea.Format.line

    On Error Resume Next
    If sourceChart.HasTitle And targetChart.HasTitle Then _
        CopyFont sourceChart.ChartTitle.Font, targetChart.ChartTitle.Font
    targetChart.HasLegend = sourceChart.HasLegend
    If sourceChart.HasLegend Then
        targetChart.Legend.Position = sourceChart.Legend.Position
        targetChart.Legend.IncludeInLayout = sourceChart.Legend.IncludeInLayout
        CopyFont sourceChart.Legend.Font, targetChart.Legend.Font
        CopyFill sourceChart.Legend.Format.Fill, targetChart.Legend.Format.Fill
        CopyLine sourceChart.Legend.Format.line, targetChart.Legend.Format.line
    End If
    For seriesIndex = 1 To Application.Min( _
            sourceChart.SeriesCollection.Count, _
            targetChart.SeriesCollection.Count)
        With targetChart.SeriesCollection(seriesIndex)
            .AxisGroup = sourceChart.SeriesCollection(seriesIndex).AxisGroup
            .MarkerStyle = sourceChart.SeriesCollection(seriesIndex).MarkerStyle
            If .MarkerStyle <> xlMarkerStyleNone Then
                .MarkerSize = sourceChart.SeriesCollection(seriesIndex).MarkerSize
                .MarkerForegroundColor = _
                    sourceChart.SeriesCollection(seriesIndex).MarkerForegroundColor
                .MarkerBackgroundColor = _
                    sourceChart.SeriesCollection(seriesIndex).MarkerBackgroundColor
            End If
            .Smooth = sourceChart.SeriesCollection(seriesIndex).Smooth
            CopyFill sourceChart.SeriesCollection(seriesIndex).Format.Fill, _
                     .Format.Fill
            CopyLine sourceChart.SeriesCollection(seriesIndex).Format.line, _
                     .Format.line
            If sourceChart.SeriesCollection(seriesIndex).HasDataLabels And _
               .HasDataLabels Then _
                CopyFont sourceChart.SeriesCollection(seriesIndex).DataLabels.Font, _
                         .DataLabels.Font
        End With
    Next seriesIndex
    On Error GoTo 0

    For Each axisType In Array(xlCategory, xlValue)
        If sourceChart.HasAxis(axisType, xlPrimary) And _
           targetChart.HasAxis(axisType, xlPrimary) Then _
            SyncAxis sourceChart.Axes(axisType), targetChart.Axes(axisType)
    Next axisType

    On Error Resume Next
    For pass = 1 To 4
        targetChart.PlotArea.InsideLeft = sourceChart.PlotArea.InsideLeft
        targetChart.PlotArea.InsideTop = sourceChart.PlotArea.InsideTop
        targetChart.PlotArea.InsideWidth = sourceChart.PlotArea.InsideWidth
        targetChart.PlotArea.InsideHeight = sourceChart.PlotArea.InsideHeight
    Next pass
    On Error GoTo 0
    CenterTitles targetChart

    ' Apply chart/marker type last because Excel may reset it while formatting.
    On Error Resume Next
    targetChart.Activate
    targetChart.ChartType = sourceChartType
    For seriesIndex = 1 To Application.Min( _
            sourceChart.SeriesCollection.Count, _
            targetChart.SeriesCollection.Count)
        With targetChart.SeriesCollection(seriesIndex)
            .ChartType = sourceChart.SeriesCollection(seriesIndex).ChartType
            .MarkerStyle = sourceChart.SeriesCollection(seriesIndex).MarkerStyle
            If .MarkerStyle <> xlMarkerStyleNone Then
                .MarkerSize = sourceChart.SeriesCollection(seriesIndex).MarkerSize
                .MarkerForegroundColor = _
                    sourceChart.SeriesCollection(seriesIndex).MarkerForegroundColor
                .MarkerBackgroundColor = _
                    sourceChart.SeriesCollection(seriesIndex).MarkerBackgroundColor
            End If
        End With
    Next seriesIndex

    ' Apply column/bar spacing last because ChartType resets Overlap to zero.
    For groupIndex = 1 To Application.Min( _
            sourceChart.ChartGroups.Count, targetChart.ChartGroups.Count)
        targetChart.ChartGroups(groupIndex).Overlap = _
            sourceChart.ChartGroups(groupIndex).Overlap
        targetChart.ChartGroups(groupIndex).GapWidth = _
            sourceChart.ChartGroups(groupIndex).GapWidth
    Next groupIndex
    On Error GoTo 0
End Sub

' Copies axis number, tick, line and gridline formats.
' Dong bo format so, tick, truc va net major/minor gridline.
Private Sub SyncAxis(ByVal sourceAxis As Axis, ByVal targetAxis As Axis)
    On Error Resume Next
    targetAxis.MinimumScaleIsAuto = sourceAxis.MinimumScaleIsAuto
    If Not sourceAxis.MinimumScaleIsAuto Then _
        targetAxis.MinimumScale = sourceAxis.MinimumScale
    targetAxis.MaximumScaleIsAuto = sourceAxis.MaximumScaleIsAuto
    If Not sourceAxis.MaximumScaleIsAuto Then _
        targetAxis.MaximumScale = sourceAxis.MaximumScale
    targetAxis.MajorUnitIsAuto = sourceAxis.MajorUnitIsAuto
    If Not sourceAxis.MajorUnitIsAuto Then _
        targetAxis.MajorUnit = sourceAxis.MajorUnit
    targetAxis.MinorUnitIsAuto = sourceAxis.MinorUnitIsAuto
    If Not sourceAxis.MinorUnitIsAuto Then _
        targetAxis.MinorUnit = sourceAxis.MinorUnit
    targetAxis.ScaleType = sourceAxis.ScaleType
    targetAxis.LogBase = sourceAxis.LogBase
    targetAxis.ReversePlotOrder = sourceAxis.ReversePlotOrder
    targetAxis.Crosses = sourceAxis.Crosses
    If sourceAxis.Crosses = xlAxisCrossesCustom Then _
        targetAxis.CrossesAt = sourceAxis.CrossesAt
    targetAxis.TickLabels.NumberFormat = sourceAxis.TickLabels.NumberFormat
    targetAxis.TickLabels.NumberFormatLinked = _
        sourceAxis.TickLabels.NumberFormatLinked
    targetAxis.TickLabels.Font.Name = sourceAxis.TickLabels.Font.Name
    targetAxis.TickLabels.Font.Size = sourceAxis.TickLabels.Font.Size
    targetAxis.TickLabels.Font.Bold = sourceAxis.TickLabels.Font.Bold
    targetAxis.TickLabels.Font.Italic = sourceAxis.TickLabels.Font.Italic
    targetAxis.TickLabels.Font.Color = sourceAxis.TickLabels.Font.Color
    targetAxis.MajorTickMark = sourceAxis.MajorTickMark
    targetAxis.MinorTickMark = sourceAxis.MinorTickMark
    targetAxis.TickLabelPosition = sourceAxis.TickLabelPosition
    CopyLine sourceAxis.Format.line, targetAxis.Format.line
    If sourceAxis.HasTitle And targetAxis.HasTitle Then _
        CopyFont sourceAxis.AxisTitle.Font, targetAxis.AxisTitle.Font

    targetAxis.HasMajorGridlines = sourceAxis.HasMajorGridlines
    If sourceAxis.HasMajorGridlines Then _
        CopyLine sourceAxis.MajorGridlines.Format.line, _
                 targetAxis.MajorGridlines.Format.line
    targetAxis.HasMinorGridlines = sourceAxis.HasMinorGridlines
    If sourceAxis.HasMinorGridlines Then _
        CopyLine sourceAxis.MinorGridlines.Format.line, _
                 targetAxis.MinorGridlines.Format.line
    On Error GoTo 0
End Sub

' Copies text color, font, size and emphasis without changing its text.
' Dong bo dinh dang chu nhung giu nguyen noi dung title cua tung chart.
Private Sub CopyFont(ByVal sourceFont As Object, ByVal targetFont As Object)
    On Error Resume Next
    targetFont.Name = sourceFont.Name
    targetFont.Size = sourceFont.Size
    targetFont.Bold = sourceFont.Bold
    targetFont.Italic = sourceFont.Italic
    targetFont.Underline = sourceFont.Underline
    targetFont.Color = sourceFont.Color
    On Error GoTo 0
End Sub

' Copies a shared Office fill format.
' Sao chep fill dung chung cua ChartArea va PlotArea.
Private Sub CopyFill(ByVal sourceFill As Object, ByVal targetFill As Object)
    On Error Resume Next
    targetFill.visible = sourceFill.visible
    If sourceFill.visible Then
        targetFill.Solid
        targetFill.ForeColor.RGB = sourceFill.ForeColor.RGB
        targetFill.Transparency = sourceFill.Transparency
    End If
    On Error GoTo 0
End Sub

' Copies a shared Office line format.
' Sao chep mau, do day, kieu net va do trong suot.
Private Sub CopyLine(ByVal sourceLine As Object, ByVal targetLine As Object)
    On Error Resume Next
    targetLine.visible = sourceLine.visible
    If sourceLine.visible Then
        targetLine.ForeColor.RGB = sourceLine.ForeColor.RGB
        targetLine.Transparency = sourceLine.Transparency
        targetLine.Weight = sourceLine.Weight
        targetLine.DashStyle = sourceLine.DashStyle
    End If
    On Error GoTo 0
End Sub

' Centers chart title and both primary axis titles.
' Can giua chart title va hai axis title chinh.
Private Sub CenterTitles(ByVal targetChart As Chart)
    Dim plotLeft As Double, plotTop As Double
    Dim plotWidth As Double, plotHeight As Double
    Dim outerPlotLeft As Double

    On Error Resume Next
    With targetChart.PlotArea
        plotLeft = .InsideLeft
        plotTop = .InsideTop
        plotWidth = .InsideWidth
        plotHeight = .InsideHeight
        outerPlotLeft = .Left
    End With
    If targetChart.HasTitle Then _
        targetChart.ChartTitle.Left = plotLeft + _
            (plotWidth - targetChart.ChartTitle.Width) / 2
    If targetChart.Axes(xlValue).HasTitle Then
        targetChart.Axes(xlValue).AxisTitle.Left = _
            Application.Max(0, _
                (outerPlotLeft - targetChart.Axes(xlValue).AxisTitle.Width) / 2)
        targetChart.Axes(xlValue).AxisTitle.Top = plotTop + _
            (plotHeight - targetChart.Axes(xlValue).AxisTitle.Height) / 2
    End If
    If targetChart.Axes(xlCategory).HasTitle Then _
        targetChart.Axes(xlCategory).AxisTitle.Left = plotLeft + _
            (plotWidth - targetChart.Axes(xlCategory).AxisTitle.Width) / 2
    On Error GoTo 0
End Sub


