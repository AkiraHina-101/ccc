Attribute VB_Name = "modRebuild"
Option Explicit

' Dashboard rebuild. Each generated column has an independent start_* cell.

' LISTS column that stores the region bookkeeping (K = column 11).
Private Const GEO_COL As Long = 11
Private Const NB_SCHEMA_COLS As Long = 8
Private Const LIST_CACHE_COL As Long = 16       ' P: selected CALC_NB rows
Private Const LIST_VALUE_COL As Long = 24       ' X: selected quantity values
Private Const DATA_ANCHOR_ROW As Long = 3
Private Const DATA_ANCHOR_COL As Long = 43      ' AQ: fixed technical area right of SPL
Private Const NB_COL_MODEL As Long = 1
Private Const NB_COL_LOAD As Long = 2
Private Const NB_COL_RPM As Long = 3
Private Const NB_COL_MIC As Long = 5
Private Const NB_COL_FREQ As Long = 7
Private Const OB_COL_MODEL As Long = 1
Private Const OB_COL_LOAD As Long = 2
Private Const OB_COL_RPM As Long = 3
Private Const OB_COL_MIC As Long = 5
Private Const OB_COL_LOW As Long = 7
Private Const OB_COL_HIGH As Long = 8

' Saved app state, restored by RestoreApp (see RebuildDashboard).
Private mPrevCalc As XlCalculation
Private mPrevEvents As Boolean
Private mPrevScreenUpdating As Boolean
Private mStage As String

