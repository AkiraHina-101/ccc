Attribute VB_Name = "modUI"
Option Explicit

' Presentation layer for the workbook. Business rules remain in modMain and
' modRebuild; this module only owns visual hierarchy, controls and chart styling.

Private Function C_Navy() As Long: C_Navy = RGB(23, 50, 77): End Function
Private Function C_Blue() As Long: C_Blue = RGB(47, 107, 154): End Function
Private Function C_Teal() As Long: C_Teal = RGB(42, 126, 108): End Function
Private Function C_Ink() As Long: C_Ink = RGB(37, 52, 66): End Function
Private Function C_Muted() As Long: C_Muted = RGB(96, 112, 126): End Function
Private Function C_Canvas() As Long: C_Canvas = RGB(244, 247, 250): End Function
Private Function C_Border() As Long: C_Border = RGB(210, 220, 229): End Function
Private Function C_Input() As Long: C_Input = RGB(235, 245, 252): End Function
Private Function C_Edit() As Long: C_Edit = RGB(255, 248, 218): End Function

Public Sub ApplyWorkbookUI(Optional ByVal silent As Boolean = False)
    Dim oldSheet As Object
    Dim errNum As Long, errText As String, uiStage As String
    On Error GoTo fail
    Set oldSheet = ActiveSheet
    uiStage = "SPL"
    StylePlot Worksheets("SPL")
    uiStage = "FILES"
    StyleFiles Worksheets("FILES")
    uiStage = "CONFIG"
    StyleConfig Worksheets("CONFIG")
    uiStage = "LISTS"
    StyleLists Worksheets("LISTS")
    uiStage = "RAW_NB"
    StyleRawData Worksheets("RAW_NB"), False
    uiStage = "RAW_OB"
    StyleRawData Worksheets("RAW_OB"), True
    uiStage = "CALC_NB"
    StyleCalc Worksheets("CALC_NB"), 8
    uiStage = "CALC_OB"
    StyleCalc Worksheets("CALC_OB"), 15
    uiStage = "sheet tabs"
    StyleWorkbookTabs
    uiStage = "restore active sheet"
    If Not oldSheet Is Nothing Then oldSheet.Activate
    Exit Sub
fail:
    errNum = Err.Number: errText = Err.Description
    modLog.ReportError "ApplyWorkbookUI", "layout - " & uiStage, errNum, errText
    If silent Then
        Err.Raise errNum, "ApplyWorkbookUI", "[" & uiStage & "] " & errText
    Else
        MsgBox "UI refresh failed: " & errText, vbExclamation
    End If
End Sub

' Safe entry point for host automation. Errors are already persisted by
' ApplyWorkbookUI; this wrapper prevents a modal VBA dialog on the desktop.
Public Sub ApplyWorkbookUIAutomation()
    On Error GoTo fail
    ApplyWorkbookUI True
    Exit Sub
fail:
    Debug.Print "AUTOMATION_UI_ERROR", Err.Number, Err.Description
End Sub

' Apply only the PLOT presentation changes that are safe for a user-arranged
' workbook. This entry point never rebuilds chart data or repositions objects.
Public Sub SyncPlotPresentationAutomation()
    Dim ws As Worksheet
    On Error GoTo fail
    Set ws = ThisWorkbook.Worksheets("SPL")
    SyncPlotBindings ws
    EnsureWorkbookSidebar ws
    EnsurePlotTopbarControls ws
    Exit Sub
fail:
    modLog.ReportError "SyncPlotPresentationAutomation", "apply PLOT presentation", _
                       Err.Number, Err.Description
End Sub

Public Sub SyncWorkbookNavigationAutomation()
    Dim sheetName As Variant
    On Error GoTo fail
    For Each sheetName In Array("SPL", "THIRD_OCTAVE", "OVERALL")
        EnsureWorkbookSidebar ThisWorkbook.Worksheets(CStr(sheetName))
    Next sheetName
    EnsurePlotTopbarControls ThisWorkbook.Worksheets("SPL")
    Exit Sub
fail:
    modLog.ReportError "SyncWorkbookNavigationAutomation", "build shared navigation", _
                       Err.Number, Err.Description
End Sub

Public Sub ShowPlotView()
    ActivateWorkbookView "SPL"
End Sub

Public Sub ActivateWorkbookView(ByVal sheetName As String)
    Dim ws As Worksheet, errorMsg As String
    On Error GoTo fail
    Select Case UCase$(sheetName)
        Case "SPL", "THIRD_OCTAVE", "OVERALL"
        Case Else
            Err.Raise vbObjectError + 78, "ActivateWorkbookView", _
                      "Unsupported workbook view: " & sheetName
    End Select
    Set ws = ThisWorkbook.Worksheets(sheetName)
    ws.Activate
    UpdateNavigationHighlight ws.Name
    Exit Sub
fail:
    errorMsg = modLog.ReportError("ActivateWorkbookView", "activate workbook view", _
                                  Err.Number, Err.Description)
    MsgBox errorMsg, vbExclamation
End Sub

Private Sub UpdateNavigationHighlight(ByVal activeViewName As String)
    Dim sheetName As Variant, navNames As Variant, viewNames As Variant
    Dim ws As Worksheet, shp As Shape, i As Long
    Dim baseFill As Long, baseText As Long, metadata As String
    navNames = Array("wbNavPlot", "wbNavThird", "wbNavOverall")
    viewNames = Array("SPL", "THIRD_OCTAVE", "OVERALL")

    For Each sheetName In viewNames
        Set ws = ThisWorkbook.Worksheets(CStr(sheetName))
        For i = LBound(navNames) To UBound(navNames)
            Set shp = Nothing
            On Error Resume Next
            Set shp = ws.Shapes(CStr(navNames(i)))
            On Error GoTo 0
            If Not shp Is Nothing Then
                metadata = shp.AlternativeText
                If Not TryReadShapeColor(metadata, "NavBaseFill", baseFill) Then
                    baseFill = shp.Fill.ForeColor.RGB
                    metadata = metadata & "|NavBaseFill=" & CStr(baseFill)
                End If
                If Not TryReadShapeColor(metadata, "NavBaseText", baseText) Then
                    baseText = shp.TextFrame2.TextRange.Font.Fill.ForeColor.RGB
                    metadata = metadata & "|NavBaseText=" & CStr(baseText)
                End If
                shp.AlternativeText = metadata
                If StrComp(CStr(viewNames(i)), activeViewName, vbTextCompare) = 0 Then
                    shp.Fill.ForeColor.RGB = RGB(255, 235, 0)
                    shp.TextFrame2.TextRange.Font.Fill.ForeColor.RGB = RGB(37, 52, 66)
                Else
                    shp.Fill.ForeColor.RGB = baseFill
                    shp.TextFrame2.TextRange.Font.Fill.ForeColor.RGB = baseText
                End If
            End If
        Next i
    Next sheetName
End Sub

Private Function TryReadShapeColor(ByVal metadata As String, ByVal keyName As String, _
                                   ByRef colorValue As Long) As Boolean
    Dim parts As Variant, part As Variant, prefix As String
    prefix = keyName & "="
    parts = Split(metadata, "|")
    For Each part In parts
        If StrComp(Left$(CStr(part), Len(prefix)), prefix, vbTextCompare) = 0 Then
            If IsNumeric(Mid$(CStr(part), Len(prefix) + 1)) Then
                colorValue = CLng(Mid$(CStr(part), Len(prefix) + 1))
                TryReadShapeColor = True
                Exit Function
            End If
        End If
    Next part
