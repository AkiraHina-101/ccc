Attribute VB_Name = "modOverall"
Option Explicit

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
