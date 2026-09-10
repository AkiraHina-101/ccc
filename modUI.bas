Attribute VB_Name = "modUI"
Option Explicit

' Returns the Model index stored in a generic Model-button name.
' Tra ve chi so Model duoc luu trong ten button Model dung chung.
Public Function ModelIndexFromButton(ByVal buttonName As String) As Long
    Const BUTTON_PREFIX As String = "tgModel_"
    Dim indexText As String

    If StrComp(Left$(buttonName, Len(BUTTON_PREFIX)), _
               BUTTON_PREFIX, vbTextCompare) <> 0 Then _
        Err.Raise vbObjectError + 830, "ModelIndexFromButton", _
                  "Invalid Model button: " & buttonName
    indexText = Mid$(buttonName, Len(BUTTON_PREFIX) + 1)
    If Not IsNumeric(indexText) Then _
        Err.Raise vbObjectError + 831, "ModelIndexFromButton", _
                  "Invalid Model button: " & buttonName
    ModelIndexFromButton = CLng(indexText)
    If ModelIndexFromButton < 1 Or ModelIndexFromButton > MAX_MODEL_COUNT Then _
        Err.Raise vbObjectError + 832, "ModelIndexFromButton", _
                  "Unsupported Model index: " & ModelIndexFromButton
End Function

' Returns the shared local state cell for one result-sheet Model.
' Tra ve o trang thai dung chung cho mot Model tren sheet ket qua.
Public Function ResultModelStateCell(ByVal ws As Worksheet, _
                                     ByVal modelIndex As Long) As Range
    If modelIndex < 1 Or modelIndex > MAX_MODEL_COUNT Then _
        Err.Raise vbObjectError + 833, "ResultModelStateCell", _
                  "Unsupported Model index: " & modelIndex
    If modelIndex <= 5 Then
        Set ResultModelStateCell = ws.Cells(modelIndex + 1, "V")
    Else
        Set ResultModelStateCell = ws.Cells(modelIndex - 4, "AF")
    End If
End Function

' Returns the cell that displays one Model name beside its toggle button.
' Tra ve o hien ten Model nam canh nut bat/tat.
Public Function ResultModelLabelCell(ByVal ws As Worksheet, _
                                     ByVal modelIndex As Long) As Range
    If modelIndex < 1 Or modelIndex > MAX_MODEL_COUNT Then _
        Err.Raise vbObjectError + 834, "ResultModelLabelCell", _
                  "Unsupported Model index: " & modelIndex
    If modelIndex <= 5 Then
        Set ResultModelLabelCell = ws.Cells(modelIndex + 1, "W")
    Else
        Set ResultModelLabelCell = ws.Cells(modelIndex - 4, "AG")
    End If
End Function

' Returns True when a stored toggle state is enabled.
' Tra ve True khi trang thai toggle dang bat.
Public Function StateIsEnabled(ByVal stateValue As Variant) As Boolean
    If Len(Trim$(CStr(stateValue))) = 0 Then
        StateIsEnabled = True
    Else
        StateIsEnabled = CBool(stateValue)
    End If
End Function

' Returns the number of nonblank Model slots in CONFIG!A9:A18.
Public Function ConfiguredModelCount() As Long
    Dim slotIndex As Long

    For slotIndex = 1 To MAX_MODEL_COUNT
        If Len(Trim$(CStr(ThisWorkbook.Worksheets("CONFIG"). _
               Cells(8 + slotIndex, "A").Value2))) > 0 Then
            ConfiguredModelCount = ConfiguredModelCount + 1
        End If
    Next slotIndex
End Function

' Maps the Nth existing chart Model to its physical CONFIG slot 1...10.
Public Function ModelSlotFromSeriesOrdinal( _
                ByVal modelOrdinal As Long) As Long
    Dim slotIndex As Long, currentOrdinal As Long

    If modelOrdinal < 1 Then Exit Function
    For slotIndex = 1 To MAX_MODEL_COUNT
        If Len(Trim$(CStr(ThisWorkbook.Worksheets("CONFIG"). _
               Cells(8 + slotIndex, "A").Value2))) > 0 Then
            currentOrdinal = currentOrdinal + 1
            If currentOrdinal = modelOrdinal Then
                ModelSlotFromSeriesOrdinal = slotIndex
                Exit Function
            End If
        End If
    Next slotIndex
End Function