End Function

Public Sub EnsureWorkbookSidebar(ByVal ws As Worksheet)
    Dim x As Single, y As Single, w As Single, h As Single, gap As Single
    x = ws.Range("A1").Left + 2
    w = Application.Max(42, ws.Range("A1").Width - 4)
    PlaceActionButton ws, "wbFit", "FIT", "FitView", x, ws.Range("A1").Top + 2, _
                      w, Application.Max(20, ws.Range("A1").Height - 4), vbWhite, C_Navy()
    y = ws.Range("A7").Top + 2
    h = 24
    gap = 4

    PlaceActionButton ws, "wbNavPlot", "SPL", "ShowPlotView", x, y, w, h, C_Navy(), vbWhite
    y = y + h + gap
    PlaceActionButton ws, "wbNavThird", "1/3 OCT", "ShowThirdOctaveView", x, y, w, h, C_Navy(), vbWhite
    y = y + h + gap
    PlaceActionButton ws, "wbNavOverall", "OA / POA", "ShowOverallView", x, y, w, h, C_Navy(), vbWhite
    y = y + h + gap + 5
    PlaceActionButton ws, "wbAddFiles", "Add files", "AddCSVs", x, y, w, h, C_Blue(), vbWhite
    y = y + h + gap
    PlaceActionButton ws, "wbImport", "Import", "ImportAll", x, y, w, h, C_Teal(), vbWhite
    y = y + h + gap
    PlaceActionButton ws, "wbData", "Data", "ToggleDataSheets", x, y, w, h, C_Muted(), vbWhite
End Sub

Private Sub EnsurePlotTopbarControls(ByVal ws As Worksheet)
    Dim y As Single, h As Single
    y = ws.Range("B7").Top + 2
    h = Application.Max(20, ws.Range("B7").Height - 4)
    PlaceActionButton ws, "uiGridX", "Grid X", "ToggleGridlinesX", _
                      ws.Range("B7").Left + 2, y, ws.Range("B7:C7").Width - 4, h, vbWhite, C_Blue()
    PlaceActionButton ws, "uiGridY", "Grid Y", "ToggleGridlinesY", _
                      ws.Range("D7").Left + 2, y, ws.Range("D7:E7").Width - 4, h, vbWhite, C_Blue()
    PlaceActionButton ws, "uiSeriesColor", "Series", "QuickSeriesColor", _
                      ws.Range("F7").Left + 2, y, ws.Range("F7:G7").Width - 4, h, vbWhite, C_Blue()
End Sub

Private Sub PlaceActionButton(ByVal ws As Worksheet, ByVal shapeName As String, _
                              ByVal caption As String, ByVal macroName As String, _
                              ByVal x As Single, ByVal y As Single, ByVal w As Single, _
                              ByVal h As Single, ByVal fillColor As Long, ByVal textColor As Long)
    Dim shp As Shape, templateShape As Shape, candidate As Shape, duplicated As ShapeRange
    Dim actionName As String
    On Error Resume Next
    Set shp = ws.Shapes(shapeName)
    On Error GoTo 0
    If Not shp Is Nothing Then
        shp.OnAction = macroName
        If Len(shp.AlternativeText) = 0 Then shp.AlternativeText = "SPL action: " & macroName
        Exit Sub
    End If
    For Each candidate In ws.Shapes
        actionName = ""
        On Error Resume Next
        actionName = candidate.OnAction
        On Error GoTo 0
        If Len(actionName) > 0 Then Set templateShape = candidate
    Next candidate
    If Not templateShape Is Nothing Then
        Set duplicated = templateShape.Duplicate
        Set shp = duplicated.Item(1)
        shp.Left = x: shp.Top = y: shp.Width = w: shp.Height = h
        shp.Name = shapeName
        shp.OnAction = macroName
        shp.AlternativeText = "SPL action: " & macroName
        shp.TextFrame2.TextRange.Text = caption
        Exit Sub
    Else
        Set shp = ws.Shapes.AddShape(msoShapeRoundedRectangle, x, y, w, h)
        shp.Name = shapeName
    End If
    With shp
        .OnAction = macroName
        .AlternativeText = "SPL action: " & macroName
        .Placement = xlFreeFloating
        .Left = x: .Top = y: .Width = w: .Height = h
        .Fill.Visible = msoTrue: .Fill.Solid: .Fill.ForeColor.RGB = fillColor
        .Line.Visible = msoTrue
        .Line.ForeColor.RGB = IIf(fillColor = vbWhite, C_Border(), fillColor)
        .Line.Weight = 1: .Shadow.Visible = msoFalse
        With .TextFrame2
            .AutoSize = msoAutoSizeNone
            .MarginLeft = 2: .MarginRight = 2: .MarginTop = 0: .MarginBottom = 0
            .VerticalAnchor = msoAnchorMiddle
            .TextRange.Text = caption
            .TextRange.ParagraphFormat.Alignment = msoAlignCenter
            .TextRange.Font.Name = UI_FONT_NAME
            .TextRange.Font.Size = 8
            .TextRange.Font.Bold = msoTrue
            .TextRange.Font.Fill.ForeColor.RGB = textColor
        End With
    End With
End Sub

Public Sub SyncPlotBindingsAutomation()
    Dim ws As Worksheet
    On Error GoTo fail
    Set ws = ThisWorkbook.Worksheets("SPL")
    SyncPlotBindings ws
    Exit Sub
fail:
    modLog.ReportError "SyncPlotBindingsAutomation", "bind PLOT contract", _
                       Err.Number, Err.Description
    Err.Raise Err.Number, "SyncPlotBindingsAutomation", Err.Description
End Sub

Private Sub SyncPlotBindings(ByVal ws As Worksheet)
    Dim axisNames As Variant, axisCells As Variant
    Dim i As Long, modelIndex As Long, modelCount As Long

    BindExistingName ws, "selRPM", ws.Range("D2")
    BindExistingName ws, "selQty", ws.Range("D4")
    BindExistingName ws, "blkAnchor", ws.Range("B31")
    BindExistingName ws, "plotZoom", ws.Range("A4")

    axisNames = Array("axXmin", "axXmax", "axXmajor", "axXminor", _
                      "axYmin", "axYmax", "axYmajor", "axYminor")
    axisCells = Array("X3", "X4", "X5", "X6", "Y3", "Y4", "Y5", "Y6")
    For i = LBound(axisNames) To UBound(axisNames)
        BindExistingName ws, CStr(axisNames(i)), ws.Range(CStr(axisCells(i)))
    Next i

    modelCount = WorksheetFunction.CountA(Worksheets("CONFIG").Range("hdrModels").Offset(1, 0).Resize(1000, 1))
    For modelIndex = 1 To modelCount
        BindExistingName ws, "plotModelName_" & modelIndex, ws.Range("AF" & modelIndex + 1)
    Next modelIndex

    ApplyListValidation ws.Range("D2"), "=RPMList"
    ApplyListValidation ws.Range("D4"), "=qtyList"
End Sub

Private Sub BindExistingName(ByVal ws As Worksheet, ByVal nameText As String, _
                             ByVal target As Range)
    BindNameToCell ws, nameText, target, target.Value2
End Sub

