Attribute VB_Name = "modThirdGrid"
Option Explicit

Private Const SH_THIRD As String = "THIRD_OCTAVE"
Private Const SH_OVERALL As String = "OVERALL"
Private Const SH_OB As String = "CALC_OB"
Private Const SH_CONFIG As String = "CONFIG"
Private Const SH_LISTS As String = "LISTS"
Private Const PREFIX_THIRD As String = "1/3_OCT_"
Private Const PREFIX_OVERALL As String = "OVERALL_"
Private Const LEGACY_PREFIX_THIRD As String = "thirdBandChart_"
Private Const LEGACY_PREFIX_OVERALL As String = "overallChart_"
Private Const DATA_COL As Long = 47                 ' AU
Private Const BAND_COL As Long = 42                 ' AP
Private Const MODEL_BLOCK_COLS As Long = 4          ' Four microphones; RPM is shared
Private Const LOAD_LIST_COL As Long = 14            ' LISTS!N
Private Const DATA_CAPACITY As Long = 19

Public Sub PrepareFormulaTemplateRows(ByVal silent As Boolean)
    Dim models As Variant, mics As Variant
    On Error GoTo fail
    models = ConfiguredModels(): mics = ConfiguredMics()
    SyncMultiRpmLoadList
    EnsureFormulaRow ThisWorkbook.Worksheets(SH_THIRD), 9, True, models, mics
    EnsureFormulaRow ThisWorkbook.Worksheets(SH_OVERALL), 9, False, models, mics
    Application.CalculateFull
    SyncFormulaResultSeries True
    Exit Sub
fail:
    Dim messageText As String
    messageText = modLog.ReportError("PrepareFormulaTemplateRows", _
        "prepare formula templates", Err.Number, Err.Description)
    If Not silent Then MsgBox messageText, vbExclamation
End Sub

