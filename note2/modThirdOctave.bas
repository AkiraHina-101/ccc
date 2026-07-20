Attribute VB_Name = "modThirdOctave"
Option Explicit

' Independent 1/3-octave analysis pipeline.
' This module never reads from, writes to or rebuilds the PLOT worksheet.

Private Const SH_NB As String = "CALC_NB"
Private Const SH_OB As String = "CALC_OB"
Private Const SH_OVERALL_CALC As String = "OVERALL_CALC"
Private Const SH_THIRD As String = "THIRD_OCTAVE"
Private Const SH_OVERALL As String = "OVERALL"

Private Const OB_CORE_COLS As Long = 10
Private Const NB_CORE_COLS As Long = 8

Private mPrevCalc As XlCalculation
Private mPrevScreen As Boolean
Private mPrevEvents As Boolean

Public Sub RefreshThirdOctaveModel(ByVal silent As Boolean)
    Dim stageName As String, failNum As Long, failDesc As String, failMsg As String
    Dim wsRaw As Worksheet, nbRows As Long, bandRows As Long
    On Error GoTo fail

    stageName = "initialize"
    Set wsRaw = ThisWorkbook.Worksheets("RAW_OB")
    If LastDataRow(wsRaw, 1) < 2 Then Err.Raise vbObjectError + 301, , _
        "RAW_OB does not contain imported 1/3-octave data."
    modLog.LogMsg "TRACE RefreshThirdOctaveModel: RAW_NB=" & _
                  CStr(LastDataRow(ThisWorkbook.Worksheets("RAW_NB"), 1) - 1) & _
                  "; RAW_OB=" & CStr(LastDataRow(wsRaw, 1) - 1)

    SaveAppState
    RequireAnalysisSheets

    stageName = "build normalized narrowband data"
    nbRows = BuildNbCalc(ThisWorkbook.Worksheets("RAW_NB"))

    stageName = "build normalized band data"
    bandRows = BuildBandCalc(wsRaw)

    Application.CalculateFull

    RestoreAppState
    modLog.ReportSuccess "RefreshThirdOctaveModel", nbRows & " NB rows; " & bandRows & " OB rows"
    If Not silent Then ConfigureAnalysisWindow ThisWorkbook.Worksheets(SH_THIRD)
    Exit Sub
fail:
    failNum = Err.Number: failDesc = Err.Description
    RestoreAppState
    modLog.LogMsg "TRACE RefreshThirdOctaveModel FAILED at " & stageName & _
                  ": " & CStr(failNum) & " - " & failDesc
    failMsg = modLog.ReportError("RefreshThirdOctaveModel", stageName, failNum, failDesc)
    If Not silent Then MsgBox failMsg, vbCritical
End Sub

Public Sub ShowThirdOctaveView()
    modUI.ActivateWorkbookView SH_THIRD
End Sub

Public Sub ShowOverallView()
    modUI.ActivateWorkbookView SH_OVERALL
End Sub

Private Sub SaveAppState()
    mPrevCalc = Application.Calculation
    mPrevScreen = Application.ScreenUpdating
    mPrevEvents = Application.EnableEvents
    Application.ScreenUpdating = False
    Application.EnableEvents = False
    Application.Calculation = xlCalculationManual
End Sub

Private Sub RestoreAppState()
    On Error Resume Next
    Application.Calculation = mPrevCalc
    Application.EnableEvents = mPrevEvents
    Application.ScreenUpdating = mPrevScreen
    On Error GoTo 0
End Sub

Private Sub RequireAnalysisSheets()
    Dim sheetName As Variant, ws As Worksheet
    For Each sheetName In Array(SH_NB, SH_OB, SH_THIRD, SH_OVERALL)
        Set ws = Nothing
        On Error Resume Next
        Set ws = ThisWorkbook.Worksheets(CStr(sheetName))
        On Error GoTo 0
        If ws Is Nothing Then Err.Raise vbObjectError + 303, , _
                                       "Required sheet is missing: " & CStr(sheetName)
    Next sheetName
End Sub

