Attribute VB_Name = "modLinkData"
Option Explicit

' Links SPL chart series to the user-owned chart-data blocks.
'
' Contract
'   CONFIG!AO4:AO...  = configured model names (in display order)
'   SPL row 3         = model headers; first occurrence is NB, second is OB
'   SPL row 4         = "Freq." plus MicroID headers
'   SPL row 5         = [Hz] / [dBA] units
'   SPL chart names   = chMic_1, chMic_2, ... (micro position within a block)
'
' This module only links chart series. It never creates/moves Shapes, creates
' names, writes chart-data formulas, or changes user-owned layout.

Private Const SH_SPL As String = "SPL"
Private Const SH_CONFIG As String = "CONFIG"
Private Const MODEL_HEADER_ROW As Long = 3
Private Const DATA_HEADER_ROW As Long = 4
Private Const UNIT_HEADER_ROW As Long = 5
Private Const DATA_FIRST_ROW As Long = 6
Private Const CFG_MODEL_COL As String = "AO"

Public Sub LinkChartDataToSeries(Optional ByVal showSummary As Boolean = True)
    Dim wsS As Worksheet, wsC As Worksheet, co As ChartObject
    Dim modelRow As Long, modelNo As Long, modelName As String
    Dim chartMicNo As Long, linkedCount As Long, missing As String
    On Error GoTo fail

    Set wsS = ThisWorkbook.Worksheets(SH_SPL)
    Set wsC = ThisWorkbook.Worksheets(SH_CONFIG)

    For Each co In wsS.ChartObjects
        chartMicNo = ChartMicroPosition(co.Name)
        If chartMicNo > 0 Then
            modelRow = 4: modelNo = 1
            Do While Len(Trim$(CStr(wsC.Cells(modelRow, CFG_MODEL_COL).Value2))) > 0
                modelName = Trim$(CStr(wsC.Cells(modelRow, CFG_MODEL_COL).Value2))
                linkedCount = linkedCount + LinkOneBand(co, wsS, modelName, _
                    "NB", 1, chartMicNo, missing)
                linkedCount = linkedCount + LinkOneBand(co, wsS, modelName, _
                    "OB", 2, chartMicNo, missing)
                modelRow = modelRow + 1: modelNo = modelNo + 1
            Loop
        End If
    Next co

    ' Reapply CONFIG style and the current NB/OB visibility after linking or
    ' creating series.
    modStyle.RefreshSeriesColors
    modSPLControls.SyncBandVisibility

    If Len(missing) > 0 Then
        Debug.Print "LinkChartDataToSeries - missing:" & missing
        Application.StatusBar = "Chart link incomplete. See VBA Immediate Window."
    ElseIf showSummary Then
        Application.StatusBar = "Chart link complete: " & linkedCount & " series linked."
    End If
    Exit Sub
fail:
    Debug.Print "LinkChartDataToSeries failed " & Err.Number & ": " & Err.Description
    Application.StatusBar = "Chart link failed. See VBA Immediate Window."
End Sub

Private Function LinkOneBand(ByVal co As ChartObject, ByVal ws As Worksheet, _
                             ByVal modelName As String, ByVal bandShortName As String, _
                             ByVal blockOccurrence As Long, ByVal chartMicNo As Long, _
                             ByRef missing As String) As Long
    Dim modelCol As Long, freqCol As Long, micHeader As String, micCol As Long
    Dim lastRow As Long, xRange As Range, yRange As Range, seriesName As String
    Dim s As Series

    modelCol = FindModelBlock(ws, modelName, blockOccurrence)
    If modelCol = 0 Then
        AddMissing missing, "SPL header row " & MODEL_HEADER_ROW & ": " & _
                            modelName & " " & bandShortName
        Exit Function
    End If

    freqCol = FrequencyColumn(ws, modelCol)
    If freqCol = 0 Then
        AddMissing missing, "Freq. header for " & modelName & " " & bandShortName
        Exit Function
    End If

    micHeader = MicroHeaderByPosition(ws, FindModelBlock(ws, modelName, 1), chartMicNo)
    If Len(micHeader) = 0 Then
        AddMissing missing, "MicroID position " & chartMicNo & " for " & co.Name
        Exit Function
    End If

    micCol = MicroColumnInBlock(ws, modelCol, freqCol, micHeader)
    If micCol = 0 Then
        AddMissing missing, "MicroID header " & micHeader & " in " & modelName & " " & bandShortName
        Exit Function
    End If

    lastRow = ws.Cells(ws.Rows.Count, freqCol).End(xlUp).Row
    If lastRow < DATA_FIRST_ROW Then
        AddMissing missing, "Chart data rows for " & modelName & " " & bandShortName
        Exit Function
    End If

    Set xRange = ws.Range(ws.Cells(DATA_FIRST_ROW, freqCol), ws.Cells(lastRow, freqCol))
    Set yRange = ws.Range(ws.Cells(DATA_FIRST_ROW, micCol), ws.Cells(lastRow, micCol))
    xRange.Calculate: yRange.Calculate

    seriesName = modelName & " " & bandShortName
    Set s = FindOrCreateSeries(co.Chart, seriesName)
    s.Name = seriesName
    s.XValues = xRange
    s.Values = yRange
    LinkOneBand = 1
End Function

