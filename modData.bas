Attribute VB_Name = "modData"
Option Explicit

' CSV import and dashboard refresh.
'
' This module supports the current NB and OB CSV structure. It writes RAW,
' fills the visible CALC formula templates and refreshes both dashboards.

Private Const CALC_TEMPLATE_ROW As Long = 4

Private mNarrowbandData() As Variant, mOctavebandData() As Variant
Private mNarrowbandExpectedRows As Long, mOctavebandExpectedRows As Long
Private mNarrowbandRowCount As Long, mOctavebandRowCount As Long
Private mNbMicHeader1 As String, mNbMicHeader2 As String
Private mNbMicHeader3 As String, mNbMicHeader4 As String
Private mObMicHeader1 As String, mObMicHeader2 As String
Private mObMicHeader3 As String, mObMicHeader4 As String

' Appends the selected CSV files to the FILES list.
Public Sub SelectCsvFiles()
    Dim picker As FileDialog
    Dim filesSheet As Worksheet
    Dim selectedFile As Variant
    Dim lastRow As Long

    Set picker = Application.FileDialog(msoFileDialogFilePicker)
    picker.Title = "Select CSV files"
    picker.AllowMultiSelect = True
    picker.Filters.Clear
    picker.Filters.Add "CSV files", "*.csv"
    If picker.Show = 0 Then Exit Sub

    Set filesSheet = ThisWorkbook.Worksheets("FILES")
    lastRow = filesSheet.Cells(filesSheet.Rows.Count, "A").End(xlUp).Row
    If lastRow < 2 Then lastRow = 1

    For Each selectedFile In picker.SelectedItems
        lastRow = lastRow + 1
        filesSheet.Cells(lastRow, "A").Value2 = CStr(selectedFile)
        filesSheet.Cells(lastRow, "B").Value2 = FileNameFromPath(CStr(selectedFile))
    Next selectedFile

    filesSheet.Activate
End Sub

' Clears every selected CSV from the FILES list.
Public Sub ClearFileList()
    Dim filesSheet As Worksheet

    Set filesSheet = ThisWorkbook.Worksheets("FILES")
    filesSheet.Range("A2:F" & filesSheet.Rows.Count).ClearContents
    filesSheet.Activate
End Sub

' Runs the complete CSV import from FILES through both dashboards.
Public Sub ImportAll(Optional ByVal silent As Boolean = False)
    Dim previousEvents As Boolean, previousScreenUpdating As Boolean

    On Error GoTo ImportFailed

    previousEvents = Application.EnableEvents
    previousScreenUpdating = Application.ScreenUpdating

    Application.Calculation = xlCalculationManual
    Application.EnableEvents = False
    Application.ScreenUpdating = False

    ValidateFiles
    ReadFiles
    WriteNarrowbandData
    WriteOctavebandData
    FillNarrowbandFormulas
    FillOctavebandFormulas
    ThisWorkbook.Worksheets("CALC_NB").Calculate
    ThisWorkbook.Worksheets("CALC_OB").Calculate
    modSPL.RefreshSPL

    Application.Calculation = xlCalculationAutomatic
    Application.EnableEvents = previousEvents
    Application.ScreenUpdating = previousScreenUpdating

    If Not silent Then
        MsgBox "Import completed." & vbCrLf & _
               "RAW_NB rows: " & mNarrowbandRowCount & vbCrLf & _
               "RAW_OB rows: " & mOctavebandRowCount, _
               vbInformation, "Import data"
    End If
    Exit Sub

ImportFailed:
    Dim errorNumber As Long
    Dim errorDescription As String

    errorNumber = Err.Number
    errorDescription = Err.Description

    Application.Calculation = xlCalculationAutomatic
    Application.EnableEvents = previousEvents
    Application.ScreenUpdating = previousScreenUpdating

    Debug.Print "ImportAll", errorNumber, errorDescription
    If silent Then
        Err.Raise errorNumber, "ImportAll", errorDescription
    Else
        MsgBox "Import failed:" & vbCrLf & errorDescription, _
               vbExclamation, "Import data"
    End If
