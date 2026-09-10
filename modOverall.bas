Attribute VB_Name = "modOverall"
Option Explicit

' Recalculates OVERALL and relinks series to the current dynamic data size.
Public Sub RefreshOverall()
    ThisWorkbook.Worksheets("CONFIG").Calculate
    ThisWorkbook.Worksheets(OVERALL_BAND_SHEET).Calculate
    ThisWorkbook.Worksheets(OVERALL_BROAD_SHEET).Calculate
    RebuildBandSingleChartSeries
    RefreshOverallSeriesRanges
End Sub



' Keeps Single-RPM charts on the RPM X axis, with one series per Model.
Public Sub RebuildBandSingleChartSeries()
    Dim ws As Worksheet, micIndex As Long, modelCount As Long, modelIndex As Long
    Dim chartObject As chartObject, seriesItem As Series
    Dim sourceColumn As Long

    Set ws = ThisWorkbook.Worksheets(OVERALL_BAND_SHEET)
    modelCount = ActiveBandModelCount(ws)
    If modelCount = 0 Then Exit Sub

    For micIndex = 1 To 4
        Set chartObject = ws.ChartObjects("chOverallSingle_" & micIndex)
        Do While chartObject.Chart.SeriesCollection.Count > 0
            chartObject.Chart.SeriesCollection( _
                chartObject.Chart.SeriesCollection.Count).Delete
        Loop
        For modelIndex = 1 To modelCount
            sourceColumn = ws.Range("BC1").Column + _
                           (modelIndex - 1) * 4 + micIndex - 1
            Set seriesItem = chartObject.Chart.SeriesCollection.NewSeries
            seriesItem.Name = ws.Cells(29, sourceColumn - micIndex + 1).Value2
            seriesItem.XValues = ws.Range("BB32")
            seriesItem.values = ws.Cells(32, sourceColumn)
        Next modelIndex
        chartObject.Chart.Axes(xlCategory).HasTitle = True
        chartObject.Chart.Axes(xlCategory).AxisTitle.text = "RPM [rpm]"
        chartObject.Chart.Axes(xlValue).HasTitle = True
        chartObject.Chart.Axes(xlValue).AxisTitle.text = "SPL [dB] (Ref: 2e-5)"
    Next micIndex
End Sub

Private Function ActiveBandModelCount(ByVal ws As Worksheet) As Long
    Dim modelIndex As Long, headerColumn As Long

    For modelIndex = 1 To MAX_MODEL_COUNT
        headerColumn = ws.Range("BC1").Column + (modelIndex - 1) * 4
        If Len(Trim$(CStr(ws.Cells(10, headerColumn).Value2))) = 0 Then Exit For
        ActiveBandModelCount = ActiveBandModelCount + 1
    Next modelIndex
End Function

' Relinks Multi-RPM series to BD13# and refreshes all current Model names.
Public Sub RefreshOverallSeriesRanges()
    Dim ws As Worksheet, broadWs As Worksheet, config As Worksheet
    Dim multiNames As Variant, singleNames As Variant
    Dim broadMultiNames As Variant, broadSingleNames As Variant
    Dim chartIndex As Long
    Dim lastMultiRow As Long, lastBroadMultiRow As Long

    Set ws = ThisWorkbook.Worksheets(OVERALL_BAND_SHEET)
    Set broadWs = ThisWorkbook.Worksheets(OVERALL_BROAD_SHEET)
    Set config = ThisWorkbook.Worksheets("CONFIG")
    multiNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                       "chOverallMulti_3", "chOverallMulti_4", _
                       "chOverallMulti_5")
    singleNames = Array("chOverallSingle_1", "chOverallSingle_2", _
                       "chOverallSingle_3", "chOverallSingle_4", _
                       "chOverallSingle_5")
    broadMultiNames = Array("chOverallBroadMulti_1", _
                            "chOverallBroadMulti_2", _
                            "chOverallBroadMulti_3", _
                            "chOverallBroadMulti_4", _
                            "chOverallBroadMulti_5")
    broadSingleNames = Array("chOverallBroadSingle_1", _
                             "chOverallBroadSingle_2", _
                             "chOverallBroadSingle_3", _
                             "chOverallBroadSingle_4", _
                             "chOverallBroadSingle_5")
    lastMultiRow = SpillLastRow(ws.Range("BB13"), 13)
    lastBroadMultiRow = SpillLastRow(broadWs.Range("BB13"), 13)

    For chartIndex = LBound(multiNames) To UBound(multiNames)
        RefreshOneOverallChart ws, config, _
            CStr(multiNames(chartIndex)), chartIndex, lastMultiRow, False
        RefreshOneOverallChart ws, config, _
            CStr(singleNames(chartIndex)), chartIndex, lastMultiRow, True
        RefreshOneBroadbandChart broadWs, config, _
            CStr(broadMultiNames(chartIndex)), chartIndex, _
            lastBroadMultiRow, False
        RefreshOneBroadbandChart broadWs, config, _
            CStr(broadSingleNames(chartIndex)), chartIndex, _
                             lastBroadMultiRow, True
    Next chartIndex
    RefreshOverallMarkerStyles