' Maps one physical CONFIG slot to its compact chart Model position.
Public Function SeriesOrdinalFromModelSlot(ByVal modelSlot As Long) As Long
    Dim slotIndex As Long

    If modelSlot < 1 Or modelSlot > MAX_MODEL_COUNT Then Exit Function
    If Len(Trim$(CStr(ThisWorkbook.Worksheets("CONFIG"). _
           Cells(8 + modelSlot, "A").Value2))) = 0 Then Exit Function
    For slotIndex = 1 To modelSlot
        If Len(Trim$(CStr(ThisWorkbook.Worksheets("CONFIG"). _
               Cells(8 + slotIndex, "A").Value2))) > 0 Then
            SeriesOrdinalFromModelSlot = _
                SeriesOrdinalFromModelSlot + 1
        End If
    Next slotIndex
End Function

' Adds or removes chart series so only configured Models are represented.
Public Sub EnsureChartSeriesCount(ByVal targetChart As Object, _
                                  ByVal expectedCount As Long)
    If expectedCount < 0 Then expectedCount = 0
    Do While targetChart.FullSeriesCollection.Count < expectedCount
        targetChart.SeriesCollection.NewSeries
    Loop
    Do While targetChart.FullSeriesCollection.Count > expectedCount
        targetChart.FullSeriesCollection( _
            targetChart.FullSeriesCollection.Count).Delete
    Loop
End Sub

' Colors one existing toggle button. VBA never creates or binds the Shape.
Public Sub SetToggleButtonColor(ByVal ws As Worksheet, _
                                ByVal shapeName As String, _
                                ByVal visible As Boolean, _
                                ByVal activeColor As Long)
    Dim buttonShape As Shape
    Dim fillColor As Long, textColor As Long

    Set buttonShape = ws.Shapes(shapeName)
    If visible Then
        fillColor = activeColor
    Else
        fillColor = RGB(166, 166, 166)
    End If

    With buttonShape.Fill
        .Solid
        .ForeColor.RGB = fillColor
    End With

    textColor = ContrastingTextColor(fillColor)
    ' TextFrame2 covers modern Shapes; TextFrame keeps older Excel compatible.
    On Error Resume Next
    buttonShape.TextFrame2.TextRange.Font.Fill.ForeColor.RGB = textColor
    buttonShape.TextFrame.Characters.Font.Color = textColor
    On Error GoTo 0
End Sub

' Returns black for a light fill and white for a dark fill.
Private Function ContrastingTextColor(ByVal fillColor As Long) As Long
    Dim redValue As Long, greenValue As Long, blueValue As Long
    Dim brightness As Double

    redValue = fillColor And &HFF&
    greenValue = (fillColor \ &H100&) And &HFF&
    blueValue = (fillColor \ &H10000) And &HFF&
    brightness = redValue * 0.299 + greenValue * 0.587 + _
                 blueValue * 0.114
    If brightness >= 160 Then
        ContrastingTextColor = RGB(0, 0, 0)
    Else
        ContrastingTextColor = RGB(255, 255, 255)
    End If
End Function

' Colors one Model button from its CONFIG color.
' Doi mau tgModel_N theo cot Color trong CONFIG, hoac mau xam khi an.
Public Sub SetModelButtonColor(ByVal ws As Worksheet, _
                               ByVal modelIndex As Long, _
                               ByVal visible As Boolean)
    Dim activeColor As Long

    activeColor = ThisWorkbook.Worksheets("CONFIG").Cells( _
                  8 + modelIndex, "B").Interior.Color
    SetToggleButtonColor ws, "tgModel_" & modelIndex, visible, activeColor
    SetModelLabelColor ws, modelIndex
End Sub

' Keeps the nearby Model-name text synchronized with its CONFIG color.
' Dong bo mau chu ten Model canh nut voi mau trong CONFIG.
Public Sub SetModelLabelColor(ByVal ws As Worksheet, _
                              ByVal modelIndex As Long)
    Dim config As Worksheet
    Dim modelName As String, labelColor As Long
    Dim labelCell As Range

    Set config = ThisWorkbook.Worksheets("CONFIG")
    modelName = Trim$(CStr(config.Cells(8 + modelIndex, "A").Value2))
    If Len(modelName) > 0 Then
        labelColor = config.Cells(8 + modelIndex, "B").Interior.Color
    Else
        labelColor = RGB(217, 217, 217)
    End If
    Set labelCell = ResultModelLabelCell(ws, modelIndex)
    With labelCell
        .Interior.Pattern = xlSolid
        .Interior.Color = labelColor
        .Font.Color = ContrastingTextColor(labelColor)
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
    End With
