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

' Returns True when a stored toggle state is enabled.
' Tra ve True khi trang thai toggle dang bat.
Public Function StateIsEnabled(ByVal stateValue As Variant) As Boolean
    If Len(Trim$(CStr(stateValue))) = 0 Then
        StateIsEnabled = True
    Else
        StateIsEnabled = CBool(stateValue)
    End If
End Function

' Colors one existing toggle button. VBA never creates or binds the Shape.
Public Sub SetToggleButtonColor(ByVal ws As Worksheet, _
                                ByVal shapeName As String, _
                                ByVal visible As Boolean, _
                                ByVal activeColor As Long)
    With ws.Shapes(shapeName).Fill
        .Solid
        If visible Then
            .ForeColor.RGB = activeColor
        Else
            .ForeColor.RGB = RGB(166, 166, 166)
        End If
    End With
End Sub

' Colors one Model button from its CONFIG color.
' Doi mau tgModel_N theo cot Color trong CONFIG, hoac mau xam khi an.
Public Sub SetModelButtonColor(ByVal ws As Worksheet, _
                               ByVal modelIndex As Long, _
                               ByVal visible As Boolean)
    Dim activeColor As Long

    activeColor = ThisWorkbook.Worksheets("CONFIG").Range("hdrModels").Offset( _
                  modelIndex, 1).Interior.Color
    SetToggleButtonColor ws, "tgModel_" & modelIndex, visible, activeColor
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
        Case "OVERALL"
            chartNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                "chOverallMulti_3", "chOverallMulti_4", _
                "chOverallSingle_1", "chOverallSingle_2", _
                "chOverallSingle_3", "chOverallSingle_4")
        Case Else
            Exit Sub
    End Select

    allVisible = True
    For modelIndex = 1 To MAX_MODEL_COUNT
        If Len(Trim$(CStr(ThisWorkbook.Worksheets("CONFIG").Range( _
               "hdrModels").Offset(modelIndex, 0).Value2))) > 0 Then
            If Not StateIsEnabled(ResultModelStateCell(ws, modelIndex).Value2) Then _
                allVisible = False
        End If
    Next modelIndex
    showSeries = Not allVisible

    For modelIndex = 1 To MAX_MODEL_COUNT
        ResultModelStateCell(ws, modelIndex).Value2 = showSeries
        If Len(Trim$(CStr(ThisWorkbook.Worksheets("CONFIG").Range( _
               "hdrModels").Offset(modelIndex, 0).Value2))) > 0 Then
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
                If Left$(CStr(chartName), 15) = "chOverallSingle" Then
                    allSeries(seriesIndex).IsFiltered = _
                        (Not showSeries) Or Not SeriesHasData(allSeries(seriesIndex))
                Else
                    allSeries(seriesIndex).IsFiltered = Not showSeries
                End If
            Next seriesIndex
        Next chartName
    End If
    ws.Shapes("sbShowAll").TextFrame.Characters.Text = _
        IIf(showSeries, "Hide All", "Show All")
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Show/Hide All"
End Sub

' Returns False for empty, all-error or zero-placeholder series.
Public Function SeriesHasData(ByVal targetSeries As Series) As Boolean
    On Error Resume Next
    SeriesHasData = Application.Count(targetSeries.Values) > 0 And _
                    (Application.Max(targetSeries.Values) <> 0 Or _
                     Application.Min(targetSeries.Values) <> 0)
    On Error GoTo 0
End Function

' Applies only CONFIG line properties to every result series.
' Khong doi formula, marker, column fill, filter state hay chart data.
Public Sub RefreshSeriesLineStyles()
    On Error GoTo fail
    modSPL.RefreshSPLSeriesRanges
    modOverall.RefreshOverallSeriesRanges
    ApplySeriesLineStyles
    RefreshModelButtonColors
    MsgBox "Series, categories and line styles updated.", _
           vbInformation, "CONFIG"
    Exit Sub
