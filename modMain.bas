Attribute VB_Name = "modMain"
Option Explicit

' CSV import. RAW_NB and RAW_OB are wide tables.  Their headers are the
' explicit V4 contract in modConst, not a reflection of CONFIG or CSV order.

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
    Dim lastF As Long, r As Long
    Dim rawNB() As Variant, rawOB() As Variant
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
    Dim bands() As String, hdr As String
    Dim isOB As Boolean, rowN As Long, nbExpected As Long, obExpected As Long
    Dim nbColN As Long, obColN As Long, micN As Long
    micN = RAW_MIC_COUNT
    ReDim bands(2 To lastF)
    For r = 2 To lastF
        InspectCSV CStr(wsF.Cells(r, 1).Value), hdr, isOB, rowN
        bands(r) = IIf(isOB, "OB", "NB")
        If isOB Then
            ValidateConfiguredCsvHeaders hdr, "OB", CStr(wsF.Cells(r, 1).Value), micN
            obExpected = obExpected + rowN
        Else
            ValidateConfiguredCsvHeaders hdr, "NB", CStr(wsF.Cells(r, 1).Value), micN
            nbExpected = nbExpected + rowN
        End If
    Next r
    nbColN = 5 + micN
    obColN = 7 + micN
    If nbExpected > wsNB.Rows.Count - 1 Then Err.Raise vbObjectError + 5, , "RAW_NB exceeds Excel row limit."
    If obExpected > wsOB.Rows.Count - 1 Then Err.Raise vbObjectError + 6, , "RAW_OB exceeds Excel row limit."
    If nbExpected > 0 Then ReDim rawNB(1 To nbExpected, 1 To nbColN)
    If obExpected > 0 Then ReDim rawOB(1 To obExpected, 1 To obColN)

    stageName = "read csv data": modLog.ReportStage "ImportAll", stageName
    ' Pass 2 writes only RAW datasets. CALC sheets are not import targets.
    Dim bd As String, nbR As Long, obR As Long
    For r = 2 To lastF
        bd = bands(r)
        If bd = "OB" Then
            ImportOneCSV CStr(wsF.Cells(r, 1).Value), CStr(wsF.Cells(r, 3).Value), _
                         bd, CStr(wsF.Cells(r, 5).Value), wsF.Cells(r, 6).Value, _
                         rawOB, obR, micN
        Else
            ImportOneCSV CStr(wsF.Cells(r, 1).Value), CStr(wsF.Cells(r, 3).Value), _
                         bd, CStr(wsF.Cells(r, 5).Value), wsF.Cells(r, 6).Value, _
                         rawNB, nbR, micN
        End If
    Next r
    If nbR + obR = 0 Then Err.Raise vbObjectError + 1, , "No data rows were read from the CSV files."

    stageName = "write raw data": modLog.ReportStage "ImportAll", stageName
    ' Keep RAW sheets grouped predictably for review: Band, Load, RPM, Model.
    If nbR > 1 Then SortRawRows rawNB, nbR
    If obR > 1 Then SortRawRows rawOB, obR
    ' Commit only after both passes succeeded: a bad CSV cannot erase old data.
    WriteRawNbSheet wsNB, rawNB, nbR, micN
    WriteRawObSheet wsOB, rawOB, obR
    RebuildRawCalcMaps
    dataWarn = ValidateRawDataWarnings(wsNB, wsOB)
    For r = 2 To lastF
        If bands(r) <> CStr(wsF.Cells(r, 4).Value) Then wsF.Cells(r, 4).Value = bands(r)
    Next r

    stageName = "refresh CONFIG state": modLog.ReportStage "ImportAll", stageName
    RefreshConfigState
    modelCountBefore = ConfiguredModelCount()
    SyncModelsFromData
    modelCountAfter = ConfiguredModelCount()
    If modelCountBefore <> modelCountAfter Then
        stageName = "sync model controls": modLog.ReportStage "ImportAll", stageName
        modSPLControls.SyncModelControlsOnly
    End If
    Application.Calculation = xlCalculationAutomatic
    Application.ScreenUpdating = True
    modLog.LogMsg "ImportAll OK: " & (lastF - 1) & " files, " & _
                  nbR & " RAW_NB rows, " & obR & " RAW_OB rows"
    If Len(dataWarn) > 0 Then
        modLog.ReportWarning "ImportAll", "data validation", dataWarn
    Else
        modLog.ReportSuccess "ImportAll", (lastF - 1) & " files; " & _
                             nbR & " RAW_NB; " & obR & " RAW_OB"
    End If
    If Not silent Then
        MsgBox "Imported " & (lastF - 1) & " files: " & _
               nbR & " RAW_NB rows, " & obR & " RAW_OB rows.", vbInformation
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