End Sub

' Validates the CSV list on FILES and counts the required NB and OB rows.
Private Sub ValidateFiles()
    Dim filesSheet As Worksheet
    Dim models As Object
    Dim lastFileRow As Long, fileRow As Long, dataRowCount As Long
    Dim filePath As String, modelName As String, bandName As String
    Dim loadName As String, headerText As String
    Dim rpmValue As Double

    Set filesSheet = ThisWorkbook.Worksheets("FILES")
    lastFileRow = filesSheet.Cells(filesSheet.Rows.Count, "A").End(xlUp).Row

    If lastFileRow < 2 Then
        Err.Raise vbObjectError + 101, "ValidateFiles", _
                  "FILES does not contain any CSV files."
    End If

    Set models = CreateObject("Scripting.Dictionary")
    models.CompareMode = vbTextCompare

    mNbMicHeader1 = "": mNbMicHeader2 = ""
    mNbMicHeader3 = "": mNbMicHeader4 = ""
    mObMicHeader1 = "": mObMicHeader2 = ""
    mObMicHeader3 = "": mObMicHeader4 = ""
    mNarrowbandExpectedRows = 0
    mOctavebandExpectedRows = 0

    For fileRow = 2 To lastFileRow
        filePath = ResolveFilePath(filesSheet, fileRow)
        ParseFileName filePath, modelName, bandName, loadName, rpmValue
        ReadCsvHeaderAndRowCount filePath, headerText, dataRowCount
        ValidateCsvHeader headerText, bandName, filePath

        models(modelName) = True

        If bandName = "NB" Then
            mNarrowbandExpectedRows = mNarrowbandExpectedRows + dataRowCount
        Else
            mOctavebandExpectedRows = mOctavebandExpectedRows + dataRowCount
        End If

        filesSheet.Cells(fileRow, "A").Value2 = filePath
        filesSheet.Cells(fileRow, "B").Value2 = FileNameFromPath(filePath)
        filesSheet.Cells(fileRow, "C").Value2 = modelName
        filesSheet.Cells(fileRow, "D").Value2 = bandName
        filesSheet.Cells(fileRow, "E").Value2 = loadName
        filesSheet.Cells(fileRow, "F").Value2 = rpmValue
    Next fileRow

    If models.Count > MAX_MODEL_COUNT Then
        Err.Raise vbObjectError + 102, "ValidateFiles", _
                  "The import contains " & models.Count & _
                  " models. The maximum is " & MAX_MODEL_COUNT & "."
    End If
End Sub

' Returns the CSV path stored in FILES.
Private Function ResolveFilePath(ByVal filesSheet As Worksheet, _
                                 ByVal fileRow As Long) As String
    Dim listedPath As String

    listedPath = Trim$(CStr(filesSheet.Cells(fileRow, "A").Value2))

    If Len(listedPath) = 0 Or Len(Dir$(listedPath)) = 0 Then
        Err.Raise vbObjectError + 103, "ResolveFilePath", _
                  "File not found: " & listedPath
    End If

    ResolveFilePath = listedPath
End Function