Public Sub RebuildDashboard(ByVal silent As Boolean)
    Dim wsP As Worksheet, wsD As Worksheet, wsCfg As Worksheet, wsL As Worksheet
    Dim nModels As Long, nMics As Long
    Dim mR0 As Long, mC As Long, micR0 As Long, micC As Long
    Dim anchorRow As Long, anchorCol As Long
    Dim nbWidth As Long, obStart As Long, lastCol As Long
    Dim perW As Long
    Dim validationMsg As String

    mStage = "initialize"
    On Error GoTo fail
    modLog.ReportStage "RebuildDashboard", mStage
    Set wsP = Worksheets("SPL"): Set wsCfg = Worksheets("CONFIG"): Set wsL = Worksheets("LISTS")
    Set wsD = EnsurePlotDataSheet(wsP)
    LockGeneratedPlotObjectPlacement wsP
    mR0 = wsCfg.Range("hdrModels").Row + 1:  mC = wsCfg.Range("hdrModels").Column
    micR0 = wsCfg.Range("hdrMics").Row + 1:  micC = wsCfg.Range("hdrMics").Column

    nModels = CountRows(wsCfg, mC, mR0)
    nMics = CountRows(wsCfg, micC, micR0)
    If nModels = 0 Or nMics = 0 Then
        validationMsg = modLog.ReportError("RebuildDashboard", "initialize", _
            vbObjectError + 51, "CONFIG needs at least one model and one mic.")
        If Not silent Then MsgBox validationMsg, vbExclamation
        Exit Sub
    End If

    ' Freeze recalc/events while writing many 300k-row FILTER formulas -
    ' otherwise automatic calc storms on every write and makes Rebuild crawl.
    mPrevCalc = Application.Calculation
    mPrevEvents = Application.EnableEvents
    mPrevScreenUpdating = Application.ScreenUpdating
    Application.ScreenUpdating = False
    Application.EnableEvents = False
    Application.Calculation = xlCalculationManual
    ' ---- locate the movable block region ----
    MigratePlotDataToDataSheet wsP, wsD
    RemoveLegacyPlotDataSheet
    EnsureAnchor wsD
    ' dynamic data height: FILTER scans only the real rows, not MAX_DATA_ROWS
    UpsertName "dRowsNB", "=MAX(1,COUNTA(CALC_NB!$A$2:$A$" & _
                               (MAX_DATA_ROWS + 1) & "))"
    UpsertName "dRowsOB", "=MAX(1,COUNTA(CALC_OB!$A$2:$A$" & _
                               (MAX_DATA_ROWS + 1) & "))"
    UpsertName "RPMList", _
        "=LISTS!$A$2:INDEX(LISTS!$A:$A,1+MAX(1,COUNTA(LISTS!$A$2:$A$1001)))"
    UpsertName "selRPMValue", _
        "=IFERROR(INDEX(LISTS!$B$2:$B$1001,MATCH(selRPM,RPMList,0)),selRPM)"
    UpsertName "selLoadValue", _
        "=IFERROR(INDEX(LISTS!$D$2:$D$1001,MATCH(selRPM,RPMList,0)),"""")"
    UpsertName "qtyList", _
        "=CONFIG!$O$21:INDEX(CONFIG!$O:$O,20+MAX(1,COUNTA(CONFIG!$O$21:$O$1020)))"
    UpsertName "qtyColHdr", _
        "=INDEX(CONFIG!$P$21:$P$1020,qtyIdx)"
    anchorRow = wsD.Range("blkAnchor").Row
    anchorCol = wsD.Range("blkAnchor").Column
    If anchorCol < 2 Then
        RestoreApp
        validationMsg = modLog.ReportError("RebuildDashboard", "initialize", _
            vbObjectError + 52, "blkAnchor must be in column B or farther right.")
        If Not silent Then MsgBox validationMsg, vbExclamation
        Exit Sub
    End If

    ' geometry of the region. Both bands use the same per-model group shape:
    ' [freq column | one Y per mic] - NB first, then a gap column, then OB.
    ' NB freq = FILTER from CALC (mics of a model share frequencies);
    ' OB freq = FILTER from CALC, one imported staircase column per model.
    perW = 1 + nMics
    nbWidth = nModels * perW
    obStart = anchorCol + nbWidth + 1            ' one gap column before OB
    lastCol = obStart + nModels * perW - 1
    RemoveInternalFilterCache wsP, wsL, anchorRow, lastCol

    ' ---- clear each independent spill start; clear legacy region once ----
    If HasOutputAnchors() Then
        ClearOutputAnchors wsD
    Else
        ClearRegion wsD, wsL, anchorCol, lastCol
    End If
    ClearGeneratedHeaders wsD, wsL, anchorRow, anchorCol, lastCol
    Stage "clear output"

    ' ---- LISTS: model on/off + series legend labels ----
    SyncOnOffAndLabels wsL, wsCfg, mR0, mC, nModels
    Stage "sync lists"

    ' ---- write NB + OB block skeleton and Xm_/Y_ names ----
    WriteBlocks wsD, wsCfg, wsL, mR0, mC, micR0, micC, nModels, nMics, _
                anchorRow, anchorCol, obStart
    StylePlotDataSheet wsD, anchorRow, anchorCol, obStart, nModels, nMics
    Stage "write data starts"

    ' ---- store region bookkeeping ----
    wsL.Cells(1, GEO_COL).Value = anchorCol
    wsL.Cells(2, GEO_COL).Value = lastCol
    wsL.Cells(3, GEO_COL).Value = obStart
    wsL.Cells(4, GEO_COL).Value = anchorRow

    ' ---- band/model toggle shapes + charts (position-preserving delta) ----
    Stage "sync band controls"
    SyncBandToggles wsP, wsL
    Stage "sync model controls"
    SyncModelToggles wsP, wsCfg, wsL, mR0, mC, nModels
    Stage "sync chart series"
    SyncCharts wsP, wsCfg, mR0, mC, micR0, micC, nModels, nMics
    DeleteStaleNames nModels, nMics
    Stage "sync charts"

    ' Normalize the established presentation contract only when its control is
    ' already present. This prevents first-run shape creation while keeping
    ' chart geometry stable across Excel save/close/reopen normalization.
    If Not FindShape(wsP, "uiSyncPlotAreas") Is Nothing Then _
        modUI.SyncPlotPresentationAutomation
    FinalizeExpandableModelToggles wsP, wsL, nModels
    Stage "preserve SPL presentation"

    Stage "calculate and axes"
    Application.Calculate                 ' single recalc after all writes
    ApplyQuantityAxes

    RestoreApp
    modLog.ReportSuccess "RebuildDashboard", nMics & " mics x " & nModels & " models"
    If Not silent Then MsgBox "Dashboard synced: " & nMics & " mics x " & nModels & " models.", vbInformation
    Exit Sub
fail:
    Dim failNum As Long, failDesc As String, failMsg As String
    failNum = Err.Number: failDesc = Err.Description
    RestoreApp
    failMsg = modLog.ReportError("RebuildDashboard", mStage, failNum, failDesc)
    If silent Then
        ' Automation callers receive the VBA error through Debug.Print only.
        ' Never rethrow here because an invisible Excel instance would display
        ' a modal VBA error dialog and block the user's desktop.
        Debug.Print "AUTOMATION_ERROR", failNum, failDesc
    Else
        MsgBox failMsg, vbCritical
    End If
End Sub

' ImportAll calls this only when the number of configured models changes.
' It updates model names/named ranges, model toggle shapes, and the empty
' per-model chart series without touching chart-data columns, formulas,
' tables, chart layout, or other SPL presentation.
Public Sub SyncModelControlsOnly()
    Dim wsP As Worksheet, wsCfg As Worksheet, wsL As Worksheet
    Dim modelRow0 As Long, modelCol As Long, nModels As Long
    Set wsP = Worksheets("SPL")
    Set wsCfg = Worksheets("CONFIG")
    Set wsL = Worksheets("LISTS")
    modelRow0 = wsCfg.Range("hdrModels").Row + 1
    modelCol = wsCfg.Range("hdrModels").Column
    nModels = CountRows(wsCfg, modelCol, modelRow0)
    SyncModelOnOffOnly wsL, nModels
    SyncModelToggles wsP, wsCfg, wsL, modelRow0, modelCol, nModels
    SyncChartSeriesWithoutFormulas wsP, wsCfg, modelRow0, modelCol, nModels
End Sub

' Keep two empty series (NB, OB) per model on every existing dashboard chart.
' Data formulas are deliberately user-owned and are never set or replaced here.
Private Sub SyncChartSeriesWithoutFormulas(ByVal wsP As Worksheet, _
                                           ByVal wsCfg As Worksheet, _
                                           ByVal mR0 As Long, ByVal mC As Long, _
                                           ByVal nModels As Long)
    Dim co As ChartObject, s As Series
    Dim j As Long, expectedCount As Long, seriesIndex As Long
    For Each co In wsP.ChartObjects
        If Left$(co.Name, 6) = "chMic_" Then
            expectedCount = nModels * 2
            Do While co.Chart.SeriesCollection.Count < expectedCount
                Set s = co.Chart.SeriesCollection.NewSeries
            Loop
            Do While co.Chart.SeriesCollection.Count > expectedCount
                co.Chart.SeriesCollection(co.Chart.SeriesCollection.Count).Delete
            Loop
            For j = 1 To nModels
                seriesIndex = (j - 1) * 2 + 1
                ApplySeriesStyle co.Chart.SeriesCollection(seriesIndex), wsCfg, _
                                 mR0, mC, j, "NB"
                ApplySeriesStyle co.Chart.SeriesCollection(seriesIndex + 1), wsCfg, _
                                 mR0, mC, j, "OB"
            Next j
        End If
    Next co
End Sub

Private Sub FinalizeExpandableModelToggles(ByVal wsP As Worksheet, _
                                           ByVal wsL As Worksheet, _
                                           ByVal nModels As Long)
    Dim anchorShape As Shape, shp As Shape, j As Long, isNew As Boolean
    RemoveExpandableModelToggleShapes wsP, 3
    If nModels <= 3 Then Exit Sub
    Set anchorShape = FindShape(wsP, "cbMdl_1")
    If anchorShape Is Nothing Then Exit Sub
    For j = 4 To nModels
        Set shp = wsP.Shapes.AddShape(msoShapeRoundedRectangle, anchorShape.Left, _
            anchorShape.Top + (j - 1) * 19, anchorShape.Width, anchorShape.Height)
        shp.Name = "cbMdl_" & j
        isNew = True
        ConfigureToggle shp, "$C$" & (j + 1), "Model " & j, _
                        ToggleIsOn(wsL.Cells(j + 1, 3).Value2), isNew
    Next j
End Sub

Private Sub LockGeneratedPlotObjectPlacement(ByVal wsP As Worksheet)
    Dim co As ChartObject, shp As Shape, nm As String
    For Each co In wsP.ChartObjects
        If Left$(co.Name, 6) = "chMic_" Then co.Placement = xlFreeFloating
    Next co
    For Each shp In wsP.Shapes
        nm = shp.Name
        If Left$(nm, 6) = "chMic_" Or Left$(nm, 7) = "tgBand_" Or _
           Left$(nm, 6) = "cbMdl_" Or Left$(nm, 2) = "ui" Then _
            shp.Placement = xlFreeFloating
    Next shp
End Sub

' Y-axis title follows the selected QUANTITIES row. Axis scales are controlled
' independently by the persistent X/Y scale tables on CONFIG.
Public Sub ApplyQuantityAxes()
    Dim wsP As Worksheet, anch As Range, q As Variant
    Dim yT As String, co As ChartObject, valueAxis As Axis
    mStage = "calculate and axes: resolve sheets"
    Set wsP = Worksheets("SPL")
    Set anch = Worksheets("CONFIG").Range("hdrQty")
    ' qtyList is a dynamic INDEX-based name; RefersToRange is not reliable in
    ' every Excel build. Evaluate returns its current values without requiring
    ' the name to resolve to a concrete Range object.
    mStage = "calculate and axes: match quantity"
    q = Application.Match(wsP.Range("selQty").Value, _
                          Application.Evaluate("qtyList"), 0)
    If IsError(q) Then Exit Sub
    yT = anch.Offset(CLng(q), 2).Value
    For Each co In wsP.ChartObjects
        mStage = "calculate and axes: chart " & co.Name
        Set valueAxis = Nothing
        On Error Resume Next
        Set valueAxis = co.Chart.Axes(xlValue)
        If Not valueAxis Is Nothing Then
            valueAxis.HasTitle = True
            valueAxis.AxisTitle.Text = yT
            valueAxis.AxisTitle.Orientation = 90
        End If
        Err.Clear
        On Error GoTo 0
    Next co
    ApplyConfiguredAxes
End Sub

' Apply the two CONFIG scale tables to every dashboard chart. Blank/non-numeric
' values mean Excel auto. Invalid min/max pairs are ignored for that axis.
Public Sub ApplyConfiguredAxes()
    Dim wsP As Worksheet, co As ChartObject
    Set wsP = Worksheets("SPL")
    For Each co In wsP.ChartObjects
        ApplyAxisValues co.Chart.Axes(xlCategory), wsP.Range("axXmin").Value, _
                        wsP.Range("axXmax").Value, wsP.Range("axXmajor").Value, _
                        wsP.Range("axXminor").Value
        ApplyAxisValues co.Chart.Axes(xlValue), wsP.Range("axYmin").Value, _
                        wsP.Range("axYmax").Value, wsP.Range("axYmajor").Value, _
                        wsP.Range("axYminor").Value
    Next co
End Sub

Private Sub ApplyAxisValues(ax As Axis, ByVal minV As Variant, ByVal maxV As Variant, _
                            ByVal majorV As Variant, ByVal minorV As Variant)
    If IsNumeric(minV) And Len(minV & "") > 0 And _
       IsNumeric(maxV) And Len(maxV & "") > 0 Then
        If CDbl(minV) >= CDbl(maxV) Then Exit Sub
    End If
    On Error Resume Next
    ax.MinimumScaleIsAuto = True: ax.MaximumScaleIsAuto = True
    ax.MajorUnitIsAuto = True: ax.MinorUnitIsAuto = True
    If IsNumeric(minV) And Len(minV & "") > 0 Then ax.MinimumScale = CDbl(minV)
    If IsNumeric(maxV) And Len(maxV & "") > 0 Then ax.MaximumScale = CDbl(maxV)
    If IsNumeric(majorV) And Len(majorV & "") > 0 And CDbl(majorV) > 0 Then ax.MajorUnit = CDbl(majorV)
    If IsNumeric(minorV) And Len(minorV & "") > 0 And CDbl(minorV) > 0 Then ax.MinorUnit = CDbl(minorV)
    On Error GoTo 0
End Sub

' ---------- region: anchor and clearing ----------

Private Function EnsurePlotDataSheet(ByVal plotSheet As Worksheet) As Worksheet
    Set EnsurePlotDataSheet = plotSheet
End Function

Private Sub EnsureAnchor(ByVal wsD As Worksheet)
    UpsertName "blkAnchor", "='" & wsD.Name & "'!$" & _
        ColLetter(DATA_ANCHOR_COL) & "$" & DATA_ANCHOR_ROW
End Sub

Private Sub MigratePlotDataToDataSheet(ByVal wsP As Worksheet, ByVal wsD As Worksheet)
    Dim n As Name, r As Range, namesToDelete As New Collection
    Dim i As Long, minCol As Long, maxCol As Long, minRow As Long, maxRow As Long
    For Each n In ThisWorkbook.Names
        If Left$(n.Name, 9) = "start_Xm_" Or Left$(n.Name, 8) = "start_Y_" Then
            Set r = Nothing
            On Error Resume Next
            Set r = n.RefersToRange.Cells(1, 1)
            On Error GoTo 0
            If Not r Is Nothing Then
                If r.Parent.Name = wsP.Name Then
                    If minCol = 0 Or r.Column < minCol Then minCol = r.Column
                    If r.Column > maxCol Then maxCol = r.Column
                    If minRow = 0 Or r.Row < minRow Then minRow = r.Row
                    If r.Row > maxRow Then maxRow = r.Row
                End If
                r.ClearContents
                namesToDelete.Add n.Name
            End If
        End If
    Next n
    For i = 1 To namesToDelete.Count
        ThisWorkbook.Names(CStr(namesToDelete(i))).Delete
    Next i
    If minCol > 0 Then
        With wsP.Range(wsP.Cells(Application.Max(1, minRow - 4), minCol), _
                       wsP.Cells(maxRow, maxCol))
            .UnMerge
            .ClearContents
        End With
    End If
End Sub

Private Sub RemoveLegacyPlotDataSheet()
    Dim ws As Worksheet, oldAlerts As Boolean
    On Error Resume Next
    Set ws = ThisWorkbook.Worksheets("SPL_DATA")
    On Error GoTo 0
    If ws Is Nothing Then Exit Sub
    oldAlerts = Application.DisplayAlerts
    Application.DisplayAlerts = False
    ws.Delete
    Application.DisplayAlerts = oldAlerts
End Sub

Private Function IsOutputAnchorName(ByVal nameText As String) As Boolean
    IsOutputAnchorName = (Left$(nameText, 9) = "start_Xm_" Or _
                          Left$(nameText, 8) = "start_Y_" Or _
                          nameText = "start_SelectedData" Or _
                          nameText = "start_SelectedValue")
End Function

Private Sub RemoveInternalFilterCache(ByVal wsP As Worksheet, ByVal wsL As Worksheet, _
                                      ByVal anchorRow As Long, ByVal chartLastCol As Long)
    Dim nameText As Variant, n As Name, r As Range
    Dim firstCol As Long, lastCol As Long
    Dim captionCell As Range, captionArea As Range
    firstCol = 0: lastCol = 0
    For Each nameText In Array("start_SelectedData", "start_SelectedValue")
        Set n = Nothing: Set r = Nothing
        On Error Resume Next
        Set n = ThisWorkbook.Names(CStr(nameText))
        If Not n Is Nothing Then Set r = n.RefersToRange.Cells(1, 1)
        On Error GoTo 0
        If Not r Is Nothing Then
            If r.Parent.Name = wsP.Name Then
                If firstCol = 0 Or r.Column < firstCol Then firstCol = r.Column
                If r.Column > lastCol Then lastCol = r.Column
                r.ClearContents
            End If
        End If
    Next nameText
    If firstCol > 0 Then
        If lastCol < firstCol + NB_SCHEMA_COLS Then lastCol = firstCol + NB_SCHEMA_COLS
        With wsP.Range(wsP.Cells(Application.Max(1, anchorRow - 2), firstCol), _
                       wsP.Cells(anchorRow, lastCol))
            .UnMerge
            .ClearContents
        End With
    End If
    Do
        Set captionCell = wsP.Cells.Find(What:="INTERNAL FILTER CACHE", _
            After:=wsP.Cells(1, 1), LookIn:=xlValues, LookAt:=xlWhole, _
            SearchOrder:=xlByRows, SearchDirection:=xlNext, MatchCase:=False)
        If captionCell Is Nothing Then Exit Do
        Set captionArea = captionCell.MergeArea
        captionArea.UnMerge
        captionArea.ClearContents
    Loop
End Sub

' Clear the whole columns spanning the previous AND the current region.
' The region right of the anchor is machine-owned, so a full-column clear
' is safe and also wipes an old region left behind when the anchor moved.
Private Sub ClearRegion(wsP As Worksheet, wsL As Worksheet, ByVal curAnchorCol As Long, ByVal curLastCol As Long)
    Dim c1 As Long, c2 As Long, pAnchor As Long, pLast As Long
    pAnchor = ToLong(wsL.Cells(1, GEO_COL).Value)
    pLast = ToLong(wsL.Cells(2, GEO_COL).Value)
    c1 = curAnchorCol: c2 = curLastCol
    If pAnchor > 0 And pAnchor < c1 Then c1 = pAnchor
    If pLast > c2 Then c2 = pLast
    If c2 < c1 Then c2 = c1
    wsP.Range(wsP.Columns(c1), wsP.Columns(c2)).ClearContents
End Sub

' Headers are machine-owned together with their chart-data columns. Unmerge the
' previous/current union first so repeated rebuilds and model-count changes stay safe.
Private Sub ClearGeneratedHeaders(ByVal wsP As Worksheet, ByVal wsL As Worksheet, _
                                  ByVal curAnchorRow As Long, ByVal curAnchorCol As Long, _
                                  ByVal curLastCol As Long)
    Dim pAnchor As Long, pLast As Long, pRow As Long
    Dim c1 As Long, c2 As Long, r1 As Long, r2 As Long
    pAnchor = ToLong(wsL.Cells(1, GEO_COL).Value)
    pLast = ToLong(wsL.Cells(2, GEO_COL).Value)
    pRow = ToLong(wsL.Cells(4, GEO_COL).Value)
    c1 = curAnchorCol: c2 = curLastCol
    r1 = curAnchorRow - 2: r2 = curAnchorRow
    ' Previous geometry belongs to the same generated layout only when its
    ' field-header row matches. A promoted user sheet may reuse LISTS while
    ' placing its presentation at a completely different row.
    If pRow = curAnchorRow Then
        If pAnchor > 0 And pAnchor < c1 Then c1 = pAnchor
        If pLast > c2 Then c2 = pLast
    End If
    If pRow = curAnchorRow And pRow > 2 Then
        If pRow - 2 < r1 Then r1 = pRow - 2
        If pRow > r2 Then r2 = pRow
    End If
    If r1 < 1 Then r1 = 1
    With wsP.Range(wsP.Cells(r1, c1), wsP.Cells(r2, c2))
        .UnMerge
        .ClearContents
    End With
End Sub

' ---------- LISTS on/off + labels ----------

Private Sub SyncOnOffAndLabels(wsL As Worksheet, wsCfg As Worksheet, _
                               ByVal mR0 As Long, ByVal mC As Long, ByVal nModels As Long)
    Dim j As Long
    SyncModelOnOffOnly wsL, nModels
    ' series legend labels (col G): 2 per model (NB / OB)
    wsL.Range("G2:G" & wsL.Rows.Count).ClearContents
    For j = 1 To nModels
        wsL.Cells(2 + (j - 1) * 2, 7).Formula = _
            "=INDEX(CONFIG!" & wsCfg.Cells(mR0 + j - 1, mC).Address & ",1)&"" NB"""
        wsL.Cells(3 + (j - 1) * 2, 7).Formula = _
            "=INDEX(CONFIG!" & wsCfg.Cells(mR0 + j - 1, mC).Address & ",1)&"" OB"""
    Next j
