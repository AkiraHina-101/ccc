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
End Sub

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
Private Sub ApplySPLSeriesVisibility(ByVal ws As Worksheet)
    Dim chartNames As Variant, chartName As Variant
    Dim allSeries As FullSeriesCollection
    Dim modelIndex As Long, firstSeriesIndex As Long
    Dim modelVisible As Boolean, nbVisible As Boolean, obVisible As Boolean

    chartNames = Array("chMic_1", "chMic_2", "chMic_3", "chMic_4")
    nbVisible = modUI.StateIsEnabled(ws.Range("splNBVisible").Value2)
    obVisible = modUI.StateIsEnabled(ws.Range("splOBVisible").Value2)
    For Each chartName In chartNames
        Set allSeries = ws.ChartObjects(CStr(chartName)).Chart.FullSeriesCollection
        For modelIndex = 1 To MAX_MODEL_COUNT
            firstSeriesIndex = (modelIndex - 1) * SPL_SERIES_PER_MODEL + 1
            If firstSeriesIndex > allSeries.Count Then Exit For
            modelVisible = modUI.StateIsEnabled( _
                           modUI.ResultModelStateCell(ws, modelIndex).Value2)
            allSeries(firstSeriesIndex).IsFiltered = Not _
                (modelVisible And nbVisible)
            If firstSeriesIndex + 1 <= allSeries.Count Then _
                allSeries(firstSeriesIndex + 1).IsFiltered = Not _
                    (modelVisible And obVisible)
        Next modelIndex
    Next chartName
End Sub