' Reads Model, Band, Load and RPM from the current CSV file name.
Private Sub ParseFileName(ByVal filePath As String, _
                          ByRef modelName As String, _
                          ByRef bandName As String, _
                          ByRef loadName As String, _
                          ByRef rpmValue As Double)
    Dim baseName As String, loadAndRpm As String, rpmText As String
    Dim bandPosition As Long, nbPosition As Long, obPosition As Long
    Dim rpmSeparator As Long

    baseName = FileNameFromPath(filePath)
    If LCase$(Right$(baseName, 4)) = ".csv" Then
        baseName = Left$(baseName, Len(baseName) - 4)
    End If

    nbPosition = InStrRev(baseName, "_NB_", -1, vbTextCompare)
    obPosition = InStrRev(baseName, "_OB_", -1, vbTextCompare)

    If nbPosition > obPosition Then
        bandPosition = nbPosition
        bandName = "NB"
    ElseIf obPosition > 0 Then
        bandPosition = obPosition
        bandName = "OB"
    End If

    If bandPosition = 0 Then
        Err.Raise vbObjectError + 104, "ParseFileName", _
                  "Band marker _NB_ or _OB_ is missing: " & baseName
    End If

    modelName = Trim$(Left$(baseName, bandPosition - 1))
    loadAndRpm = Mid$(baseName, bandPosition + 4)
    rpmSeparator = InStrRev(loadAndRpm, "_")

    If rpmSeparator = 0 Then
        Err.Raise vbObjectError + 105, "ParseFileName", _
                  "Load or RPM is missing: " & baseName
    End If

    loadName = Trim$(Left$(loadAndRpm, rpmSeparator - 1))
    rpmText = Trim$(Mid$(loadAndRpm, rpmSeparator + 1))
    If LCase$(Right$(rpmText, 3)) <> "rpm" Then
        Err.Raise vbObjectError + 106, "ParseFileName", _
                  "RPM is missing from file name: " & baseName
    End If

    rpmText = Left$(rpmText, Len(rpmText) - 3)
    If Not IsNumeric(rpmText) Then
        Err.Raise vbObjectError + 107, "ParseFileName", _
                  "RPM is not numeric: " & baseName
    End If
    rpmValue = CDbl(rpmText)

    If Len(modelName) = 0 Or Len(loadName) = 0 Then
        Err.Raise vbObjectError + 108, "ParseFileName", _
                  "Model or Load is missing: " & baseName
    End If
End Sub

' Reads one CSV header and counts its non-empty data rows.
Private Sub ReadCsvHeaderAndRowCount(ByVal filePath As String, _
                                     ByRef headerText As String, _
                                     ByRef dataRowCount As Long)
    Dim fileLines() As String
    Dim lineIndex As Long

    fileLines = Split(NormalizeLineEndings(ReadTextFile(filePath)), vbLf)

    headerText = Trim$(fileLines(0))
    dataRowCount = 0

    For lineIndex = 1 To UBound(fileLines)
        If Len(Trim$(fileLines(lineIndex))) > 0 Then
            dataRowCount = dataRowCount + 1
        End If
    Next lineIndex

    If Len(headerText) = 0 Or dataRowCount = 0 Then
        Err.Raise vbObjectError + 109, "ReadCsvHeaderAndRowCount", _
                  "CSV is empty: " & filePath
    End If
End Sub

' Checks the current NB or OB header and stores its four microphone names.
Private Sub ValidateCsvHeader(ByVal headerText As String, _
                              ByVal bandName As String, _
                              ByVal filePath As String)
    Dim headers() As String

    headers = Split(headerText, ",")

    If bandName = "NB" Then
        If UBound(headers) <> 4 Or _
           StrComp(Trim$(headers(0)), "Frequency [Hz]", vbTextCompare) <> 0 Then
            Err.Raise vbObjectError + 110, "ValidateCsvHeader", _
                      "Unexpected NB header: " & filePath
        End If

        If Len(mNbMicHeader1) = 0 Then
            mNbMicHeader1 = Trim$(headers(1))
            mNbMicHeader2 = Trim$(headers(2))
            mNbMicHeader3 = Trim$(headers(3))
            mNbMicHeader4 = Trim$(headers(4))
        ElseIf StrComp(mNbMicHeader1, Trim$(headers(1)), vbTextCompare) <> 0 Or _
               StrComp(mNbMicHeader2, Trim$(headers(2)), vbTextCompare) <> 0 Or _
               StrComp(mNbMicHeader3, Trim$(headers(3)), vbTextCompare) <> 0 Or _
               StrComp(mNbMicHeader4, Trim$(headers(4)), vbTextCompare) <> 0 Then
            Err.Raise vbObjectError + 114, "ValidateCsvHeader", _
                      "NB microphone headers do not match: " & filePath
        End If
    Else
        If UBound(headers) <> 6 Or _
           StrComp(Trim$(headers(0)), "f_low", vbTextCompare) <> 0 Or _
           StrComp(Trim$(headers(1)), "f_high", vbTextCompare) <> 0 Or _
           StrComp(Trim$(headers(2)), "f_center", vbTextCompare) <> 0 Then
            Err.Raise vbObjectError + 110, "ValidateCsvHeader", _
                      "Unexpected OB header: " & filePath
        End If

        If Len(mObMicHeader1) = 0 Then
            mObMicHeader1 = Trim$(headers(3))
            mObMicHeader2 = Trim$(headers(4))
            mObMicHeader3 = Trim$(headers(5))
            mObMicHeader4 = Trim$(headers(6))
        ElseIf StrComp(mObMicHeader1, Trim$(headers(3)), vbTextCompare) <> 0 Or _
               StrComp(mObMicHeader2, Trim$(headers(4)), vbTextCompare) <> 0 Or _
               StrComp(mObMicHeader3, Trim$(headers(5)), vbTextCompare) <> 0 Or _
               StrComp(mObMicHeader4, Trim$(headers(6)), vbTextCompare) <> 0 Then
            Err.Raise vbObjectError + 114, "ValidateCsvHeader", _
                      "OB microphone headers do not match: " & filePath
        End If
    End If