Public Sub PrepareFirstThreeThirdBands(ByVal silent As Boolean)
    Dim ws As Worksheet, models As Variant, mics As Variant, bands As Variant
    Dim slotNo As Long, headerRow As Long
    On Error GoTo fail
    Set ws = ThisWorkbook.Worksheets(SH_THIRD)
    models = ConfiguredModels(): mics = ConfiguredMics()
    bands = Array(200#, 250#, 315#)
    For slotNo = 1 To 3
        headerRow = FormulaHeaderRow(slotNo)
        PrepareBandCell ws, headerRow, CDbl(bands(slotNo - 1))
        EnsureFormulaRow ws, headerRow, True, models, mics
    Next slotNo
    Application.CalculateFull
    Exit Sub
fail:
    Dim messageText As String
    messageText = modLog.ReportError("PrepareFirstThreeThirdBands", _
        "prepare 200/250/315 Hz formula rows", Err.Number, Err.Description)
    If Not silent Then MsgBox messageText, vbExclamation
End Sub

Public Sub LinkFormulaCharts(Optional ByVal silent As Boolean = False)
    Dim ws As Worksheet, prefixText As String, isThird As Boolean
    Dim models As Variant, mics As Variant, slotNo As Long, micNo As Long
    Dim headerRow As Long, expectedSlots As Collection, item As Variant
    Dim co As ChartObject, linkedN As Long, missing As String, invalid As String
    Dim foundNames As Object, parsedSlot As Long, parsedMic As Long, messageText As String
    On Error GoTo fail
    Set ws = ActiveSheet
    If ws.Name = SH_THIRD Then
        prefixText = PREFIX_THIRD: isThird = True
    ElseIf ws.Name = SH_OVERALL Then
        prefixText = PREFIX_OVERALL
    Else
        If Not silent Then MsgBox "LINK CHARTS only works on THIRD_OCTAVE or OVERALL.", vbExclamation
        Exit Sub
    End If
    models = ConfiguredModels(): mics = ConfiguredMics()
    Set expectedSlots = FormulaSlots(ws, isThird)
    Set foundNames = CreateObject("Scripting.Dictionary"): foundNames.CompareMode = vbTextCompare

    For Each co In ws.ChartObjects
        If ParseChartName(co.Name, prefixText, parsedSlot, parsedMic) Then
            foundNames(CStr(parsedSlot) & "_" & CStr(parsedMic)) = True
            headerRow = FormulaHeaderRow(parsedSlot)
            If Len(Trim$(CStr(ws.Cells(headerRow, DATA_COL).Value2))) = 0 Then
                AppendMessage invalid, co.Name & " (formula table missing)"
            Else
                SyncOneChart co, ws, prefixText, parsedSlot, parsedMic, headerRow, models
                linkedN = linkedN + 1
            End If
        ElseIf HasFormulaChartPrefix(co.Name, prefixText) Then
            AppendMessage invalid, co.Name & " (invalid name)"
        End If
    Next co

    For Each item In expectedSlots
        slotNo = CLng(item)
        For micNo = 1 To 4
            If Not foundNames.Exists(CStr(slotNo) & "_" & CStr(micNo)) Then _
                AppendMessage missing, prefixText & slotNo & "_" & micNo
        Next micNo
    Next item
    Application.CalculateFull
    messageText = "Linked chart series: " & linkedN
    If Len(missing) > 0 Then messageText = messageText & vbCrLf & vbCrLf & "Missing charts:" & vbCrLf & missing
    If Len(invalid) > 0 Then messageText = messageText & vbCrLf & vbCrLf & "Skipped:" & vbCrLf & invalid
    If Len(missing) = 0 And Len(invalid) = 0 Then messageText = messageText & vbCrLf & "All expected charts are linked."
    If Not silent Then MsgBox messageText, _
        IIf(Len(missing) > 0 Or Len(invalid) > 0, vbExclamation, vbInformation), "LINK CHARTS"
    Exit Sub
fail:
    messageText = modLog.ReportError("LinkFormulaCharts", "link active-sheet charts", Err.Number, Err.Description)
    If Not silent Then MsgBox messageText, vbCritical, "LINK CHARTS"
End Sub

Public Sub ToggleFormulaModel()
    Dim ws As Worksheet, callerShape As Shape, modelName As String
    Dim co As ChartObject, s As Series, enableModel As Boolean
    Dim stateText As String, messageText As String
    On Error GoTo fail
    Set ws = Application.ActiveSheet
    If ws.Name <> SH_THIRD And ws.Name <> SH_OVERALL Then Exit Sub
    Set callerShape = ws.Shapes(CStr(Application.Caller))
    modelName = ShapeMetadataValue(callerShape.AlternativeText, "Model")
    If Len(modelName) = 0 Then Err.Raise vbObjectError + 91, _
        "ToggleFormulaModel", "The model button does not contain Model metadata."
    stateText = ShapeMetadataValue(callerShape.AlternativeText, "Enabled")
    enableModel = Not (Len(stateText) = 0 Or stateText = "1")
    For Each co In ws.ChartObjects
        Set s = FindSeries(co.Chart, modelName)
        If Not s Is Nothing Then s.IsFiltered = Not enableModel
    Next co
    callerShape.AlternativeText = "Model=" & modelName & "|Enabled=" & IIf(enableModel, "1", "0")
    StyleFormulaModelButton callerShape, modelName, enableModel
    Exit Sub
fail:
    messageText = modLog.ReportError("ToggleFormulaModel", "toggle formula chart model", _
        Err.Number, Err.Description)
    MsgBox messageText, vbExclamation
End Sub

Public Sub SyncFormulaResultSeries(ByVal silent As Boolean)
    Dim models As Variant, mics As Variant
    Dim stageName As String
    On Error GoTo fail
    stageName = "read model and mic configuration"
    models = ConfiguredModels(): mics = ConfiguredMics()
    stageName = "update multi-RPM load list"
    SyncMultiRpmLoadList
    stageName = "sync THIRD_OCTAVE formula tables and chart series"
    SyncFormulaSheet ThisWorkbook.Worksheets(SH_THIRD), PREFIX_THIRD, True, models, mics
    stageName = "sync OVERALL formula tables and chart series"
    SyncFormulaSheet ThisWorkbook.Worksheets(SH_OVERALL), PREFIX_OVERALL, False, models, mics
    stageName = "sync model controls"
    EnsureResultModelControls True
    stageName = "calculate formula tables"
    Application.CalculateFull
    modLog.ReportSuccess "SyncFormulaResultSeries", "existing named charts synchronized"
    Exit Sub
fail:
    Dim messageText As String
    messageText = modLog.ReportError("SyncFormulaResultSeries", _
        stageName, Err.Number, Err.Description)
    If Not silent Then MsgBox messageText, vbExclamation
End Sub

Public Sub EnsureResultModelControls(Optional ByVal silent As Boolean = False)
    Dim models As Variant, sheetName As Variant, modelI As Long
    Dim ws As Worksheet, stageName As String, messageText As String
    Dim errNum As Long, errDesc As String
    On Error GoTo fail
    models = ConfiguredModels()
    ' SPL model controls are owned exclusively by modRebuild. Keeping result-
    ' grid control creation on THIRD_OCTAVE/OVERALL avoids two modules creating
    ' and repositioning the same cbMdl_* shapes when model count expands.
    For Each sheetName In Array(SH_THIRD, SH_OVERALL)
        Set ws = ThisWorkbook.Worksheets(CStr(sheetName))
        For modelI = LBound(models) To UBound(models)
            stageName = ws.Name & " model " & CStr(modelI - LBound(models) + 1)
            EnsureOneResultModelControl ws, modelI - LBound(models) + 1, CStr(models(modelI))
        Next modelI
    Next sheetName
    Exit Sub
fail:
    errNum = Err.Number: errDesc = Err.Description
    messageText = modLog.ReportError("EnsureResultModelControls", stageName, errNum, errDesc)
    If silent Then
        Err.Raise errNum, "EnsureResultModelControls", errDesc
    Else
        MsgBox messageText, vbExclamation, "MODEL CONTROLS"
    End If
End Sub

Private Sub SyncFormulaSheet(ByVal ws As Worksheet, ByVal prefixText As String, _
                             ByVal isThird As Boolean, ByVal models As Variant, ByVal mics As Variant)
    Dim co As ChartObject, slotNo As Long, micNo As Long, headerRow As Long
    Dim prepared As Object, key As String, stageName As String
    On Error GoTo fail
    Set prepared = CreateObject("Scripting.Dictionary")
    For Each co In ws.ChartObjects
        stageName = "parse " & co.Name
        If ParseChartName(co.Name, prefixText, slotNo, micNo) Then
            headerRow = FormulaHeaderRow(slotNo)
            key = CStr(headerRow)
            If Not prepared.Exists(key) Then
                stageName = "prepare formula table for " & co.Name
                EnsureFormulaRow ws, headerRow, isThird, models, mics
                ws.Calculate
                prepared.Add key, True
            End If
            stageName = "link " & co.Name
            SyncOneChart co, ws, prefixText, slotNo, micNo, headerRow, models
        End If
    Next co
    Exit Sub
fail:
    Err.Raise Err.Number, "SyncFormulaSheet", ws.Name & " | " & stageName & " | " & Err.Description
End Sub

Private Function FormulaSlots(ByVal ws As Worksheet, ByVal isThird As Boolean) As Collection
    Dim result As New Collection, slotNo As Long, headerRow As Long
    For slotNo = 1 To 200
        headerRow = FormulaHeaderRow(slotNo)
        If headerRow > ws.Rows.Count Then Exit For
        If Len(Trim$(CStr(ws.Cells(headerRow, DATA_COL).Value2))) > 0 Then
            If Not isThird Or Len(Trim$(CStr(ws.Cells(headerRow, BAND_COL).Value2))) > 0 Then result.Add slotNo
        End If
    Next slotNo
    Set FormulaSlots = result
End Function

Private Function FormulaHeaderRow(ByVal slotNo As Long) As Long
    FormulaHeaderRow = 9 + (slotNo - 1) * 22
End Function

Private Sub PrepareBandCell(ByVal ws As Worksheet, ByVal headerRow As Long, ByVal bandHz As Double)
    Dim target As Range
    Set target = ws.Range(ws.Cells(headerRow, BAND_COL), ws.Cells(headerRow + 16, BAND_COL + 3))
    target.UnMerge: target.Merge
    target.Value2 = bandHz: target.NumberFormat = "0.### ""Hz"""
    target.Interior.Color = RGB(255, 255, 0): target.Font.Bold = True
    target.HorizontalAlignment = xlCenter: target.VerticalAlignment = xlCenter
End Sub

Private Sub AppendMessage(ByRef targetText As String, ByVal itemText As String)
    If Len(targetText) > 0 Then targetText = targetText & vbCrLf
    targetText = targetText & "- " & itemText
End Sub

Private Sub EnsureFormulaRow(ByVal ws As Worksheet, ByVal headerRow As Long, ByVal isThird As Boolean, _
                             ByVal models As Variant, ByVal mics As Variant)
    Dim modelI As Long, micI As Long, dataI As Long, baseCol As Long, dataRow As Long
    Dim modelCell As Range, rpmCell As Range, formulaText As String
    Dim lastDataRow As Long, loadAddress As String, bandAddress As String
    Dim modelCount As Long, cleanupLastCol As Long
    Dim calcWs As Worksheet
    Set calcWs = ThisWorkbook.Worksheets(SH_OB)
    lastDataRow = LastUsedRow(calcWs, 1)
    dataRow = headerRow + 3
    loadAddress = IIf(isThird, "$D$3", "$P$3")
    bandAddress = ws.Cells(headerRow, BAND_COL).Address(True, True)
    modelCount = UBound(models) - LBound(models) + 1
    'One RPM column is shared by every model.  Each model owns only four mic columns.
    cleanupLastCol = DATA_COL + modelCount * MODEL_BLOCK_COLS
    'AT is the former per-model RPM column.  It belongs to the old formula layout
    'and must be cleared before writing the current shared-RPM table in AU:BG.
    With ws.Range(ws.Cells(headerRow, DATA_COL - 1), _
                  ws.Cells(dataRow + DATA_CAPACITY - 1, cleanupLastCol))
        .UnMerge
        .ClearContents
    End With
    With ws.Range(ws.Cells(headerRow, DATA_COL - 1), _
                  ws.Cells(dataRow + DATA_CAPACITY - 1, DATA_COL - 1))
        .Interior.Pattern = xlNone
        .Borders.LineStyle = xlNone
    End With

    Set rpmCell = ws.Cells(dataRow, DATA_COL)
    ws.Cells(headerRow, DATA_COL).Value2 = "RPM"
    ws.Cells(headerRow + 1, DATA_COL).Value2 = "RPM"
    ws.Cells(headerRow + 2, DATA_COL).Value2 = "[rpm]"
    With ws.Range(ws.Cells(headerRow, DATA_COL), ws.Cells(headerRow + 2, DATA_COL))
        .HorizontalAlignment = xlCenter: .VerticalAlignment = xlCenter
        .Font.Bold = True: .Borders.LineStyle = xlContinuous
        .Borders.Color = RGB(150, 160, 170)
    End With
    ws.Cells(headerRow, DATA_COL).Interior.Color = RGB(18, 55, 85)
    ws.Cells(headerRow, DATA_COL).Font.Color = vbWhite
    ws.Range(ws.Cells(headerRow + 1, DATA_COL), _
             ws.Cells(headerRow + 2, DATA_COL)).Interior.Color = RGB(232, 238, 243)
    If isThird Then
        formulaText = ThirdRpmFormula(loadAddress, bandAddress, lastDataRow)
    Else
        formulaText = OverallRpmFormula(loadAddress, lastDataRow)
    End If
    rpmCell.Formula2 = formulaText

    For modelI = LBound(models) To UBound(models)
        baseCol = DATA_COL + 1 + (modelI - LBound(models)) * MODEL_BLOCK_COLS
        Set modelCell = ws.Cells(headerRow, baseCol)
        ws.Range(ws.Cells(headerRow, baseCol), ws.Cells(headerRow, baseCol + 3)).Merge
        modelCell.Value2 = CStr(models(modelI))
        With ws.Range(ws.Cells(headerRow, baseCol), ws.Cells(headerRow, baseCol + 3))
            .HorizontalAlignment = xlCenter: .VerticalAlignment = xlCenter
            .Font.Bold = True: .Interior.Color = RGB(18, 55, 85): .Font.Color = vbWhite
        End With
        For micI = 0 To 3
            ws.Cells(headerRow + 1, baseCol + micI).Value2 = CStr(mics(micI))
            ws.Cells(headerRow + 2, baseCol + micI).Value2 = "[dBA]"
        Next micI
        With ws.Range(ws.Cells(headerRow + 1, baseCol), ws.Cells(headerRow + 2, baseCol + 3))
            .HorizontalAlignment = xlCenter: .VerticalAlignment = xlCenter
            .Font.Bold = True: .Interior.Color = RGB(232, 238, 243)
            .Borders.LineStyle = xlContinuous: .Borders.Color = RGB(150, 160, 170)
        End With
        For micI = 1 To 4
            For dataI = 0 To DATA_CAPACITY - 1
                If isThird Then
                    formulaText = ThirdValueFormula(ws.Cells(dataRow + dataI, DATA_COL).Address(False, True), _
                        modelCell.Address(True, True), loadAddress, bandAddress, micI, lastDataRow)
                Else
                    formulaText = OverallValueFormula(ws.Cells(dataRow + dataI, DATA_COL).Address(False, True), _
                        modelCell.Address(True, True), loadAddress, micI, lastDataRow)
                End If
                ws.Cells(dataRow + dataI, baseCol + micI - 1).Formula2 = formulaText
            Next dataI
        Next micI
    Next modelI
End Sub

Private Function ThirdRpmFormula(ByVal loadRef As String, ByVal bandRef As String, _
                                 ByVal lastR As Long) As String
    ThirdRpmFormula = "=LET(ld," & loadRef & ",bd," & bandRef & _
        ",IF(OR(ld="""",bd=""""),"""",SORT(UNIQUE(FILTER(CALC_OB!$C$2:$C$" & lastR & _
        ",(CALC_OB!$B$2:$B$" & lastR & "=ld)*(CALC_OB!$I$2:$I$" & lastR & _
        "=bd),"""")))))"
End Function

Private Function ThirdValueFormula(ByVal rpmRef As String, ByVal modelRef As String, _
                                   ByVal loadRef As String, ByVal bandRef As String, _
                                   ByVal micNo As Long, ByVal lastR As Long) As String
    ThirdValueFormula = "=IF(" & rpmRef & "="""","""",IFERROR(MAXIFS(CALC_OB!$J$2:$J$" & lastR & _
        ",CALC_OB!$A$2:$A$" & lastR & "," & modelRef & ",CALC_OB!$B$2:$B$" & lastR & _
        "," & loadRef & ",CALC_OB!$C$2:$C$" & lastR & "," & rpmRef & ",CALC_OB!$E$2:$E$" & lastR & _
        "," & micNo & ",CALC_OB!$I$2:$I$" & lastR & "," & bandRef & "),NA()))"
End Function

Private Function OverallRpmFormula(ByVal loadRef As String, ByVal lastR As Long) As String
    OverallRpmFormula = "=LET(ld," & loadRef & _
        ",IF(ld="""","""",SORT(UNIQUE(FILTER(CALC_OB!$C$2:$C$" & lastR & _
        ",CALC_OB!$B$2:$B$" & lastR & "=ld,"""")))))"
End Function

Private Function OverallValueFormula(ByVal rpmRef As String, ByVal modelRef As String, _
                                     ByVal loadRef As String, ByVal micNo As Long, ByVal lastR As Long) As String
    OverallValueFormula = "=IF(" & rpmRef & "="""","""",IFERROR(IF($D$3=""POA"",MAXIFS(CALC_OB!$O$2:$O$" & lastR & _
        ",CALC_OB!$A$2:$A$" & lastR & "," & modelRef & ",CALC_OB!$B$2:$B$" & lastR & _
        "," & loadRef & ",CALC_OB!$C$2:$C$" & lastR & "," & rpmRef & ",CALC_OB!$E$2:$E$" & lastR & _
        "," & micNo & "),MAXIFS(CALC_OB!$L$2:$L$" & lastR & ",CALC_OB!$A$2:$A$" & lastR & _
        "," & modelRef & ",CALC_OB!$B$2:$B$" & lastR & "," & loadRef & ",CALC_OB!$C$2:$C$" & lastR & _
        "," & rpmRef & ",CALC_OB!$E$2:$E$" & lastR & "," & micNo & ")),NA()))"
End Function

Private Sub SyncOneChart(ByVal co As ChartObject, ByVal ws As Worksheet, ByVal prefixText As String, _
                         ByVal slotNo As Long, ByVal micNo As Long, ByVal headerRow As Long, ByVal models As Variant)
    Dim modelI As Long, baseCol As Long, dataRow As Long, pointCount As Long, s As Series
    Dim xAddress As String, yAddress As String, sheetRef As String, stageName As String
    On Error GoTo fail
    dataRow = headerRow + 3
    sheetRef = "'" & Replace(ws.Name, "'", "''") & "'!"
    For modelI = LBound(models) To UBound(models)
        baseCol = DATA_COL + 1 + (modelI - LBound(models)) * MODEL_BLOCK_COLS
        pointCount = Application.Count(ws.Cells(dataRow, DATA_COL).Resize(DATA_CAPACITY, 1))
        If pointCount < 1 Then pointCount = 1
        xAddress = ws.Cells(dataRow, DATA_COL).Resize(pointCount, 1).Address(True, True)
        yAddress = ws.Cells(dataRow, baseCol + micNo - 1).Resize(pointCount, 1).Address(True, True)
        stageName = "find series " & CStr(models(modelI))
        Set s = FindSeries(co.Chart, CStr(models(modelI)))
        stageName = "create series " & CStr(models(modelI))
        If s Is Nothing Then Set s = co.Chart.SeriesCollection.NewSeries
        stageName = "assign series " & CStr(models(modelI))
        s.Formula = "=SERIES(""" & CStr(models(modelI)) & """," & _
                    sheetRef & xAddress & "," & sheetRef & yAddress & "," & _
                    (modelI - LBound(models) + 1) & ")"
    Next modelI
    stageName = "remove unknown series"
    DeleteUnknownSeries co.Chart, models
    Exit Sub
fail:
    Err.Raise Err.Number, "SyncOneChart", co.Name & " | " & stageName & " | " & Err.Description
End Sub

Private Sub SyncMultiRpmLoadList()
    Dim ws As Worksheet, data As Variant, lastR As Long, loads As Object, rpms As Object
    Dim r As Long, loadName As String, item As Variant, outRow As Long, target As Range
    Set ws = ThisWorkbook.Worksheets(SH_OB): lastR = LastUsedRow(ws, 1)
    Set loads = CreateObject("Scripting.Dictionary"): loads.CompareMode = vbTextCompare
    If lastR >= 2 Then data = ws.Range("A2:C" & lastR).Value2
    For r = 1 To UBound(data, 1)
        loadName = CStr(data(r, 2))
        If Not loads.Exists(loadName) Then Set rpms = CreateObject("Scripting.Dictionary"): loads.Add loadName, rpms
        Set rpms = loads(loadName): rpms(CStr(data(r, 3))) = True
    Next r
    Set ws = ThisWorkbook.Worksheets(SH_LISTS)
    ws.Range(ws.Cells(1, LOAD_LIST_COL), ws.Cells(ws.Rows.Count, LOAD_LIST_COL)).ClearContents
    ws.Cells(1, LOAD_LIST_COL).Value2 = "MULTI-RPM LOADS": outRow = 2
    For Each item In loads.Keys
        If loads(item).Count > 1 Then ws.Cells(outRow, LOAD_LIST_COL).Value2 = CStr(item): outRow = outRow + 1
    Next item
    If outRow > 2 Then
        Set target = ws.Cells(2, LOAD_LIST_COL).Resize(outRow - 2, 1)
        AddOrReplaceName "multiRpmLoadList", "='" & SH_LISTS & "'!" & target.Address(True, True)
        'Do not rewrite validation automatically: these result sheets are user-laid out.
        'The named list remains available for the existing load selector controls.
        EnsureFormulaLoadSelection ThisWorkbook.Worksheets(SH_THIRD).Range("D3"), target
        EnsureFormulaLoadSelection ThisWorkbook.Worksheets(SH_OVERALL).Range("P3"), target
    End If
End Sub

Private Sub EnsureFormulaLoadSelection(ByVal selectedCell As Range, ByVal validLoads As Range)
    Dim item As Range, currentValue As String, isValid As Boolean
    currentValue = Trim$(CStr(selectedCell.Value2))
    For Each item In validLoads.Cells
        If StrComp(currentValue, Trim$(CStr(item.Value2)), vbTextCompare) = 0 Then
            isValid = True
            Exit For
        End If
    Next item
    If Not isValid Then selectedCell.Value2 = validLoads.Cells(1, 1).Value2
End Sub

Private Function ConfiguredModels() As Variant
    Dim hdr As Range, countN As Long, result() As Variant, i As Long
    Set hdr = ThisWorkbook.Worksheets(SH_CONFIG).Range("hdrModels")
    Do While Len(Trim$(CStr(hdr.Offset(countN + 1, 0).Value2))) > 0: countN = countN + 1: Loop
    ReDim result(0 To countN - 1)
    For i = 0 To countN - 1: result(i) = CStr(hdr.Offset(i + 1, 0).Value2): Next i
    ConfiguredModels = result
End Function

Private Function ConfiguredMics() As Variant
    Dim hdr As Range, result(0 To 3) As Variant, i As Long
    Set hdr = ThisWorkbook.Worksheets(SH_CONFIG).Range("hdrMics")
    For i = 0 To 3: result(i) = CStr(hdr.Offset(i + 1, 1).Value2): Next i
    ConfiguredMics = result
End Function

Private Function ParseChartName(ByVal chartName As String, ByVal prefixText As String, _
                                ByRef slotNo As Long, ByRef micNo As Long) As Boolean
    Dim tail As String, parts As Variant
    If StrComp(Left$(chartName, Len(prefixText)), prefixText, vbTextCompare) = 0 Then
        tail = Mid$(chartName, Len(prefixText) + 1)
        parts = Split(tail, "_")
        If UBound(parts) <> 1 Then Exit Function
        If Not IsNumeric(parts(0)) Or Not IsNumeric(parts(1)) Then Exit Function
        slotNo = CLng(parts(0)): micNo = CLng(parts(1))
    ElseIf prefixText = PREFIX_THIRD And _
           StrComp(Left$(chartName, Len(LEGACY_PREFIX_THIRD)), LEGACY_PREFIX_THIRD, vbTextCompare) = 0 Then
        tail = Mid$(chartName, Len(LEGACY_PREFIX_THIRD) + 1)
        parts = Split(tail, "_")
        If UBound(parts) <> 1 Then Exit Function
        If Not IsNumeric(parts(0)) Or Not IsNumeric(parts(1)) Then Exit Function
        slotNo = CLng(parts(0)): micNo = CLng(parts(1))
    ElseIf prefixText = PREFIX_OVERALL And _
           StrComp(Left$(chartName, Len(LEGACY_PREFIX_OVERALL)), LEGACY_PREFIX_OVERALL, vbTextCompare) = 0 Then
        tail = Mid$(chartName, Len(LEGACY_PREFIX_OVERALL) + 1)
        If Not IsNumeric(tail) Then Exit Function
        slotNo = 1: micNo = CLng(tail)
    Else
        Exit Function
    End If
    If slotNo < 1 Or micNo < 1 Or micNo > 4 Then Exit Function
    ParseChartName = True
End Function

Private Function HasFormulaChartPrefix(ByVal chartName As String, ByVal prefixText As String) As Boolean
    If StrComp(Left$(chartName, Len(prefixText)), prefixText, vbTextCompare) = 0 Then
        HasFormulaChartPrefix = True
    ElseIf prefixText = PREFIX_THIRD Then
        HasFormulaChartPrefix = (StrComp(Left$(chartName, Len(LEGACY_PREFIX_THIRD)), _
            LEGACY_PREFIX_THIRD, vbTextCompare) = 0)
    ElseIf prefixText = PREFIX_OVERALL Then
        HasFormulaChartPrefix = (StrComp(Left$(chartName, Len(LEGACY_PREFIX_OVERALL)), _
            LEGACY_PREFIX_OVERALL, vbTextCompare) = 0)
    End If
End Function

Private Function FindSeries(ByVal ch As Chart, ByVal modelName As String) As Series
    Dim s As Series
    For Each s In ch.SeriesCollection
        If StrComp(Replace(CStr(s.Name), "=", ""), modelName, vbTextCompare) = 0 Then Set FindSeries = s: Exit Function
    Next s
End Function

Private Function ShapeMetadataValue(ByVal metadata As String, ByVal keyName As String) As String
    Dim parts As Variant, part As Variant, prefixText As String
    prefixText = keyName & "="
    parts = Split(metadata, "|")
    For Each part In parts
        If StrComp(Left$(CStr(part), Len(prefixText)), prefixText, vbTextCompare) = 0 Then
            ShapeMetadataValue = Mid$(CStr(part), Len(prefixText) + 1)
            Exit Function
        End If
    Next part
End Function

Private Sub StyleFormulaModelButton(ByVal shp As Shape, ByVal modelName As String, ByVal enabled As Boolean)
    Dim hdr As Range, rowOffset As Long, modelColor As Long
    Set hdr = ThisWorkbook.Worksheets(SH_CONFIG).Range("hdrModels")
    rowOffset = 1
    Do While Len(Trim$(CStr(hdr.Offset(rowOffset, 0).Value2))) > 0
        If StrComp(CStr(hdr.Offset(rowOffset, 0).Value2), modelName, vbTextCompare) = 0 Then
            modelColor = modRebuild.GetModelDisplayColor(rowOffset)
            Exit Do
        End If
        rowOffset = rowOffset + 1
    Loop
    If modelColor = 0 Then modelColor = RGB(64, 103, 145)
    shp.Fill.ForeColor.RGB = IIf(enabled, modelColor, RGB(190, 198, 205))
End Sub

Private Sub EnsureOneResultModelControl(ByVal ws As Worksheet, ByVal modelIndex As Long, _
                                        ByVal modelName As String)
    Dim nameCell As Range, previousCell As Range, shp As Shape, templateShape As Shape
    Dim nameText As String, shapeName As String, enabled As Boolean, stateText As String
    Dim verticalStep As Double
    nameText = ResultModelRangeName(ws.Name, modelIndex)
    Set nameCell = ExistingNamedCell(nameText, ws)
    If nameCell Is Nothing Then
        If modelIndex = 1 Then
            Set nameCell = ws.Range("AF2")
        Else
            Set previousCell = ExistingNamedCell(ResultModelRangeName(ws.Name, modelIndex - 1), ws)
            If previousCell Is Nothing Then Err.Raise vbObjectError + 96, _
                "EnsureOneResultModelControl", ws.Name & " previous model named range is missing."
            Set nameCell = previousCell.Offset(1, 0)
            previousCell.Copy Destination:=nameCell
        End If
        AddOrReplaceName nameText, "='" & Replace(ws.Name, "'", "''") & "'!" & nameCell.Address
    End If
    nameCell.Value2 = modelName

    shapeName = "cbMdl_" & modelIndex
    Set shp = FindShapeByName(ws, shapeName)
    If shp Is Nothing Then
        Set shp = FindShapeByName(ws, "formulaModelToggle_" & modelIndex)
        If Not shp Is Nothing Then shp.Name = shapeName
    End If
    If shp Is Nothing Then
        If modelIndex <= 1 Then Err.Raise vbObjectError + 97, _
            "EnsureOneResultModelControl", ws.Name & " has no model button template."
        Set templateShape = FindShapeByName(ws, "cbMdl_" & modelIndex - 1)
        Set previousCell = ExistingNamedCell(ResultModelRangeName(ws.Name, modelIndex - 1), ws)
        If templateShape Is Nothing Or previousCell Is Nothing Then Err.Raise vbObjectError + 98, _
            "EnsureOneResultModelControl", ws.Name & " previous model button is missing."
        verticalStep = nameCell.Top - previousCell.Top
        Set shp = ws.Shapes.AddShape(msoShapeRoundedRectangle, templateShape.Left, _
            templateShape.Top + verticalStep, templateShape.Width, templateShape.Height)
        templateShape.PickUp
        shp.Apply
        shp.Name = shapeName
        shp.Placement = xlFreeFloating
    End If

    If ws.Name = "SPL" Then
        shp.OnAction = "ToggleDashboardFilter"
        shp.AlternativeText = "$C$" & (modelIndex + 1) & "|Model " & modelIndex
        enabled = CBool(ThisWorkbook.Worksheets(SH_LISTS).Cells(modelIndex + 1, 3).Value2)
    Else
        stateText = ShapeMetadataValue(shp.AlternativeText, "Enabled")
        enabled = (Len(stateText) = 0 Or stateText = "1")
        shp.OnAction = "ToggleFormulaModel"
        shp.AlternativeText = "Model=" & modelName & "|Enabled=" & IIf(enabled, "1", "0")
    End If
    shp.Visible = msoTrue
    SetModelButtonFill shp, modelIndex, enabled
End Sub

Private Function ResultModelRangeName(ByVal sheetName As String, ByVal modelIndex As Long) As String
    Select Case sheetName
        Case "SPL": ResultModelRangeName = "plotModelName_" & modelIndex
        Case SH_THIRD: ResultModelRangeName = "thirdModelName_" & modelIndex
        Case SH_OVERALL: ResultModelRangeName = "overallModelName_" & modelIndex
    End Select
End Function

Private Function ExistingNamedCell(ByVal nameText As String, ByVal expectedSheet As Worksheet) As Range
    Dim nm As Name
    On Error Resume Next
    Set nm = ThisWorkbook.Names(nameText)
    If Not nm Is Nothing Then Set ExistingNamedCell = nm.RefersToRange.Cells(1, 1)
    On Error GoTo 0
    If Not ExistingNamedCell Is Nothing Then
        If Not ExistingNamedCell.Parent Is expectedSheet Then Set ExistingNamedCell = Nothing
    End If
End Function

Private Function FindShapeByName(ByVal ws As Worksheet, ByVal shapeName As String) As Shape
    On Error Resume Next
    Set FindShapeByName = ws.Shapes(shapeName)
    On Error GoTo 0
End Function

Private Sub SetModelButtonFill(ByVal shp As Shape, ByVal modelIndex As Long, ByVal enabled As Boolean)
    Dim modelColor As Long
    modelColor = modRebuild.GetModelDisplayColor(modelIndex)
    shp.Fill.ForeColor.RGB = IIf(enabled, modelColor, RGB(190, 198, 205))
End Sub

Private Sub DeleteUnknownSeries(ByVal ch As Chart, ByVal models As Variant)
    Dim i As Long, j As Long, keep As Boolean
    For i = ch.SeriesCollection.Count To 1 Step -1
        keep = False
        For j = LBound(models) To UBound(models)
            If StrComp(Replace(CStr(ch.SeriesCollection(i).Name), "=", ""), CStr(models(j)), vbTextCompare) = 0 Then keep = True: Exit For
        Next j
        If Not keep Then ch.SeriesCollection(i).Delete
    Next i
End Sub

Private Sub ApplySeriesStyle(ByVal s As Series, ByVal modelName As String)
    Dim hdr As Range, r As Long, clr As Long
    Set hdr = ThisWorkbook.Worksheets(SH_CONFIG).Range("hdrModels")
    r = 1
    Do While Len(Trim$(CStr(hdr.Offset(r, 0).Value2))) > 0
        If StrComp(CStr(hdr.Offset(r, 0).Value2), modelName, vbTextCompare) = 0 Then clr = hdr.Offset(r, STYLE_OB_COLOR_OFS).Interior.Color: Exit Do
        r = r + 1
    Loop
    If clr = 0 Then clr = RGB(64, 103, 145)
    s.Format.Line.ForeColor.RGB = clr: s.Format.Line.Weight = 1.75
    s.MarkerForegroundColor = clr: s.MarkerBackgroundColor = clr
End Sub

Private Function SeriesRangeName(ByVal sheetName As String, ByVal slotNo As Long, _
                                 ByVal modelNo As Long, ByVal micNo As Long) As String
    SeriesRangeName = "ser_" & IIf(sheetName = SH_THIRD, "oct", "oa") & "_" & slotNo & "_" & modelNo & "_" & micNo
End Function

Private Sub AddOrReplaceName(ByVal nameText As String, ByVal refersText As String)
    On Error Resume Next: ThisWorkbook.Names(nameText).Delete: On Error GoTo 0
    ThisWorkbook.Names.Add Name:=nameText, RefersTo:=refersText
End Sub

Private Function LastUsedRow(ByVal ws As Worksheet, ByVal columnNo As Long) As Long
    LastUsedRow = ws.Cells(ws.Rows.Count, columnNo).End(xlUp).Row
End Function