End Sub

' The import path needs model toggle state but must not write any formulas.
Private Sub SyncModelOnOffOnly(ByVal wsL As Worksheet, ByVal nModels As Long)
    Dim j As Long
    For j = 1 To nModels
        If Len(wsL.Cells(j + 1, 3).Value) = 0 Then wsL.Cells(j + 1, 3).Value = True
    Next j
    wsL.Range(wsL.Cells(nModels + 2, 3), wsL.Cells(wsL.Rows.Count, 3)).ClearContents
End Sub

' ---------- block skeleton + Xm_/Y_ names ----------

' Both bands get a default group [freq | Y mic1 .. Y micN], but every formula
' start is independently movable through a start_* workbook name.
Private Sub WriteBlocks(wsP As Worksheet, wsCfg As Worksheet, wsL As Worksheet, _
                        ByVal mR0 As Long, ByVal mC As Long, _
                        ByVal micR0 As Long, ByVal micC As Long, _
                        ByVal nModels As Long, ByVal nMics As Long, _
                        ByVal anchorRow As Long, ByVal anchorCol As Long, ByVal obStart As Long)
    Dim m As Long, j As Long, base As Long, yCol As Long
    Dim mdl As String, modelRef As String, cond As String, perW As Long
    Dim startCell As Range, startName As String, dataName As String
    perW = 1 + nMics
    WriteBlockHeaders wsP, wsCfg, mR0, mC, micR0, micC, _
                      nModels, nMics, anchorRow, anchorCol, obStart

    ' Filter CALC_NB once on the technical LISTS sheet. CALC_OB is small enough
    ' for its staircase formulas to read directly without another cache block.
    wsL.Range(wsL.Cells(1, LIST_CACHE_COL), wsL.Cells(wsL.Rows.Count, LIST_VALUE_COL)).ClearContents
    wsL.Cells(1, LIST_CACHE_COL).Value2 = "Selected CALC_NB rows"
    wsL.Cells(1, LIST_VALUE_COL).Value2 = "Selected quantity"
    mStage = "write data starts: NB cache"
    Set startCell = wsL.Cells(2, LIST_CACHE_COL)
    UpsertName "start_SelectedData", "=LISTS!" & startCell.Address
    startCell.Formula2 = "=IFERROR(FILTER(" & CalcNbSchemaTable() & ",(" & _
                         CalcNbCol(NB_COL_RPM) & "=selRPMValue)*(" & _
                         CalcNbCol(NB_COL_LOAD) & "=selLoadValue)),NA())"
    UpsertName "selData", SpillRef(startCell)

    mStage = "write data starts: NB selected value"
    Set startCell = wsL.Cells(2, LIST_VALUE_COL)
    UpsertName "start_SelectedValue", "=LISTS!" & startCell.Address
    startCell.Formula2 = "=IFERROR(FILTER(" & CalcNbSelectedValueCol() & ",(" & _
                         CalcNbCol(NB_COL_RPM) & "=selRPMValue)*(" & _
                         CalcNbCol(NB_COL_LOAD) & "=selLoadValue)),NA())"
    UpsertName "selValue", SpillRef(startCell)

    For j = 1 To nModels
        mStage = "write data starts: model " & CStr(j) & " identity"
        mdl = CStr(wsCfg.Cells(mR0 + j - 1, mC).Value)
        modelRef = "CONFIG!" & wsCfg.Cells(mR0 + j - 1, mC).Address

        ' ---- NB group: FILTER freq (from mic 1) + FILTER Y per mic ----
        base = anchorCol + (j - 1) * perW
        cond = NbFilterCond(1, modelRef, j, "chkNB")
        startName = "start_Xm_" & j & "_NB": dataName = "Xm_" & j & "_NB"
        Set startCell = OutputAnchor(wsP, startName, wsP.Cells(anchorRow + 2, base))
        startCell.Formula2 = _
            "=IFERROR(FILTER(" & SelectedDataCol(NB_COL_FREQ) & "," & cond & "),NA())"
        UpsertName dataName, SpillRef(startCell)
        For m = 1 To nMics
            yCol = base + m
            cond = NbFilterCond(m, modelRef, j, "chkNB")
            startName = "start_Y_" & m & "_" & j & "_NB"
            dataName = "Y_" & m & "_" & j & "_NB"
            Set startCell = OutputAnchor(wsP, startName, wsP.Cells(anchorRow + 2, yCol))
            startCell.Formula2 = _
                "=IFERROR(FILTER(" & SelectedValueCol() & "," & cond & "),NA())"
            UpsertName dataName, SpillRef(startCell)
        Next m

        ' ---- OB group: FILTER imported staircase freq + FILTER Y per mic ----
        base = obStart + (j - 1) * perW
        mStage = "write data starts: model " & CStr(j) & " OB X"
        cond = ObFilterCond(1, modelRef, j, "chkOB")
        startName = "start_Xm_" & j & "_OB": dataName = "Xm_" & j & "_OB"
        Set startCell = OutputAnchor(wsP, startName, wsP.Cells(anchorRow + 2, base))
        startCell.Formula2 = _
            "=IFERROR(LET(lo,FILTER(" & CalcObCol(OB_COL_LOW) & "," & cond & ")," & _
            "hi,FILTER(" & CalcObCol(OB_COL_HIGH) & "," & cond & "),n,ROWS(lo),k,SEQUENCE(n*2)," & _
            "IF(MOD(k,2)=1,INDEX(lo,ROUNDUP(k/2,0)),INDEX(hi,k/2))),NA())"
        UpsertName dataName, SpillRef(startCell)
        For m = 1 To nMics
            mStage = "write data starts: model " & CStr(j) & " OB mic " & CStr(m)
            yCol = base + m
            cond = ObFilterCond(m, modelRef, j, "chkOB")
            startName = "start_Y_" & m & "_" & j & "_OB"
            dataName = "Y_" & m & "_" & j & "_OB"
            Set startCell = OutputAnchor(wsP, startName, wsP.Cells(anchorRow + 2, yCol))
            startCell.Formula2 = _
                "=IFERROR(LET(v,FILTER(" & CalcObSelectedValueCol() & "," & cond & _
                "),n,ROWS(v),INDEX(v,ROUNDUP(SEQUENCE(n*2)/2,0))),NA())"
            UpsertName dataName, SpillRef(startCell)
        Next m
    Next j
