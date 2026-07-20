Attribute VB_Name = "modMain"
Option Explicit

' CSV import. RAW sheets stay lossless; CALC sheets only normalize source values.

' ---------- Button: add CSV files (call repeatedly, multi folders) ----------
Public Sub AddCSVs()
    Dim fd As FileDialog, i As Long
    Set fd = Application.FileDialog(msoFileDialogFilePicker)
    With fd
        .Title = "Select Actran CSV files (you can run this again for another folder)"
        .AllowMultiSelect = True
        .Filters.Clear
        .Filters.Add "CSV files", "*.csv"
        If .Show = 0 Then Exit Sub

        ' Batch the file-list update.
        Dim prevSU As Boolean, prevCalc As XlCalculation
        prevSU = Application.ScreenUpdating: prevCalc = Application.Calculation
        Application.ScreenUpdating = False: Application.Calculation = xlCalculationManual
        On Error GoTo done

        Dim ws As Worksheet, seen As Object, r As Long, path As String
        Dim md As String, bd As String, ld As String, rpm As Variant
        Set ws = Worksheets("FILES")
        Set seen = CreateObject("Scripting.Dictionary")
        seen.CompareMode = vbTextCompare
        r = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
        Dim rr As Long
        For rr = 2 To r
            If Len(ws.Cells(rr, 1).Value) > 0 Then seen(ws.Cells(rr, 1).Value) = 1
        Next rr

        For i = 1 To .SelectedItems.Count
            path = .SelectedItems(i)
            If Not seen.Exists(path) Then
                seen(path) = 1
                r = r + 1
                ParseFileName path, md, bd, ld, rpm
                ws.Cells(r, 1).Value = path
                ws.Cells(r, 2).Value = Mid$(path, InStrRev(path, "\") + 1)
                ws.Cells(r, 3).Value = md
                ws.Cells(r, 4).Value = bd
                ws.Cells(r, 5).Value = ld
                ws.Cells(r, 6).Value = rpm
            End If
        Next i
done:
        Dim addErrNum As Long, addErrDesc As String
        addErrNum = Err.Number: addErrDesc = Err.Description
        Application.Calculation = prevCalc
        Application.ScreenUpdating = prevSU
        If addErrNum <> 0 Then MsgBox modLog.ReportError( _
            "AddCSVs", "append file list", addErrNum, addErrDesc), vbExclamation
    End With
    Worksheets("FILES").Activate
End Sub

' Convention: Model_Band_Load...rpm  e.g.  M1_NB_load01_1000rpm.csv
' Tolerant: band accepts NB/narrow/OB/octave (any case); RPM = digits before "rpm".
Public Sub ParseFileName(ByVal fullPath As String, md As String, bd As String, _
                         ld As String, rpm As Variant)
    Dim base As String, parts() As String, i As Long, s As String, p As Long
    base = Mid$(fullPath, InStrRev(fullPath, "\") + 1)
    If InStrRev(base, ".") > 0 Then base = Left$(base, InStrRev(base, ".") - 1)
    parts = Split(base, "_")
    md = "?": bd = "?": ld = "": rpm = ""
    If UBound(parts) >= 0 Then md = parts(0)
    If UBound(parts) >= 1 Then
        Select Case LCase$(parts(1))
            Case "nb", "narrow", "narrowband": bd = "NB"
            Case "ob", "octave", "octaveband", "oct": bd = "OB"
            Case Else: bd = UCase$(parts(1))
        End Select
    End If
    For i = 2 To UBound(parts)
        ' RPM is stored separately; do not duplicate its token inside Load.
        If LCase$(Right$(parts(i), 3)) <> "rpm" Then _
            ld = ld & IIf(Len(ld) > 0, "_", "") & parts(i)
    Next i
    ' rpm = digits immediately before "rpm" anywhere in the name
    p = InStr(1, LCase$(base), "rpm")
    If p > 1 Then
        i = p - 1: s = ""
        Do While i >= 1 And IsNumeric(Mid$(base, i, 1))
            s = Mid$(base, i, 1) & s: i = i - 1
        Loop
        If Len(s) > 0 Then rpm = CDbl(s)
    End If
End Sub

' ---------- Button: clear file list ----------
Public Sub ClearList()
    With Worksheets("FILES")
        .Range("A2:F" & .Rows.Count).ClearContents
    End With
End Sub

' ---------- Button: import all listed CSVs ----------
Public Sub ImportAll(Optional ByVal silent As Boolean = False)
    Dim wsF As Worksheet, wsNB As Worksheet, wsOB As Worksheet
    Dim lastF As Long, r As Long, outR As Long
    Dim data() As Variant, rawNB() As Variant, rawOB() As Variant
    Dim stageName As String, failMsg As String, dataWarn As String
    Dim modelCountBefore As Long, modelCountAfter As Long
    stageName = "initialize"
    On Error GoTo fail
    modLog.ReportStage "ImportAll", stageName
    Set wsF = Worksheets("FILES")
    Set wsNB = Worksheets("RAW_NB"): Set wsOB = Worksheets("RAW_OB")
    lastF = wsF.Cells(wsF.Rows.Count, 1).End(xlUp).Row
    If lastF < 2 Then
        failMsg = modLog.ReportError("ImportAll", "validate files", vbObjectError + 61, _
                                     "FILES does not contain any CSV paths.")
        If Not silent Then MsgBox failMsg, vbExclamation
        Exit Sub
    End If

    Application.ScreenUpdating = False
    Application.Calculation = xlCalculationManual
    stageName = "validate files": modLog.ReportStage "ImportAll", stageName

    ' Pass 1: validate every file/header and size the lossless wide RAW arrays.
    ' No worksheet data is cleared until all files have parsed successfully.
    Dim bands() As String, hdr As String, nbHeader As String, obHeader As String
    Dim isOB As Boolean, rowN As Long, nbExpected As Long, obExpected As Long
    Dim nbColN As Long, obColN As Long
    ReDim bands(2 To lastF)
    For r = 2 To lastF
        InspectCSV CStr(wsF.Cells(r, 1).Value), hdr, isOB, rowN
        bands(r) = IIf(isOB, "OB", "NB")
        If isOB Then
            ValidateOrSetHeader obHeader, obColN, hdr, "OB", CStr(wsF.Cells(r, 1).Value)
            obExpected = obExpected + rowN
        Else
            ValidateOrSetHeader nbHeader, nbColN, hdr, "NB", CStr(wsF.Cells(r, 1).Value)
            nbExpected = nbExpected + rowN
        End If
    Next r
    If nbExpected > wsNB.Rows.Count - 1 Then Err.Raise vbObjectError + 5, , "RAW_NB exceeds Excel row limit."
    If obExpected > wsOB.Rows.Count - 1 Then Err.Raise vbObjectError + 6, , "RAW_OB exceeds Excel row limit."
    If nbExpected > 0 Then ReDim rawNB(1 To nbExpected, 1 To nbColN + RAW_META_COLS)
    If obExpected > 0 Then ReDim rawOB(1 To obExpected, 1 To obColN + RAW_META_COLS)

    stageName = "read csv data": modLog.ReportStage "ImportAll", stageName
    ' Pass 2: build CALC tidy rows and lossless wide RAW rows in memory.
    ReDim data(1 To MAX_DATA_ROWS, 1 To N_SCHEMA_COLS)
    outR = 0
    Dim bd As String, nbR As Long, obR As Long
    For r = 2 To lastF
        bd = bands(r)
        If bd = "OB" Then
            ImportOneCSV CStr(wsF.Cells(r, 1).Value), CStr(wsF.Cells(r, 3).Value), _
                         bd, CStr(wsF.Cells(r, 5).Value), wsF.Cells(r, 6).Value, _
                         data, outR, rawOB, obR, obColN
        Else
            ImportOneCSV CStr(wsF.Cells(r, 1).Value), CStr(wsF.Cells(r, 3).Value), _
                         bd, CStr(wsF.Cells(r, 5).Value), wsF.Cells(r, 6).Value, _
                         data, outR, rawNB, nbR, nbColN
        End If
    Next r
    If outR = 0 Then Err.Raise vbObjectError + 1, , "No data rows were read from the CSV files."

    stageName = "write raw data": modLog.ReportStage "ImportAll", stageName
    ' Commit only after both passes succeeded: a bad CSV cannot erase old data.
    WriteRawSheet wsNB, rawNB, nbR, nbHeader, nbColN
    WriteRawSheet wsOB, rawOB, obR, obHeader, obColN
    dataWarn = ValidateRawDataWarnings(wsNB, wsOB)
    For r = 2 To lastF
        If bands(r) <> CStr(wsF.Cells(r, 4).Value) Then wsF.Cells(r, 4).Value = bands(r)
    Next r

    stageName = "refresh lists": modLog.ReportStage "ImportAll", stageName
    RefreshLists
    modelCountBefore = ConfiguredModelCount()
    SyncModelsFromData
    modelCountAfter = ConfiguredModelCount()
    ' warn if any model's mics do not share the same NB frequency axis
    Dim freqWarn As String
    freqWarn = CheckNBFreqConsistency(data, outR)
    stageName = "refresh third-octave analysis": modLog.ReportStage "ImportAll", stageName
    modThirdOctave.RefreshThirdOctaveModel silent:=True
    If modelCountBefore <> modelCountAfter Then
        stageName = "sync model controls": modLog.ReportStage "ImportAll", stageName
        modRebuild.SyncModelControlsOnly
    End If
    Application.Calculation = xlCalculationAutomatic
    Application.ScreenUpdating = True
    modLog.LogMsg "ImportAll OK: " & (lastF - 1) & " files, " & outR & _
                  " normalized source rows, " & nbR & " RAW_NB rows, " & obR & " RAW_OB rows" & _
                  IIf(Len(freqWarn) > 0, " | FREQ MISMATCH: " & freqWarn, "")
    If Len(dataWarn) > 0 Then
        modLog.ReportWarning "ImportAll", "data validation", dataWarn
    Else
        modLog.ReportSuccess "ImportAll", (lastF - 1) & " files; " & outR & _
                             " source rows; " & nbR & " RAW_NB; " & obR & " RAW_OB"
    End If
    If Not silent Then
        MsgBox "Imported " & (lastF - 1) & " files: " & outR & " source rows, " & _
               nbR & " RAW_NB rows, " & obR & " RAW_OB rows.", vbInformation
        If Len(freqWarn) > 0 Then _
            MsgBox "Warning: these models have mics with DIFFERENT NB frequencies " & _
                   "(the shared frequency axis may misalign): " & freqWarn, vbExclamation
    End If
    If Not silent Then Worksheets("SPL").Activate
    Exit Sub
fail:
    Dim failNum As Long, failDesc As String
    failNum = Err.Number: failDesc = Err.Description
    Application.Calculation = xlCalculationAutomatic
    Application.ScreenUpdating = True
    failMsg = modLog.ReportError("ImportAll", stageName, failNum, failDesc)
    If Not silent Then MsgBox failMsg, vbCritical
End Sub

Private Function ConfiguredModelCount() As Long
    Dim ws As Worksheet, row0 As Long, colNo As Long
    Set ws = Worksheets("CONFIG")
    row0 = ws.Range("hdrModels").Row + 1
    colNo = ws.Range("hdrModels").Column
    Do While Len(Trim$(CStr(ws.Cells(row0 + ConfiguredModelCount, colNo).Value))) > 0
        ConfiguredModelCount = ConfiguredModelCount + 1
    Loop
End Function

' Advisory validation only. RAW and CALC remain lossless: warnings never remove,
' reorder or rewrite source rows, and they do not add a Status column to CALC.
Private Function ValidateRawDataWarnings(ByVal wsNB As Worksheet, _
                                         ByVal wsOB As Worksheet) As String
    Dim nbDup As Long, nbOrder As Long, obDup As Long, obLimits As Long, obOrder As Long
    Dim nbSample As String, obSample As String, limitSample As String
    ValidateNbWarnings wsNB, nbDup, nbOrder, nbSample
    ValidateObWarnings wsOB, obDup, obLimits, obOrder, obSample, limitSample
    If nbDup > 0 Then AppendDataWarning ValidateRawDataWarnings, _
        "NB duplicate frequencies=" & nbDup & FirstSampleText(nbSample)
    If nbOrder > 0 Then AppendDataWarning ValidateRawDataWarnings, _
        "NB non-increasing frequency rows=" & nbOrder
    If obDup > 0 Then AppendDataWarning ValidateRawDataWarnings, _
        "OB duplicate center bands=" & obDup & FirstSampleText(obSample)
    If obLimits > 0 Then AppendDataWarning ValidateRawDataWarnings, _
        "OB invalid low/center/high rows=" & obLimits & FirstSampleText(limitSample)
    If obOrder > 0 Then AppendDataWarning ValidateRawDataWarnings, _
        "OB non-increasing center-band rows=" & obOrder
End Function

Private Sub ValidateNbWarnings(ByVal ws As Worksheet, ByRef duplicateCount As Long, _
                               ByRef orderCount As Long, ByRef sampleText As String)
    Dim lastR As Long, data As Variant, seen As Object, lastFreq As Object
    Dim r As Long, key As String, fileKey As String, freq As Double
    lastR = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
    If lastR < 2 Then Exit Sub
    data = ws.Range("A2:G" & lastR).Value2
    Set seen = CreateObject("Scripting.Dictionary")
    Set lastFreq = CreateObject("Scripting.Dictionary")
    seen.CompareMode = vbTextCompare: lastFreq.CompareMode = vbTextCompare
    For r = 1 To UBound(data, 1)
        If IsNumeric(data(r, 7)) Then
            freq = CDbl(data(r, 7))
            key = DataIdentity(data(r, 3), data(r, 5), data(r, 6), freq)
            If seen.Exists(key) Then
                duplicateCount = duplicateCount + 1
                If Len(sampleText) = 0 Then sampleText = CStr(data(r, 2)) & " @ " & CStr(freq) & " Hz"
            Else
                seen.Add key, True
            End If
            fileKey = CStr(data(r, 1))
            If lastFreq.Exists(fileKey) Then If freq <= CDbl(lastFreq(fileKey)) Then orderCount = orderCount + 1
            lastFreq(fileKey) = freq
        End If
    Next r
End Sub

Private Sub ValidateObWarnings(ByVal ws As Worksheet, ByRef duplicateCount As Long, _
                               ByRef limitCount As Long, ByRef orderCount As Long, _
                               ByRef duplicateSample As String, ByRef limitSample As String)
    Dim lastR As Long, data As Variant, seen As Object, lastCenter As Object
    Dim r As Long, key As String, fileKey As String, lo As Double, hi As Double, fc As Double
    lastR = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
    If lastR < 2 Then Exit Sub
    data = ws.Range("A2:I" & lastR).Value2
    Set seen = CreateObject("Scripting.Dictionary")
    Set lastCenter = CreateObject("Scripting.Dictionary")
    seen.CompareMode = vbTextCompare: lastCenter.CompareMode = vbTextCompare
    For r = 1 To UBound(data, 1)
        If IsNumeric(data(r, 7)) And IsNumeric(data(r, 8)) And IsNumeric(data(r, 9)) Then
            lo = CDbl(data(r, 7)): hi = CDbl(data(r, 8)): fc = CDbl(data(r, 9))
            key = DataIdentity(data(r, 3), data(r, 5), data(r, 6), fc)
            If seen.Exists(key) Then
                duplicateCount = duplicateCount + 1
                If Len(duplicateSample) = 0 Then duplicateSample = CStr(data(r, 2)) & " @ " & CStr(fc) & " Hz"
            Else
                seen.Add key, True
            End If
            If lo >= hi Or fc <= lo Or fc >= hi Then
                limitCount = limitCount + 1
                If Len(limitSample) = 0 Then limitSample = CStr(data(r, 2)) & _
                    " [" & CStr(lo) & ", " & CStr(fc) & ", " & CStr(hi) & "]"
            End If
            fileKey = CStr(data(r, 1))
            If lastCenter.Exists(fileKey) Then If fc <= CDbl(lastCenter(fileKey)) Then orderCount = orderCount + 1
            lastCenter(fileKey) = fc
        End If
    Next r
End Sub

Private Function DataIdentity(ByVal modelValue As Variant, ByVal loadValue As Variant, _
                              ByVal rpmValue As Variant, ByVal frequencyValue As Variant) As String
    DataIdentity = CStr(modelValue) & ChrW(30) & CStr(loadValue) & ChrW(30) & _
                   CStr(rpmValue) & ChrW(30) & CStr(frequencyValue)
End Function

Private Sub AppendDataWarning(ByRef warningText As String, ByVal itemText As String)
    If Len(warningText) > 0 Then warningText = warningText & "; "
    warningText = warningText & itemText
End Sub

Private Function FirstSampleText(ByVal sampleText As String) As String
    If Len(sampleText) > 0 Then FirstSampleText = " (first: " & sampleText & ")"
End Function

' Inspect one CSV without changing workbook data. Returns its exact header,
' detected band and count of nonblank data rows.
Private Sub InspectCSV(ByVal csvPath As String, ByRef headerText As String, _
                       ByRef isOB As Boolean, ByRef rowN As Long)
    Dim ff As Integer, txt As String, fileLines() As String, i As Long
    If Dir(csvPath) = "" Then Err.Raise vbObjectError + 2, , "File not found: " & csvPath
    ff = FreeFile
    Open csvPath For Binary Access Read As #ff
    If LOF(ff) = 0 Then Close #ff: Err.Raise vbObjectError + 7, , "Empty CSV: " & csvPath
    txt = Space$(LOF(ff))
    Get #ff, , txt
    Close #ff
    txt = Replace(txt, vbCrLf, vbLf)
    txt = Replace(txt, vbCr, vbLf)
    fileLines = Split(txt, vbLf)
    headerText = fileLines(0)
    headerText = Trim$(headerText)
    If Len(headerText) = 0 Then Err.Raise vbObjectError + 8, , "Missing CSV header: " & csvPath
    rowN = 0
    For i = 1 To UBound(fileLines)
        If Len(Trim$(fileLines(i))) > 0 Then rowN = rowN + 1
    Next i
    isOB = (InStr(1, LCase$(headerText), "f_low") > 0)
End Sub

' All files of one band must share the same ordered raw columns. This prevents
' silent column shifts while preserving the exact CSV header in RAW_NB/RAW_OB.
Private Sub ValidateOrSetHeader(ByRef savedHeader As String, ByRef colN As Long, _
                                ByVal candidate As String, ByVal band As String, ByVal csvPath As String)
    If Len(savedHeader) = 0 Then
        savedHeader = candidate
        colN = UBound(Split(candidate, ",")) + 1
    ElseIf StrComp(savedHeader, candidate, vbTextCompare) <> 0 Then
        Err.Raise vbObjectError + 9, , band & " header differs from the other " & band & _
                  " files: " & csvPath
    End If
End Sub

' Replace one lossless wide RAW sheet after a successful import.
Private Sub WriteRawSheet(ws As Worksheet, rawData() As Variant, ByVal rawRows As Long, _
                          ByVal rawHeader As String, ByVal rawColN As Long)
    Dim h() As String, c As Long
    ' Clear only the previously used rectangle. Clearing ws.Cells touches more
    ' than 17 billion cells and makes an otherwise small import appear hung.
    ws.UsedRange.ClearContents
    ws.Cells(1, 1).Value = "FullPath": ws.Cells(1, 2).Value = "FileName"
    ws.Cells(1, 3).Value = "Model": ws.Cells(1, 4).Value = "Band"
    ws.Cells(1, 5).Value = "Load": ws.Cells(1, 6).Value = "RPM"
    If Len(rawHeader) > 0 Then
        h = Split(rawHeader, ",")
        For c = 0 To rawColN - 1
            ws.Cells(1, c + RAW_META_COLS + 1).Value = Trim$(h(c))
        Next c
    End If
    If rawRows > 0 Then ws.Range("A2").Resize(rawRows, rawColN + RAW_META_COLS).Value = rawData
    ws.Rows(1).Font.Bold = True
End Sub

' Check that, within each model, all mics share the same NB frequency axis
' (per model & rpm). Returns a comma list of offending model names ("" = OK).
' Mics of a model are assumed to share frequencies, so RebuildDashboard uses
' one shared NB frequency column per model - this flags data that breaks it.
Private Function CheckNBFreqConsistency(data() As Variant, ByVal outR As Long) As String
    Dim i As Long, mdl As String, rpm As String, mic As String, mr As String, k As String
    Dim freqStr As Object, micsOf As Object, offenders As Object
    Set freqStr = CreateObject("Scripting.Dictionary")   ' model|rpm|mic -> freq concat
    Set micsOf = CreateObject("Scripting.Dictionary")    ' model|rpm     -> dict(mic)
    Set offenders = CreateObject("Scripting.Dictionary")
    offenders.CompareMode = vbTextCompare

    For i = 1 To outR
        If CStr(data(i, COL_BAND)) = "NB" Then
            mdl = CStr(data(i, COL_MODEL)): rpm = CStr(data(i, COL_RPM)): mic = CStr(data(i, COL_MIC))
            mr = mdl & "|" & rpm
            k = mr & "|" & mic
            freqStr(k) = freqStr(k) & CStr(data(i, COL_FREQ)) & ";"
            If Not micsOf.Exists(mr) Then Set micsOf(mr) = CreateObject("Scripting.Dictionary")
            micsOf(mr)(mic) = 1
        End If
    Next i

    Dim mrKey As Variant, micKey As Variant, firstFreq As String, curMics As Object
    For Each mrKey In micsOf.Keys
        Set curMics = micsOf(mrKey)
        firstFreq = ""
        For Each micKey In curMics.Keys
            Dim fs As String
            fs = freqStr(mrKey & "|" & micKey)
            If Len(firstFreq) = 0 Then
                firstFreq = fs
            ElseIf StrComp(fs, firstFreq, vbBinaryCompare) <> 0 Then
                offenders(Split(CStr(mrKey), "|")(0)) = 1
            End If
        Next micKey
    Next mrKey

    Dim msg As String, o As Variant
    For Each o In offenders.Keys
        msg = msg & IIf(Len(msg) > 0, ", ", "") & CStr(o)
    Next o
    CheckNBFreqConsistency = msg
End Function

' Read one CSV into the output array.
' NB : Frequency [Hz], POINT_1 1001..1004        -> 1 row per (freq, mic)
' OB : f_low, f_high, f_center, POINT_1 1001..04 -> 2 rows per (band, mic)  [step]
'      f_center is stored in COL_FC on both step rows (future center-based charts).
' The band is AUTO-DETECTED from the header ("f_low" present -> OB, else NB)
' and returned via bd, overriding whatever the file name said.
Private Sub ImportOneCSV(ByVal csvPath As String, ByVal md As String, ByRef bd As String, _
                         ByVal loadName As String, ByVal rpm As Variant, _
                         data() As Variant, outR As Long, _
                         ByRef rawData() As Variant, ByRef rawR As Long, ByVal rawColN As Long)
    Dim ff As Integer, txt As String, fileLines() As String, li As Long
    Dim txtLine As String, parts() As String
    Dim isOB As Boolean, m As Long, c As Long, rawVal As String
    Dim fLo As Double, fHi As Double, fc As Variant, fq As Double, v As Double, micOfs As Long

    If Dir(csvPath) = "" Then Err.Raise vbObjectError + 2, , "File not found: " & csvPath

    ' read whole file, tolerate LF-only or CRLF line endings
    ff = FreeFile
    Open csvPath For Binary Access Read As #ff
    txt = Space$(LOF(ff))
    Get #ff, , txt
    Close #ff
    txt = Replace(txt, vbCrLf, vbLf)
    txt = Replace(txt, vbCr, vbLf)
    fileLines = Split(txt, vbLf)

    ' band auto-detect from header: "f_low" present -> OB, otherwise NB
    isOB = (InStr(1, LCase$(fileLines(0)), "f_low") > 0)
    bd = IIf(isOB, "OB", "NB")
    micOfs = IIf(isOB, 3, 1)   ' index of first mic column (0-based)

    ' mic count = data columns after the frequency column(s), from the header
    Dim micN As Long
    micN = rawColN - micOfs
    If micN < 1 Then Err.Raise vbObjectError + 4, , "No mic columns found in: " & csvPath

    For li = 1 To UBound(fileLines)          ' li=0 is the header -> skipped
        txtLine = Trim$(fileLines(li))
        If Len(txtLine) > 0 Then
            parts = Split(txtLine, ",")
            If UBound(parts) + 1 <> rawColN Then Err.Raise vbObjectError + 10, , _
                "CSV row has " & (UBound(parts) + 1) & " columns; expected " & rawColN & ": " & csvPath

            ' Preserve the original wide row once (no OB staircase duplication).
            rawR = rawR + 1
            rawData(rawR, 1) = csvPath
            rawData(rawR, 2) = Mid$(csvPath, InStrRev(csvPath, "\") + 1)
            rawData(rawR, 3) = md: rawData(rawR, 4) = bd
            rawData(rawR, 5) = loadName: rawData(rawR, 6) = rpm
            For c = 0 To rawColN - 1
                rawVal = Trim$(parts(c))
                If IsNumeric(rawVal) Then
                    rawData(rawR, c + RAW_META_COLS + 1) = CDbl(rawVal)
                Else
                    rawData(rawR, c + RAW_META_COLS + 1) = rawVal
                End If
            Next c

            ' Build the tidy CALC rows used by formulas/charts.
            For m = 1 To micN
                v = CDbl(Trim$(parts(micOfs + m - 1)))
                If isOB Then
                    fLo = CDbl(Trim$(parts(0))): fHi = CDbl(Trim$(parts(1)))
                    fc = CDbl(Trim$(parts(2)))
                    PushRow data, outR, md, rpm, bd, m, fLo, v, fc
                    PushRow data, outR, md, rpm, bd, m, fHi, v, fc
                Else
                    fq = CDbl(Trim$(parts(0)))
                    PushRow data, outR, md, rpm, bd, m, fq, v, Empty
                End If
            Next m
        End If
    Next li
End Sub

Private Sub PushRow(data() As Variant, outR As Long, md As String, rpm As Variant, _
                    bd As String, mic As Long, fq As Double, v As Double, fc As Variant)
    outR = outR + 1
    If outR > MAX_DATA_ROWS Then Err.Raise vbObjectError + 3, , "More than " & MAX_DATA_ROWS & " rows - increase MAX_DATA_ROWS."
    data(outR, COL_MODEL) = md: data(outR, COL_RPM) = rpm: data(outR, COL_BAND) = bd
    data(outR, COL_MIC) = mic: data(outR, COL_FREQ) = fq: data(outR, COL_DB) = v
    data(outR, COL_FC) = fc
End Sub

' ---------- Button: show/hide the data sheets (RAW_NB / RAW_OB / CALC / LISTS) ----------
Public Sub ToggleDataSheets()
    Dim vis As Boolean, nm As Variant, ws As Worksheet
    vis = Not (Worksheets("RAW_NB").Visible = xlSheetVisible)
    For Each nm In Array("RAW_NB", "RAW_OB", "LISTS", "CALC_NB", "CALC_OB")
        Set ws = Nothing
        On Error Resume Next
        Set ws = Worksheets(CStr(nm))
        On Error GoTo 0
        If Not ws Is Nothing Then ws.Visible = IIf(vis, xlSheetVisible, xlSheetHidden)
    Next nm
    If vis Then Worksheets("RAW_NB").Activate Else Worksheets("SPL").Activate
End Sub

' ---------- sync CONFIG MODELS table with the imported data ----------
' Models present in FILES keep their full NB / OB / Projection style row;
' models with no data lose only their name. Prefilled palette rows remain so
' newly discovered models inherit the next visible CONFIG style row.
Public Sub SyncModelsFromData()
    Dim wsF As Worksheet, wsCfg As Worksheet
    Dim d As Object, styles As Object
    Dim r As Long, lastR As Long, n As Long, k As Variant
    Dim row0 As Long, mC As Long

    Set wsF = Worksheets("FILES"): Set wsCfg = Worksheets("CONFIG")
    row0 = wsCfg.Range("hdrModels").Row + 1   ' first data row of MODELS table
    mC = wsCfg.Range("hdrModels").Column
    Set d = CreateObject("Scripting.Dictionary")
    d.CompareMode = vbTextCompare

    ' distinct models from the file list, in order of first appearance
    lastR = wsF.Cells(wsF.Rows.Count, 1).End(xlUp).Row
    For r = 2 To lastR
        If Len(Trim$(wsF.Cells(r, 3).Value)) > 0 Then d(Trim$(wsF.Cells(r, 3).Value)) = 1
    Next r
    If d.Count = 0 Then Exit Sub

    ' remember all nine style cells of currently configured models
    Set styles = CreateObject("Scripting.Dictionary")
    styles.CompareMode = vbTextCompare
    r = row0
    Do While Len(Trim$(wsCfg.Cells(r, mC).Value)) > 0
        styles(Trim$(wsCfg.Cells(r, mC).Value)) = CaptureModelStyle(wsCfg, r, mC)
        r = r + 1
    Loop

    ' on/off states are positional - reset them so every model starts ON
    Worksheets("LISTS").Range("C2:C" & Worksheets("LISTS").Rows.Count).ClearContents

    ' Rewrite model names only. Do not clear the palette/style cells beside them.
    wsCfg.Range(wsCfg.Cells(row0, mC), wsCfg.Cells(r + d.Count + 5, mC)).ClearContents
    n = 0
    For Each k In d.Keys
        wsCfg.Cells(row0 + n, mC).Value = k
        If styles.Exists(CStr(k)) Then RestoreModelStyle wsCfg, row0 + n, mC, styles(CStr(k))
        n = n + 1
    Next k
End Sub

Private Function CaptureModelStyle(ws As Worksheet, ByVal dataRow As Long, _
                                   ByVal modelCol As Long) As Variant
    Dim a(1 To MODEL_STYLE_COLS) As Variant, ofs As Long, cell As Range
    For ofs = 1 To MODEL_STYLE_COLS
        Set cell = ws.Cells(dataRow, modelCol + ofs)
        If IsStyleColorOffset(ofs) Then
            If cell.Interior.ColorIndex = xlColorIndexNone Then
                a(ofs) = Empty
            Else
                a(ofs) = CLng(cell.Interior.Color)
            End If
        Else
            a(ofs) = cell.Value
        End If
    Next ofs
    CaptureModelStyle = a
End Function

Private Sub RestoreModelStyle(ws As Worksheet, ByVal dataRow As Long, _
                              ByVal modelCol As Long, ByVal a As Variant)
    Dim ofs As Long, cell As Range
    For ofs = 1 To MODEL_STYLE_COLS
        Set cell = ws.Cells(dataRow, modelCol + ofs)
        If IsStyleColorOffset(ofs) Then
            If IsEmpty(a(ofs)) Then
                cell.Interior.Pattern = xlNone
            Else
                cell.Interior.Color = CLng(a(ofs))
            End If
        Else
            cell.Value = a(ofs)
        End If
    Next ofs
End Sub

Private Function IsStyleColorOffset(ByVal ofs As Long) As Boolean
    IsStyleColorOffset = (ofs = STYLE_NB_COLOR_OFS Or _
                          ofs = STYLE_OB_COLOR_OFS Or _
                          ofs = STYLE_PROJ_COLOR_OFS)
End Function

' ---------- refresh dropdown source lists on LISTS ----------
Public Sub RefreshLists()
    Dim wsF As Worksheet, wsL As Worksheet, d As Object, r As Long, lastR As Long
    Dim k As Variant, arr() As Variant, rpmArr() As Variant, loadArr() As Variant
    Dim n As Long, i As Long, j As Long, tmp As Variant
    Dim loadName As String, rpmValue As Variant, displayText As String
    Set wsF = Worksheets("FILES"): Set wsL = Worksheets("LISTS")
    Set d = CreateObject("Scripting.Dictionary")
    d.CompareMode = vbTextCompare
    lastR = wsF.Cells(wsF.Rows.Count, 1).End(xlUp).Row
    For r = 2 To lastR
        loadName = Trim$(CStr(wsF.Cells(r, 5).Value))
        rpmValue = wsF.Cells(r, 6).Value
        If Len(rpmValue & "") > 0 Then
            displayText = IIf(Len(loadName) > 0, loadName & " - ", "") & _
                          RpmText(rpmValue) & " rpm"
            d(displayText) = Array(rpmValue, loadName)
        End If
    Next r
    wsL.Range("A2:B" & wsL.Rows.Count).ClearContents
    wsL.Range("D2:D" & wsL.Rows.Count).ClearContents
    If d.Count = 0 Then Exit Sub
    n = d.Count: ReDim arr(1 To n): ReDim rpmArr(1 To n): ReDim loadArr(1 To n)
    i = 0
    For Each k In d.Keys
        i = i + 1: arr(i) = k: rpmArr(i) = d(k)(0): loadArr(i) = d(k)(1)
    Next k
    For i = 1 To n - 1                       ' RPM ascending, label as tie-breaker
        For j = i + 1 To n
            If CDbl(rpmArr(j)) < CDbl(rpmArr(i)) Or _
               (CDbl(rpmArr(j)) = CDbl(rpmArr(i)) And arr(j) < arr(i)) Then
                tmp = arr(i): arr(i) = arr(j): arr(j) = tmp
                tmp = rpmArr(i): rpmArr(i) = rpmArr(j): rpmArr(j) = tmp
                tmp = loadArr(i): loadArr(i) = loadArr(j): loadArr(j) = tmp
            End If
        Next j
    Next i
    For i = 1 To n
        wsL.Cells(i + 1, 1).Value = arr(i)
        wsL.Cells(i + 1, 2).Value = rpmArr(i)
        wsL.Cells(i + 1, 4).Value = loadArr(i)
    Next i
    ' default selection if current one vanished
    If IsError(Application.Match(Worksheets("SPL").Range("selRPM").Value, wsL.Range("A2:A" & n + 1), 0)) Then
        Worksheets("SPL").Range("selRPM").Value = arr(1)
    End If
End Sub

Private Function RpmText(ByVal v As Variant) As String
    If IsNumeric(v) Then
        If CDbl(v) = Fix(CDbl(v)) Then
            RpmText = CStr(CLng(v))
        Else
            RpmText = CStr(CDbl(v))
        End If
    Else
        RpmText = Trim$(CStr(v))
    End If
End Function