' Advisory validation only. Warnings never remove, reorder or rewrite RAW rows.
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
    data = ws.Range("A2:I" & lastR).Value2
    Set seen = CreateObject("Scripting.Dictionary")
    Set lastFreq = CreateObject("Scripting.Dictionary")
    seen.CompareMode = vbTextCompare: lastFreq.CompareMode = vbTextCompare
    For r = 1 To UBound(data, 1)
        If IsNumeric(data(r, 5)) Then
            freq = CDbl(data(r, 5))
            key = DataIdentity(data(r, 4), data(r, 2), data(r, 3), freq)
            If seen.Exists(key) Then
                duplicateCount = duplicateCount + 1
                If Len(sampleText) = 0 Then sampleText = CStr(data(r, 4)) & " @ " & CStr(freq) & " Hz"
            Else
                seen.Add key, True
            End If
            fileKey = CStr(data(r, 1)) & ChrW(30) & CStr(data(r, 2)) & ChrW(30) & _
                      CStr(data(r, 3)) & ChrW(30) & CStr(data(r, 4))
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
    data = ws.Range("A2:K" & lastR).Value2
    Set seen = CreateObject("Scripting.Dictionary")
    Set lastCenter = CreateObject("Scripting.Dictionary")
    seen.CompareMode = vbTextCompare: lastCenter.CompareMode = vbTextCompare
    For r = 1 To UBound(data, 1)
        If IsNumeric(data(r, 5)) And IsNumeric(data(r, 6)) And IsNumeric(data(r, 7)) Then
            lo = CDbl(data(r, 5)): hi = CDbl(data(r, 6)): fc = CDbl(data(r, 7))
            key = DataIdentity(data(r, 4), data(r, 2), data(r, 3), fc)
            If seen.Exists(key) Then
                duplicateCount = duplicateCount + 1
                If Len(duplicateSample) = 0 Then duplicateSample = CStr(data(r, 4)) & " @ " & CStr(fc) & " Hz"
            Else
                seen.Add key, True
            End If
            If lo >= hi Or fc <= lo Or fc >= hi Then
                limitCount = limitCount + 1
                If Len(limitSample) = 0 Then limitSample = CStr(data(r, 4)) & _
                    " [" & CStr(lo) & ", " & CStr(fc) & ", " & CStr(hi) & "]"
            End If
            fileKey = CStr(data(r, 1)) & ChrW(30) & CStr(data(r, 2)) & ChrW(30) & _
                      CStr(data(r, 3)) & ChrW(30) & CStr(data(r, 4))
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
    Dim ff As Integer, txt As String, fileLines() As String, parts() As String, i As Long
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
    parts = Split(headerText, ",")
    isOB = (HeaderIndex(parts, ConfigHeader("OB_LOW", "f_low")) >= 0)
End Sub

' Validate names configured by the user. CSV columns may be in any order.
Private Sub ValidateConfiguredCsvHeaders(ByVal headerText As String, ByVal band As String, _
                                         ByVal csvPath As String, ByVal micCount As Long)
    Dim parts() As String, m As Long, key As String
    parts = Split(headerText, ",")
    If band = "NB" Then
        RequireHeader parts, ConfigHeader("NB_FREQ", HDR_NB_FREQ), csvPath
        For m = 1 To RAW_MIC_COUNT
            RequireHeader parts, ConfigHeader("NB_MIC_" & CStr(m), ""), csvPath
        Next m
    Else
        RequireHeader parts, ConfigHeader("OB_LOW", "f_low"), csvPath
        RequireHeader parts, ConfigHeader("OB_HIGH", "f_high"), csvPath
        RequireHeader parts, ConfigHeader("OB_CENTER", "f_center"), csvPath
        For m = 1 To RAW_MIC_COUNT
            RequireHeader parts, ConfigHeader("OB_MIC_" & CStr(m), ""), csvPath
        Next m
    End If
