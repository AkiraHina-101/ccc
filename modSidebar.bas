Attribute VB_Name = "modSidebar"
Option Explicit

' Fits the active result sheet using its A4 zoom value.
' Dat zoom theo o A4 va dua man hinh ve goc tren ben trai.
Public Sub FitView()
    Dim ws As Worksheet
    Dim chartNames As Variant
    Dim zoomPercent As Long

    On Error GoTo fail
    Set ws = Application.ActiveSheet
    chartNames = SidebarChartNames(ws)
    zoomPercent = CLng(ws.Range("A4").Value2 * 100)
    If zoomPercent < 10 Or zoomPercent > 400 Then zoomPercent = 90
    With ThisWorkbook.Windows(1)
        .Zoom = zoomPercent
        .ScrollRow = 1
        .ScrollColumn = 1
    End With
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Fit"
End Sub

' Changes zoom from the sbZoomUp or sbZoomDown button.
' Dung ten button de tang hoac giam zoom 5 phan tram.
Public Sub ChangeViewZoom()
    Dim ws As Worksheet
    Dim chartNames As Variant
    Dim changePercent As Long, zoomPercent As Long

    On Error GoTo fail
    If TypeName(Application.Caller) <> "String" Then Exit Sub
    Select Case CStr(Application.Caller)
        Case "sbZoomUp": changePercent = 5
        Case "sbZoomDown": changePercent = -5
        Case Else: Exit Sub
    End Select
    Set ws = Application.ActiveSheet
    chartNames = SidebarChartNames(ws)
    zoomPercent = CLng(ThisWorkbook.Windows(1).Zoom) + changePercent
    If zoomPercent < 10 Then zoomPercent = 10
    If zoomPercent > 400 Then zoomPercent = 400
    ws.Range("A4").Value2 = zoomPercent / 100
    ws.Range("A4").NumberFormat = "0%"
    ThisWorkbook.Windows(1).Zoom = zoomPercent
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Zoom"
End Sub

' Cycles X or Y gridlines from the clicked button name.
' Dung ten button de chon truc X hoac Y va doi trang thai grid.
Public Sub ToggleGridlines()
    Dim ws As Worksheet
    Dim chartNames As Variant, chartName As Variant
    Dim sourceAxis As Axis, targetAxis As Axis
    Dim axisType As XlAxisType
    Dim showMajor As Boolean, showMinor As Boolean

    On Error GoTo fail
    If TypeName(Application.Caller) <> "String" Then Exit Sub
    Select Case CStr(Application.Caller)
        Case "sbGridX": axisType = xlCategory
        Case "sbGridY": axisType = xlValue
        Case Else: Exit Sub
    End Select
    Set ws = Application.ActiveSheet
    chartNames = SidebarChartNames(ws)
    Set sourceAxis = ws.ChartObjects(CStr(chartNames(0))).Chart.Axes(axisType)
    If Not sourceAxis.HasMajorGridlines Then
        showMajor = True
    ElseIf Not sourceAxis.HasMinorGridlines Then
        showMajor = True
        showMinor = True
    End If
    For Each chartName In chartNames
        Set targetAxis = ws.ChartObjects(CStr(chartName)).Chart.Axes(axisType)
        targetAxis.HasMajorGridlines = showMajor
        targetAxis.HasMinorGridlines = showMinor
    Next chartName
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Grid"
End Sub

' Centers chart and primary-axis titles on the fixed chart list.
' Can giua title cua cac chart co ten trong mang co dinh.
Public Sub MiddleChartTitles()
    Dim ws As Worksheet
    Dim chartName As Variant

    On Error GoTo fail
    Set ws = Application.ActiveSheet
    For Each chartName In SidebarChartNames(ws)
        CenterTitles ws.ChartObjects(CStr(chartName)).Chart
    Next chartName
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Middle title"
End Sub