End Sub

Private Sub WriteBlockHeaders(ByVal wsP As Worksheet, ByVal wsCfg As Worksheet, _
                              ByVal mR0 As Long, ByVal mC As Long, _
                              ByVal micR0 As Long, ByVal micC As Long, _
                              ByVal nModels As Long, ByVal nMics As Long, _
                              ByVal anchorRow As Long, ByVal anchorCol As Long, _
                              ByVal obStart As Long)
    Dim topRow As Long, modelRow As Long, fieldRow As Long, unitRow As Long
    Dim perW As Long, nbLast As Long, obLast As Long
    Dim j As Long, m As Long, base As Long
    Dim modelName As String, micName As String

    topRow = anchorRow - 2: modelRow = anchorRow - 1
    fieldRow = anchorRow: unitRow = anchorRow + 1
    perW = 1 + nMics
    nbLast = anchorCol + nModels * perW - 1
    obLast = obStart + nModels * perW - 1
    MergeHeader wsP, topRow, anchorCol, nbLast, "CHART DATA - NARROWBAND"
    MergeHeader wsP, topRow, obStart, obLast, "CHART DATA - OCTAVEBAND"

    For j = 1 To nModels
        modelName = CStr(wsCfg.Cells(mR0 + j - 1, mC).Value)
        base = anchorCol + (j - 1) * perW
        mStage = "write data starts: model " & CStr(j) & " NB X"
        MergeHeader wsP, modelRow, base, base + perW - 1, modelName
        wsP.Cells(fieldRow, base).Value = "Frequency"
        If Len(CStr(wsP.Cells(unitRow, base).Value2)) = 0 Then _
            wsP.Cells(unitRow, base).Value = "[Hz]"
        base = obStart + (j - 1) * perW
        MergeHeader wsP, modelRow, base, base + perW - 1, modelName
        wsP.Cells(fieldRow, base).Value = "Frequency"
        If Len(CStr(wsP.Cells(unitRow, base).Value2)) = 0 Then _
            wsP.Cells(unitRow, base).Value = "[Hz]"
        For m = 1 To nMics
            mStage = "write data starts: model " & CStr(j) & " NB mic " & CStr(m)
            micName = "Mic " & CStr(wsCfg.Cells(micR0 + m - 1, micC).Value)
            wsP.Cells(fieldRow, anchorCol + (j - 1) * perW + m).Value = micName
            wsP.Cells(fieldRow, obStart + (j - 1) * perW + m).Value = micName
            If Len(CStr(wsP.Cells(unitRow, anchorCol + (j - 1) * perW + m).Value2)) = 0 Then _
                wsP.Cells(unitRow, anchorCol + (j - 1) * perW + m).Formula = "=selQty"
            If Len(CStr(wsP.Cells(unitRow, obStart + (j - 1) * perW + m).Value2)) = 0 Then _
                wsP.Cells(unitRow, obStart + (j - 1) * perW + m).Formula = "=selQty"
        Next m
    Next j

End Sub

Private Sub MergeHeader(ByVal ws As Worksheet, ByVal rowNumber As Long, _
                        ByVal firstCol As Long, ByVal lastCol As Long, _
                        ByVal caption As String)
    With ws.Range(ws.Cells(rowNumber, firstCol), ws.Cells(rowNumber, lastCol))
        If .MergeCells Then .UnMerge
        If lastCol > firstCol Then .Merge
        .Cells(1, 1).Value = caption
    End With
End Sub

Private Sub StylePlotDataSheet(ByVal ws As Worksheet, ByVal anchorRow As Long, _
                               ByVal anchorCol As Long, ByVal obStart As Long, _
                               ByVal nModels As Long, ByVal nMics As Long)
    Dim perW As Long, nbLast As Long, obLast As Long, topRow As Long
    perW = 1 + nMics
    nbLast = anchorCol + nModels * perW - 1
    obLast = obStart + nModels * perW - 1
    topRow = anchorRow - 2
    ws.Range(ws.Cells(topRow, anchorCol), ws.Cells(anchorRow, obLast)).Font.Name = UI_FONT_NAME
    ws.Columns(anchorCol - 1).ColumnWidth = 2.5
    ws.Range(ws.Columns(anchorCol), ws.Columns(nbLast)).ColumnWidth = 11.5
    ws.Columns(nbLast + 1).ColumnWidth = 2.5
    ws.Range(ws.Columns(obStart), ws.Columns(obLast)).ColumnWidth = 11.5
    ws.Rows(topRow).RowHeight = 24
    ws.Rows(anchorRow - 1).RowHeight = 23
    ws.Rows(anchorRow).RowHeight = 28
    With ws.Range(ws.Cells(topRow, anchorCol), ws.Cells(anchorRow, obLast))
        .Borders.LineStyle = xlContinuous
        .Borders.Color = RGB(180, 190, 200)
        .VerticalAlignment = xlCenter
    End With
    With ws.Range(ws.Cells(topRow, anchorCol), ws.Cells(topRow, nbLast))
        .Interior.Color = RGB(18, 55, 85): .Font.Color = vbWhite: .Font.Bold = True
    End With
    With ws.Range(ws.Cells(topRow, obStart), ws.Cells(topRow, obLast))
        .Interior.Color = RGB(31, 127, 111): .Font.Color = vbWhite: .Font.Bold = True
    End With
    With ws.Range(ws.Cells(anchorRow - 1, anchorCol), ws.Cells(anchorRow, obLast))
        .Interior.Color = RGB(232, 238, 243): .Font.Bold = True
        .HorizontalAlignment = xlCenter
    End With
End Sub

' Boolean condition array (as string) for a FILTER over CALC:
'   mic = m, model = modelRef, band = bd, numeric rpm mapped from selRPM label.
Private Function NbFilterCond(ByVal m As Long, ByVal modelRef As String, _
                              ByVal j As Long, ByVal bandToggle As String) As String
    NbFilterCond = "(" & SelectedDataCol(NB_COL_MIC) & "=" & m & ")*" & _
                   "(" & SelectedDataCol(NB_COL_MODEL) & "=" & modelRef & ")*" & _
                   "LISTS!$C$" & (j + 1) & "*" & bandToggle
End Function

Private Function ObFilterCond(ByVal m As Long, ByVal modelRef As String, _
                              ByVal j As Long, ByVal bandToggle As String) As String
    ObFilterCond = "(" & CalcObCol(OB_COL_MIC) & "=" & m & ")*" & _
                   "(" & CalcObCol(OB_COL_MODEL) & "=" & modelRef & ")*" & _
                   "(" & CalcObCol(OB_COL_LOAD) & "=selLoadValue)*" & _
                   "(" & CalcObCol(OB_COL_RPM) & "=selRPMValue)*" & _
                   "LISTS!$C$" & (j + 1) & "*" & bandToggle
End Function

' Resolve/create one independently movable formula-start cell.
Private Function OutputAnchor(wsP As Worksheet, ByVal anchorName As String, _
                              defaultCell As Range) As Range
    Dim n As Name, r As Range
    On Error Resume Next
    Set n = ThisWorkbook.Names(anchorName)
    If Not n Is Nothing Then Set r = n.RefersToRange.Cells(1, 1)
    On Error GoTo 0
    If Not r Is Nothing Then
        If r.Parent.Name = wsP.Name Then
            Set OutputAnchor = r
            Exit Function
        End If
    End If
    Set OutputAnchor = defaultCell
    UpsertName anchorName, "='" & defaultCell.Parent.Name & "'!" & defaultCell.Address