End Sub

Private Sub RequireHeader(ByRef parts() As String, ByVal headerText As String, ByVal csvPath As String)
    If Len(Trim$(headerText)) = 0 Or HeaderIndex(parts, headerText) < 0 Then _
        Err.Raise vbObjectError + 9, , "Mapped CSV header not found: '" & headerText & "' in " & csvPath
End Sub

' Replace RAW_NB using the fixed V4 application headers.
Private Sub WriteRawNbSheet(ws As Worksheet, rawData() As Variant, ByVal rawRows As Long, _
                            ByVal micCount As Long)
    ' Clear only the previously used rectangle. Clearing ws.Cells touches more
    ' than 17 billion cells and makes an otherwise small import appear hung.
    ws.UsedRange.ClearContents
    ws.Cells(1, 1).Resize(1, 9).Value = RawNbHeaders()
    If rawRows > 0 Then ws.Range("A2").Resize(rawRows, 5 + RAW_MIC_COUNT).Value = rawData
    ws.Rows(1).Font.Bold = True
End Sub

' Read one CSV into the appropriate wide RAW sheet.  CSV columns can move;
' their values are resolved by CONFIG mapping, then written to fixed RAW fields.
' The band is AUTO-DETECTED from the header ("f_low" present -> OB, else NB)
' and returned via bd, overriding whatever the file name said.
Private Sub ImportOneCSV(ByVal csvPath As String, ByVal md As String, ByRef bd As String, _
                         ByVal loadName As String, ByVal rpm As Variant, _
                         ByRef rawData() As Variant, ByRef rawR As Long, ByVal rawColN As Long)
    Dim ff As Integer, txt As String, fileLines() As String, li As Long
    Dim txtLine As String, parts() As String, headerParts() As String
    Dim isOB As Boolean, m As Long, sourceColN As Long
    Dim cFreq As Long, cLo As Long, cHi As Long, cCenter As Long, micCols() As Long

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

    headerParts = Split(fileLines(0), ",")
    sourceColN = UBound(headerParts) + 1
    ' Band and every source value are resolved by the editable CONFIG header map.
    isOB = (HeaderIndex(headerParts, ConfigHeader("OB_LOW", "f_low")) >= 0)
    bd = IIf(isOB, "OB", "NB")
    Dim micN As Long
    micN = RAW_MIC_COUNT
    If micN < 1 Then Err.Raise vbObjectError + 4, , "No mapped microphone headers found in: " & csvPath
    ReDim micCols(1 To micN)
    For m = 1 To micN
        micCols(m) = HeaderIndex(headerParts, ConfigHeader(IIf(isOB, "OB_MIC_", "NB_MIC_") & CStr(m), ""))
    Next m
    If isOB Then
        cLo = HeaderIndex(headerParts, ConfigHeader("OB_LOW", "f_low"))
        cHi = HeaderIndex(headerParts, ConfigHeader("OB_HIGH", "f_high"))
        cCenter = HeaderIndex(headerParts, ConfigHeader("OB_CENTER", "f_center"))
    Else
        cFreq = HeaderIndex(headerParts, ConfigHeader("NB_FREQ", "Frequency [Hz]"))
    End If

    For li = 1 To UBound(fileLines)          ' li=0 is the header -> skipped
        txtLine = Trim$(fileLines(li))
        If Len(txtLine) > 0 Then
            parts = Split(txtLine, ",")
            If UBound(parts) + 1 <> sourceColN Then Err.Raise vbObjectError + 10, , _
                "CSV row has " & (UBound(parts) + 1) & " columns; expected " & sourceColN & ": " & csvPath

            rawR = rawR + 1
            rawData(rawR, 1) = bd: rawData(rawR, 2) = loadName
            rawData(rawR, 3) = rpm: rawData(rawR, 4) = md
            If isOB Then
                rawData(rawR, 5) = CsvValue(parts(cLo))
                rawData(rawR, 6) = CsvValue(parts(cHi))
                rawData(rawR, 7) = CsvValue(parts(cCenter))
                For m = 1 To micN
                    rawData(rawR, 7 + m) = CsvValue(parts(micCols(m)))
                Next m
            Else
                rawData(rawR, 5) = CsvValue(parts(cFreq))
                For m = 1 To micN
                    rawData(rawR, 5 + m) = CsvValue(parts(micCols(m)))
                Next m
            End If
        End If
    Next li
