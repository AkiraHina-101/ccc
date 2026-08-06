Attribute VB_Name = "modOverall"
Option Explicit

' Recalculates OVERALL and relinks series to the current dynamic data size.
Public Sub RefreshOverall()
    ThisWorkbook.Worksheets("CONFIG").Calculate
    ThisWorkbook.Worksheets("OVERALL").Calculate
    RefreshOverallSeriesRanges
End Sub

' Relinks Multi-RPM series to AR13# and refreshes all current Model names.
Public Sub RefreshOverallSeriesRanges()
    Dim ws As Worksheet, config As Worksheet
    Dim multiNames As Variant, singleNames As Variant
    Dim chartIndex As Long
    Dim lastMultiRow As Long

    Set ws = ThisWorkbook.Worksheets("OVERALL")
    Set config = ThisWorkbook.Worksheets("CONFIG")
    multiNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                       "chOverallMulti_3", "chOverallMulti_4")
    singleNames = Array("chOverallSingle_1", "chOverallSingle_2", _
                        "chOverallSingle_3", "chOverallSingle_4")
    lastMultiRow = SpillLastRow(ws.Range("AR13"), 13)

    For chartIndex = LBound(multiNames) To UBound(multiNames)
        RefreshOneOverallChart ws, config, _
            CStr(multiNames(chartIndex)), chartIndex, lastMultiRow, False
        RefreshOneOverallChart ws, config, _
            CStr(singleNames(chartIndex)), chartIndex, lastMultiRow, True
    Next chartIndex
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
    Dim debugContext As String

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
        valueColumn = ws.Range("AS1").Column + _
                      (modelIndex - 1) * 4 + chartIndex
        Set seriesItem = allSeries(seriesIndex)

        If Len(modelName) > 0 Then seriesItem.Name = modelName
        If singleRpm Then
            seriesItem.XValues = ws.Range("AR32")
            seriesItem.Values = ws.Cells(32, valueColumn)
        Else
            seriesItem.XValues = ws.Range(ws.Range("AR13"), _
                                          ws.Cells(lastMultiRow, "AR"))
            seriesItem.Values = ws.Range(ws.Cells(13, valueColumn), _
                                         ws.Cells(lastMultiRow, valueColumn))
        End If
        seriesItem.IsFiltered = Not _
            (visible And modUI.SeriesHasData(seriesItem))
    Next seriesIndex
    Exit Sub
fail:
    Debug.Print "OVERALL RANGE FAILED", debugContext, _
                Err.Number, Err.Description
    Err.Raise Err.Number, "RefreshOneOverallChart", _
              debugContext & "; " & Err.Description
End Sub

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
                  ThisWorkbook.Worksheets("OVERALL"), modelIndex).Value2)
    SetOverallModelVisible modelIndex, visible
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "OVERALL Model"
End Sub

' Sets one OVERALL Model on all fixed result charts.
' Dat trang thai mot Model tren tat ca chart OVERALL co dinh.
Private Sub SetOverallModelVisible(ByVal modelIndex As Long, _
                                   ByVal visible As Boolean)
    Dim ws As Worksheet
    Dim chartNames As Variant, chartName As Variant
    Dim allSeries As FullSeriesCollection
    Dim targetSeries As Series
    Dim modelOrdinal As Long, firstSeriesIndex As Long, seriesOffset As Long

    Set ws = ThisWorkbook.Worksheets("OVERALL")
    modUI.ResultModelStateCell(ws, modelIndex).Value2 = visible

    chartNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                       "chOverallMulti_3", "chOverallMulti_4", _
                       "chOverallSingle_1", "chOverallSingle_2", _
                       "chOverallSingle_3", "chOverallSingle_4")
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
    modUI.SetModelButtonColor ws, modelIndex, visible
End Sub