' User command: apply the zoom stored in A4 of the active worksheet and return
' the window to the top-left of that sheet.
Public Sub FitView()
    Dim activeObject As Object, ws As Worksheet, wnd As Window
    Dim zoomPct As Long, errorMsg As String
    On Error GoTo fail

    Set activeObject = Application.ActiveSheet
    If activeObject Is Nothing Then
        Err.Raise vbObjectError + 71, "FitView", "No active worksheet is available."
    End If
    If Not TypeOf activeObject Is Worksheet Then
        Err.Raise vbObjectError + 72, "FitView", "The active sheet is not a worksheet."
    End If
    Set ws = activeObject
    If Not ws.Parent Is ThisWorkbook Then
        Err.Raise vbObjectError + 73, "FitView", _
                  "The active worksheet does not belong to this workbook."
    End If
    If Not TryReadZoom(ws.Range("A4"), zoomPct) Then
        Err.Raise vbObjectError + 71, "FitView", _
                  ws.Name & "!A4 must contain a zoom from 10% to 400%."
    End If

    Set wnd = ThisWorkbook.Windows(1)
    wnd.Zoom = zoomPct
    wnd.ScrollRow = 1
    wnd.ScrollColumn = 1
    Exit Sub
fail:
    errorMsg = modLog.ReportError("FitView", "apply active-sheet A4 zoom and scroll", _
                                  Err.Number, Err.Description)
    MsgBox errorMsg, vbExclamation
End Sub

Public Sub IncreaseViewZoom()
    ChangeActiveSheetZoom 5
End Sub

Public Sub DecreaseViewZoom()
    ChangeActiveSheetZoom -5
End Sub

' Bind future Adjust buttons to this macro. A button may target one chart by
' storing "AdjustChart=<chart object name>" in AlternativeText. Without that
' metadata, every chart on the active result sheet is adjusted.
Public Sub AdjustChartTitles()
    Dim activeObject As Object, ws As Worksheet, callerShape As Shape
    Dim chartName As String, callerName As String, co As ChartObject
    Dim errorMsg As String
    On Error GoTo fail

    Set activeObject = Application.ActiveSheet
    If activeObject Is Nothing Then Err.Raise vbObjectError + 79, _
        "AdjustChartTitles", "No active worksheet is available."
    If Not TypeOf activeObject Is Worksheet Then Err.Raise vbObjectError + 80, _
        "AdjustChartTitles", "The active sheet is not a worksheet."
    Set ws = activeObject
    If Not ws.Parent Is ThisWorkbook Then Err.Raise vbObjectError + 81, _
        "AdjustChartTitles", "The active worksheet does not belong to this workbook."

    If TypeName(Application.Caller) = "String" Then
        callerName = CStr(Application.Caller)
        On Error Resume Next
        Set callerShape = ws.Shapes(callerName)
        On Error GoTo fail
        If Not callerShape Is Nothing Then
            chartName = MetadataValue(callerShape.AlternativeText, "AdjustChart")
        End If
    End If

    If Len(chartName) > 0 Then
        Set co = ws.ChartObjects(chartName)
        AdjustOneChartTitles co.Chart
    Else
        For Each co In ws.ChartObjects
            AdjustOneChartTitles co.Chart
        Next co
    End If
    Exit Sub
fail:
    errorMsg = modLog.ReportError("AdjustChartTitles", "align chart and axis titles", _
                                  Err.Number, Err.Description)
    MsgBox errorMsg, vbExclamation
End Sub

' Use the selected chart as the size, shape format, and PlotArea master for every
' chart on the active worksheet. Target Left/Top positions and chart data are unchanged.
Public Sub SyncPlotAreasFromSelectedChart()
    Dim ws As Worksheet, masterChart As Chart, co As ChartObject
    Dim masterObject As ChartObject, syncedCount As Long, errorMsg As String
    Dim targetLeft As Double, targetTop As Double
    Dim commonLeft As Double, commonTop As Double
    Dim commonRight As Double, commonBottom As Double
    Dim masterWidth As Double, masterHeight As Double, geometryPass As Long
    On Error GoTo fail

    If Application.ActiveChart Is Nothing Then
        MsgBox "Select one chart to use as the PlotArea master, then run this macro again.", _
               vbExclamation, "SYNC PLOT AREAS"
        Exit Sub
    End If
    Set masterChart = Application.ActiveChart
    If Not TypeOf masterChart.Parent Is ChartObject Then Err.Raise vbObjectError + 92, _
        "SyncPlotAreasFromSelectedChart", "The selected chart is not an embedded worksheet chart."
    Set masterObject = masterChart.Parent
    masterWidth = masterObject.Width
    masterHeight = masterObject.Height
    Set ws = masterObject.Parent
    If Not ws.Parent Is ThisWorkbook Then Err.Raise vbObjectError + 93, _
        "SyncPlotAreasFromSelectedChart", "The selected chart does not belong to this workbook."

    masterObject.Placement = xlFreeFloating
    For Each co In ws.ChartObjects
        If StrComp(co.Name, masterObject.Name, vbTextCompare) <> 0 Then
            targetLeft = co.Left
            targetTop = co.Top
            co.Width = masterObject.Width
            co.Height = masterObject.Height
            co.Placement = xlFreeFloating
            CopyChartShapeFormat masterObject, co
            CopyChartAreaFormat masterChart.ChartArea, co.Chart.ChartArea
            CopyChartTextLayout masterChart, co.Chart
            DoEvents
            SyncOnePlotArea masterChart.PlotArea, co.Chart.PlotArea
            AdjustOneChartTitles co.Chart
            co.Left = targetLeft
            co.Top = targetTop
            syncedCount = syncedCount + 1
        End If
    Next co

    ' Tick labels with different text widths (for example 90 versus 100) can
    ' make the master's inside rectangle impossible for another chart. Use the
    ' intersection that every chart can display, then align all visible grids.
    commonLeft = -1
    commonTop = -1
    commonRight = 1E+30
    commonBottom = 1E+30
    For Each co In ws.ChartObjects
        With co.Chart.PlotArea
            If .InsideLeft > commonLeft Then commonLeft = .InsideLeft
            If .InsideTop > commonTop Then commonTop = .InsideTop
            If .InsideLeft + .InsideWidth < commonRight Then commonRight = .InsideLeft + .InsideWidth
            If .InsideTop + .InsideHeight < commonBottom Then commonBottom = .InsideTop + .InsideHeight
        End With
    Next co
    If commonRight > commonLeft And commonBottom > commonTop Then
        For Each co In ws.ChartObjects
            targetLeft = co.Left
            targetTop = co.Top
            For geometryPass = 1 To 4
                co.Width = masterWidth
                co.Height = masterHeight
                AlignInsidePlotArea co.Chart.PlotArea, commonLeft, commonTop, _
                                    commonRight - commonLeft, commonBottom - commonTop
            Next geometryPass
            AdjustOneChartTitles co.Chart
            co.Width = masterWidth
            co.Height = masterHeight
            co.Left = targetLeft
            co.Top = targetTop
        Next co
    End If
    MsgBox "Chart size, shape format, and PlotArea synchronized from " & masterObject.Name & " to " & _
           syncedCount & " chart(s) on " & ws.Name & ".", _
           vbInformation, "SYNC PLOT AREAS"
    Exit Sub
fail:
    errorMsg = modLog.ReportError("SyncPlotAreasFromSelectedChart", _
        "synchronize chart size, shape format, and PlotArea", Err.Number, Err.Description)
    MsgBox errorMsg, vbExclamation, "SYNC PLOT AREAS"
End Sub