End Sub

Private Function ConfiguredMicCount() As Long
    Dim ws As Worksheet, rowNo As Long, colNo As Long
    Set ws = ThisWorkbook.Worksheets("CONFIG")
    rowNo = ThisWorkbook.Names("hdrMics").RefersToRange.Row + 1
    colNo = ThisWorkbook.Names("hdrMics").RefersToRange.Column
    Do While Len(Trim$(CStr(ws.Cells(rowNo + ConfiguredMicCount, colNo).Value2))) > 0
        ConfiguredMicCount = ConfiguredMicCount + 1
    Loop
End Function

' User-editable CSV header map: CONFIG!AA = key, CONFIG!AD = header to find.
Private Function ConfigHeader(ByVal keyText As String, ByVal fallbackValue As String) As String
    Dim ws As Worksheet, r As Long, lastR As Long
    Set ws = ThisWorkbook.Worksheets("CONFIG")
    lastR = ws.Cells(ws.Rows.Count, 27).End(xlUp).Row
    For r = 6 To lastR
        If StrComp(Trim$(CStr(ws.Cells(r, 27).Value2)), keyText, vbTextCompare) = 0 Then
            ConfigHeader = Trim$(CStr(ws.Cells(r, 30).Value2))
            If Len(ConfigHeader) > 0 Then Exit Function
        End If
    Next r
    ConfigHeader = fallbackValue
End Function

' Returns a zero-based CSV field index. Matching ignores capitalization,
' spacing and punctuation so a configured name remains readable to users.
Private Function HeaderIndex(ByVal headerParts() As String, ByVal wantedHeader As String) As Long
    Dim i As Long, wantedKey As String
    HeaderIndex = -1
    wantedKey = HeaderKeyLocal(wantedHeader)
    For i = LBound(headerParts) To UBound(headerParts)
        If HeaderKeyLocal(CsvCellText(headerParts(i))) = wantedKey Then
            HeaderIndex = i
            Exit Function
        End If
    Next i
End Function

Private Function HeaderKeyLocal(ByVal headerText As String) As String
    Dim i As Long, ch As String
    headerText = LCase$(Trim$(headerText))
    For i = 1 To Len(headerText)
        ch = Mid$(headerText, i, 1)
        If ch Like "[a-z0-9]" Then HeaderKeyLocal = HeaderKeyLocal & ch
    Next i
End Function

Private Function CsvValue(ByVal rawText As String) As Variant
    rawText = CsvCellText(rawText)
    If IsNumeric(rawText) Then CsvValue = CDbl(rawText) Else CsvValue = rawText
End Function

Private Sub WriteRawObSheet(ws As Worksheet, rawData() As Variant, ByVal rawRows As Long)
    ws.UsedRange.ClearContents
    ws.Cells(1, 1).Resize(1, 11).Value = RawObHeaders()
    If rawRows > 0 Then ws.Range("A2").Resize(rawRows, 7 + RAW_MIC_COUNT).Value = rawData
    ws.Rows(1).Font.Bold = True
End Sub

' Sort only import records, not worksheet rows. File path and frequency/band
' fields break ties so each imported file stays in its natural data order.
Private Sub SortRawRows(ByRef data() As Variant, ByVal itemCount As Long)
    If itemCount > 1 Then QuickSortRawRows data, 1, itemCount
End Sub

