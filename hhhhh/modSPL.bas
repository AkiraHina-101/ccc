Attribute VB_Name = "modSPL"
Option Explicit

' Recalculates only the SPL worksheet.
' Goi sau khi import hoac khi du lieu nguon thay doi.
' Khong tao chart, button hoac thay doi trang thai toggle.
Public Sub RefreshSPL()
    Dim splSheet As Worksheet, configSheet As Worksheet
    Dim loadList As Range, rpmList As Range

    Set splSheet = ThisWorkbook.Worksheets("SPL")
    Set configSheet = ThisWorkbook.Worksheets("CONFIG")

    configSheet.Calculate
    Set loadList = configSheet.Range("loadCurrentList")
    If IsError(Application.Match(splSheet.Range("D2").Value2, _
                                 loadList, 0)) Then
        splSheet.Range("D2").Value2 = loadList.Cells(1, 1).Value2
        configSheet.Calculate
    End If

    Set rpmList = configSheet.Range("rpmCurrentList")
    If IsError(Application.Match(splSheet.Range("D3").Value2, _
                                 rpmList, 0)) Then
        splSheet.Range("D3").Value2 = rpmList.Cells(1, 1).Value2
    End If

    splSheet.Calculate
    RefreshSPLSeriesRanges
End Sub

' Relinks every SPL series to the current spill size instead of fixed rows.
Public Sub RefreshSPLSeriesRanges()
    Dim ws As Worksheet, chartNames As Variant, chartName As Variant
    Dim chartIndex As Long, modelIndex As Long, modelOrdinal As Long
    Dim seriesIndex As Long, expectedSeriesCount As Long
    Dim modelCount As Long
    Dim nbXColumn As Long, nbYColumn As Long
    Dim obBlockColumn As Long, obCenterColumn As Long
    Dim obXColumn As Long, obYColumn As Long
    Dim lastNbRow As Long, lastObRow As Long
    Dim modelName As String
    Dim config As Worksheet, spillRange As Range, seriesItem As Series
    Dim allSeries As FullSeriesCollection

    Set ws = ThisWorkbook.Worksheets("SPL")
    Set config = ThisWorkbook.Worksheets("CONFIG")
    chartNames = Array("chMic_1", "chMic_2", "chMic_3", "chMic_4")
    FormatSPLObChartData ws

    For chartIndex = LBound(chartNames) To UBound(chartNames)
        ws.ChartObjects(CStr(chartNames(chartIndex))).Chart.PlotVisibleOnly = False
        expectedSeriesCount = modUI.ConfiguredModelCount() * _
                              SPL_SERIES_PER_MODEL
        modUI.EnsureChartSeriesCount _
            ws.ChartObjects(CStr(chartNames(chartIndex))).Chart, _
            expectedSeriesCount
        Set allSeries = ws.ChartObjects(CStr(chartNames(chartIndex))). _
                        Chart.FullSeriesCollection
        modelCount = allSeries.Count \ SPL_SERIES_PER_MODEL
        If modelCount > MAX_MODEL_COUNT Then modelCount = MAX_MODEL_COUNT
        For modelOrdinal = 1 To modelCount
            modelIndex = modUI.ModelSlotFromSeriesOrdinal(modelOrdinal)
            If modelIndex = 0 Then Exit For
            modelName = CStr(config.Cells(8 + modelIndex, "A").Value2)
            nbXColumn = ws.Range("AQ1").Column + (modelIndex - 1) * 5
            nbYColumn = nbXColumn + chartIndex + 1
            ' Moi OB Model co block hien thi 6 cot:
            ' Center | Frequency | Mic 1 | Mic 2 | Mic 3 | Mic 4.
            obBlockColumn = ws.Range("CP1").Column + _
                            (modelIndex - 1) * 6
            obCenterColumn = obBlockColumn
            obXColumn = obCenterColumn + 1
            obYColumn = obBlockColumn + chartIndex + 2
            lastNbRow = SpillLastRow(ws.Cells(SPL_DATA_FIRST_ROW, nbXColumn), _
                                     SPL_DATA_FIRST_ROW)
            lastObRow = SpillLastRow( _
                        ws.Cells(SPL_DATA_FIRST_ROW, obCenterColumn), _
                        SPL_DATA_FIRST_ROW)

            seriesIndex = (modelOrdinal - 1) * SPL_SERIES_PER_MODEL + 1
            Set seriesItem = allSeries(seriesIndex)
            If Len(modelName) > 0 Then seriesItem.Name = modelName & " NB"
            seriesItem.XValues = ws.Range( _
                ws.Cells(SPL_DATA_FIRST_ROW, nbXColumn), _
                ws.Cells(lastNbRow, nbXColumn))
            seriesItem.Values = ws.Range( _
                ws.Cells(SPL_DATA_FIRST_ROW, nbYColumn), _
                ws.Cells(lastNbRow, nbYColumn))

            Set seriesItem = allSeries(seriesIndex + 1)
            If Len(modelName) > 0 Then seriesItem.Name = modelName & " OB"
            seriesItem.XValues = ws.Range( _
                ws.Cells(SPL_DATA_FIRST_ROW, obXColumn), _
                ws.Cells(lastObRow, obXColumn))
            seriesItem.Values = ws.Range( _
                ws.Cells(SPL_DATA_FIRST_ROW, obYColumn), _
                ws.Cells(lastObRow, obYColumn))
        Next modelOrdinal
    Next chartIndex

    ApplySPLSeriesVisibility ws