End Sub

' Reads every validated CSV into the NB and OB arrays in memory.
Private Sub ReadFiles()
    Dim filesSheet As Worksheet
    Dim lastFileRow As Long, fileRow As Long
    Dim filePath As String, modelName As String, bandName As String
    Dim loadName As String
    Dim rpmValue As Double

    Set filesSheet = ThisWorkbook.Worksheets("FILES")
    lastFileRow = filesSheet.Cells(filesSheet.Rows.Count, "A").End(xlUp).Row

    mNarrowbandRowCount = 0
    mOctavebandRowCount = 0

    If mNarrowbandExpectedRows > 0 Then
        ReDim mNarrowbandData(1 To mNarrowbandExpectedRows, 1 To 8)
    End If
    If mOctavebandExpectedRows > 0 Then
        ReDim mOctavebandData(1 To mOctavebandExpectedRows, 1 To 10)
    End If

    For fileRow = 2 To lastFileRow
        filePath = ResolveFilePath(filesSheet, fileRow)
        ParseFileName filePath, modelName, bandName, loadName, rpmValue

        If bandName = "NB" Then
            ReadNarrowbandFile filePath, modelName, loadName, rpmValue
        Else
            ReadOctavebandFile filePath, modelName, loadName, rpmValue
        End If
    Next fileRow
End Sub

' Adds one five-column NB CSV to the RAW_NB data array.
Private Sub ReadNarrowbandFile(ByVal filePath As String, _
                               ByVal modelName As String, _
                               ByVal loadName As String, _
                               ByVal rpmValue As Double)
    Dim fileLines() As String, values() As String
    Dim lineIndex As Long, microphoneIndex As Long

    fileLines = Split(NormalizeLineEndings(ReadTextFile(filePath)), vbLf)

    For lineIndex = 1 To UBound(fileLines)
        If Len(Trim$(fileLines(lineIndex))) > 0 Then
            values = Split(Trim$(fileLines(lineIndex)), ",")
            If UBound(values) <> 4 Then
                Err.Raise vbObjectError + 111, "ReadNarrowbandFile", _
                          "NB row must contain 5 columns: " & filePath
            End If

            mNarrowbandRowCount = mNarrowbandRowCount + 1
            mNarrowbandData(mNarrowbandRowCount, 1) = loadName
            mNarrowbandData(mNarrowbandRowCount, 2) = rpmValue
            mNarrowbandData(mNarrowbandRowCount, 3) = modelName
            mNarrowbandData(mNarrowbandRowCount, 4) = CDbl(values(0))

            For microphoneIndex = 1 To 4
                mNarrowbandData(mNarrowbandRowCount, 4 + microphoneIndex) = _
                    CDbl(values(microphoneIndex))
            Next microphoneIndex
        End If
    Next lineIndex
End Sub