End Function

' Dynamic-array spill range consumed by chart series, e.g. =SPL!$BA$2#.
Private Function SpillRef(startCell As Range) As String
    SpillRef = "='" & startCell.Parent.Name & "'!" & startCell.Address & "#"
End Function

Private Function HasOutputAnchors() As Boolean
    Dim n As Name
    For Each n In ThisWorkbook.Names
        If Left$(n.Name, 9) = "start_Xm_" Or Left$(n.Name, 8) = "start_Y_" _
           Or n.Name = "start_SelectedData" Or n.Name = "start_SelectedValue" Then
            HasOutputAnchors = True
            Exit Function
        End If
    Next n
End Function

' Clearing the formula start removes its spill without touching unrelated cells.
Private Sub ClearOutputAnchors(wsP As Worksheet)
    Dim n As Name, r As Range
    For Each n In ThisWorkbook.Names
        If Left$(n.Name, 9) = "start_Xm_" Or Left$(n.Name, 8) = "start_Y_" _
           Or n.Name = "start_SelectedData" Or n.Name = "start_SelectedValue" Then
            Set r = Nothing
            On Error Resume Next
            Set r = n.RefersToRange.Cells(1, 1)
            On Error GoTo 0
            If Not r Is Nothing Then
                If r.Parent.Name = wsP.Name Then r.ClearContents
            End If
        End If
    Next n
End Sub

Private Sub UpsertName(ByVal nm As String, ByVal refTo As String)
    Dim n As Name
    On Error Resume Next
    Set n = ThisWorkbook.Names(nm)
    On Error GoTo 0
    If n Is Nothing Then
        ThisWorkbook.Names.Add Name:=nm, RefersTo:=refTo
    Else
        n.RefersTo = refTo
    End If
End Sub

' Remove series names whose (mic,model) no longer exists, plus legacy per-mic
' "X_" names from older versions. Safe to call AFTER SyncCharts has rebuilt
' every chart's series (no live references remain).
Private Sub DeleteStaleNames(ByVal nModels As Long, ByVal nMics As Long)
    Dim nmObj As Name, nm As String, p() As String, i As Long
    Dim toDel As Collection: Set toDel = New Collection
    For Each nmObj In ThisWorkbook.Names
        nm = nmObj.Name
        If Left$(nm, 2) = "X_" Or nm = "obFreqX" Then
            toDel.Add nm                          ' legacy names from older layouts
        ElseIf Left$(nm, 9) = "start_Xm_" Then
            p = Split(nm, "_")                    ' [start, Xm, j, band]
            If UBound(p) >= 2 Then
                If ToLong(p(2)) < 1 Or ToLong(p(2)) > nModels Then toDel.Add nm
            End If
        ElseIf Left$(nm, 8) = "start_Y_" Then
            p = Split(nm, "_")                    ' [start, Y, m, j, band]
            If UBound(p) >= 3 Then
                If ToLong(p(2)) < 1 Or ToLong(p(2)) > nMics _
                   Or ToLong(p(3)) < 1 Or ToLong(p(3)) > nModels Then toDel.Add nm
            End If
        ElseIf Left$(nm, 2) = "Y_" Then
            p = Split(nm, "_")                    ' [Y, m, j, band]
            If UBound(p) >= 2 Then
                If ToLong(p(1)) < 1 Or ToLong(p(1)) > nMics _
                   Or ToLong(p(2)) < 1 Or ToLong(p(2)) > nModels Then toDel.Add nm
            End If
        ElseIf Left$(nm, 3) = "Xm_" Then
            p = Split(nm, "_")                    ' [Xm, j, NB]  (shared per-model X)
            If UBound(p) >= 1 Then
                If ToLong(p(1)) < 1 Or ToLong(p(1)) > nModels Then toDel.Add nm
            End If
        End If
    Next nmObj
    For i = 1 To toDel.Count
        On Error Resume Next
        ThisWorkbook.Names(toDel(i)).RefersToRange.Cells(1, 1).ClearContents
        ThisWorkbook.Names(toDel(i)).Delete
        On Error GoTo 0
    Next i
End Sub

' ---------- scalable band/model toggle shapes ----------

' Shape click handler shared by Narrowband, Octaveband and every model.
' AlternativeText carries "$cell$address|caption"; the Boolean itself remains
' in LISTS, so the existing named ranges and FILTER/chart formulas stay intact.
Public Sub ToggleDashboardFilter(Optional ByVal shapeName As String = "")
    Dim wsP As Worksheet, wsL As Worksheet, shp As Shape, stateCell As Range
    Dim payload As String, sep As Long, cellAddr As String, label As String
    Dim isOn As Boolean, errorMsg As String
    On Error GoTo fail
    Set wsP = Worksheets("SPL"): Set wsL = Worksheets("LISTS")
    If Len(shapeName) = 0 Then shapeName = CStr(Application.Caller)
    Set shp = wsP.Shapes(shapeName)
    payload = shp.AlternativeText
    sep = InStr(1, payload, "|", vbBinaryCompare)
    If sep < 2 Then Err.Raise vbObjectError + 31, , "Invalid toggle metadata: " & shp.Name
    cellAddr = Left$(payload, sep - 1)
    label = Mid$(payload, sep + 1)
    Set stateCell = wsL.Range(cellAddr)
    isOn = Not ToggleIsOn(stateCell.Value)
    stateCell.Value = isOn
    If Left$(shp.Name, 6) = "cbMdl_" Then
        shp.Fill.ForeColor.RGB = IIf(isOn, ModelToggleAccentColor(shp), RGB(205, 209, 214))
    Else
        ApplyToggleStyle shp, isOn, label
    End If
    Application.Calculate
    Exit Sub
fail:
    errorMsg = modLog.ReportError("ToggleDashboardFilter", "update control", _
                                  Err.Number, Err.Description)
End Sub

' Ensure the two static band controls are Shapes too. The legacy Form Control
' captions are recognized and converted in place when an older workbook is rebuilt.
Private Sub SyncBandToggles(wsP As Worksheet, wsL As Worksheet)
    If Len(wsL.Range("I2").Value) = 0 Then wsL.Range("I2").Value = True
    If Len(wsL.Range("I3").Value) = 0 Then wsL.Range("I3").Value = True
    SyncOneBandToggle wsP, wsL, "tgBand_NB", "$I$2", "Narrowband", 460, 20
    SyncOneBandToggle wsP, wsL, "tgBand_OB", "$I$3", "Octaveband", 575, 20
End Sub

Private Sub SyncOneBandToggle(wsP As Worksheet, wsL As Worksheet, ByVal shpName As String, _
                              ByVal cellAddr As String, ByVal label As String, _
                              ByVal defaultLeft As Single, ByVal defaultTop As Single)
    Dim shp As Shape, isNew As Boolean
    Set shp = FindShape(wsP, shpName)
    If shp Is Nothing Then Set shp = FindLegacyToggle(wsP, label)
    Set shp = EnsureToggleShape(wsP, shp, shpName, defaultLeft, defaultTop, 110, 28, isNew)
    ConfigureToggle shp, cellAddr, label, ToggleIsOn(wsL.Range(cellAddr).Value), isNew
End Sub

' Upsert every model toggle beside its fixed named model cell. Existing Shapes
' keep their exact user-arranged geometry; defaults apply only on first create.
Private Sub SyncModelToggles(wsP As Worksheet, wsCfg As Worksheet, wsL As Worksheet, _
                             ByVal mR0 As Long, ByVal mC As Long, ByVal nModels As Long)
    Dim j As Long, i As Long, shp As Shape, previousShape As Shape
    Dim previousNameCell As Range, nm As String, shpName As String
    Dim isNew As Boolean
    Dim legacyName As String, modelNameRef As String
    Dim nameCell As Range, nmObj As Name
    Dim cx As Single, cy As Single, slot As Long
    Dim wanted As Object: Set wanted = CreateObject("Scripting.Dictionary")
    wanted.CompareMode = vbTextCompare
    RemoveDuplicateModelToggleShapes wsP
    RemoveExpandableModelToggleShapes wsP, 3

    For j = 1 To nModels
        mStage = "sync model controls: model " & CStr(j) & " prepare"
        nm = CStr(wsCfg.Cells(mR0 + j - 1, mC).Value)
        shpName = "cbMdl_" & j
        legacyName = "cbMdl_" & Sanitize(nm)
        Set nameCell = PlotModelNameCell(wsP, j)
        nameCell.Value = nm
        If Len(modelNameRef) > 0 Then modelNameRef = modelNameRef & ","
        modelNameRef = modelNameRef & nameCell.Address(External:=True)
        wanted(shpName) = True
        Set shp = FindShape(wsP, shpName)
        ' Preserve position/size when migrating an older cbMdl_<model-name> shape.
        If shp Is Nothing And StrComp(legacyName, shpName, vbTextCompare) <> 0 Then
            Set shp = FindShape(wsP, legacyName)
        End If
        cx = nameCell.Left + nameCell.Width + 3
        cy = nameCell.Top - 3
        isNew = False
        mStage = "sync model controls: model " & CStr(j) & " ensure shape"
        Set shp = EnsureToggleShape(wsP, shp, shpName, cx, cy, 82, 24, isNew)
        If isNew And j > 3 Then
            Set previousShape = FindShape(wsP, "cbMdl_1")
            If Not previousShape Is Nothing Then
                shp.Left = previousShape.Left
                shp.Top = previousShape.Top + (j - 1) * 19
            End If
        End If
        mStage = "sync model controls: model " & CStr(j) & " configure"
        ConfigureToggle shp, "$C$" & (j + 1), "Model " & j, _
                        ToggleIsOn(wsL.Cells(j + 1, 3).Value), isNew
    Next j
    If Len(modelNameRef) > 0 Then UpsertName "plotModelNames", "=" & modelNameRef

    Dim toHide As Collection: Set toHide = New Collection
    For Each shp In wsP.Shapes
        If Left$(shp.Name, 6) = "cbMdl_" Then
            If Not wanted.Exists(shp.Name) Then toHide.Add shp.Name
        End If
    Next shp
    For i = 1 To toHide.Count
        wsP.Shapes(toHide(i)).Visible = msoFalse
    Next i

    ' Delete obsolete per-model name cells and their old displayed values.
    Dim staleNames As Collection: Set staleNames = New Collection
    For Each nmObj In ThisWorkbook.Names
        If Left$(nmObj.Name, 14) = "plotModelName_" Then
            i = ToLong(Mid$(nmObj.Name, 15))
            If i < 1 Or i > nModels Then staleNames.Add nmObj.Name
        End If
    Next nmObj
    For i = 1 To staleNames.Count
        On Error Resume Next
        ThisWorkbook.Names(staleNames(i)).RefersToRange.ClearContents
        ThisWorkbook.Names(staleNames(i)).Delete
        On Error GoTo 0
    Next i