Private Sub CopyChartTextLayout(ByVal sourceChart As Chart, ByVal targetChart As Chart)
    Dim axisType As Variant, sourceAxis As Axis, targetAxis As Axis
    On Error Resume Next

    If sourceChart.HasTitle And targetChart.HasTitle Then
        CopyChartFont sourceChart.ChartTitle.Format.TextFrame2.TextRange.Font, _
                      targetChart.ChartTitle.Format.TextFrame2.TextRange.Font
    End If

    For Each axisType In Array(xlCategory, xlValue)
        Set sourceAxis = Nothing
        Set targetAxis = Nothing
        Set sourceAxis = sourceChart.Axes(axisType, xlPrimary)
        Set targetAxis = targetChart.Axes(axisType, xlPrimary)
        If Not sourceAxis Is Nothing And Not targetAxis Is Nothing Then
            CopyLegacyFont sourceAxis.TickLabels.Font, targetAxis.TickLabels.Font
            targetAxis.TickLabels.NumberFormat = sourceAxis.TickLabels.NumberFormat
            If sourceAxis.HasTitle And targetAxis.HasTitle Then
                CopyChartFont sourceAxis.AxisTitle.Format.TextFrame2.TextRange.Font, _
                              targetAxis.AxisTitle.Format.TextFrame2.TextRange.Font
            End If
        End If
    Next axisType

    If sourceChart.HasLegend And targetChart.HasLegend Then
        CopyLegacyFont sourceChart.Legend.Font, targetChart.Legend.Font
    End If
    On Error GoTo 0
End Sub

Private Sub CopyChartFont(ByVal sourceFont As Object, ByVal targetFont As Object)
    On Error Resume Next
    targetFont.Name = sourceFont.Name
    targetFont.Size = sourceFont.Size
    targetFont.Bold = sourceFont.Bold
    targetFont.Italic = sourceFont.Italic
    targetFont.Fill.ForeColor.RGB = sourceFont.Fill.ForeColor.RGB
    On Error GoTo 0
End Sub

Private Sub CopyLegacyFont(ByVal sourceFont As Object, ByVal targetFont As Object)
    On Error Resume Next
    targetFont.Name = sourceFont.Name
    targetFont.Size = sourceFont.Size
    targetFont.Bold = sourceFont.Bold
    targetFont.Italic = sourceFont.Italic
    targetFont.Color = sourceFont.Color
    On Error GoTo 0
End Sub

Private Sub CopyChartShapeFormat(ByVal sourceObject As ChartObject, ByVal targetObject As ChartObject)
    On Error Resume Next
    With targetObject.ShapeRange.Fill
        .Visible = sourceObject.ShapeRange.Fill.Visible
        If sourceObject.ShapeRange.Fill.Visible Then
            .Solid
            .ForeColor.RGB = sourceObject.ShapeRange.Fill.ForeColor.RGB
            .BackColor.RGB = sourceObject.ShapeRange.Fill.BackColor.RGB
            .Transparency = sourceObject.ShapeRange.Fill.Transparency
        End If
    End With
    With targetObject.ShapeRange.Line
        .Visible = sourceObject.ShapeRange.Line.Visible
        If sourceObject.ShapeRange.Line.Visible Then
            .ForeColor.RGB = sourceObject.ShapeRange.Line.ForeColor.RGB
            .Transparency = sourceObject.ShapeRange.Line.Transparency
            .Weight = sourceObject.ShapeRange.Line.Weight
            .DashStyle = sourceObject.ShapeRange.Line.DashStyle
        End If
    End With
    On Error GoTo 0
End Sub

Private Sub CopyChartAreaFormat(ByVal sourceArea As ChartArea, ByVal targetArea As ChartArea)
    On Error GoTo legacyFormat
    With targetArea.Format.Fill
        .Visible = sourceArea.Format.Fill.Visible
        If sourceArea.Format.Fill.Visible Then
            .Solid
            .ForeColor.RGB = sourceArea.Format.Fill.ForeColor.RGB
            .BackColor.RGB = sourceArea.Format.Fill.BackColor.RGB
            .Transparency = sourceArea.Format.Fill.Transparency
        End If
    End With
    With targetArea.Format.Line
        .Visible = sourceArea.Format.Line.Visible
        If sourceArea.Format.Line.Visible Then
            .ForeColor.RGB = sourceArea.Format.Line.ForeColor.RGB
            .Transparency = sourceArea.Format.Line.Transparency
            .Weight = sourceArea.Format.Line.Weight
            .DashStyle = sourceArea.Format.Line.DashStyle
        End If
    End With
    Exit Sub
legacyFormat:
    Err.Clear
    On Error Resume Next
    targetArea.Interior.Color = sourceArea.Interior.Color
    targetArea.Border.Color = sourceArea.Border.Color
    targetArea.Border.LineStyle = sourceArea.Border.LineStyle
    targetArea.Border.Weight = sourceArea.Border.Weight
    On Error GoTo 0
End Sub

Private Sub SyncOnePlotArea(ByVal sourceArea As PlotArea, ByVal targetArea As PlotArea)
    Dim insideLeft As Double, insideTop As Double
    Dim insideWidth As Double, insideHeight As Double
    insideLeft = sourceArea.InsideLeft
    insideTop = sourceArea.InsideTop
    insideWidth = sourceArea.InsideWidth
    insideHeight = sourceArea.InsideHeight

    targetArea.Left = sourceArea.Left
    targetArea.Top = sourceArea.Top
    targetArea.Width = sourceArea.Width
    targetArea.Height = sourceArea.Height
    ' The visible grid is the inside plot rectangle. Excel can keep the outer
    ' PlotArea equal while changing this rectangle to accommodate tick-label text.
    AlignInsidePlotArea targetArea, insideLeft, insideTop, insideWidth, insideHeight
    CopyPlotAreaFill sourceArea, targetArea
    CopyPlotAreaLine sourceArea, targetArea
End Sub

Private Sub AlignInsidePlotArea(ByVal targetArea As PlotArea, _
                                ByVal desiredLeft As Double, ByVal desiredTop As Double, _
                                ByVal desiredWidth As Double, ByVal desiredHeight As Double)
    Dim requestedLeft As Double, requestedTop As Double
    Dim requestedWidth As Double, requestedHeight As Double
    Dim pass As Long
    requestedLeft = desiredLeft
    requestedTop = desiredTop
    requestedWidth = desiredWidth
    requestedHeight = desiredHeight
    On Error Resume Next
    For pass = 1 To 8
        targetArea.InsideLeft = requestedLeft
        targetArea.InsideTop = requestedTop
        targetArea.InsideWidth = requestedWidth
        targetArea.InsideHeight = requestedHeight
        requestedLeft = requestedLeft + desiredLeft - targetArea.InsideLeft
        requestedTop = requestedTop + desiredTop - targetArea.InsideTop
        requestedWidth = requestedWidth + desiredWidth - targetArea.InsideWidth
        requestedHeight = requestedHeight + desiredHeight - targetArea.InsideHeight
        If Abs(targetArea.InsideLeft - desiredLeft) < 0.05 And _
           Abs(targetArea.InsideTop - desiredTop) < 0.05 And _
           Abs(targetArea.InsideWidth - desiredWidth) < 0.05 And _
           Abs(targetArea.InsideHeight - desiredHeight) < 0.05 Then Exit For
    Next pass
    On Error GoTo 0
End Sub