End Sub

' Makes every series marker circular in all ten OVERALL Multi charts.
' Dat marker tron dong nhat cho moi series cua 10 chart Multi OVERALL.
Public Sub RefreshOverallMarkerStyles()
    Dim bandWs As Worksheet, broadWs As Worksheet
    Dim targetSeries As FullSeriesCollection
    Dim chartNames As Variant, chartName As Variant
    Dim targetWs As Worksheet
    Dim seriesIndex As Long, lineColor As Long

    Set bandWs = ThisWorkbook.Worksheets(OVERALL_BAND_SHEET)
    Set broadWs = ThisWorkbook.Worksheets(OVERALL_BROAD_SHEET)
    For Each targetWs In ThisWorkbook.Worksheets( _
            Array(OVERALL_BAND_SHEET, OVERALL_BROAD_SHEET))
        If targetWs.Name = OVERALL_BAND_SHEET Then
            chartNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                "chOverallMulti_3", "chOverallMulti_4", "chOverallMulti_5")
        Else
            chartNames = Array("chOverallBroadMulti_1", _
                "chOverallBroadMulti_2", "chOverallBroadMulti_3", _
                "chOverallBroadMulti_4", "chOverallBroadMulti_5")
        End If
        For Each chartName In chartNames
            Set targetSeries = targetWs.ChartObjects(CStr(chartName)). _
                               Chart.FullSeriesCollection
            For seriesIndex = 1 To targetSeries.Count
                With targetSeries(seriesIndex)
                    .MarkerStyle = xlMarkerStyleCircle
                    .MarkerSize = 5
                    On Error Resume Next
                    lineColor = .Format.line.ForeColor.RGB
                    .MarkerForegroundColor = lineColor
                    .MarkerBackgroundColor = lineColor
                    On Error GoTo 0
                End With
            Next seriesIndex
        Next chartName
    Next targetWs
End Sub

' Relinks only the series that actually exist in one OVERALL chart.
' Series position maps to Model through OVERALL_SERIES_PER_MODEL.
Private Sub RefreshOneOverallChart(ByVal ws As Worksheet, _
                                   ByVal config As Worksheet, _
                                   ByVal chartName As String, _
                                   ByVal chartIndex As Long, _
                                   ByVal lastMultiRow As Long, _
                                   ByVal singleRpm As Boolean)
    Dim allSeries As FullSeriesCollection
    Dim seriesIndex As Long, modelIndex As Long, modelOrdinal As Long
    Dim valueColumn As Long, expectedSeriesCount As Long
    Dim modelName As String, visible As Boolean
    Dim seriesItem As Series
    Dim xRange As Range, valueRange As Range
    Dim hasData As Boolean
    Dim debugContext As String, currentProperty As String
    Dim xAddress As String, valueAddress As String

    On Error GoTo fail
    expectedSeriesCount = modUI.ConfiguredModelCount() * _
                          OVERALL_SERIES_PER_MODEL
    modUI.EnsureChartSeriesCount ws.ChartObjects(chartName).Chart, _
                                 expectedSeriesCount
    Set allSeries = ws.ChartObjects(chartName).Chart.FullSeriesCollection
    Debug.Print "OVERALL RANGE CHART", chartName, _
                "SeriesCount=" & allSeries.Count

    For seriesIndex = 1 To allSeries.Count
        modelOrdinal = ((seriesIndex - 1) \ _
                        OVERALL_SERIES_PER_MODEL) + 1
        modelIndex = modUI.ModelSlotFromSeriesOrdinal(modelOrdinal)
        If modelIndex = 0 Then Exit For

        debugContext = "Chart=" & chartName & _
                       "; Series=" & seriesIndex & _
                       "; ModelIndex=" & modelIndex
        Debug.Print "OVERALL RANGE SERIES", debugContext

        modelName = CStr(config.Cells(8 + modelIndex, "A").Value2)
        visible = modUI.StateIsEnabled( _
                  modUI.ResultModelStateCell(ws, modelIndex).Value2)
        If chartIndex = 4 Then
            valueColumn = ws.Range("CR1").Column + modelIndex - 1
        Else
            valueColumn = ws.Range("BC1").Column + _
                          (modelIndex - 1) * 4 + chartIndex
        End If
        Set seriesItem = allSeries(seriesIndex)

        If Len(modelName) > 0 Then
            currentProperty = "Name"
            Debug.Print "  OVERALL SET Name", modelName
            seriesItem.Name = modelName
        End If
        If singleRpm Then
            Set xRange = ws.Range("BB32")
            Set valueRange = ws.Cells(32, valueColumn)
        Else
            Set xRange = ws.Range(ws.Range("BB13"), _
                                  ws.Cells(lastMultiRow, "BB"))
            Set valueRange = ws.Range(ws.Cells(13, valueColumn), _
                                      ws.Cells(lastMultiRow, valueColumn))
        End If
        xAddress = xRange.Address(False, False)
        valueAddress = valueRange.Address(False, False)

        currentProperty = "XValues"
        Debug.Print "  OVERALL SET XValues", _
                    xAddress, _
                    "Rows=" & xRange.Rows.Count
        seriesItem.XValues = xRange

        currentProperty = "Values"
        Debug.Print "  OVERALL SET Values", _
                    valueAddress, _
                    "Rows=" & valueRange.Rows.Count
        seriesItem.values = valueRange

        currentProperty = "SeriesHasData"
        hasData = modUI.SeriesHasData(seriesItem)
        Err.Clear
        currentProperty = "IsFiltered"
        Debug.Print "  OVERALL SET IsFiltered", _
                    "Visible=" & visible, "HasData=" & hasData
        seriesItem.IsFiltered = Not _
            (visible And hasData)
        Err.Clear
        currentProperty = "Complete"
        Debug.Print "  OVERALL SERIES SUCCESS", debugContext
    Next seriesIndex
    Exit Sub