End Sub

' One fixed, user-movable cell per model. Existing named cells retain their
' address. New cells use a compact grid above the charts; the toggle is created
' immediately to the right of its cell.
Private Function PlotModelNameCell(wsP As Worksheet, ByVal modelIndex As Long) As Range
    Dim n As Name, previousCell As Range
    On Error Resume Next
    Set n = ThisWorkbook.Names("plotModelName_" & modelIndex)
    If Not n Is Nothing Then Set PlotModelNameCell = n.RefersToRange.Cells(1, 1)
    On Error GoTo 0
    If Not PlotModelNameCell Is Nothing Then
        If PlotModelNameCell.Parent.Name = wsP.Name Then Exit Function
        Set PlotModelNameCell = Nothing
    End If

    If modelIndex > 1 Then
        Set previousCell = PlotModelNameCell(wsP, modelIndex - 1)
        Set PlotModelNameCell = previousCell.Offset(1, 0)
        previousCell.Copy
        PlotModelNameCell.PasteSpecial xlPasteFormats
        Application.CutCopyMode = False
    Else
        Set PlotModelNameCell = wsP.Range("AF2")
    End If
    UpsertName "plotModelName_" & modelIndex, _
               "=SPL!" & PlotModelNameCell.Address
End Function

' Return a rounded rectangle. AutoShapes are kept as arranged; legacy controls
' are recreated with the same position and size. Defaults apply only when new.
Private Function EnsureToggleShape(wsP As Worksheet, ByVal existing As Shape, _
                                   ByVal shpName As String, ByVal defaultLeft As Single, _
                                   ByVal defaultTop As Single, ByVal defaultW As Single, _
                                   ByVal defaultH As Single, ByRef isNew As Boolean) As Shape
    Dim x As Single, y As Single, w As Single, h As Single
    Dim templateShape As Shape, candidate As Shape
    Dim familyPrefix As String
    x = defaultLeft: y = defaultTop: w = defaultW: h = defaultH
    isNew = False
    If Not existing Is Nothing Then
        x = existing.Left: y = existing.Top
        w = existing.Width: h = existing.Height
        existing.Name = shpName
        Set EnsureToggleShape = existing
        Exit Function
    End If
    familyPrefix = Left$(shpName, InStr(1, shpName, "_"))
    For Each candidate In wsP.Shapes
        If Left$(candidate.Name, Len(familyPrefix)) = familyPrefix Then Set templateShape = candidate
    Next candidate
    If Not templateShape Is Nothing Then
        Set EnsureToggleShape = wsP.Shapes.AddShape(msoShapeRoundedRectangle, _
            defaultLeft, defaultTop, _
            templateShape.Width, templateShape.Height)
        EnsureToggleShape.Name = shpName
        isNew = True
        Exit Function
    End If
    Set EnsureToggleShape = wsP.Shapes.AddShape(msoShapeRoundedRectangle, x, y, w, h)
    EnsureToggleShape.Name = shpName
    isNew = True
End Function

Private Sub ConfigureToggle(shp As Shape, ByVal cellAddr As String, _
                            ByVal label As String, ByVal isOn As Boolean, ByVal isNew As Boolean)
    shp.AlternativeText = cellAddr & "|" & label
    shp.OnAction = "ToggleDashboardFilter"
    shp.Visible = msoTrue
    If Left$(shp.Name, 6) = "cbMdl_" Then
        If isNew Then
            shp.Placement = xlFreeFloating
            shp.LockAspectRatio = msoFalse
            ApplyToggleStyle shp, isOn, label
        Else
            shp.Fill.ForeColor.RGB = IIf(isOn, ModelToggleAccentColor(shp), RGB(205, 209, 214))
        End If
        Exit Sub
    End If
    If isNew Then
        shp.Placement = xlFreeFloating
        shp.LockAspectRatio = msoFalse
        ApplyToggleStyle shp, isOn, label
    Else
        shp.TextFrame2.TextRange.Text = IIf(isOn, ChrW(&H2713), ChrW(&H25A1))
    End If
End Sub

Private Sub RemoveExpandableModelToggleShapes(ByVal wsP As Worksheet, _
                                               ByVal fixedModelCount As Long)
    Dim i As Long, modelIndex As Long, nm As String
    For i = wsP.Shapes.Count To 1 Step -1
        nm = wsP.Shapes(i).Name
        If Left$(nm, 6) = "cbMdl_" Then
            modelIndex = ToLong(Mid$(nm, 7))
            If modelIndex > fixedModelCount Then wsP.Shapes(i).Delete
        End If
    Next i
End Sub

Private Sub RemoveDuplicateModelToggleShapes(ByVal wsP As Worksheet)
    Dim seen As Object, removeAt As Collection
    Dim i As Long, nm As String
    Set seen = CreateObject("Scripting.Dictionary")
    Set removeAt = New Collection
    seen.CompareMode = vbTextCompare
    ' Keep the last object for a duplicated Excel shape name. COM lookup and
    ' the presentation contract also resolve that last object, so this cleanup
    ' is stable instead of visibly jumping to an older hidden duplicate.
    For i = wsP.Shapes.Count To 1 Step -1
        nm = wsP.Shapes(i).Name
        If Left$(nm, 6) = "cbMdl_" Then
            If seen.Exists(nm) Then
                removeAt.Add i
            Else
                seen.Add nm, True
            End If
        End If
    Next i
    For i = 1 To removeAt.Count
        wsP.Shapes(CLng(removeAt(i))).Delete
    Next i
End Sub

' Model toggles use the configured NB series color as the stable model identity.
' Band toggles keep the semantic green. Geometry remains user-owned.
Private Sub ApplyToggleStyle(shp As Shape, ByVal isOn As Boolean, ByVal label As String)
    Dim glyph As String, compact As Boolean, isModelToggle As Boolean, accentColor As Long
    glyph = IIf(isOn, ChrW(&H2713), ChrW(&H25A1))
    isModelToggle = (Left$(shp.Name, 6) = "cbMdl_")
    compact = (isModelToggle Or Left$(shp.Name, 7) = "tgBand_")
    If isModelToggle Then
        accentColor = ModelToggleAccentColor(shp)
    Else
        accentColor = RGB(42, 126, 76)
    End If
    With shp
        .Fill.Visible = msoTrue
        .Fill.Solid
        .Line.Visible = msoTrue
        .Line.Weight = 1.25
        .Shadow.Visible = msoFalse
        If isOn Then
            .Fill.ForeColor.RGB = accentColor
            .Line.ForeColor.RGB = accentColor
        Else
            .Fill.ForeColor.RGB = RGB(205, 209, 214)
            .Line.ForeColor.RGB = IIf(isModelToggle, accentColor, RGB(145, 150, 156))
        End If
        With .TextFrame2
            .AutoSize = msoAutoSizeNone
            If compact Then
                .MarginLeft = 1: .MarginRight = 1
            Else
                .MarginLeft = 5: .MarginRight = 5
            End If
            .MarginTop = 1: .MarginBottom = 1
            .VerticalAnchor = msoAnchorMiddle
            If compact Or Len(label) = 0 Then
                .TextRange.Text = glyph
            Else
                .TextRange.Text = glyph & "  " & label
            End If
            .TextRange.ParagraphFormat.Alignment = msoAlignCenter
            .TextRange.Font.Name = UI_FONT_NAME
            .TextRange.Font.Size = 11
            .TextRange.Font.Bold = msoTrue
            If isOn Then
                .TextRange.Font.Fill.ForeColor.RGB = RGB(255, 255, 255)
            Else
                .TextRange.Font.Fill.ForeColor.RGB = RGB(92, 96, 101)
            End If
            .TextRange.Characters(1, 1).Font.Name = UI_FONT_NAME
            .TextRange.Characters(1, 1).Font.Size = 17
        End With
    End With
End Sub

Private Function ModelToggleAccentColor(ByVal shp As Shape) As Long
    Dim modelIndex As Long
    modelIndex = ToLong(Mid$(shp.Name, 7))
    ModelToggleAccentColor = GetModelDisplayColor(modelIndex)
