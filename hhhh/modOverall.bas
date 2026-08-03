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
    Dim chartIndex As Long, modelIndex As Long, valueColumn As Long
    Dim lastMultiRow As Long
    Dim modelName As String, visible As Boolean
    Dim seriesItem As Series

    Set ws = ThisWorkbook.Worksheets("OVERALL")
    Set config = ThisWorkbook.Worksheets("CONFIG")
    multiNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                       "chOverallMulti_3", "chOverallMulti_4")
    singleNames = Array("chOverallSingle_1", "chOverallSingle_2", _
                        "chOverallSingle_3", "chOverallSingle_4")
    lastMultiRow = SpillLastRow(ws.Range("AR13"), 13)

    For chartIndex = LBound(multiNames) To UBound(multiNames)
        For modelIndex = 1 To 6
            modelName = CStr(config.Cells(8 + modelIndex, "A").Value2)
            visible = modUI.StateIsEnabled( _
                      modUI.ResultModelStateCell(ws, modelIndex).Value2)
            valueColumn = ws.Range("AS1").Column + _
                          (modelIndex - 1) * 4 + chartIndex

            Set seriesItem = ws.ChartObjects(CStr(multiNames(chartIndex))). _
                             Chart.FullSeriesCollection(modelIndex)
            If Len(modelName) > 0 Then seriesItem.Name = modelName
            seriesItem.XValues = ws.Range(ws.Range("AR13"), _
                                          ws.Cells(lastMultiRow, "AR"))
            seriesItem.Values = ws.Range(ws.Cells(13, valueColumn), _
                                         ws.Cells(lastMultiRow, valueColumn))
            seriesItem.IsFiltered = Not _
                (visible And modUI.SeriesHasData(seriesItem))

            Set seriesItem = ws.ChartObjects(CStr(singleNames(chartIndex))). _
                             Chart.FullSeriesCollection(modelIndex)
            If Len(modelName) > 0 Then seriesItem.Name = modelName
            seriesItem.XValues = ws.Range("AR32")
            seriesItem.Values = ws.Cells(32, valueColumn)
            seriesItem.IsFiltered = Not _
                (visible And modUI.SeriesHasData(seriesItem))
        Next modelIndex
    Next chartIndex
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
    Dim modelName As String
    Dim singleIndex As Long

    Set ws = ThisWorkbook.Worksheets("OVERALL")
    modUI.ResultModelStateCell(ws, modelIndex).Value2 = visible

    chartNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                       "chOverallMulti_3", "chOverallMulti_4", _
                       "chOverallSingle_1", "chOverallSingle_2", _
                       "chOverallSingle_3", "chOverallSingle_4")
    modelName = Trim$(CStr(ThisWorkbook.Worksheets("CONFIG").Range( _
                "hdrModels").Offset(modelIndex, 0).Value2))
    For Each chartName In chartNames
        Set allSeries = ws.ChartObjects(CStr(chartName)).Chart.FullSeriesCollection
        If Left$(CStr(chartName), 15) = "chOverallSingle" Then
            Set targetSeries = Nothing
            For singleIndex = 1 To allSeries.Count
                If StrComp(Trim$(CStr(allSeries(singleIndex).Name)), _
                           modelName, vbTextCompare) = 0 Then
                    Set targetSeries = allSeries(singleIndex)
                    Exit For
                End If
            Next singleIndex
            If Not targetSeries Is Nothing Then
                If modUI.SeriesHasData(targetSeries) Then
                    targetSeries.IsFiltered = Not visible
                Else
                    targetSeries.IsFiltered = True
                End If
            End If
        ElseIf modelIndex <= allSeries.Count Then
            allSeries(modelIndex).IsFiltered = Not visible
        End If
    Next chartName
    modUI.SetModelButtonColor ws, modelIndex, visible
End Sub