Private Sub CopyPlotAreaFill(ByVal sourceArea As PlotArea, ByVal targetArea As PlotArea)
    On Error GoTo legacyFill
    With targetArea.Format.Fill
        .Visible = sourceArea.Format.Fill.Visible
        If sourceArea.Format.Fill.Visible Then
            .Solid
            .ForeColor.RGB = sourceArea.Format.Fill.ForeColor.RGB
            .BackColor.RGB = sourceArea.Format.Fill.BackColor.RGB
            .Transparency = sourceArea.Format.Fill.Transparency
        End If
    End With
    Exit Sub
legacyFill:
    Err.Clear
    On Error Resume Next
    targetArea.Interior.Color = sourceArea.Interior.Color
    On Error GoTo 0
End Sub

Private Sub CopyPlotAreaLine(ByVal sourceArea As PlotArea, ByVal targetArea As PlotArea)
    On Error GoTo legacyLine
    With targetArea.Format.Line
        .Visible = sourceArea.Format.Line.Visible
        If sourceArea.Format.Line.Visible Then
            .ForeColor.RGB = sourceArea.Format.Line.ForeColor.RGB
            .Transparency = sourceArea.Format.Line.Transparency
            .Weight = sourceArea.Format.Line.Weight
            .DashStyle = sourceArea.Format.Line.DashStyle
        End If
    End With
    Exit Sub
legacyLine:
    Err.Clear
    On Error Resume Next
    targetArea.Border.Color = sourceArea.Border.Color
    targetArea.Border.LineStyle = sourceArea.Border.LineStyle
    targetArea.Border.Weight = sourceArea.Border.Weight
    On Error GoTo 0
End Sub

Private Sub AdjustOneChartTitles(ByVal ch As Chart)
    Dim plotLeft As Double, plotTop As Double, plotWidth As Double, plotHeight As Double
    Dim outerPlotLeft As Double, outerPlotBottom As Double
    Dim chartWidth As Double, chartHeight As Double
    Dim titleObject As ChartTitle, xTitle As AxisTitle, yTitle As AxisTitle
    On Error GoTo done

    With ch.PlotArea
        plotLeft = .InsideLeft: plotTop = .InsideTop
        plotWidth = .InsideWidth: plotHeight = .InsideHeight
        outerPlotLeft = .Left
        outerPlotBottom = .Top + .Height
    End With
    chartWidth = ch.ChartArea.Width
    chartHeight = ch.ChartArea.Height

    If ch.HasTitle Then
        Set titleObject = ch.ChartTitle
        titleObject.Left = CenterObject(plotLeft, plotWidth, titleObject.Width)
        titleObject.Top = CenterObject(0, plotTop, titleObject.Height)
    End If

    If ch.HasAxis(xlValue, xlPrimary) Then
        If ch.Axes(xlValue, xlPrimary).HasTitle Then
            Set yTitle = ch.Axes(xlValue, xlPrimary).AxisTitle
            yTitle.Left = CenterObject(0, outerPlotLeft, yTitle.Width)
            yTitle.Top = CenterObject(plotTop, plotHeight, yTitle.Height)
        End If
    End If

    If ch.HasAxis(xlCategory, xlPrimary) Then
        If ch.Axes(xlCategory, xlPrimary).HasTitle Then
            Set xTitle = ch.Axes(xlCategory, xlPrimary).AxisTitle
            xTitle.Left = CenterObject(plotLeft, plotWidth, xTitle.Width)
            xTitle.Top = CenterObject(outerPlotBottom, _
                                      Application.Max(0, chartHeight - outerPlotBottom), _
                                      xTitle.Height)
        End If
    End If
done:
End Sub

Private Function CenterObject(ByVal regionStart As Double, ByVal regionSize As Double, _
                              ByVal objectSize As Double) As Double
    CenterObject = regionStart + Application.Max(0, regionSize - objectSize) / 2
End Function

Private Function MetadataValue(ByVal metadata As String, ByVal keyName As String) As String
    Dim parts As Variant, part As Variant, prefix As String
    prefix = keyName & "="
    parts = Split(metadata, "|")
    For Each part In parts
        If StrComp(Left$(CStr(part), Len(prefix)), prefix, vbTextCompare) = 0 Then
            MetadataValue = Mid$(CStr(part), Len(prefix) + 1)
            Exit Function
        End If
    Next part
End Function

Private Sub ChangeActiveSheetZoom(ByVal deltaPercent As Long)
    Dim activeObject As Object, ws As Worksheet
    Dim rawZoom As Double, currentZoomPct As Double, newZoomPct As Double
    Dim errorMsg As String
    On Error GoTo fail

    Set activeObject = Application.ActiveSheet
    If activeObject Is Nothing Then
        Err.Raise vbObjectError + 74, "ChangeActiveSheetZoom", _
                  "No active worksheet is available."
    End If
    If Not TypeOf activeObject Is Worksheet Then
        Err.Raise vbObjectError + 75, "ChangeActiveSheetZoom", _
                  "The active sheet is not a worksheet."
    End If
    Set ws = activeObject
    If Not ws.Parent Is ThisWorkbook Then
        Err.Raise vbObjectError + 76, "ChangeActiveSheetZoom", _
                  "The active worksheet does not belong to this workbook."
    End If
    If Not IsNumeric(ws.Range("A4").Value2) Then
        Err.Raise vbObjectError + 77, "ChangeActiveSheetZoom", _
                  ws.Name & "!A4 must contain a zoom from 10% to 400%."
    End If
    rawZoom = CDbl(ws.Range("A4").Value2)
    If rawZoom > 0 And rawZoom <= 4 Then
        currentZoomPct = rawZoom * 100#
    Else
        currentZoomPct = rawZoom
    End If
    If currentZoomPct < 10 Or currentZoomPct > 400 Then
        Err.Raise vbObjectError + 77, "ChangeActiveSheetZoom", _
                  ws.Name & "!A4 must contain a zoom from 10% to 400%."
    End If
    newZoomPct = currentZoomPct + CDbl(deltaPercent)
    If newZoomPct < 10 Then newZoomPct = 10
    If newZoomPct > 400 Then newZoomPct = 400
    With ws.Range("A4")
        .Value2 = newZoomPct / 100#
        .NumberFormat = "0%"
    End With
    FitView
    Exit Sub
fail:
    errorMsg = modLog.ReportError("ChangeActiveSheetZoom", _
                                  "change active-sheet A4 zoom", _
                                  Err.Number, Err.Description)
    MsgBox errorMsg, vbExclamation
End Sub

Private Sub EnsureFitViewControl(ByVal ws As Worksheet)
    If Len(Trim$(CStr(ws.Range("A4").Value2))) = 0 Then ws.Range("A4").Value2 = 0.6
    BindExistingName ws, "plotZoom", ws.Range("A4")
    With ws.Range("plotZoom")
        If Len(Trim$(CStr(.Value2))) = 0 Then
            .Value2 = 0.8
            .NumberFormat = "0%"
            .HorizontalAlignment = xlCenter
            .VerticalAlignment = xlCenter
            .Font.Name = UI_FONT_NAME
            .Font.Bold = True
            .Font.Color = C_Navy()
        End If
    End With
    EnsureActionButton ws, "uiFitView", "VIEW", "FitView", _
                       ws.Range("A1").Left, ws.Range("A1").Top, _
                       ws.Range("A1").Width, ws.Range("A1").Height, _
                       vbWhite, C_Navy()
End Sub