' Adds one seven-column OB CSV to the RAW_OB data array.
Private Sub ReadOctavebandFile(ByVal filePath As String, _
                               ByVal modelName As String, _
                               ByVal loadName As String, _
                               ByVal rpmValue As Double)
    Dim fileLines() As String, values() As String
    Dim lineIndex As Long, microphoneIndex As Long

    fileLines = Split(NormalizeLineEndings(ReadTextFile(filePath)), vbLf)

    For lineIndex = 1 To UBound(fileLines)
        If Len(Trim$(fileLines(lineIndex))) > 0 Then
            values = Split(Trim$(fileLines(lineIndex)), ",")
            If UBound(values) <> 6 Then
                Err.Raise vbObjectError + 112, "ReadOctavebandFile", _
                          "OB row must contain 7 columns: " & filePath
            End If

            mOctavebandRowCount = mOctavebandRowCount + 1
            mOctavebandData(mOctavebandRowCount, 1) = loadName
            mOctavebandData(mOctavebandRowCount, 2) = rpmValue
            mOctavebandData(mOctavebandRowCount, 3) = modelName
            mOctavebandData(mOctavebandRowCount, 4) = CDbl(values(0))
            mOctavebandData(mOctavebandRowCount, 5) = CDbl(values(1))
            mOctavebandData(mOctavebandRowCount, 6) = CDbl(values(2))

            For microphoneIndex = 1 To 4
                mOctavebandData(mOctavebandRowCount, 6 + microphoneIndex) = _
                    CDbl(values(2 + microphoneIndex))
            Next microphoneIndex
        End If
    Next lineIndex
End Sub

' Replaces the RAW_NB header and data with the current NB import.
Private Sub WriteNarrowbandData()
    Dim rawSheet As Worksheet
    Dim previousLastRow As Long

    Set rawSheet = ThisWorkbook.Worksheets("RAW_NB")
    previousLastRow = rawSheet.Cells(rawSheet.Rows.Count, "A").End(xlUp).Row

    If previousLastRow >= 2 Then
        rawSheet.Range("A2:H" & previousLastRow).ClearContents
    End If

    rawSheet.Range("A1:H1").Value2 = Array( _
        "Load", "RPM", "Model", "Frequency [Hz]", _
        mNbMicHeader1, mNbMicHeader2, mNbMicHeader3, mNbMicHeader4)

    If mNarrowbandRowCount > 0 Then
        rawSheet.Range("A2").Resize(mNarrowbandRowCount, 8).Value2 = _
            mNarrowbandData
    End If
End Sub

' Replaces the RAW_OB header and data with the current OB import.
Private Sub WriteOctavebandData()
    Dim rawSheet As Worksheet
    Dim previousLastRow As Long

    Set rawSheet = ThisWorkbook.Worksheets("RAW_OB")
    previousLastRow = rawSheet.Cells(rawSheet.Rows.Count, "A").End(xlUp).Row

    If previousLastRow >= 2 Then
        rawSheet.Range("A2:J" & previousLastRow).ClearContents
    End If

    rawSheet.Range("A1:J1").Value2 = Array( _
        "Load", "RPM", "Model", "f_low_Hz", "f_high_Hz", _
        "f_center_Hz", mObMicHeader1, mObMicHeader2, _
        mObMicHeader3, mObMicHeader4)

    If mOctavebandRowCount > 0 Then
        rawSheet.Range("A2").Resize(mOctavebandRowCount, 10).Value2 = _
            mOctavebandData
    End If
End Sub