End Sub

' Shows or hides every valid series and changes the button text.
' Series Single RPM rong/0 luon duoc giu an.
Public Sub ToggleAllResultSeries()
    Dim ws As Worksheet
    Dim chartNames As Variant, chartName As Variant
    Dim allSeries As FullSeriesCollection
    Dim seriesIndex As Long, modelIndex As Long
    Dim allVisible As Boolean, showSeries As Boolean

    On Error GoTo fail
    Set ws = Application.ActiveSheet
    Select Case UCase$(ws.Name)
        Case "SPL"
            chartNames = Array("chMic_1", "chMic_2", "chMic_3", "chMic_4")
        Case UCase$(OVERALL_BAND_SHEET)
            chartNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                "chOverallMulti_3", "chOverallMulti_4", _
                "chOverallMulti_5", _
                "chOverallSingle_1", "chOverallSingle_2", _
                "chOverallSingle_3", "chOverallSingle_4", _
                "chOverallSingle_5")
        Case UCase$(OVERALL_BROAD_SHEET)
            chartNames = Array( _
                "chOverallBroadMulti_1", "chOverallBroadMulti_2", _
                "chOverallBroadMulti_3", "chOverallBroadMulti_4", _
                "chOverallBroadMulti_5", _
                "chOverallBroadSingle_1", "chOverallBroadSingle_2", _
                "chOverallBroadSingle_3", "chOverallBroadSingle_4", _
                "chOverallBroadSingle_5")
        Case Else
            Exit Sub
    End Select

    allVisible = True
    For modelIndex = 1 To MAX_MODEL_COUNT
        If Len(Trim$(CStr(ThisWorkbook.Worksheets("CONFIG"). _
               Cells(8 + modelIndex, "A").Value2))) > 0 Then
            If Not StateIsEnabled(ResultModelStateCell(ws, modelIndex).Value2) Then _
                allVisible = False
        End If
    Next modelIndex
    showSeries = Not allVisible

    For modelIndex = 1 To MAX_MODEL_COUNT
        ResultModelStateCell(ws, modelIndex).Value2 = showSeries
        If Len(Trim$(CStr(ThisWorkbook.Worksheets("CONFIG"). _
               Cells(8 + modelIndex, "A").Value2))) > 0 Then
            On Error Resume Next
            SetModelButtonColor ws, modelIndex, showSeries
            On Error GoTo fail
        End If
    Next modelIndex

    If UCase$(ws.Name) = "SPL" Then
        modSPL.ApplySPLSeriesVisibility ws
    Else
        For Each chartName In chartNames
            Set allSeries = ws.ChartObjects(CStr(chartName)).Chart.FullSeriesCollection
            For seriesIndex = 1 To allSeries.Count
                If InStr(1, CStr(chartName), "Single", _
                           vbTextCompare) > 0 Then
                    allSeries(seriesIndex).IsFiltered = _
                        (Not showSeries) Or Not SeriesHasData(allSeries(seriesIndex))
                Else
                    allSeries(seriesIndex).IsFiltered = Not showSeries
                End If
            Next seriesIndex
        Next chartName
    End If
    ws.Shapes("sbShowAll").TextFrame.Characters.text = _
        IIf(showSeries, "Hide All", "Show All")
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Show/Hide All"
End Sub

' Returns False for empty, all-error or zero-placeholder series.
Public Function SeriesHasData(ByVal targetSeries As Series) As Boolean
    Dim seriesValues As Variant, oneValue As Variant

    On Error GoTo noData
    seriesValues = targetSeries.values
    If IsArray(seriesValues) Then
        For Each oneValue In seriesValues
            If Not IsError(oneValue) Then
                If IsNumeric(oneValue) Then
                    If CDbl(oneValue) <> 0 Then
                        SeriesHasData = True
                        Exit For
                    End If
                End If
            End If
        Next oneValue
    ElseIf Not IsError(seriesValues) Then
        If IsNumeric(seriesValues) Then _
            SeriesHasData = (CDbl(seriesValues) <> 0)
    End If
    Err.Clear
    Exit Function
noData:
    SeriesHasData = False
    Err.Clear
End Function