Private Sub QuickSortRawRows(ByRef data() As Variant, ByVal firstRow As Long, ByVal lastRow As Long)
    Dim i As Long, j As Long, c As Long, mid As Long, colCount As Long
    Dim pivot() As Variant, swapValue As Variant
    If firstRow >= lastRow Then Exit Sub
    colCount = UBound(data, 2)
    mid = (firstRow + lastRow) \ 2
    ReDim pivot(1 To colCount)
    For c = 1 To colCount
        pivot(c) = data(mid, c)
    Next c
    i = firstRow: j = lastRow
    Do While i <= j
        Do While CompareRawRows(data, i, pivot) < 0
            i = i + 1
        Loop
        Do While CompareRawRows(data, j, pivot) > 0
            j = j - 1
        Loop
        If i <= j Then
            For c = 1 To colCount
                swapValue = data(i, c): data(i, c) = data(j, c): data(j, c) = swapValue
            Next c
            i = i + 1: j = j - 1
        End If
    Loop
    If firstRow < j Then QuickSortRawRows data, firstRow, j
    If i < lastRow Then QuickSortRawRows data, i, lastRow
End Sub

Private Function CompareRawRows(ByRef data() As Variant, ByVal rowNo As Long, _
                                ByRef pivot() As Variant) As Long
    Dim colNo As Variant, result As Long
    For Each colNo In Array(1, 2, 3, 4, 5, 7) ' Band, Load, RPM, Model, frequency
        result = CompareRawValue(data(rowNo, CLng(colNo)), pivot(CLng(colNo)))
        If result <> 0 Then
            CompareRawRows = result
            Exit Function
        End If
    Next colNo
End Function

Private Function CompareRawValue(ByVal leftValue As Variant, ByVal rightValue As Variant) As Long
    If IsNumeric(leftValue) And IsNumeric(rightValue) Then
        If CDbl(leftValue) < CDbl(rightValue) Then
            CompareRawValue = -1
        ElseIf CDbl(leftValue) > CDbl(rightValue) Then
            CompareRawValue = 1
        End If
    Else
        ' Binary comparison gives predictable source-style ordering: LOAD1
        ' precedes LOAD_TEST instead of locale sorting '_' ahead of digits.
        CompareRawValue = StrComp(UCase$(CStr(leftValue)), UCase$(CStr(rightValue)), vbBinaryCompare)
    End If
End Function