Private Function BuildNbCalc(ByVal wsRaw As Worksheet) As Long
    Dim ws As Worksheet, lastRawRow As Long, lastRawCol As Long
    Dim cModel As Long, cLoad As Long, cRPM As Long, cFreq As Long
    Dim micCount As Long, totalRows As Long, rawData As Variant, outData() As Variant
    Dim r As Long, m As Long, o As Long, micCol As Long
    Dim modelName As String, loadName As String, rpmValue As Variant
    Dim freq As Variant, rawValue As Variant, lastUserCol As Long

    Set ws = ThisWorkbook.Worksheets(SH_NB)
    lastRawRow = LastDataRow(wsRaw, 1)
    If lastRawRow < 2 Then
        ClearDataBody ws, NB_CORE_COLS, Application.Max(NB_CORE_COLS + 1, LastHeaderColumn(ws))
        BuildNbCalc = 0
        Exit Function
    End If
    lastRawCol = LastHeaderColumn(wsRaw)
    cModel = HeaderColumn(wsRaw, "Model")
    cLoad = HeaderColumn(wsRaw, "Load")
    cRPM = HeaderColumn(wsRaw, "RPM")
    cFreq = HeaderColumn(wsRaw, "Frequency [Hz]")
    micCount = lastRawCol - cFreq
    If micCount < 1 Then Err.Raise vbObjectError + 310, , "RAW_NB has no microphone columns."

    rawData = wsRaw.Range(wsRaw.Cells(1, 1), wsRaw.Cells(lastRawRow, lastRawCol)).Value2
    totalRows = (lastRawRow - 1) * micCount
    ReDim outData(1 To totalRows, 1 To NB_CORE_COLS)
    For r = 2 To lastRawRow
        modelName = CStr(rawData(r, cModel))
        loadName = CStr(rawData(r, cLoad))
        rpmValue = rawData(r, cRPM)
        freq = rawData(r, cFreq)
        For m = 1 To micCount
            o = o + 1: micCol = cFreq + m: rawValue = rawData(r, micCol)
            outData(o, 1) = modelName
            outData(o, 2) = loadName
            outData(o, 3) = rpmValue
            outData(o, 4) = ConditionLabel(loadName, rpmValue)
            outData(o, 5) = m
            outData(o, 6) = MicTitle(m, CStr(rawData(1, micCol)))
            outData(o, 7) = freq
            outData(o, 8) = rawValue
        Next m
    Next r

    RemoveLegacyNbStatusColumn ws
    lastUserCol = Application.Max(NB_CORE_COLS + 1, LastHeaderColumn(ws))
    ClearDataBody ws, NB_CORE_COLS, lastUserCol
    WriteHeaders ws, Array("Model", "Load", "RPM", "Condition", "Mic_No", "Mic_Title", _
                            "Frequency_Hz", "Raw_Value")
    ws.Range("A2").Resize(totalRows, NB_CORE_COLS).Value = outData
    FillUserExtensions ws, NB_CORE_COLS + 1, totalRows + 1
    BuildNbCalc = totalRows
End Function