' Applies only CONFIG line properties to every result series.
' Khong doi formula, marker, column fill, filter state hay chart data.
Public Sub RefreshSeriesLineStyles()
    Dim currentStep As String

    On Error GoTo fail
    Debug.Print String$(72, "=")
    Debug.Print "UPDATE SERIES DEBUG START", Format$(Now, "yyyy-mm-dd hh:nn:ss")

    currentStep = "0. Validate Model slots"
    Debug.Print currentStep
    modData.ValidateModelSlots

    currentStep = "1. Refresh SPL series ranges"
    Debug.Print currentStep
    modSPL.RefreshSPLSeriesRanges

    currentStep = "2. Refresh OVERALL series ranges"
    Debug.Print currentStep
    modOverall.RefreshOverallSeriesRanges

    currentStep = "3. Apply series line styles"
    Debug.Print currentStep
    ApplySeriesLineStyles

    currentStep = "4. Synchronize OVERALL marker styles"
    Debug.Print currentStep
    modOverall.RefreshOverallMarkerStyles

    currentStep = "5. Refresh Model button colors"
    Debug.Print currentStep
    RefreshModelButtonColors

    Debug.Print "UPDATE SERIES DEBUG SUCCESS"
    Debug.Print String$(72, "=")
    MsgBox "Series, categories and line styles updated.", _
           vbInformation, "CONFIG"
    Exit Sub
fail:
    Debug.Print "UPDATE SERIES DEBUG FAILED"
    Debug.Print "Step=" & currentStep
    Debug.Print "Error number=" & Err.Number
    Debug.Print "Error source=" & Err.Source
    Debug.Print "Error description=" & Err.Description
    Debug.Print String$(72, "=")
    MsgBox "Step: " & currentStep & vbCrLf & _
           "Error " & Err.Number & ": " & Err.Description, _
           vbExclamation, "Set series lines"
End Sub

' Refreshes every existing Model button from its CONFIG NB color.
' Cap nhat moi nut Model hien co theo mau NB trong CONFIG.
Public Sub RefreshModelButtonColors()
    Dim ws As Worksheet
    Dim modelIndex As Long, visible As Boolean

    For Each ws In ThisWorkbook.Worksheets(Array("SPL", OVERALL_BAND_SHEET, OVERALL_BROAD_SHEET))
        For modelIndex = 1 To MAX_MODEL_COUNT
            If ShapeExists(ws, "tgModel_" & modelIndex) Then
                visible = StateIsEnabled(ResultModelStateCell( _
                          ws, modelIndex).Value2)
                SetModelButtonColor ws, modelIndex, visible
            Else
                SetModelLabelColor ws, modelIndex
            End If
        Next modelIndex
    Next ws
    RefreshOverallModelHeaders
    RefreshSPLModelHeaders
    RefreshTablesModelTextColors
End Sub

' Rebuilds position-driven font colors on TABLES from CONFIG Narrow-band colors.
Public Sub RefreshTablesModelTextColors()
    Dim ws As Worksheet, config As Worksheet
    Dim targetRange As Range, rule As FormatCondition
    Dim rangeAddress As Variant, modelIndex As Long
    Dim anchorAddress As String, modelColor As Long

    Set ws = ThisWorkbook.Worksheets("TABLES")
    Set config = ThisWorkbook.Worksheets("CONFIG")

    For Each rangeAddress In Array( _
            "B11:B21", "J9:S9", "AD9:AM9", _
            "AX9:BG9", "BR9:CA9")
        Set targetRange = ws.Range(CStr(rangeAddress))
        targetRange.FormatConditions.Delete
        anchorAddress = targetRange.Cells(1, 1).Address(False, False)
        For modelIndex = 1 To MAX_MODEL_COUNT
            modelColor = config.Cells(8 + modelIndex, "B").Interior.Color
            Set rule = targetRange.FormatConditions.Add( _
                Type:=xlExpression, _
                Formula1:="=" & anchorAddress & "=CONFIG!$H$" & _
                         CStr(8 + modelIndex))
            rule.Font.Color = modelColor
        Next modelIndex
    Next rangeAddress
End Sub