fail:
    Debug.Print "OVERALL RANGE FAILED", debugContext, _
                "Property=" & currentProperty, Err.Number, Err.Description
    Err.Raise Err.Number, "RefreshOneOverallChart", _
              debugContext & "; Property=" & currentProperty & _
              "; X=" & xAddress & _
              "; Y=" & valueAddress & _
              "; " & Err.Description
End Sub

' Relinks one all-band chart to the prepared OVERALL chart-data blocks.
' Multi uses BB13:CP24; Single uses BB32:CP32.
Private Sub RefreshOneBroadbandChart(ByVal ws As Worksheet, _
                                     ByVal config As Worksheet, _
                                     ByVal chartName As String, _
                                     ByVal chartIndex As Long, _
                                     ByVal lastMultiRow As Long, _
                                     ByVal singleRpm As Boolean)
    Dim allSeries As FullSeriesCollection
    Dim seriesIndex As Long, modelIndex As Long, modelOrdinal As Long
    Dim valueColumn As Long, expectedSeriesCount As Long
    Dim modelName As String, visible As Boolean, hasData As Boolean
    Dim seriesItem As Series, xRange As Range, valueRange As Range

    expectedSeriesCount = modUI.ConfiguredModelCount() * _
                          OVERALL_SERIES_PER_MODEL
    modUI.EnsureChartSeriesCount ws.ChartObjects(chartName).Chart, _
                                 expectedSeriesCount
    Set allSeries = ws.ChartObjects(chartName).Chart.FullSeriesCollection

    For seriesIndex = 1 To allSeries.Count
        modelOrdinal = ((seriesIndex - 1) \ _
                        OVERALL_SERIES_PER_MODEL) + 1
        modelIndex = modUI.ModelSlotFromSeriesOrdinal(modelOrdinal)
        If modelIndex = 0 Then Exit For
        modelName = CStr(config.Cells(8 + modelIndex, "A").Value2)
        visible = modUI.StateIsEnabled( _
                  modUI.ResultModelStateCell(ws, modelIndex).Value2)
        If chartIndex = 4 Then
            valueColumn = ws.Range("CR1").Column + modelIndex - 1
        Else
            valueColumn = ws.Range("BC1").Column + _
                          (modelIndex - 1) * 4 + chartIndex
        End If
        Set seriesItem = allSeries(seriesIndex)
        If Len(modelName) > 0 Then seriesItem.Name = modelName

        If singleRpm Then
            Set xRange = ws.Range("BB32")
            Set valueRange = ws.Cells(32, valueColumn)
        Else
            Set xRange = ws.Range(ws.Range("BB13"), _
                                  ws.Cells(lastMultiRow, "BB"))
            Set valueRange = ws.Range(ws.Cells(13, valueColumn), _
                                      ws.Cells(lastMultiRow, valueColumn))
        End If
        seriesItem.XValues = xRange
        seriesItem.values = valueRange
        hasData = modUI.SeriesHasData(seriesItem)
        Err.Clear
        seriesItem.IsFiltered = Not (visible And hasData)
        Err.Clear
    Next seriesIndex
End Sub