End Sub

' Formats only the populated part of each visible six-column OB Model block.
Private Sub FormatSPLObChartData(ByVal ws As Worksheet)
    Dim modelIndex As Long, blockColumn As Long, lastRow As Long
    Dim maxLastRow As Long, dataRow As Long, hasData As Boolean
    Dim clearRange As Range, rowRange As Range, frequencyRange As Range

    Set clearRange = ws.Range("CP6:EW234")
    clearRange.Borders.LineStyle = xlNone
    clearRange.Font.Bold = False
    clearRange.Interior.Pattern = xlNone

    maxLastRow = SPL_DATA_FIRST_ROW - 1
    For modelIndex = 1 To MAX_MODEL_COUNT
        blockColumn = ws.Range("CP1").Column + (modelIndex - 1) * 6
        If Len(CStr(ws.Cells(SPL_DATA_FIRST_ROW, blockColumn).Value2)) > 0 Then
            lastRow = SpillLastRow( _
                      ws.Cells(SPL_DATA_FIRST_ROW, blockColumn), _
                      SPL_DATA_FIRST_ROW)
            If lastRow > maxLastRow Then maxLastRow = lastRow
            Set frequencyRange = ws.Range( _
                ws.Cells(SPL_DATA_FIRST_ROW, blockColumn), _
                ws.Cells(lastRow, blockColumn + 1))
            frequencyRange.Font.Bold = True
        End If
    Next modelIndex

    For dataRow = SPL_DATA_FIRST_ROW To maxLastRow
        hasData = False
        For modelIndex = 1 To MAX_MODEL_COUNT
            blockColumn = ws.Range("CP1").Column + (modelIndex - 1) * 6
            If Len(CStr(ws.Cells(dataRow, blockColumn).Value2)) > 0 Then
                hasData = True
                Exit For
            End If
        Next modelIndex
        If hasData Then
            Set rowRange = ws.Range(ws.Cells(dataRow, "CP"), _
                                    ws.Cells(dataRow, "EW"))
            rowRange.Interior.Pattern = xlSolid
            If ((dataRow - SPL_DATA_FIRST_ROW) \ 2) Mod 2 = 1 Then
                rowRange.Interior.Color = RGB(237, 243, 246)
            Else
                rowRange.Interior.Color = RGB(255, 255, 255)
            End If
            With rowRange.Borders
                .LineStyle = xlContinuous
                .Color = RGB(217, 217, 217)
                .Weight = xlThin
            End With
        End If
    Next dataRow
End Sub

' Returns the final row of a dynamic-array spill, or its anchor row if empty.
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