' Fills the CALC_NB formulas down to the last imported NB row.
Private Sub FillNarrowbandFormulas()
    Dim calculationSheet As Worksheet
    Dim lastFormulaRow As Long, previousLastRow As Long

    Set calculationSheet = ThisWorkbook.Worksheets("CALC_NB")
    lastFormulaRow = mNarrowbandRowCount + CALC_TEMPLATE_ROW - 1
    previousLastRow = calculationSheet.Cells( _
        calculationSheet.Rows.Count, "A").End(xlUp).Row

    If previousLastRow > CALC_TEMPLATE_ROW Then
        calculationSheet.Range("A5:H" & previousLastRow).ClearContents
        calculationSheet.Range("I5:L" & previousLastRow).ClearContents
    End If

    If mNarrowbandRowCount = 0 Then Exit Sub

    RequireFormula calculationSheet.Range("A4"), "CALC_NB!A4"
    RequireFormula calculationSheet.Range("I4"), "CALC_NB!I4"

    calculationSheet.Range("A4:H4").AutoFill _
        Destination:=calculationSheet.Range("A4:H" & lastFormulaRow)
    calculationSheet.Range("I4:L4").AutoFill _
        Destination:=calculationSheet.Range("I4:L" & lastFormulaRow)
End Sub

' Fills the CALC_OB formulas down to the last imported OB row.
Private Sub FillOctavebandFormulas()
    Dim calculationSheet As Worksheet
    Dim lastFormulaRow As Long, previousLastRow As Long

    Set calculationSheet = ThisWorkbook.Worksheets("CALC_OB")
    lastFormulaRow = mOctavebandRowCount + CALC_TEMPLATE_ROW - 1
    previousLastRow = calculationSheet.Cells( _
        calculationSheet.Rows.Count, "A").End(xlUp).Row

    If previousLastRow > CALC_TEMPLATE_ROW Then
        calculationSheet.Range("A5:J" & previousLastRow).ClearContents
        calculationSheet.Range("K5:N" & previousLastRow).ClearContents
        calculationSheet.Range("O5:R" & previousLastRow).ClearContents
    End If

    If mOctavebandRowCount = 0 Then Exit Sub

    RequireFormula calculationSheet.Range("A4"), "CALC_OB!A4"
    RequireFormula calculationSheet.Range("K4"), "CALC_OB!K4"
    RequireFormula calculationSheet.Range("O4"), "CALC_OB!O4"

    calculationSheet.Range("A4:J4").AutoFill _
        Destination:=calculationSheet.Range("A4:J" & lastFormulaRow)
    calculationSheet.Range("K4:N4").AutoFill _
        Destination:=calculationSheet.Range("K4:N" & lastFormulaRow)
    calculationSheet.Range("O4:R4").AutoFill _
        Destination:=calculationSheet.Range("O4:R" & lastFormulaRow)
End Sub

' Stops the import when a required row-4 formula template is missing.
Private Sub RequireFormula(ByVal templateCell As Range, _
                           ByVal cellDescription As String)
    If Not templateCell.HasFormula Then
        Err.Raise vbObjectError + 113, "RequireFormula", _
                  "Formula template is missing: " & cellDescription
    End If
End Sub

' Reads the complete contents of one CSV file as text.
Private Function ReadTextFile(ByVal filePath As String) As String
    Dim fileNumber As Integer
    Dim errorNumber As Long, errorDescription As String

    On Error GoTo fail
    fileNumber = FreeFile
    Open filePath For Binary Access Read As #fileNumber
    If LOF(fileNumber) > 0 Then
        ReadTextFile = Input$(LOF(fileNumber), fileNumber)
    End If
    Close #fileNumber
    Exit Function
fail:
    errorNumber = Err.Number
    errorDescription = Err.Description
    On Error Resume Next
    If fileNumber > 0 Then Close #fileNumber
    On Error GoTo 0
    Err.Raise errorNumber, "ReadTextFile", errorDescription
End Function

' Converts Windows and old Mac line endings to one VBA line separator.
Private Function NormalizeLineEndings(ByVal textValue As String) As String
    textValue = Replace(textValue, vbCrLf, vbLf)
    textValue = Replace(textValue, vbCr, vbLf)
    NormalizeLineEndings = textValue
End Function

' Returns only the file name from a full Windows path.
Private Function FileNameFromPath(ByVal filePath As String) As String
    Dim separatorPosition As Long

    separatorPosition = InStrRev(filePath, "\")
    If separatorPosition > 0 Then
        FileNameFromPath = Mid$(filePath, separatorPosition + 1)
    Else
        FileNameFromPath = filePath
    End If
End Function