End Function

Private Function ToggleIsOn(ByVal v As Variant) As Boolean
    On Error Resume Next
    ToggleIsOn = CBool(v)
    On Error GoTo 0
End Function

Private Function FindLegacyToggle(wsP As Worksheet, ByVal label As String) As Shape
    Dim shp As Shape, txt As String
    For Each shp In wsP.Shapes
        txt = ""
        On Error Resume Next
        txt = shp.TextFrame.Characters.Text
        On Error GoTo 0
        If StrComp(Trim$(txt), label, vbTextCompare) = 0 Then
            Set FindLegacyToggle = shp
            Exit Function
        End If
    Next shp
End Function

' ---------- charts (position-preserving) ----------

Private Sub SyncCharts(wsP As Worksheet, wsCfg As Worksheet, _
                       ByVal mR0 As Long, ByVal mC As Long, ByVal micR0 As Long, ByVal micC As Long, _
                       ByVal nModels As Long, ByVal nMics As Long)
    Dim m As Long, j As Long, co As ChartObject, ch As Chart, s As Series
    Dim cnt As Long, lblRow As Long, mm As Long, isNew As Boolean, isNewSeries As Boolean

    ' Keep stale charts as hidden user-owned slots. Their geometry and titles
    ' survive a temporary CONFIG change and are reused if the mic returns.
    For Each co In wsP.ChartObjects
        If Left$(co.Name, 6) = "chMic_" Then
            mm = ToLong(Mid$(co.Name, 7))
            If mm < 1 Or mm > nMics Then
                co.Visible = False
                On Error Resume Next
                Do While co.Chart.SeriesCollection.Count > 0
                    co.Chart.SeriesCollection(1).Delete
                Loop
                On Error GoTo 0
            End If
        End If
    Next co

    For m = 1 To nMics
        Set co = FindChart(wsP, "chMic_" & m)
        isNew = co Is Nothing
        If isNew Then
            Set co = NewChartSlot(wsP, m)
            co.Name = "chMic_" & m
        End If
        co.Visible = True
        Set ch = co.Chart
        If isNew Then ch.ChartType = xlXYScatterLinesNoMarkers

        ' Update data bindings in place so existing series formatting remains
        ' user-owned. Only a genuinely new series receives CONFIG defaults.
        cnt = 0
        For j = 1 To nModels
            cnt = cnt + 1                                   ' NB series (shared per-model X)
            isNewSeries = (ch.SeriesCollection.Count < cnt)
            If isNewSeries Then Set s = ch.SeriesCollection.NewSeries Else Set s = ch.SeriesCollection(cnt)
            lblRow = 2 + (j - 1) * 2
            s.Formula = SeriesFormula(lblRow, "Xm_" & j & "_NB", "Y_" & m & "_" & j & "_NB", cnt)
            If isNewSeries Then ApplySeriesStyle s, wsCfg, mR0, mC, j, "NB"
            cnt = cnt + 1                                   ' OB series (manual per-model X)
            isNewSeries = (ch.SeriesCollection.Count < cnt)
            If isNewSeries Then Set s = ch.SeriesCollection.NewSeries Else Set s = ch.SeriesCollection(cnt)
            lblRow = 3 + (j - 1) * 2
            s.Formula = SeriesFormula(lblRow, "Xm_" & j & "_OB", "Y_" & m & "_" & j & "_OB", cnt)
            If isNewSeries Then ApplySeriesStyle s, wsCfg, mR0, mC, j, "OB"
        Next j
        On Error Resume Next
        Do While ch.SeriesCollection.Count > cnt
            ch.SeriesCollection(ch.SeriesCollection.Count).Delete
        Loop
        On Error GoTo 0

        ' Existing chart titles are fully user-owned. A new chart receives one
        ' usable default, then later rebuilds leave its text and format intact.
        If isNew Then
            ch.HasTitle = True
            ch.ChartTitle.Text = wsCfg.Cells(micR0 + m - 1, micC + 1).Value
            ch.ChartTitle.Font.Color = RGB(23, 50, 77)
            ch.ChartTitle.Font.Bold = True
            ch.ChartTitle.Font.Size = 13
            With ch.Axes(xlCategory)
                .HasTitle = True
                .AxisTitle.Text = wsCfg.Range("lblX").Value
            End With
            ch.PlotArea.Format.Line.ForeColor.RGB = RGB(120, 120, 120)
            ch.PlotArea.Format.Line.Weight = 0.75
            ch.ChartArea.Format.Line.ForeColor.RGB = RGB(180, 180, 180)
        End If
        If isNew Then ch.HasLegend = False
    Next m
End Sub

Private Function SeriesFormula(ByVal lblRow As Long, ByVal xName As String, _
                               ByVal yName As String, ByVal order As Long) As String
    SeriesFormula = "=SERIES('[" & ThisWorkbook.Name & "]LISTS'!$G$" & lblRow & _
                    ",'" & ThisWorkbook.Name & "'!" & xName & _
                    ",'" & ThisWorkbook.Name & "'!" & yName & "," & order & ")"
End Function

Private Function FindChart(wsP As Worksheet, ByVal nm As String) As ChartObject
    Dim co As ChartObject
    For Each co In wsP.ChartObjects
        If co.Name = nm Then Set FindChart = co: Exit Function
    Next co
End Function

' New charts use a two-column grid and append rows without moving any existing
' chart. The mic index, not the current visible count, owns the default slot.
Private Function NewChartSlot(wsP As Worksheet, ByVal micIndex As Long) As ChartObject
    Dim slot As Long, chLeft As Single, chTop As Single, top0 As Single
    Dim templateChart As ChartObject, candidate As ChartObject
    For Each candidate In wsP.ChartObjects
        If Left$(candidate.Name, 6) = "chMic_" Then Set templateChart = candidate
    Next candidate
    If Not templateChart Is Nothing Then
        templateChart.Copy
        wsP.Paste
        Set NewChartSlot = wsP.ChartObjects(wsP.ChartObjects.Count)
        NewChartSlot.Left = templateChart.Left + templateChart.Width
        NewChartSlot.Top = templateChart.Top
        NewChartSlot.Width = templateChart.Width
        NewChartSlot.Height = templateChart.Height
        NewChartSlot.Placement = xlFreeFloating
        Exit Function
    End If
    slot = micIndex - 1
    top0 = GRID_TOP0 + 40
    chLeft = CHART_LEFT + (slot Mod CHARTS_PER_ROW) * CHART_GAP_X
    chTop = top0 + Int(slot / CHARTS_PER_ROW) * CHART_GAP_Y
    Set NewChartSlot = wsP.ChartObjects.Add(chLeft, chTop, CHART_W, CHART_H)
    NewChartSlot.Placement = xlFreeFloating
End Function

' ---------- small helpers ----------

Private Sub Stage(ByVal s As String)
    mStage = s
    modLog.ReportStage "RebuildDashboard", s
End Sub

' Restore the app state saved at the start of RebuildDashboard.
Private Sub RestoreApp()
    On Error Resume Next
    Application.Calculation = mPrevCalc
    Application.EnableEvents = mPrevEvents
    Application.ScreenUpdating = mPrevScreenUpdating
    On Error GoTo 0
End Sub

' Apply one configured style group. Projection uses the same table contract but
' has no live series yet; future projection code can call this helper with PROJ.
Private Sub ApplySeriesStyle(s As Series, wsCfg As Worksheet, ByVal mR0 As Long, _
                             ByVal mC As Long, ByVal j As Long, ByVal bandKey As String)
    Dim baseOfs As Long, fallbackW As Single
    baseOfs = StyleBaseOffset(bandKey)
    fallbackW = IIf(UCase$(bandKey) = "OB", OB_WEIGHT, _
                    IIf(UCase$(bandKey) = "PROJ", PROJ_WEIGHT, NB_WEIGHT))
    With s
        .Format.Line.ForeColor.RGB = ConfiguredSeriesColor(wsCfg, mR0, mC, j, baseOfs)
        .Format.Line.DashStyle = DashStyleFromCode(wsCfg.Cells(mR0 + j - 1, mC + baseOfs + 1).Value)
        .Format.Line.Weight = ConfiguredWeight(wsCfg.Cells(mR0 + j - 1, mC + baseOfs + 2).Value, fallbackW)
        .MarkerStyle = xlMarkerStyleNone
    End With
End Sub

Private Function StyleBaseOffset(ByVal bandKey As String) As Long
    Select Case UCase$(Trim$(bandKey))
        Case "OB": StyleBaseOffset = STYLE_OB_COLOR_OFS
        Case "PROJ", "PROJECTION": StyleBaseOffset = STYLE_PROJ_COLOR_OFS
        Case Else: StyleBaseOffset = STYLE_NB_COLOR_OFS
    End Select
End Function

' Color = the fill of the group's Color cell; blank falls back to the palette.
Private Function ConfiguredSeriesColor(wsCfg As Worksheet, ByVal mR0 As Long, _
                                       ByVal mC As Long, ByVal j As Long, _
                                       ByVal colorOfs As Long) As Long
    Dim c As Range
    Set c = wsCfg.Cells(mR0 + j - 1, mC + colorOfs)
    If c.Interior.ColorIndex = xlColorIndexNone Then
        Dim pal As Variant
        pal = Array(RGB(255, 0, 0), RGB(0, 0, 255), RGB(0, 176, 80), RGB(112, 48, 160), _
                    RGB(237, 70, 180), RGB(255, 88, 24), RGB(0, 220, 230), RGB(242, 190, 0), _
                    RGB(0, 166, 214), RGB(0, 184, 156), RGB(128, 0, 128), RGB(224, 0, 122), _
                    RGB(255, 152, 24), RGB(190, 255, 30))
        ConfiguredSeriesColor = pal((j - 1) Mod 14)
    Else
        ConfiguredSeriesColor = c.Interior.Color
    End If