' CSV quote characters delimit fields; they are not part of headers or values.
Private Function CsvCellText(ByVal rawText As String) As String
    rawText = Trim$(rawText)
    If Len(rawText) >= 2 And Left$(rawText, 1) = """" And Right$(rawText, 1) = """" Then
        rawText = Mid$(rawText, 2, Len(rawText) - 2)
        rawText = Replace(rawText, """""", """")
    End If
    CsvCellText = Trim$(rawText)
End Function


' ---------- Button: show/hide the active data sheets ----------
Public Sub ToggleDataSheets()
    Dim vis As Boolean, nm As Variant, ws As Worksheet
    vis = Not (Worksheets("RAW_NB").Visible = xlSheetVisible)
    For Each nm In Array("RAW_NB", "RAW_OB")
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
    Dim d As Object, styles As Object, toggles As Object
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
    Set toggles = CreateObject("Scripting.Dictionary")
    toggles.CompareMode = vbTextCompare
    r = row0
    Do While Len(Trim$(wsCfg.Cells(r, mC).Value)) > 0
        styles(Trim$(wsCfg.Cells(r, mC).Value)) = CaptureModelStyle(wsCfg, r, mC)
        If Len(CStr(wsCfg.Cells(CFG_STATE_DATA_ROW + r - row0, _
                                CFG_MODEL_ENABLED_COL).Value2)) = 0 Then
            toggles(Trim$(wsCfg.Cells(r, mC).Value)) = True
        Else
            toggles(Trim$(wsCfg.Cells(r, mC).Value)) = _
                CBool(wsCfg.Cells(CFG_STATE_DATA_ROW + r - row0, _
                                  CFG_MODEL_ENABLED_COL).Value2)
        End If
        r = r + 1
    Loop

    ' Rewrite model names only. Do not clear the palette/style cells beside them.
    wsCfg.Range(wsCfg.Cells(row0, mC), wsCfg.Cells(r + d.Count + 5, mC)).ClearContents
    n = 0
    For Each k In d.Keys
        wsCfg.Cells(row0 + n, mC).Value = k
        If styles.Exists(CStr(k)) Then RestoreModelStyle wsCfg, row0 + n, mC, styles(CStr(k))
        If toggles.Exists(CStr(k)) Then
            wsCfg.Cells(CFG_STATE_DATA_ROW + n, CFG_MODEL_ENABLED_COL).Value2 = toggles(CStr(k))
        Else
            wsCfg.Cells(CFG_STATE_DATA_ROW + n, CFG_MODEL_ENABLED_COL).Value2 = True
        End If
        n = n + 1
    Next k
    wsCfg.Range(wsCfg.Cells(CFG_STATE_DATA_ROW + n, CFG_MODEL_ENABLED_COL), _
                wsCfg.Cells(CFG_STATE_DATA_ROW + CFG_STATE_MAX_ROWS - 1, _
                            CFG_MODEL_ENABLED_COL)).ClearContents
End Sub

' CALC sheets are formula views.  Every RAW field is selected from the CALC
' column header; mic lookups derive the source header from the MicroID header.
Public Sub RebuildRawCalcMaps()
    WriteCalcNbFormulas
    WriteCalcObFormulas
    ClearLegacyTechnicalState
End Sub

Private Sub WriteCalcNbFormulas()
    Dim wsRaw As Worksheet, ws As Worksheet, lastR As Long, clearTo As Long
    Set wsRaw = ThisWorkbook.Worksheets("RAW_NB"): Set ws = ThisWorkbook.Worksheets("CALC_NB")
    lastR = wsRaw.Cells(wsRaw.Rows.Count, 1).End(xlUp).Row
    clearTo = Application.Max(ws.Cells(ws.Rows.Count, 1).End(xlUp).Row, lastR + 2)
    If clearTo < 4 Then clearTo = 4
    ws.Range("A4:I" & clearTo).ClearContents: ws.Range("L4:O" & clearTo).ClearContents
    If lastR < 2 Then Exit Sub
    ws.Range("A4:I" & lastR + 2).FormulaR1C1 = _
        "=IFERROR(INDEX(RAW_NB!R2C1:R" & lastR & "C9,ROW()-3,XMATCH(IF(COLUMN()>=6,""" & HDR_MIC_PREFIX & """&R2C,IF(COLUMN()=5,""" & HDR_NB_FREQ & """,R2C)),RAW_NB!R1C1:R1C9,0)),"""")"
    ws.Range("L4:O" & lastR + 2).FormulaR1C1 = "=IF(RC[-6]="""","""",R3C11*10^(RC[-6]/20))"
End Sub

Private Sub WriteCalcObFormulas()
    Dim wsRaw As Worksheet, ws As Worksheet, lastR As Long, clearTo As Long
    Set wsRaw = ThisWorkbook.Worksheets("RAW_OB"): Set ws = ThisWorkbook.Worksheets("CALC_OB")
    lastR = wsRaw.Cells(wsRaw.Rows.Count, 1).End(xlUp).Row
    clearTo = Application.Max(ws.Cells(ws.Rows.Count, 1).End(xlUp).Row, lastR + 2)
    If clearTo < 4 Then clearTo = 4
    ws.Range("A4:K" & clearTo).ClearContents: ws.Range("N4:Q" & clearTo).ClearContents
    ws.Range("T4:W" & clearTo).ClearContents
    If lastR < 2 Then Exit Sub
    ws.Range("A4:K" & lastR + 2).FormulaR1C1 = _
        "=IFERROR(INDEX(RAW_OB!R2C1:R" & lastR & "C11,ROW()-3,XMATCH(IF(COLUMN()>=8,""" & HDR_MIC_PREFIX & """&R2C,R2C),RAW_OB!R1C1:R1C11,0)),"""")"
    ws.Range("N4:Q" & lastR + 2).FormulaR1C1 = "=IF(RC[-6]="""","""",R3C13*10^(RC[-6]/20))"
    ws.Range("T4:W" & lastR + 2).FormulaR1C1 = "=IF(RC[-6]="""","""",20*LOG10((R3C18*RC[-6])/R3C19))"
End Sub

Private Function RawNbHeaders() As Variant
    RawNbHeaders = Array(HDR_BAND, HDR_LOAD, HDR_RPM, HDR_MODEL, HDR_NB_FREQ, _
                         HDR_MIC_PREFIX & MIC_ID_1, HDR_MIC_PREFIX & MIC_ID_2, _
                         HDR_MIC_PREFIX & MIC_ID_3, HDR_MIC_PREFIX & MIC_ID_4)
End Function

Private Function RawObHeaders() As Variant
    RawObHeaders = Array(HDR_BAND, HDR_LOAD, HDR_RPM, HDR_MODEL, HDR_OB_LOW, _
                         HDR_OB_HIGH, HDR_OB_CENTER, HDR_MIC_PREFIX & MIC_ID_1, _
                         HDR_MIC_PREFIX & MIC_ID_2, HDR_MIC_PREFIX & MIC_ID_3, _
                         HDR_MIC_PREFIX & MIC_ID_4)
End Function

Private Sub ClearLegacyTechnicalState()
    Dim ws As Worksheet, nm As Name, staleNames As New Collection, i As Long
    Set ws = ThisWorkbook.Worksheets("CONFIG")
    ' Keep only the active technical-state columns in AG:AT. The unused mirror
    ' columns and retired compact-index names are application-owned.
    ws.Range("AJ:AJ,AP:AP,AS:AS").ClearContents
    For Each nm In ThisWorkbook.Names
        If Left$(nm.Name, 5) = "idxNB" Or Left$(nm.Name, 5) = "idxOB" Then staleNames.Add nm.Name
    Next nm
    For i = 1 To staleNames.Count
        ThisWorkbook.Names(CStr(staleNames(i))).Delete
    Next i
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

' ---------- refresh dropdown choices in CONFIG technical state ----------
Public Sub RefreshConfigState()
    Dim wsF As Worksheet, wsL As Worksheet, d As Object, r As Long, lastR As Long
    Dim k As Variant, arr() As Variant, rpmArr() As Variant, loadArr() As Variant
    Dim n As Long, i As Long, j As Long, tmp As Variant
    Dim loadName As String, rpmValue As Variant, displayText As String
    Set wsF = Worksheets("FILES"): Set wsL = Worksheets("CONFIG")
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
    wsL.Range(wsL.Cells(CFG_STATE_DATA_ROW, CFG_RPM_LABEL_COL), _
              wsL.Cells(CFG_STATE_DATA_ROW + CFG_STATE_MAX_ROWS - 1, _
                        CFG_RPM_VALUE_COL)).ClearContents
    wsL.Range(wsL.Cells(CFG_STATE_DATA_ROW, CFG_LOAD_VALUE_COL), _
              wsL.Cells(CFG_STATE_DATA_ROW + CFG_STATE_MAX_ROWS - 1, _
                        CFG_LOAD_VALUE_COL)).ClearContents
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
        wsL.Cells(CFG_STATE_DATA_ROW + i - 1, CFG_RPM_LABEL_COL).Value = arr(i)
        wsL.Cells(CFG_STATE_DATA_ROW + i - 1, CFG_RPM_VALUE_COL).Value = rpmArr(i)
        wsL.Cells(CFG_STATE_DATA_ROW + i - 1, CFG_LOAD_VALUE_COL).Value = loadArr(i)
    Next i
    ' Load and RPM are separate user inputs on SPL, not a combined named value.
    With Worksheets("SPL")
        If Len(Trim$(CStr(.Range("D2").Value2))) = 0 Then .Range("D2").Value = loadArr(1)
        If Len(Trim$(CStr(.Range("D3").Value2))) = 0 Then .Range("D3").Value = rpmArr(1)
    End With
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