' Entry point for the manually assigned tgModel_1...tgModel_10 buttons.
' Lay Model index tu ten button, dao trang thai trong o V/AF,
' dong bo hai series NB/OB va doi mau button theo CONFIG.
Public Sub ToggleSPLModel()
    Dim ws As Worksheet
    Dim modelIndex As Long, visible As Boolean

    On Error GoTo fail
    If TypeName(Application.Caller) <> "String" Then Exit Sub
    Set ws = ThisWorkbook.Worksheets("SPL")
    modelIndex = modUI.ModelIndexFromButton(CStr(Application.Caller))
    visible = Not modUI.StateIsEnabled(modUI.ResultModelStateCell( _
                  ws, modelIndex).Value2)
    modUI.ResultModelStateCell(ws, modelIndex).Value2 = visible
    ApplySPLSeriesVisibility ws
    modUI.SetModelButtonColor ws, modelIndex, visible
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "SPL Model"
End Sub

' Toggles NB or OB from the manually assigned Band button name.
' Dung Select Case de chon splNBVisible hoac splOBVisible.
Public Sub ToggleSPLBand()
    Dim ws As Worksheet
    Dim stateCell As Range
    Dim buttonName As String
    Dim visible As Boolean

    On Error GoTo fail
    If TypeName(Application.Caller) <> "String" Then Exit Sub
    Set ws = ThisWorkbook.Worksheets("SPL")
    buttonName = CStr(Application.Caller)
    Select Case buttonName
        Case "tgBand_NB": Set stateCell = ws.Range("splNBVisible")
        Case "tgBand_OB": Set stateCell = ws.Range("splOBVisible")
        Case Else: Exit Sub
    End Select
    visible = Not modUI.StateIsEnabled(stateCell.Value2)
    stateCell.Value2 = visible
    ApplySPLSeriesVisibility ws
    modUI.SetToggleButtonColor ws, buttonName, visible, _
                               RGB(42, 126, 76)
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "SPL Band"
End Sub

' Applies the final visibility to chMic_1...chMic_4.
' Moi Model co SPL_SERIES_PER_MODEL series theo thu tu co dinh NB roi OB.
' Series chi hien khi ca trang thai Model va trang thai Band deu bat.
Public Sub ApplySPLSeriesVisibility(ByVal ws As Worksheet)
    Dim chartNames As Variant, chartName As Variant
    Dim allSeries As FullSeriesCollection
    Dim modelIndex As Long, modelOrdinal As Long, firstSeriesIndex As Long
    Dim modelVisible As Boolean, nbVisible As Boolean, obVisible As Boolean

    chartNames = Array("chMic_1", "chMic_2", "chMic_3", "chMic_4")
    nbVisible = modUI.StateIsEnabled(ws.Range("splNBVisible").Value2)
    obVisible = modUI.StateIsEnabled(ws.Range("splOBVisible").Value2)
    For Each chartName In chartNames
        Set allSeries = ws.ChartObjects(CStr(chartName)).Chart.FullSeriesCollection
        For modelOrdinal = 1 To allSeries.Count \ SPL_SERIES_PER_MODEL
            modelIndex = modUI.ModelSlotFromSeriesOrdinal(modelOrdinal)
            If modelIndex = 0 Then Exit For
            firstSeriesIndex = (modelOrdinal - 1) * _
                               SPL_SERIES_PER_MODEL + 1
            If firstSeriesIndex > allSeries.Count Then Exit For
            modelVisible = modUI.StateIsEnabled( _
                           modUI.ResultModelStateCell(ws, modelIndex).Value2)
            allSeries(firstSeriesIndex).IsFiltered = Not _
                (modelVisible And nbVisible And _
                 modUI.SeriesHasData(allSeries(firstSeriesIndex)))
            If firstSeriesIndex + 1 <= allSeries.Count Then _
                allSeries(firstSeriesIndex + 1).IsFiltered = Not _
                    (modelVisible And obVisible And _
                     modUI.SeriesHasData(allSeries(firstSeriesIndex + 1)))
        Next modelOrdinal
    Next chartName
End Sub