' Merges and colors the SPL Narrowband and Octave-band Model headers.
' Gop va to mau tieu de Model NB/OB tren sheet SPL theo CONFIG.
Public Sub RefreshSPLModelHeaders()
    Dim ws As Worksheet, config As Worksheet
    Dim modelIndex As Long, firstColumn As Long
    Dim modelName As String, headerColor As Long
    Dim headerRange As Range

    Set ws = ThisWorkbook.Worksheets("SPL")
    Set config = ThisWorkbook.Worksheets("CONFIG")
    For modelIndex = 1 To MAX_MODEL_COUNT
        modelName = Trim$(CStr(config.Cells(8 + modelIndex, "A").Value2))

        ' Narrowband: five columns per Model, starting at AQ.
        firstColumn = ws.Range("AQ1").Column + (modelIndex - 1) * 5
        Set headerRange = ws.Range(ws.Cells(3, firstColumn), _
                                   ws.Cells(3, firstColumn + 4))
        If Len(modelName) > 0 Then
            headerColor = config.Cells(8 + modelIndex, "B").Interior.Color
        Else
            headerColor = RGB(217, 217, 217)
        End If
        FormatMergedModelHeader headerRange, headerColor

        ' Octave-band: six columns per Model, starting at CP.
        firstColumn = ws.Range("CP1").Column + (modelIndex - 1) * 6
        Set headerRange = ws.Range(ws.Cells(3, firstColumn), _
                                   ws.Cells(3, firstColumn + 5))
        If Len(modelName) > 0 Then
            headerColor = config.Cells(8 + modelIndex, "E").Interior.Color
        Else
            headerColor = RGB(217, 217, 217)
        End If
        FormatMergedModelHeader headerRange, headerColor
    Next modelIndex
End Sub

Private Sub FormatMergedModelHeader(ByVal headerRange As Range, _
                                    ByVal headerColor As Long)
    If Not headerRange.MergeCells Then headerRange.Merge
    With headerRange
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .Interior.Pattern = xlSolid
        .Interior.Color = headerColor
        .Font.Color = ContrastingTextColor(headerColor)
    End With
End Sub

' Merges each four-microphone Model header and applies its CONFIG NB color.
' Gop tieu de Model 4 MIC va to mau theo mau Narrowband trong CONFIG.
Public Sub RefreshOverallModelHeaders()
    Dim ws As Worksheet, config As Worksheet
    Dim modelIndex As Long, headerRow As Variant
    Dim firstColumn As Long, modelName As String, headerColor As Long
    Dim headerRange As Range

    Set config = ThisWorkbook.Worksheets("CONFIG")
    For Each ws In ThisWorkbook.Worksheets( _
            Array(OVERALL_BAND_SHEET, OVERALL_BROAD_SHEET))
        For modelIndex = 1 To MAX_MODEL_COUNT
            firstColumn = ws.Range("BC1").Column + (modelIndex - 1) * 4
            modelName = Trim$(CStr(config.Cells(8 + modelIndex, "A").Value2))
            If Len(modelName) > 0 Then
                headerColor = config.Cells(8 + modelIndex, "B").Interior.Color
            Else
                headerColor = RGB(217, 217, 217)
            End If

            For Each headerRow In Array(10, 29)
                Set headerRange = ws.Range( _
                    ws.Cells(CLng(headerRow), firstColumn), _
                    ws.Cells(CLng(headerRow), firstColumn + 3))
                If Not headerRange.MergeCells Then headerRange.Merge
                With headerRange
                    .HorizontalAlignment = xlCenter
                    .VerticalAlignment = xlCenter
                    .Interior.Pattern = xlSolid
                    .Interior.Color = headerColor
                    .Font.Color = ContrastingTextColor(headerColor)
                End With
            Next headerRow

            ' The 4-MIC tables have one Model-name cell per CONFIG slot.
            For Each headerRow In Array(10, 29)
                Set headerRange = ws.Cells(CLng(headerRow), _
                    ws.Range("CR1").Column + modelIndex - 1)
                With headerRange
                    .Interior.Pattern = xlSolid
                    .Interior.Color = headerColor
                    .Font.Color = ContrastingTextColor(headerColor)
                    .HorizontalAlignment = xlCenter
                    .VerticalAlignment = xlCenter
                End With
            Next headerRow
        Next modelIndex
    Next ws
End Sub

' Returns True when one named Shape exists on the worksheet.
' Tra ve True khi Shape co ten ton tai tren worksheet.
Private Function ShapeExists(ByVal ws As Worksheet, _
                             ByVal shapeName As String) As Boolean
    Dim targetShape As Shape

    On Error Resume Next
    Set targetShape = ws.Shapes(shapeName)
    On Error GoTo 0
    ShapeExists = Not targetShape Is Nothing