Private Function FindModelBlock(ByVal ws As Worksheet, ByVal modelName As String, _
                                ByVal occurrence As Long) As Long
    Dim lastCol As Long, firstCol As Long, colNo As Long, found As Long
    firstCol = ChartDataFirstColumn(ws)
    lastCol = ws.Cells(MODEL_HEADER_ROW, ws.Columns.Count).End(xlToLeft).Column
    For colNo = firstCol To lastCol
        If StrComp(Trim$(CStr(ws.Cells(MODEL_HEADER_ROW, colNo).Value2)), _
                     modelName, vbTextCompare) = 0 Then
            found = found + 1
            If found = occurrence Then
                FindModelBlock = colNo
                Exit Function
            End If
        End If
    Next colNo
End Function

Private Function FrequencyColumn(ByVal ws As Worksheet, ByVal modelCol As Long) As Long
    Dim colNo As Long
    For colNo = modelCol To Application.Max(1, modelCol - 32) Step -1
        If StrComp(Trim$(CStr(ws.Cells(DATA_HEADER_ROW, colNo).Value2)), "Freq.", _
                     vbTextCompare) = 0 Then
            FrequencyColumn = colNo
            Exit Function
        End If
    Next colNo
End Function

Private Function ChartDataFirstColumn(ByVal ws As Worksheet) As Long
    Dim wsC As Worksheet, r As Long, lastRow As Long, titleCol As Long
    Set wsC = ThisWorkbook.Worksheets(SH_CONFIG)
    lastRow = wsC.Cells(wsC.Rows.Count, "AU").End(xlUp).Row
    For r = 1 To lastRow
        If StrComp(Trim$(CStr(wsC.Cells(r, "AU").Value2)), _
                     "Chart data first column", vbTextCompare) = 0 Then
            If IsNumeric(wsC.Cells(r, "AV").Value2) Then
                ChartDataFirstColumn = CLng(wsC.Cells(r, "AV").Value2)
                Exit Function
            End If
        End If
    Next r
    titleCol = FindTextInRow(ws, 2, "CHART DATA - NARROWBAND")
    If titleCol > 0 Then ChartDataFirstColumn = titleCol Else ChartDataFirstColumn = 1
End Function

Private Function FindTextInRow(ByVal ws As Worksheet, ByVal rowNo As Long, _
                               ByVal findText As String) As Long
    Dim colNo As Long, lastCol As Long
    lastCol = ws.Cells(rowNo, ws.Columns.Count).End(xlToLeft).Column
    For colNo = 1 To lastCol
        If StrComp(Trim$(CStr(ws.Cells(rowNo, colNo).Value2)), findText, _
                     vbTextCompare) = 0 Then
            FindTextInRow = colNo
            Exit Function
        End If
    Next colNo
End Function

Private Function MicroHeaderByPosition(ByVal ws As Worksheet, ByVal firstModelCol As Long, _
                                       ByVal micPosition As Long) As String
    Dim freqCol As Long, colNo As Long, count As Long
    If firstModelCol = 0 Then Exit Function
    freqCol = FrequencyColumn(ws, firstModelCol)
    If freqCol = 0 Then Exit Function

    For colNo = freqCol + 1 To freqCol + 32
        If StrComp(Trim$(CStr(ws.Cells(UNIT_HEADER_ROW, colNo).Value2)), "[dBA]", _
                     vbTextCompare) = 0 Then
            count = count + 1
            If count = micPosition Then
                MicroHeaderByPosition = Trim$(CStr(ws.Cells(DATA_HEADER_ROW, colNo).Value2))
                Exit Function
            End If
        ElseIf count > 0 Then
            Exit Function
        End If
    Next colNo
End Function

Private Function MicroColumnInBlock(ByVal ws As Worksheet, ByVal modelCol As Long, _
                                    ByVal freqCol As Long, ByVal micHeader As String) As Long
    Dim firstCol As Long, colNo As Long
    firstCol = IIf(freqCol = modelCol, modelCol + 1, modelCol)
    For colNo = firstCol To firstCol + 31
        If StrComp(Trim$(CStr(ws.Cells(UNIT_HEADER_ROW, colNo).Value2)), "[dBA]", _
                     vbTextCompare) <> 0 Then Exit Function
        If StrComp(Trim$(CStr(ws.Cells(DATA_HEADER_ROW, colNo).Value2)), _
                     micHeader, vbTextCompare) = 0 Then
            MicroColumnInBlock = colNo
            Exit Function
        End If
    Next colNo
End Function

Private Function FindOrCreateSeries(ByVal ch As Chart, ByVal seriesName As String) As Series
    Dim s As Series
    For Each s In ch.SeriesCollection
        If StrComp(CStr(s.Name), seriesName, vbTextCompare) = 0 Then
            Set FindOrCreateSeries = s
            Exit Function
        End If
    Next s
    Set FindOrCreateSeries = ch.SeriesCollection.NewSeries
End Function

Private Function ChartMicroPosition(ByVal chartName As String) As Long
    If Left$(chartName, 6) = "chMic_" Then ChartMicroPosition = Val(Mid$(chartName, 7))
End Function

Private Sub AddMissing(ByRef missing As String, ByVal itemText As String)
    If InStr(1, vbLf & missing & vbLf, vbLf & itemText & vbLf, vbTextCompare) = 0 Then
        missing = missing & vbCrLf & "- " & itemText
    End If
End Sub