' Returns the last non-empty RPM row inside a fixed chart-data block.
Private Function LastNonBlankRow(ByVal dataRange As Range, _
                                 ByVal fallbackRow As Long) As Long
    Dim rowIndex As Long

    For rowIndex = dataRange.Rows.Count To 1 Step -1
        If Not IsError(dataRange.Cells(rowIndex, 1).Value2) Then
            If Len(CStr(dataRange.Cells(rowIndex, 1).Value2)) > 0 Then
                LastNonBlankRow = dataRange.Cells(rowIndex, 1).Row
                Exit Function
            End If
        End If
    Next rowIndex
    LastNonBlankRow = fallbackRow
End Function

' Returns the last row of one spill, or the anchor row when there is no spill.
Private Function SpillLastRow(ByVal anchorCell As Range, _
                              ByVal emptyRow As Long) As Long
    Dim spillRange As Range

    On Error Resume Next
    Set spillRange = anchorCell.SpillingToRange
    On Error GoTo 0
    If spillRange Is Nothing Then
        SpillLastRow = emptyRow
    Else
        SpillLastRow = spillRange.Row + spillRange.Rows.Count - 1
    End If
End Function

' Entry point assigned to every OVERALL Model button.
' Thu tuc khong tham so duoc gan cho moi button Model tren OVERALL.
Public Sub ToggleOverallModel()
    Dim modelIndex As Long, visible As Boolean

    On Error GoTo fail
    If TypeName(Application.Caller) <> "String" Then Exit Sub
    modelIndex = modUI.ModelIndexFromButton(CStr(Application.Caller))
    visible = Not modUI.StateIsEnabled(modUI.ResultModelStateCell( _
                  ThisWorkbook.Worksheets(OVERALL_BAND_SHEET), modelIndex).Value2)
    SetOverallModelVisible modelIndex, visible
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "OVERALL Model"
End Sub

' Sets one OVERALL Model on all fixed result charts.
' Dat trang thai mot Model tren tat ca chart OVERALL co dinh.
Private Sub SetOverallModelVisible(ByVal modelIndex As Long, _
                                   ByVal visible As Boolean)
    Dim ws As Worksheet, broadWs As Worksheet
    Dim chartNames As Variant, chartName As Variant
    Dim allSeries As FullSeriesCollection
    Dim targetSeries As Series
    Dim modelOrdinal As Long, firstSeriesIndex As Long, seriesOffset As Long

    Set ws = ThisWorkbook.Worksheets(OVERALL_BAND_SHEET)
    Set broadWs = ThisWorkbook.Worksheets(OVERALL_BROAD_SHEET)
    modUI.ResultModelStateCell(ws, modelIndex).Value2 = visible
    modUI.ResultModelStateCell(broadWs, modelIndex).Value2 = visible

    chartNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                       "chOverallMulti_3", "chOverallMulti_4", _
                       "chOverallMulti_5", _
                       "chOverallSingle_1", "chOverallSingle_2", _
                       "chOverallSingle_3", "chOverallSingle_4", _
                       "chOverallSingle_5")
    modelOrdinal = modUI.SeriesOrdinalFromModelSlot(modelIndex)
    If modelOrdinal = 0 Then Exit Sub
    firstSeriesIndex = (modelOrdinal - 1) * _
                       OVERALL_SERIES_PER_MODEL + 1
    For Each chartName In chartNames
        Set allSeries = ws.ChartObjects(CStr(chartName)).Chart.FullSeriesCollection
        For seriesOffset = 0 To OVERALL_SERIES_PER_MODEL - 1
            If firstSeriesIndex + seriesOffset <= allSeries.Count Then
                Set targetSeries = allSeries(firstSeriesIndex + seriesOffset)
                If modUI.SeriesHasData(targetSeries) Then
                    targetSeries.IsFiltered = Not visible
                Else
                    targetSeries.IsFiltered = True
                End If
            End If
        Next seriesOffset
    Next chartName
    chartNames = Array("chOverallBroadMulti_1", "chOverallBroadMulti_2", _
                       "chOverallBroadMulti_3", "chOverallBroadMulti_4", _
                       "chOverallBroadMulti_5", _
                       "chOverallBroadSingle_1", "chOverallBroadSingle_2", _
                       "chOverallBroadSingle_3", "chOverallBroadSingle_4", _
                       "chOverallBroadSingle_5")
    For Each chartName In chartNames
        Set allSeries = broadWs.ChartObjects(CStr(chartName)).Chart.FullSeriesCollection
        For seriesOffset = 0 To OVERALL_SERIES_PER_MODEL - 1
            If firstSeriesIndex + seriesOffset <= allSeries.Count Then
                Set targetSeries = allSeries(firstSeriesIndex + seriesOffset)
                targetSeries.IsFiltered = Not (visible And modUI.SeriesHasData(targetSeries))
            End If
        Next seriesOffset
    Next chartName
    modUI.SetModelButtonColor ws, modelIndex, visible
    modUI.SetModelButtonColor broadWs, modelIndex, visible
End Sub