End Function

' Testable worker without a dialog; the Shape calls the zero-argument entry above.
Public Sub ApplySeriesLineStyles()
    Dim ws As Worksheet, chartNames As Variant, chartName As Variant
    Dim chartItem As Object, seriesList As Object, seriesItem As Object
    Dim modelName As String, bandName As String
    Dim config As Worksheet
    Dim seriesIndex As Long, modelIndex As Long, styleOffset As Long
    Dim seriesPerModel As Long, modelOrdinal As Long
    Dim updateSeriesFill As Boolean
    Dim debugContext As String

    On Error GoTo fail
    Set config = ThisWorkbook.Worksheets("CONFIG")
    For Each ws In ThisWorkbook.Worksheets(Array("SPL", OVERALL_BAND_SHEET, OVERALL_BROAD_SHEET))
        Debug.Print "STYLE SHEET START", ws.Name
        If ws.Name = "SPL" Then
            seriesPerModel = SPL_SERIES_PER_MODEL
            chartNames = Array("chMic_1", "chMic_2", "chMic_3", "chMic_4")
        ElseIf ws.Name = OVERALL_BAND_SHEET Then
            seriesPerModel = OVERALL_SERIES_PER_MODEL
            chartNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                "chOverallMulti_3", "chOverallMulti_4", _
                "chOverallMulti_5", _
                "chOverallSingle_1", "chOverallSingle_2", _
                "chOverallSingle_3", "chOverallSingle_4", _
                "chOverallSingle_5")
        Else
            seriesPerModel = OVERALL_SERIES_PER_MODEL
            chartNames = Array( _
                "chOverallBroadMulti_1", "chOverallBroadMulti_2", _
                "chOverallBroadMulti_3", "chOverallBroadMulti_4", _
                "chOverallBroadMulti_5", _
                "chOverallBroadSingle_1", "chOverallBroadSingle_2", _
                "chOverallBroadSingle_3", "chOverallBroadSingle_4", _
                "chOverallBroadSingle_5")
        End If

        For Each chartName In chartNames
            debugContext = "Sheet=" & ws.Name & "; Chart=" & CStr(chartName)
            Debug.Print "STYLE CHART START", debugContext
            updateSeriesFill = ((ws.Name = OVERALL_BAND_SHEET Or _
                                ws.Name = OVERALL_BROAD_SHEET) And _
                                InStr(1, CStr(chartName), "Single", _
                                      vbTextCompare) > 0)
            Set chartItem = ws.ChartObjects(CStr(chartName)).Chart
            Set seriesList = Nothing
            On Error Resume Next
            Set seriesList = chartItem.FullSeriesCollection
            On Error GoTo fail
            If seriesList Is Nothing Then Set seriesList = chartItem.SeriesCollection

            seriesIndex = 0
            For Each seriesItem In seriesList
                seriesIndex = seriesIndex + 1
                modelOrdinal = ((seriesIndex - 1) \ seriesPerModel) + 1
                modelIndex = ModelSlotFromSeriesOrdinal(modelOrdinal)
                If modelIndex = 0 Then Exit For
                If ws.Name = "SPL" Then
                    bandName = IIf(seriesIndex Mod 2 = 0, "OB", "NB")
                    styleOffset = IIf(bandName = "OB", 4, 1)
                Else
                    bandName = "NB"
                    styleOffset = 1
                End If

                modelName = CStr(config.Cells(8 + modelIndex, "A").Value2)
                debugContext = "Sheet=" & ws.Name & _
                               "; Chart=" & CStr(chartName) & _
                               "; Series=" & seriesIndex & _
                               "; ModelIndex=" & modelIndex & _
                               "; Model=" & modelName & _
                               "; Band=" & bandName
                Debug.Print "STYLE SERIES", debugContext
                If Len(modelName) > 0 Then
                    If ws.Name = "SPL" Then
                        seriesItem.Name = modelName & " " & bandName
                    Else
                        seriesItem.Name = modelName
                    End If
                End If
                ApplyOneLineStyle seriesItem, modelName, styleOffset, _
                                  updateSeriesFill
            Next seriesItem
            Debug.Print "STYLE CHART SUCCESS", CStr(chartName)
        Next chartName
        Debug.Print "STYLE SHEET SUCCESS", ws.Name
    Next ws
    Exit Sub