Private Function TryReadZoom(ByVal sourceCell As Range, ByRef zoomPct As Long) As Boolean
    Dim raw As Variant, textValue As String, parsed As Double, hasPercent As Boolean
    raw = sourceCell.Value2
    If IsNumeric(raw) Then
        parsed = CDbl(raw)
    Else
        textValue = Trim$(CStr(raw))
        hasPercent = (Right$(textValue, 1) = "%")
        If hasPercent Then textValue = Trim$(Left$(textValue, Len(textValue) - 1))
        If Not IsNumeric(textValue) Then Exit Function
        parsed = CDbl(textValue)
    End If
    If Not hasPercent And parsed > 0# And parsed <= 4# Then parsed = parsed * 100#
    zoomPct = CLng(parsed + 0.5)
    TryReadZoom = (zoomPct >= 10 And zoomPct <= 400)
End Function

Private Sub StylePlot(ByVal ws As Worksheet)
    Dim co As ChartObject
    ' PLOT is user-owned presentation. A workbook-wide UI refresh may maintain
    ' only explicit automation contracts; it must not rewrite cells, dimensions,
    ' chart formatting or object geometry on this sheet.
    EnsureFitViewControl ws
    For Each co In ws.ChartObjects
        If Left$(co.Name, 6) = "chMic_" Then co.Chart.HasLegend = False
    Next co
    modRebuild.RefreshModelControlColors
End Sub

' Presentation for the machine-owned, formula-backed chart-data block. Text and
' geometry are generated by modRebuild; this routine owns only visual hierarchy.
Private Function ConfiguredRowCount(ByVal headerCell As Range) As Long
    Do While Len(Trim$(CStr(headerCell.Offset(ConfiguredRowCount + 1, 0).Value))) > 0
        ConfiguredRowCount = ConfiguredRowCount + 1
    Loop
End Function

Private Sub StyleFiles(ByVal ws As Worksheet)
    Dim lastRow As Long
    Dim actionLeft As Single, actionTop As Single, actionWidth As Single, actionGap As Single
    lastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
    With ws
        .Cells.Font.Name = UI_FONT_NAME
        .Cells.Font.Color = C_Ink()
        .Range("A1:F1").Interior.Color = C_Navy()
        .Range("A1:F1").Font.Color = vbWhite
        .Range("A1:F1").Font.Bold = True
        .Range("A1:F1").RowHeight = 26
        .Range("A2:F500").Interior.Color = vbWhite
        .Range("A2:F500").Borders(xlInsideHorizontal).Color = RGB(232, 237, 242)
        .Range("H1:I1").Interior.Color = C_Navy()
        .Range("H1:I1").Font.Color = vbWhite
        .Range("H1:I1").Font.Bold = True
        .Range("H2:I7").Interior.Color = RGB(248, 250, 252)
        .Range("H1:I7").Borders.Color = C_Border()
        .Range("H1:I7").Borders.Weight = xlThin
        .Range("I1").Font.Bold = True
        .Range("I1").HorizontalAlignment = xlCenter
        .Range("I1").FormatConditions.Delete
        With .Range("I1").FormatConditions.Add(Type:=xlCellValue, _
             Operator:=xlEqual, Formula1:="=""OK""")
            .Interior.Color = RGB(226, 242, 230)
            .Font.Color = RGB(27, 105, 60)
        End With
        With .Range("I1").FormatConditions.Add(Type:=xlCellValue, _
             Operator:=xlEqual, Formula1:="=""ERROR""")
            .Interior.Color = RGB(252, 229, 229)
            .Font.Color = RGB(165, 40, 40)
        End With
        With .Range("I1").FormatConditions.Add(Type:=xlCellValue, _
             Operator:=xlEqual, Formula1:="=""RUNNING""")
            .Interior.Color = RGB(255, 244, 214)
            .Font.Color = RGB(145, 91, 0)
        End With
        .Columns("A").ColumnWidth = 52
        .Columns("B").ColumnWidth = 30
        .Columns("C:F").ColumnWidth = 13
        .Columns("G").ColumnWidth = 3
        .Columns("H").ColumnWidth = 18
        .Columns("I").ColumnWidth = 42
        .Rows("2:" & Application.Max(2, lastRow)).RowHeight = 18
        .Range("F2:F" & Application.Max(2, lastRow)).NumberFormat = "0"
        If Not .AutoFilterMode Then .Range("A1:F" & Application.Max(2, lastRow)).AutoFilter
    End With
    actionGap = 7
    actionLeft = ws.Range("H9").Left
    actionTop = ws.Range("H9").Top + 1
    actionWidth = (ws.Range("H9:I9").Width - actionGap * 2) / 3
    EnsureActionButton ws, "uiFilesAdd", "Add files", "AddCSVs", _
                       actionLeft, actionTop, actionWidth, 24, C_Blue(), vbWhite
    EnsureActionButton ws, "uiFilesImport", "Import data", "ImportAll", _
                       actionLeft + actionWidth + actionGap, actionTop, actionWidth, 24, C_Teal(), vbWhite
    EnsureActionButton ws, "uiFilesClear", "Clear list", "ClearList", _
                       actionLeft + (actionWidth + actionGap) * 2, actionTop, actionWidth, 24, vbWhite, C_Muted()
    ConfigureWindow ws, True, True, 100
End Sub

Private Sub StyleConfig(ByVal ws As Worksheet)
    With ws
        .Cells.Font.Name = UI_FONT_NAME
        .Cells.Font.Color = C_Ink()
        .Range("A1:Q2").UnMerge
        .Range("A1:Q2").Merge
        .Range("A1:Q2").Interior.Color = C_Navy()
        .Range("A1").Value = "SPL TOOL  /  CONFIGURATION"
        .Range("A1").Font.Color = vbWhite
        .Range("A1").Font.Bold = True
        .Range("A1").Font.Size = 18
        .Range("A1:Q2").HorizontalAlignment = xlLeft
        .Range("A1:Q2").VerticalAlignment = xlCenter
        .Rows("1:2").RowHeight = 27
        .Range("A7:Q7").UnMerge
        .Range("A7:Q7").Merge
        .Range("A7:Q7").Interior.Color = RGB(228, 237, 245)
        .Range("A7").Value = "DASHBOARD LABELS"
        .Range("A7:Q7").Font.Color = C_Navy()
        .Range("A7:Q7").Font.Bold = True
        .Range("A8:A9").Font.Color = C_Muted()
        .Range("B8:B9").Interior.Color = C_Edit()
        StyleSectionHeader .Range("A19:J20")
        StyleSectionHeader .Range("L19:M20")
        StyleSectionHeader .Range("O19:Q20")
        StyleSectionHeader .Range("L27:N28")
        .Range("A21:A34,M21:M24,O21:Q25").Interior.Color = C_Edit()
        .Range("C21:J34").HorizontalAlignment = xlCenter
        .Range("A37:Q39").Interior.Color = RGB(248, 250, 252)
        .Range("A37:A39").Font.Color = C_Muted()
        .Range("A37:A39").Font.Size = 9
        .Rows("3:6").RowHeight = 9
        .Rows("10:18").RowHeight = 9
        .Rows("35:36").RowHeight = 9
        .Columns("A").ColumnWidth = 18
        .Columns("B:J").ColumnWidth = 11
        .Columns("K").ColumnWidth = 3
        .Columns("L:N").ColumnWidth = 16
        .Columns("O:Q").ColumnWidth = 20
    End With
    ConfigureDataWindow ws, 0, 0, 90