fail:
    MsgBox Err.Description, vbExclamation, "Set series lines"
End Sub

' Refreshes every existing Model button from its CONFIG NB color.
' Cap nhat moi nut Model hien co theo mau NB trong CONFIG.
Public Sub RefreshModelButtonColors()
    Dim ws As Worksheet
    Dim modelIndex As Long, visible As Boolean

    For Each ws In ThisWorkbook.Worksheets(Array("SPL", "OVERALL"))
        For modelIndex = 1 To MAX_MODEL_COUNT
            If ShapeExists(ws, "tgModel_" & modelIndex) Then
                visible = StateIsEnabled(ResultModelStateCell( _
                          ws, modelIndex).Value2)
                SetModelButtonColor ws, modelIndex, visible
            End If
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

    On Error GoTo fail
    Set config = ThisWorkbook.Worksheets("CONFIG")
    For Each ws In ThisWorkbook.Worksheets(Array("SPL", "OVERALL"))
        If ws.Name = "SPL" Then
            chartNames = Array("chMic_1", "chMic_2", "chMic_3", "chMic_4")
        Else
            chartNames = Array("chOverallMulti_1", "chOverallMulti_2", _
                "chOverallMulti_3", "chOverallMulti_4", _
                "chOverallSingle_1", "chOverallSingle_2", _
                "chOverallSingle_3", "chOverallSingle_4")
        End If

        For Each chartName In chartNames
            Set chartItem = ws.ChartObjects(CStr(chartName)).Chart
            Set seriesList = Nothing
            On Error Resume Next
            Set seriesList = chartItem.FullSeriesCollection
            On Error GoTo fail
            If seriesList Is Nothing Then Set seriesList = chartItem.SeriesCollection

            seriesIndex = 0
            For Each seriesItem In seriesList
                seriesIndex = seriesIndex + 1
                If ws.Name = "SPL" Then
                    modelIndex = (seriesIndex + 1) \ 2
                    bandName = IIf(seriesIndex Mod 2 = 0, "OB", "NB")
                    styleOffset = IIf(bandName = "OB", 4, 1)
                Else
                    modelIndex = seriesIndex
                    bandName = "NB"
                    styleOffset = 1
                End If

                modelName = CStr(config.Cells(8 + modelIndex, "A").Value2)
                If Len(modelName) > 0 Then
                    If ws.Name = "SPL" Then
                        seriesItem.Name = modelName & " " & bandName
                    Else
                        seriesItem.Name = modelName
                    End If
                End If
                ApplyOneLineStyle seriesItem, modelName, styleOffset
            Next seriesItem
        Next chartName
    Next ws
    Exit Sub
fail:
    Err.Raise Err.Number, "ApplySeriesLineStyles", Err.Description
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
                              ByVal styleOffset As Long)
    Dim config As Worksheet, modelCell As Range, styleCell As Range
    Dim dashValue As Variant, weightValue As Variant

    Set config = ThisWorkbook.Worksheets("CONFIG")
    Set modelCell = config.Range("A9:A18").Find(modelName, , xlValues, _
                    xlWhole, xlByRows, xlNext, False)
    If modelCell Is Nothing Then Exit Sub

    Set styleCell = modelCell.Offset(0, styleOffset)
    dashValue = styleCell.Offset(0, 1).Value2
    weightValue = styleCell.Offset(0, 2).Value2

    With seriesItem.Format.Line
        .Visible = msoTrue
        If styleCell.Interior.ColorIndex <> xlColorIndexNone Then _
            .ForeColor.RGB = styleCell.Interior.Color
        If IsNumeric(dashValue) And dashValue > 0 Then
            Select Case CLng(dashValue)
                Case 1
                    .DashStyle = msoLineSolid
                Case 2
                    .DashStyle = msoLineDash
                Case Else: .DashStyle = CLng(dashValue)
            End Select
        End If
        If IsNumeric(weightValue) And weightValue > 0 Then _
            .Weight = CSng(weightValue)
    End With
End Sub