fail:
    Debug.Print "APPLY SERIES STYLES FAILED", debugContext
    Debug.Print "Error number=" & Err.Number
    Debug.Print "Error source=" & Err.Source
    Debug.Print "Error description=" & Err.Description
    Err.Raise Err.Number, "ApplySeriesLineStyles", _
              debugContext & "; " & Err.Description
End Sub

' Reads "Model NB" / "Model OB".  An unsuffixed series uses NB style.
Private Sub SeriesStyleKey(ByVal seriesName As String, _
                           ByRef modelName As String, _
                           ByRef bandName As String)
    Dim splitAt As Long, suffix As String

    modelName = Trim$(seriesName)
    bandName = "NB"
    splitAt = InStrRev(modelName, " ")
    If splitAt = 0 Then Exit Sub
    suffix = UCase$(Trim$(Mid$(modelName, splitAt + 1)))
    If suffix = "NB" Or suffix = "OB" Then
        bandName = suffix
        modelName = Trim$(Left$(modelName, splitAt - 1))
    End If
End Sub

' Finds the Model row and applies Color, Line and Weight only.
Private Sub ApplyOneLineStyle(ByVal seriesItem As Series, _
                              ByVal modelName As String, _
                              ByVal styleOffset As Long, _
                              Optional ByVal updateFill As Boolean = False)
    Dim config As Worksheet, modelCell As Range, styleCell As Range
    Dim dashValue As Variant, weightValue As Variant
    Dim currentProperty As String

    On Error GoTo fail
    Set config = ThisWorkbook.Worksheets("CONFIG")
    Set modelCell = config.Range("A9:A18").Find(modelName, , xlValues, _
                    xlWhole, xlByRows, xlNext, False)
    If modelCell Is Nothing Then Exit Sub

    Set styleCell = modelCell.Offset(0, styleOffset)
    dashValue = styleCell.Offset(0, 1).Value2
    weightValue = styleCell.Offset(0, 2).Value2
    Debug.Print "  STYLE VALUES", _
                "Model=" & modelName, _
                "Cell=" & styleCell.Address(False, False), _
                "Color=" & styleCell.Interior.Color, _
                "Dash=" & CStr(dashValue), _
                "Weight=" & CStr(weightValue)

    With seriesItem.Format.line
        currentProperty = "Visible"
        Debug.Print "    SET Visible"
        .visible = msoTrue
        If styleCell.Interior.ColorIndex <> xlColorIndexNone Then
            currentProperty = "ForeColor.RGB"
            Debug.Print "    SET Color", styleCell.Interior.Color
            .ForeColor.RGB = styleCell.Interior.Color
        End If
        If IsNumeric(dashValue) And dashValue > 0 Then
            currentProperty = "DashStyle"
            Debug.Print "    SET DashStyle", CLng(dashValue)
            Select Case CLng(dashValue)
                Case 1
                    .DashStyle = msoLineSolid
                Case 2
                    .DashStyle = msoLineDash
                Case Else: .DashStyle = CLng(dashValue)
            End Select
        End If
        If IsNumeric(weightValue) And weightValue > 0 Then
            currentProperty = "Weight"
            Debug.Print "    SET Weight", CSng(weightValue)
            .Weight = CSng(weightValue)
        End If
    End With
    If updateFill And _
       styleCell.Interior.ColorIndex <> xlColorIndexNone Then
        currentProperty = "Fill.ForeColor.RGB"
        Debug.Print "    SET Fill Color", styleCell.Interior.Color
        With seriesItem.Format.Fill
            .visible = msoTrue
            .Solid
            .ForeColor.RGB = styleCell.Interior.Color
        End With
    End If
    Debug.Print "  STYLE ITEM SUCCESS", modelName
    Exit Sub
fail:
    Debug.Print "  STYLE ITEM FAILED", _
                "Model=" & modelName, _
                "Property=" & currentProperty, _
                "Dash=" & CStr(dashValue), _
                "Weight=" & CStr(weightValue), _
                "Error=" & Err.Number & " / " & Err.Description
    Err.Raise Err.Number, "ApplyOneLineStyle", _
              "Model=" & modelName & _
              "; Property=" & currentProperty & _
              "; Dash=" & CStr(dashValue) & _
              "; Weight=" & CStr(weightValue) & _
              "; " & Err.Description
End Sub