End Sub

Private Sub StyleRawData(ByVal ws As Worksheet, ByVal octaveBand As Boolean)
    Dim lastRow As Long, lastCol As Long, measureCol As Long
    Dim headerRange As Range, filterRange As Range
    lastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
    lastCol = ws.Cells(1, ws.Columns.Count).End(xlToLeft).Column
    If lastRow < 1 Or lastCol < 1 Then Exit Sub
    measureCol = IIf(octaveBand, 10, 8)
    Set headerRange = ws.Range(ws.Cells(1, 1), ws.Cells(1, lastCol))
    Set filterRange = ws.Range(ws.Cells(1, 1), ws.Cells(Application.Max(2, lastRow), lastCol))

    With ws
        .UsedRange.Font.Name = UI_FONT_NAME
        .UsedRange.Font.Size = 9
        With headerRange
            .Font.Color = vbWhite
            .Font.Bold = True
            .HorizontalAlignment = xlCenter
            .VerticalAlignment = xlCenter
            .WrapText = True
            .RowHeight = 34
            .Borders(xlEdgeBottom).Color = C_Border()
            .Borders(xlEdgeBottom).Weight = xlMedium
        End With
        .Range(.Cells(1, 1), .Cells(1, 6)).Interior.Color = C_Navy()
        If measureCol > 7 Then
            .Range(.Cells(1, 7), .Cells(1, measureCol - 1)).Interior.Color = C_Blue()
        End If
        If lastCol >= measureCol Then
            .Range(.Cells(1, measureCol), .Cells(1, lastCol)).Interior.Color = C_Teal()
        End If
        .Columns("A").ColumnWidth = 48
        .Columns("B").ColumnWidth = 31
        .Columns("C").ColumnWidth = 14
        .Columns("D").ColumnWidth = 8
        .Columns("E").ColumnWidth = 14
        .Columns("F").ColumnWidth = 10
        .Range(.Columns(7), .Columns(lastCol)).ColumnWidth = 14
        .Range("A2:B" & Application.Max(2, lastRow)).HorizontalAlignment = xlLeft
        .Range(.Cells(2, 3), .Cells(Application.Max(2, lastRow), 6)).HorizontalAlignment = xlCenter
        .Range(.Cells(2, 6), .Cells(Application.Max(2, lastRow), lastCol)).NumberFormat = "0.000"
        .Range("F2:F" & Application.Max(2, lastRow)).NumberFormat = "0"
        If Not .AutoFilterMode Then filterRange.AutoFilter
    End With
    ConfigureDataWindow ws, 2, 1, 90
End Sub

Private Sub StyleCalc(ByVal ws As Worksheet, ByVal coreCols As Long)
    Dim lastRow As Long, lastHeaderCol As Long, filterRange As Range
    lastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
    lastHeaderCol = ws.Cells(1, ws.Columns.Count).End(xlToLeft).Column
    If lastHeaderCol < coreCols Then lastHeaderCol = coreCols
    Set filterRange = ws.Range(ws.Cells(1, 1), _
                              ws.Cells(Application.Max(2, lastRow), lastHeaderCol))

    With ws
        .UsedRange.Font.Name = UI_FONT_NAME
        .UsedRange.Font.Size = 9
        With .Range(.Cells(1, 1), .Cells(1, coreCols))
            .Interior.Color = C_Navy()
            .Font.Color = vbWhite
            .Font.Bold = True
            .HorizontalAlignment = xlCenter
            .VerticalAlignment = xlCenter
            .WrapText = True
            .Borders(xlEdgeBottom).Color = C_Border()
            .Borders(xlEdgeBottom).Weight = xlMedium
        End With
        With .Range(.Cells(1, coreCols + 1), .Cells(1, 26))
            .Interior.Color = C_Edit()
            .Font.Color = C_Navy()
            .Font.Bold = True
            .HorizontalAlignment = xlCenter
            .Borders(xlEdgeBottom).Color = RGB(214, 188, 105)
            .Borders(xlEdgeBottom).Weight = xlMedium
        End With
        .Rows(1).RowHeight = 34
        .Columns("A").ColumnWidth = 14
        .Columns("B").ColumnWidth = 10
        .Columns("C:D").ColumnWidth = 9
        .Columns("E:G").ColumnWidth = 14
        .Columns("H:Z").ColumnWidth = 14
        .Range("B2:B" & Application.Max(2, lastRow)).NumberFormat = "0"
        .Range("D2:D" & Application.Max(2, lastRow)).NumberFormat = "0"
        .Range("E2:G" & Application.Max(2, lastRow)).NumberFormat = "0.000"
        If Not .AutoFilterMode Then filterRange.AutoFilter
        On Error Resume Next
        If .Range("H1").Comment Is Nothing Then
            .Range("H1").AddComment _
                "USER CALCULATIONS: add a unique header in row 1 and a template formula in row 2. Configure the quantity on CONFIG."
        End If
        On Error GoTo 0
    End With
    ConfigureDataWindow ws, 4, 1, 90
End Sub

Private Sub StyleLists(ByVal ws As Worksheet)
    With ws
        .Cells.Font.Name = UI_FONT_NAME
        .Cells.Font.Size = 10
        .Range("J1:J4").Value = Application.Transpose(Array( _
            "Chart-data first column", "Chart-data last column", _
            "Octaveband first column", "Header row"))
        With .Range("A1:B1,C1,G1,I1")
            .Interior.Color = C_Navy()
            .Font.Color = vbWhite
            .Font.Bold = True
            .HorizontalAlignment = xlCenter
            .WrapText = True
        End With
        .Rows(1).RowHeight = 32
        .Columns("A").ColumnWidth = 24
        .Columns("B:C").ColumnWidth = 14
        .Columns("D:F").ColumnWidth = 3
        .Columns("G").ColumnWidth = 22
        .Columns("H").ColumnWidth = 3
        .Columns("I").ColumnWidth = 16
        .Columns("J").ColumnWidth = 24
        .Columns("K").ColumnWidth = 12
        With .Range("J1:J4")
            .Interior.Color = RGB(232, 235, 238)
            .Font.Color = C_Muted()
            .Font.Bold = True
        End With
        With .Range("K1:K4")
            .Interior.Color = C_Input()
            .Font.Color = C_Navy()
            .Font.Bold = True
            .HorizontalAlignment = xlCenter
        End With
        .Range("J1:K4").Borders.Color = C_Border()
        .Range("J1:K4").Borders.Weight = xlThin
    End With
    If ws.Visible = xlSheetVisible Then ConfigureDataWindow ws, 0, 1, 95
End Sub

Private Sub StyleWorkbookTabs()
    Worksheets("SPL").Tab.Color = C_Navy()
    Worksheets("FILES").Tab.Color = C_Blue()
    Worksheets("CONFIG").Tab.Color = RGB(214, 164, 58)
    Worksheets("LISTS").Tab.Color = C_Muted()
    Worksheets("RAW_NB").Tab.Color = C_Blue()
    Worksheets("RAW_OB").Tab.Color = C_Teal()
    Worksheets("CALC_NB").Tab.Color = RGB(118, 86, 156)
    Worksheets("CALC_OB").Tab.Color = RGB(148, 96, 176)
End Sub