' Synchronizes chart appearance from the selected chart.
' Lay chart dang chon lam mau va dong bo cac chart trong mang co dinh.
Public Sub SyncChartAppearance()
    Dim sourceObject As ChartObject, targetObject As ChartObject
    Dim ws As Worksheet
    Dim chartNames As Variant, chartName As Variant
    Dim chartPrefix As String
    Dim separatorPosition As Long
    Dim targetLeft As Double, targetTop As Double
    Dim sourceIsTarget As Boolean

    On Error GoTo fail
    If Application.ActiveChart Is Nothing Then
        MsgBox "Select a chart first.", vbInformation, "Sync"
        Exit Sub
    End If
    Select Case TypeName(Application.Selection)
        Case "ChartObject", "ChartArea", "PlotArea", "Series", "Point", _
             "Axis", "Gridlines", "ChartTitle", "AxisTitle", "Legend", _
             "LegendEntry", "DataLabel", "Trendline", "ErrorBars"
        Case Else
            MsgBox "Select a chart first.", vbInformation, "Sync"
            Exit Sub
    End Select
    Set sourceObject = Application.ActiveChart.Parent
    Set ws = sourceObject.Parent
    chartNames = SidebarChartNames(ws)
    separatorPosition = InStrRev(sourceObject.Name, "_")
    If separatorPosition = 0 Then
        MsgBox "Chart name needs a group prefix.", vbInformation, "Sync"
        Exit Sub
    End If
    chartPrefix = Left$(sourceObject.Name, separatorPosition)
    For Each chartName In chartNames
        If StrComp(CStr(chartName), sourceObject.Name, vbTextCompare) = 0 Then
            sourceIsTarget = True
            Exit For
        End If
    Next chartName
    If Not sourceIsTarget Then
        MsgBox "Select a listed chart.", vbInformation, "Sync"
        Exit Sub
    End If

    For Each chartName In chartNames
        If StrComp(Left$(CStr(chartName), Len(chartPrefix)), _
                   chartPrefix, vbTextCompare) = 0 And _
           StrComp(CStr(chartName), sourceObject.Name, vbTextCompare) <> 0 Then
            Set targetObject = ws.ChartObjects(CStr(chartName))
            targetLeft = targetObject.Left
            targetTop = targetObject.Top
            targetObject.Width = sourceObject.Width
            targetObject.Height = sourceObject.Height
            On Error Resume Next
            targetObject.RoundedCorners = sourceObject.RoundedCorners
            On Error GoTo fail
            SyncOneChart sourceObject.Chart, targetObject.Chart
            targetObject.Left = targetLeft
            targetObject.Top = targetTop
        End If
    Next chartName
    sourceObject.Activate
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Sync"
End Sub

' Returns the fixed chart names; add future chart names here.
' Tra ve mang ten chart co dinh; them chart moi tai day.
Private Function SidebarChartNames(ByVal ws As Worksheet) As Variant
    If Not ws.Parent Is ThisWorkbook Then _
        Err.Raise vbObjectError + 860, , "Select SPL or OVERALL."
    Select Case UCase$(ws.Name)
        Case "SPL"
            SidebarChartNames = Array( _
                "chMic_1", "chMic_2", "chMic_3", "chMic_4")
        Case "OVERALL"
            SidebarChartNames = Array( _
                "chOverallMulti_1", "chOverallMulti_2", _
                "chOverallMulti_3", "chOverallMulti_4", _
                "chOverallSingle_1", "chOverallSingle_2", _
                "chOverallSingle_3", "chOverallSingle_4")
        Case Else
            Err.Raise vbObjectError + 861, , "Select SPL or OVERALL."
    End Select
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
    CopyLine sourceChart.ChartArea.Format.Line, targetChart.ChartArea.Format.Line
    CopyFill sourceChart.PlotArea.Format.Fill, targetChart.PlotArea.Format.Fill
    CopyLine sourceChart.PlotArea.Format.Line, targetChart.PlotArea.Format.Line

    On Error Resume Next
    If sourceChart.HasTitle And targetChart.HasTitle Then _
        CopyFont sourceChart.ChartTitle.Font, targetChart.ChartTitle.Font
    targetChart.HasLegend = sourceChart.HasLegend
    If sourceChart.HasLegend Then
        targetChart.Legend.Position = sourceChart.Legend.Position
        targetChart.Legend.IncludeInLayout = sourceChart.Legend.IncludeInLayout
        CopyFont sourceChart.Legend.Font, targetChart.Legend.Font
        CopyFill sourceChart.Legend.Format.Fill, targetChart.Legend.Format.Fill
        CopyLine sourceChart.Legend.Format.Line, targetChart.Legend.Format.Line
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
            CopyLine sourceChart.SeriesCollection(seriesIndex).Format.Line, _
                     .Format.Line
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
    targetChart.Parent.Activate
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
    CopyLine sourceAxis.Format.Line, targetAxis.Format.Line
    If sourceAxis.HasTitle And targetAxis.HasTitle Then _
        CopyFont sourceAxis.AxisTitle.Font, targetAxis.AxisTitle.Font

    targetAxis.HasMajorGridlines = sourceAxis.HasMajorGridlines
    If sourceAxis.HasMajorGridlines Then _
        CopyLine sourceAxis.MajorGridlines.Format.Line, _
                 targetAxis.MajorGridlines.Format.Line
    targetAxis.HasMinorGridlines = sourceAxis.HasMinorGridlines
    If sourceAxis.HasMinorGridlines Then _
        CopyLine sourceAxis.MinorGridlines.Format.Line, _
                 targetAxis.MinorGridlines.Format.Line
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
    targetFill.Visible = sourceFill.Visible
    If sourceFill.Visible Then
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
    targetLine.Visible = sourceLine.Visible
    If sourceLine.Visible Then
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