Private Function BuildBandCalc(ByVal wsRaw As Worksheet) As Long
    Dim ws As Worksheet, lastRawRow As Long, lastRawCol As Long
    Dim cModel As Long, cLoad As Long, cRPM As Long, cLo As Long, cHi As Long, cFc As Long
    Dim micCount As Long, totalRows As Long, rawData As Variant, outData() As Variant
    Dim r As Long, m As Long, o As Long, micCol As Long
    Dim modelName As String, loadName As String, rpmValue As Variant
    Dim fc As Variant, lo As Variant, hi As Variant, rawValue As Variant
    Dim lastUserCol As Long

    Set ws = ThisWorkbook.Worksheets(SH_OB)
    lastRawRow = LastDataRow(wsRaw, 1)
    lastRawCol = LastHeaderColumn(wsRaw)
    cModel = HeaderColumn(wsRaw, "Model")
    cLoad = HeaderColumn(wsRaw, "Load")
    cRPM = HeaderColumn(wsRaw, "RPM")
    cLo = HeaderColumn(wsRaw, "f_low")
    cHi = HeaderColumn(wsRaw, "f_high")
    cFc = HeaderColumn(wsRaw, "f_center")
    micCount = lastRawCol - cFc
    If micCount < 1 Then Err.Raise vbObjectError + 302, , "RAW_OB has no microphone columns."

    rawData = wsRaw.Range(wsRaw.Cells(1, 1), wsRaw.Cells(lastRawRow, lastRawCol)).Value2
    totalRows = (lastRawRow - 1) * micCount
    ReDim outData(1 To totalRows, 1 To OB_CORE_COLS)

    For r = 2 To lastRawRow
        modelName = CStr(rawData(r, cModel))
        loadName = CStr(rawData(r, cLoad))
        rpmValue = rawData(r, cRPM)
        lo = rawData(r, cLo): hi = rawData(r, cHi): fc = rawData(r, cFc)
        For m = 1 To micCount
            o = o + 1: micCol = cFc + m: rawValue = rawData(r, micCol)
            outData(o, 1) = modelName
            outData(o, 2) = loadName
            outData(o, 3) = rpmValue
            outData(o, 4) = ConditionLabel(loadName, rpmValue)
            outData(o, 5) = m
            outData(o, 6) = MicTitle(m, CStr(rawData(1, micCol)))
            outData(o, 7) = lo
            outData(o, 8) = hi
            outData(o, 9) = fc
            outData(o, 10) = rawValue
        Next m
    Next r

    RemoveLegacyGeneratedCalcColumns ws
    lastUserCol = Application.Max(OB_CORE_COLS + 1, LastHeaderColumn(ws))
    ClearDataBody ws, OB_CORE_COLS, lastUserCol
    WriteHeaders ws, Array("Model", "Load", "RPM", "Condition", "Mic_No", "Mic_Title", _
                           "f_low_Hz", "f_high_Hz", "f_center_Hz", "Raw_Value")
    ws.Range("A2").Resize(totalRows, OB_CORE_COLS).Value = outData
    FillUserExtensions ws, OB_CORE_COLS + 1, totalRows + 1
    BuildBandCalc = totalRows
End Function

Private Sub ConfigureAnalysisWindow(ByVal ws As Worksheet)
    Dim wnd As Window
    On Error GoTo done
    ws.Activate
    Set wnd = ThisWorkbook.Windows(1)
    wnd.DisplayGridlines = False
    modUI.FitView
done:
End Sub

Private Sub RemoveLegacyGeneratedCalcColumns(ByVal ws As Worksheet)
    Dim legacyHeaders As Variant, i As Long, matchesLegacy As Boolean
    legacyHeaders = Array("Band_Energy", "OA_dB", "POA_From_Hz", "POA_To_Hz", "POA_dB")
    matchesLegacy = True
    For i = 0 To UBound(legacyHeaders)
        If StrComp(Trim$(CStr(ws.Cells(1, 11 + i).Value2)), _
                   CStr(legacyHeaders(i)), vbTextCompare) <> 0 Then
            matchesLegacy = False
            Exit For
        End If
    Next i
    If matchesLegacy Then ws.Range("K:O").ClearContents
End Sub

Private Sub RemoveLegacyNbStatusColumn(ByVal ws As Worksheet)
    If StrComp(Trim$(CStr(ws.Cells(1, 9).Value2)), "USER FORMULA (optional)", vbTextCompare) = 0 And _
       StrComp(Trim$(CStr(ws.Cells(2, 9).Value2)), "OK", vbTextCompare) = 0 Then
        ws.Columns(9).ClearContents
    End If
End Sub

Public Sub RemoveLegacyCalcSheets()
    Dim oldAlerts As Boolean
    oldAlerts = Application.DisplayAlerts
    On Error GoTo cleanFail
    Application.DisplayAlerts = False
    DeleteSheetIfExists "CALC"
    DeleteSheetIfExists SH_OVERALL_CALC
cleanExit:
    Application.DisplayAlerts = oldAlerts
    Exit Sub
cleanFail:
    Application.DisplayAlerts = oldAlerts
    Err.Raise Err.Number, "RemoveLegacyCalcSheets", Err.Description
End Sub