Private Sub ConfigureDataWindow(ByVal ws As Worksheet, ByVal freezeColumns As Long, _
                                ByVal freezeRows As Long, ByVal zoomPct As Long)
    Dim win As Window
    On Error Resume Next
    If Not Application.Visible Then Exit Sub
    If ws.Visible <> xlSheetVisible Then Exit Sub
    ws.Activate
    Set win = ActiveWindow
    If win Is Nothing Then Exit Sub
    With win
        .DisplayGridlines = False
        .DisplayHeadings = True
        .Zoom = zoomPct
        .FreezePanes = False
        .SplitColumn = freezeColumns
        .SplitRow = freezeRows
        .FreezePanes = (freezeColumns > 0 Or freezeRows > 0)
    End With
    On Error GoTo 0
End Sub

Private Sub StyleSectionHeader(ByVal target As Range)
    target.Interior.Color = RGB(228, 237, 245)
    target.Font.Color = C_Navy()
    target.Font.Bold = True
    target.Borders.Color = C_Border()
    target.Borders.Weight = xlThin
End Sub

Private Sub EnsureActionButton(ByVal ws As Worksheet, ByVal shapeName As String, _
                               ByVal caption As String, ByVal macroName As String, _
                               ByVal x As Single, ByVal y As Single, ByVal w As Single, _
                               ByVal h As Single, ByVal fillColor As Long, ByVal textColor As Long)
    Dim shp As Shape, isNew As Boolean
    On Error Resume Next
    Set shp = ws.Shapes(shapeName)
    On Error GoTo 0
    If shp Is Nothing Then Set shp = FindActionButton(ws, macroName)
    If shp Is Nothing Then
        Set shp = ws.Shapes.AddShape(msoShapeRoundedRectangle, x, y, w, h)
        shp.Name = shapeName
        isNew = True
    End If
    With shp
        .OnAction = macroName
        .AlternativeText = "SPL action: " & macroName
        ' Existing action-button geometry and appearance belong to the user.
        If Not isNew Then Exit Sub
        .Placement = xlFreeFloating
        .Left = x: .Top = y: .Width = w: .Height = h
        .Fill.Visible = msoTrue
        .Fill.Solid
        .Fill.ForeColor.RGB = fillColor
        .Line.Visible = msoTrue
        .Line.ForeColor.RGB = IIf(fillColor = vbWhite, C_Border(), fillColor)
        .Line.Weight = 1
        .Shadow.Visible = msoFalse
        With .TextFrame2
            .AutoSize = msoAutoSizeNone
            .MarginLeft = 5: .MarginRight = 5
            .MarginTop = 1: .MarginBottom = 1
            .VerticalAnchor = msoAnchorMiddle
            .TextRange.Text = caption
            .TextRange.ParagraphFormat.Alignment = msoAlignCenter
            .TextRange.Font.Name = UI_FONT_NAME
            .TextRange.Font.Size = 9
            .TextRange.Font.Bold = msoTrue
            .TextRange.Font.Fill.ForeColor.RGB = textColor
        End With
    End With
End Sub

Private Function FindActionButton(ByVal ws As Worksheet, ByVal macroName As String) As Shape
    Dim shp As Shape, actionName As String
    For Each shp In ws.Shapes
        actionName = ""
        On Error Resume Next
        actionName = shp.OnAction
        On Error GoTo 0
        If StrComp(actionName, macroName, vbTextCompare) = 0 Then
            Set FindActionButton = shp
            Exit Function
        End If
    Next shp
End Function

Private Function NamedValue(ByVal nameText As String) As Variant
    On Error GoTo missing
    NamedValue = ThisWorkbook.Names(nameText).RefersToRange.Cells(1, 1).Value
    Exit Function
missing:
    NamedValue = Empty
End Function

Private Sub BindNameToCell(ByVal ws As Worksheet, ByVal nameText As String, _
                           ByVal target As Range, ByVal value As Variant)
    Dim nm As Name, oldCell As Range
    On Error Resume Next
    Set nm = ThisWorkbook.Names(nameText)
    If Not nm Is Nothing Then Set oldCell = nm.RefersToRange.Cells(1, 1)
    On Error GoTo 0
    If Not oldCell Is Nothing Then
        If oldCell.Parent.Name = ws.Name And oldCell.Address <> target.Address Then
            oldCell.ClearContents
        End If
    End If
    If nm Is Nothing Then
        ThisWorkbook.Names.Add Name:=nameText, RefersTo:="=SPL!" & target.Address
    Else
        nm.RefersTo = "=SPL!" & target.Address
    End If
    target.Value = value
End Sub

Private Sub ApplyListValidation(ByVal target As Range, ByVal listFormula As String, _
                                Optional ByVal migrationSource As Range = Nothing)
    Dim failNum As Long, failText As String
    Dim currentFormula As String, sourceFormula As String

    ' ClearFormats does not remove validation. Preserve the valid object on
    ' repeated rebuilds instead of deleting and recreating it through Excel's
    ' fragile Validation.Add API.
    On Error Resume Next
    currentFormula = target.Validation.Formula1
    Err.Clear
    On Error GoTo 0
    If SameValidationFormula(currentFormula, listFormula) Then Exit Sub

    ' One-time migration from the former horizontal dashboard cells. Copying
    ' the validation object is more reliable than recreating dynamic named-list
    ' formulas in some Excel builds.
    If Not migrationSource Is Nothing Then
        On Error Resume Next
        sourceFormula = migrationSource.Validation.Formula1
        On Error GoTo fail
        If SameValidationFormula(sourceFormula, listFormula) Then
            migrationSource.Copy
            target.PasteSpecial Paste:=xlPasteValidation
            Application.CutCopyMode = False
            If SameValidationFormula(target.Validation.Formula1, listFormula) Then Exit Sub
        End If
    End If

    On Error Resume Next
    target.Validation.Delete
    Err.Clear
    On Error GoTo fail
    target.Validation.Add Type:=xlValidateList, AlertStyle:=xlValidAlertStop, _
                          Operator:=xlBetween, Formula1:=listFormula
    target.Validation.IgnoreBlank = True
    target.Validation.InCellDropdown = True
    target.Validation.ShowError = False
    Exit Sub
fail:
    failNum = Err.Number
    failText = Err.Description
    Err.Raise failNum, "ApplyListValidation", _
              target.Address(False, False) & " -> " & listFormula & ": " & failText
End Sub

Private Function SameValidationFormula(ByVal actual As String, _
                                       ByVal expected As String) As Boolean
    actual = Replace$(Trim$(actual), "=", "")
    expected = Replace$(Trim$(expected), "=", "")
    SameValidationFormula = (Len(actual) > 0 And _
                             StrComp(actual, expected, vbTextCompare) = 0)
End Function

Private Sub ConfigureWindow(ByVal ws As Worksheet, ByVal showHeadings As Boolean, _
                            ByVal freezeTopRow As Boolean, ByVal zoomPct As Long)
    Dim win As Window
    ' Window presentation is best-effort. Hidden automation sessions may have
    ' no usable active window and must never fail a workbook build.
    On Error Resume Next
    ws.Activate
    Set win = ActiveWindow
    If win Is Nothing Then Exit Sub
    With win
        .DisplayGridlines = False
        .DisplayHeadings = showHeadings
        .Zoom = zoomPct
        If Application.Visible Then
            .FreezePanes = False
            .SplitColumn = 0
            .SplitRow = 0
        End If
        If freezeTopRow And Application.Visible Then
            .SplitRow = 1
            .FreezePanes = True
        End If
    End With
    On Error GoTo 0
End Sub