End Function

' Canonical model identity used outside charts. NB is the stable source because
' one control cannot represent independent NB and OB colors at the same time.
Public Function GetModelDisplayColor(ByVal modelIndex As Long) As Long
    Dim wsCfg As Worksheet, hdr As Range
    On Error GoTo fallback
    If modelIndex < 1 Then GoTo fallback
    Set wsCfg = ThisWorkbook.Worksheets("CONFIG")
    Set hdr = wsCfg.Range("hdrModels")
    If Len(Trim$(CStr(hdr.Offset(modelIndex, 0).Value2))) = 0 Then GoTo fallback
    GetModelDisplayColor = ConfiguredSeriesColor(wsCfg, hdr.Row + 1, _
                                                  hdr.Column, modelIndex, _
                                                  STYLE_NB_COLOR_OFS)
    Exit Function
fallback:
    GetModelDisplayColor = RGB(96, 112, 126)
End Function

' Keep the model-name text and toggle fill synchronized with the canonical
' model color without moving, resizing or recreating existing controls.
Public Sub RefreshModelControlColors()
    Dim wsP As Worksheet, wsCfg As Worksheet, wsL As Worksheet
    Dim hdr As Range, nameCell As Range, shp As Shape, nmObj As Name
    Dim j As Long, colorValue As Long
    On Error GoTo fail
    Set wsP = ThisWorkbook.Worksheets("SPL")
    Set wsCfg = ThisWorkbook.Worksheets("CONFIG")
    Set wsL = ThisWorkbook.Worksheets("LISTS")
    Set hdr = wsCfg.Range("hdrModels")
    j = 1
    Do While Len(Trim$(CStr(hdr.Offset(j, 0).Value2))) > 0
        colorValue = GetModelDisplayColor(j)
        Set nameCell = Nothing
        Set nmObj = Nothing
        On Error Resume Next
        Set nmObj = ThisWorkbook.Names("plotModelName_" & j)
        If Not nmObj Is Nothing Then Set nameCell = nmObj.RefersToRange.Cells(1, 1)
        On Error GoTo fail
        If Not nameCell Is Nothing Then
            nameCell.Font.Color = colorValue
        End If
        Set shp = FindShape(wsP, "cbMdl_" & j)
        If Not shp Is Nothing Then
            ApplyToggleStyle shp, ToggleIsOn(wsL.Cells(j + 1, 3).Value2), "Model " & j
        End If
        j = j + 1
    Loop
    Exit Sub
fail:
    modLog.ReportError "RefreshModelControlColors", "sync model legend colors", _
                       Err.Number, Err.Description
End Sub

' Run manually after changing CONFIG styles or recovering a chart whose series
' formatting was lost. Existing series, data, formulas, and geometry are kept.
Public Sub RefreshSeriesColors()
    Dim wsP As Worksheet, wsCfg As Worksheet, hdr As Range
    Dim co As ChartObject, j As Long, nModels As Long, seriesIndex As Long
    On Error GoTo fail
    Set wsP = ThisWorkbook.Worksheets("SPL")
    Set wsCfg = ThisWorkbook.Worksheets("CONFIG")
    Set hdr = wsCfg.Range("hdrModels")
    nModels = CountRows(wsCfg, hdr.Column, hdr.Row + 1)
    For Each co In wsP.ChartObjects
        If Left$(co.Name, 6) = "chMic_" Then
            For j = 1 To nModels
                seriesIndex = (j - 1) * 2 + 1
                If co.Chart.SeriesCollection.Count >= seriesIndex Then _
                    ApplySeriesStyle co.Chart.SeriesCollection(seriesIndex), _
                                     wsCfg, hdr.Row + 1, hdr.Column, j, "NB"
                If co.Chart.SeriesCollection.Count >= seriesIndex + 1 Then _
                    ApplySeriesStyle co.Chart.SeriesCollection(seriesIndex + 1), _
                                     wsCfg, hdr.Row + 1, hdr.Column, j, "OB"
            Next j
        End If
    Next co
    RefreshModelControlColors
    modLog.ReportSuccess "RefreshSeriesColors", "restored styles for existing chart series"
    Exit Sub
fail:
    modLog.ReportError "RefreshSeriesColors", "apply CONFIG series styles", _
                       Err.Number, Err.Description
End Sub

' User-facing codes intentionally match the CONFIG legend/reference:
' 1 LineSolid, 2 LineDash, 3 LineDot, 4 LineDashDot, 5 LineDashDotDot.
Private Function DashStyleFromCode(ByVal v As Variant) As Long
    Dim code As Long
    If IsNumeric(v) Then code = CLng(v)
    Select Case code
        Case 2: DashStyleFromCode = msoLineDash
        Case 3: DashStyleFromCode = msoLineRoundDot
        Case 4: DashStyleFromCode = msoLineDashDot
        Case 5: DashStyleFromCode = msoLineDashDotDot
        Case Else: DashStyleFromCode = msoLineSolid
    End Select
End Function

Private Function ConfiguredWeight(ByVal v As Variant, ByVal fallbackW As Single) As Single
    If IsNumeric(v) And CDbl(v) > 0 Then
        ConfiguredWeight = CSng(v)
    Else
        ConfiguredWeight = fallbackW
    End If
End Function

Private Function CountRows(ws As Worksheet, ByVal col As Long, ByVal row0 As Long) As Long
    Dim n As Long
    Do While Len(Trim$(ws.Cells(row0 + n, col).Value)) > 0
        n = n + 1
    Loop
    CountRows = n
End Function

Private Function CountModelToggles(wsP As Worksheet) As Long
    Dim shp As Shape, n As Long
    For Each shp In wsP.Shapes
        If Left$(shp.Name, 6) = "cbMdl_" Then n = n + 1
    Next shp
    CountModelToggles = n
End Function

Private Function FindShape(wsP As Worksheet, ByVal nm As String) As Shape
    Dim shp As Shape
    For Each shp In wsP.Shapes
        If shp.Name = nm Then Set FindShape = shp: Exit Function
    Next shp
End Function

' Sanitize a model name into a legal, address-safe shape-name suffix.
Private Function Sanitize(ByVal s As String) As String
    Dim i As Long, ch As String, o As String
    For i = 1 To Len(s)
        ch = Mid$(s, i, 1)
        If ch Like "[A-Za-z0-9]" Then o = o & ch Else o = o & "_"
    Next i
    If Len(o) = 0 Then o = "x"
    Sanitize = o
End Function

' Non-volatile CALC column range sized to the ACTUAL data rows (dRows name).
' INDEX endpoints preserve dynamic sizing without OFFSET invalidating every
' FILTER whenever Excel recalculates an unrelated cell.
Private Function CalcNbCol(ByVal col As Long) As String
    Dim colRef As String
    colRef = "$" & ColLetter(col) & ":$" & ColLetter(col)
    CalcNbCol = "CALC_NB!$" & ColLetter(col) & "$2:INDEX(CALC_NB!" & colRef & ",dRowsNB+1)"
End Function

' Core A:G row matrix used by the one-time selected-RPM cache.
Private Function CalcNbSchemaTable() As String
    CalcNbSchemaTable = "CALC_NB!$A$2:INDEX(CALC_NB!$A:$H,dRowsNB+1," & NB_SCHEMA_COLS & ")"
End Function

' A column from the selected-RPM cache (selData spill).
Private Function SelectedDataCol(ByVal col As Long) As String
    SelectedDataCol = "INDEX(selData,0," & col & ")"
End Function

' Dynamic CALC value column selected by CONFIG QUANTITIES. There is no fixed
' PlotVal helper column: any schema or user-calculated header can be plotted.
Private Function SelectedValueCol() As String
    SelectedValueCol = "selValue"
End Function

' Dynamic source value column used only once to build selValue.
Private Function CalcNbSelectedValueCol() As String
    CalcNbSelectedValueCol = _
        "INDEX(CALC_NB!$A:$Z,2,MATCH(qtyColHdr,CALC_NB!$1:$1,0)):" & _
        "INDEX(CALC_NB!$A:$Z,dRowsNB+1,MATCH(qtyColHdr,CALC_NB!$1:$1,0))"
End Function

Private Function CalcObCol(ByVal col As Long) As String
    Dim colRef As String
    colRef = "$" & ColLetter(col) & ":$" & ColLetter(col)
    CalcObCol = "CALC_OB!$" & ColLetter(col) & "$2:INDEX(CALC_OB!" & colRef & ",dRowsOB+1)"
End Function

Private Function CalcObSelectedValueCol() As String
    CalcObSelectedValueCol = _
        "INDEX(CALC_OB!$A:$Z,2,MATCH(qtyColHdr,CALC_OB!$1:$1,0)):" & _
        "INDEX(CALC_OB!$A:$Z,dRowsOB+1,MATCH(qtyColHdr,CALC_OB!$1:$1,0))"
End Function

Private Function ColLetter(ByVal col As Long) As String
    ColLetter = Split(Cells(1, col).Address(True, False), "$")(0)
End Function

Private Function ToLong(ByVal v As Variant) As Long
    If IsNumeric(v) Then ToLong = CLng(v) Else ToLong = 0
End Function