Private Sub DeleteSheetIfExists(ByVal sheetName As String)
    Dim ws As Worksheet
    On Error Resume Next
    Set ws = ThisWorkbook.Worksheets(sheetName)
    On Error GoTo 0
    If Not ws Is Nothing Then ws.Delete
End Sub


Private Sub ClearDataBody(ByVal ws As Worksheet, ByVal coreCols As Long, ByVal lastCol As Long)
    Dim lastR As Long: lastR = Application.Max(2, LastDataRow(ws, 1))
    ws.Range(ws.Cells(2, 1), ws.Cells(lastR, coreCols)).ClearContents
    If lastCol > coreCols Then ws.Range(ws.Cells(3, coreCols + 1), ws.Cells(lastR, lastCol)).ClearContents
End Sub

Private Sub FillUserExtensions(ByVal ws As Worksheet, ByVal firstUserCol As Long, ByVal lastR As Long)
    Dim lastC As Long: lastC = LastHeaderColumn(ws)
    If lastC < firstUserCol Or lastR < 2 Then Exit Sub
    ws.Range(ws.Cells(2, firstUserCol), ws.Cells(2, lastC)).Copy _
        ws.Range(ws.Cells(2, firstUserCol), ws.Cells(lastR, lastC))
End Sub

Private Sub WriteHeaders(ByVal ws As Worksheet, ByVal headers As Variant)
    Dim i As Long
    For i = LBound(headers) To UBound(headers)
        ws.Cells(1, i - LBound(headers) + 1).Value = headers(i)
    Next i
End Sub

Private Function ConditionLabel(ByVal loadName As Variant, ByVal rpmValue As Variant) As String
    ConditionLabel = Trim$(CStr(loadName)) & IIf(Len(Trim$(CStr(loadName))) > 0, " | ", "") & _
                     RpmTextLocal(rpmValue) & " rpm"
End Function

Private Function MicTitle(ByVal micNo As Long, ByVal fallbackHeader As String) As String
    Dim ws As Worksheet, row0 As Long, r As Long, micCol As Long
    Set ws = ThisWorkbook.Worksheets("CONFIG")
    row0 = ThisWorkbook.Names("hdrMics").RefersToRange.Row + 1
    micCol = ThisWorkbook.Names("hdrMics").RefersToRange.Column
    r = row0
    Do While Len(Trim$(CStr(ws.Cells(r, micCol).Value))) > 0
        If CLng(ws.Cells(r, micCol).Value) = micNo Then
            If Len(Trim$(CStr(ws.Cells(r, micCol + 1).Value))) > 0 Then
                MicTitle = CStr(ws.Cells(r, micCol + 1).Value)
                Exit Function
            End If
        End If
        r = r + 1
    Loop
    MicTitle = fallbackHeader
End Function

Private Function HeaderColumn(ByVal ws As Worksheet, ByVal headerText As String) As Long
    Dim c As Long, lastC As Long
    lastC = LastHeaderColumn(ws)
    For c = 1 To lastC
        If StrComp(Trim$(CStr(ws.Cells(1, c).Value)), headerText, vbTextCompare) = 0 Then
            HeaderColumn = c: Exit Function
        End If
    Next c
    Err.Raise vbObjectError + 305, , "Missing header '" & headerText & "' on " & ws.Name
End Function

Private Function LastHeaderColumn(ByVal ws As Worksheet) As Long
    LastHeaderColumn = ws.Cells(1, ws.Columns.Count).End(xlToLeft).Column
    If LastHeaderColumn < 1 Then LastHeaderColumn = 1
End Function

Private Function LastDataRow(ByVal ws As Worksheet, ByVal columnNo As Long) As Long
    LastDataRow = ws.Cells(ws.Rows.Count, columnNo).End(xlUp).Row
    If LastDataRow < 1 Then LastDataRow = 1
End Function

Private Function RpmTextLocal(ByVal v As Variant) As String
    If IsNumeric(v) Then
        If CDbl(v) = Fix(CDbl(v)) Then
            RpmTextLocal = CStr(CLng(v))
        Else
            RpmTextLocal = CStr(CDbl(v))
        End If
    Else
        RpmTextLocal = Trim$(CStr(v))
    End If
End Function
