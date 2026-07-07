Attribute VB_Name = "ModRibbonCallbacks"
Option Explicit

' Ribbon callbacks - all entry points reachable from ribbon.xml.
' Every callback's first parameter is IRibbonControl (required by the spec).
' Buttons dispatch to real macros, branching on state held in ModRibbonState.

Private Const EXCEL_FONT_TAG As String = "ReportToolExcelFonts"
Private Const DEFAULT_EXCEL_FONTS As String = "Calibri|Aptos|Arial|Tahoma|Verdana|Times New Roman"

Public Sub OnRibbonLoad(ribbon As IRibbonUI)
    Set AppRibbonUI = ribbon
    TableTransferInitializeRibbon ribbon
    BalloonInitializeEvents
    RefreshWorkbookLinksRibbon
    RefreshChartImageRibbon
End Sub

' Snap the ribbon back to one of this tool's tabs after an action that
' selects or creates a shape/picture, so PowerPoint does not strand the
' user on the Picture/Shape Format contextual tab. ActivateTab is Office
' 2010+; the error guard keeps older builds working.
Public Sub ActivateMyTab(ByVal tabId As String)
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then AppRibbonUI.ActivateTab tabId
    On Error GoTo 0
End Sub

' ===== Group 1: Excel to PPT =====================================

Public Sub OnPasteFromExcel(control As IRibbonControl)
    EnsureExcelPasteDefaults
    PasteExcelSelection "Table", ExcelPastePlacement, _
        False, True, ExcelKeepFont, ExcelForceFontName(), _
        ExcelForcedSizeForPaste(), False
End Sub

Public Sub GetExcelPasteSupertip(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    Select Case ExcelPastePlacement
        Case "Replace"
            returnedVal = "Paste the Excel selection into the selected object frame as a native editable table."
        Case "Link"
            returnedVal = "Paste the Excel selection as a native editable PowerPoint table and save its workbook source for refresh."
        Case Else
            returnedVal = "Paste the Excel selection as a native editable PowerPoint table."
    End Select
End Sub

Public Sub OnPasteExcelMode(control As IRibbonControl)
    EnsureExcelPasteDefaults
    ExcelPasteMode = control.tag
    RefreshExcelPasteUI
    PasteExcelSelection ExcelPasteMode, ExcelPastePlacement, _
        False, True, ExcelKeepFont, ExcelForceFontName(), _
        ExcelForcedSizeForPaste(), False
End Sub

Public Sub OnPasteExcelReplaceSelected(control As IRibbonControl)
    EnsureExcelPasteDefaults
    PasteExcelSelection "Table", "Replace", _
        False, True, ExcelKeepFont, ExcelForceFontName(), _
        ExcelForcedSizeForPaste(), False
End Sub

Public Sub OnPasteFromExcelLinked(control As IRibbonControl)
    EnsureExcelPasteDefaults
    PasteExcelSelection "Table", "Original", _
        False, True, ExcelKeepFont, ExcelForceFontName(), _
        ExcelForcedSizeForPaste(), True
    RefreshWorkbookLinksRibbon
End Sub

Public Sub OnRefreshLinkedExcelTable(control As IRibbonControl)
    WorkbookLinksRefreshAll
End Sub

Public Sub OnBreakLinkedExcelTable(control As IRibbonControl)
    WorkbookLinksBreakSelected
End Sub

Public Sub OnWorkbookLinksRefreshAll(control As IRibbonControl)
    WorkbookLinksRefreshAll
    RefreshWorkbookLinksRibbon
End Sub

Public Sub OnWorkbookLinksRefreshSmart(control As IRibbonControl)
    If WorkbookLinksSelectedLinkedCount() > 0 Then
        WorkbookLinksRefreshSelected
    Else
        WorkbookLinksRefreshAll
    End If
    RefreshWorkbookLinksRibbon
End Sub

Public Sub GetWorkbookLinksAutoRefresh(control As IRibbonControl, ByRef returnedVal)
    returnedVal = WorkbookAutoRefresh
End Sub

Public Sub OnWorkbookLinksAutoRefresh(control As IRibbonControl, pressed As Boolean)
    WorkbookLinksSetAutoRefresh pressed
    RefreshWorkbookLinksRibbon
End Sub

Public Sub OnWorkbookLinksRelinkSelected(control As IRibbonControl)
    WorkbookLinksSetNewSourceSelected
    RefreshWorkbookLinksRibbon
End Sub

Public Sub OnWorkbookLinksChangeWorkbook(control As IRibbonControl)
    WorkbookLinksChangeWorkbookSource
    RefreshWorkbookLinksRibbon
End Sub

Public Sub OnWorkbookLinksSwitchSheetChoice(control As IRibbonControl)
    WorkbookLinksSwitchSheetToSelected control.tag
    RefreshWorkbookLinksRibbon
End Sub

Public Sub GetWorkbookSwitchSheetLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = WorkbookLinksSwitchSheetLabel()
End Sub

Public Sub GetWorkbookSwitchSheetContent(control As IRibbonControl, ByRef returnedVal)
    returnedVal = WorkbookLinksSwitchSheetMenuContent()
End Sub

Public Sub OnWorkbookRefreshMode(control As IRibbonControl)
    EnsureExcelPasteDefaults
    WorkbookLinksApplyRefreshMode control.tag
    RefreshWorkbookLinksRibbon
End Sub

Public Sub OnWorkbookLinksAutoByName(control As IRibbonControl)
    WorkbookLinksAutoLinkByName
    RefreshWorkbookLinksRibbon
End Sub

Public Sub OnWorkbookLinksOpenSource(control As IRibbonControl)
    WorkbookLinksOpenSource
End Sub

Public Sub GetWorkbookSelectedTableEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (WorkbookLinksSelectedTableCount() > 0)
End Sub

Public Sub GetWorkbookSelectedLinkedEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (WorkbookLinksSelectedLinkedCount() > 0)
End Sub

Public Sub GetWorkbookSingleLinkedEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (WorkbookLinksSelectedTableCount() = 1 And _
        WorkbookLinksSelectedLinkedCount() = 1)
End Sub

Public Sub GetWorkbookAnyLinkedEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (WorkbookLinksPresentationCount() > 0)
End Sub

Public Sub GetWorkbookRefreshAllLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = "Refresh All (" & CStr(WorkbookLinksPresentationCount()) & ")"
End Sub

Public Sub GetWorkbookRefreshSmartLabel(control As IRibbonControl, ByRef returnedVal)
    Dim selectedCount As Long
    selectedCount = WorkbookLinksSelectedLinkedCount()
    If selectedCount > 0 Then
        returnedVal = "Refresh Selected (" & CStr(selectedCount) & ")"
    Else
        returnedVal = "Refresh (" & CStr(WorkbookLinksPresentationCount()) & ")"
    End If
End Sub

Public Sub GetWorkbookRefreshModeLabel(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = "Update: " & WorkbookLinksRefreshModeLabel()
End Sub

Public Sub RefreshWorkbookLinksRibbon()
    On Error Resume Next
    If AppRibbonUI Is Nothing Then Exit Sub
    AppRibbonUI.InvalidateControl "btnWorkbookLinksRefreshSmart"
    AppRibbonUI.InvalidateControl "tglWorkbookLinksAutoRefresh"
    AppRibbonUI.InvalidateControl "mnuWorkbookChangeSource"
    AppRibbonUI.InvalidateControl "mnuWorkbookRefreshMode"
    AppRibbonUI.InvalidateControl "btnWorkbookLinksOpenSource"
    AppRibbonUI.InvalidateControl "btnWorkbookLinksChooseRange"
    AppRibbonUI.InvalidateControl "dmWorkbookLinksSwitchSheet"
    AppRibbonUI.InvalidateControl "btnWorkbookLinksChangeWorkbook"
    AppRibbonUI.InvalidateControl "btnWorkbookLinksPasteLinked"
    On Error GoTo 0
End Sub

Public Sub OnScreenClipInsertNew(control As IRibbonControl)
    ScreenClipInsertNew
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnScreenClipReplaceSelected(control As IRibbonControl)
    ScreenClipReplaceSelected
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnPastePngInsertNew(control As IRibbonControl)
    PastePngInsertNew
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnPastePngReplaceSelected(control As IRibbonControl)
    PastePngReplaceSelected
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnPasteJpegInsertNew(control As IRibbonControl)
    PasteJpegInsertNew
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImagePasteLinked(control As IRibbonControl)
    ChartImagePasteLinkedFromExcel
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageUpdateSelected(control As IRibbonControl)
    ChartImageUpdateSelected
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageUpdateCurrentSlide(control As IRibbonControl)
    ChartImageUpdateCurrentSlide
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageUpdateAll(control As IRibbonControl)
    ChartImageUpdateAll
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageRefreshSmart(control As IRibbonControl)
    ChartImageRefreshSmart
    ActivateMyTab "tabReportTool"
End Sub

Public Sub GetChartImageAutoRefresh(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartAutoRefresh
End Sub

Public Sub OnChartImageAutoRefresh(control As IRibbonControl, pressed As Boolean)
    ChartImageSetAutoRefresh pressed
    RefreshChartImageRibbon
End Sub

Public Sub GetChartImageRefreshLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageRefreshLabel()
End Sub

Public Sub GetChartImageRefreshEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageRefreshEnabled()
End Sub

Public Sub GetChartImageRefreshModeLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageRefreshModeLabel()
End Sub

Public Sub GetChartImageRefreshModePressed(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageRefreshModePressed(control.tag)
End Sub

Public Sub GetChartImagePartialModeEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageRefreshPartialEnabled()
End Sub

Public Sub OnChartImageRefreshMode(control As IRibbonControl, pressed As Boolean)
    ChartImageSetRefreshMode control.tag, pressed
    RefreshChartImageRibbon
End Sub

Public Sub OnChartImageSetSource(control As IRibbonControl)
    ChartImageSetSourceFromSelection
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageChangeWorkbook(control As IRibbonControl)
    ChartImageChangeWorkbookOnly
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageChangeWorkbookSlide(control As IRibbonControl)
    ChartImageChangeWorkbookCurrentSlide
    RefreshChartImageRibbon
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageChangeWorkbookAll(control As IRibbonControl)
    ChartImageChangeWorkbookAll
    RefreshChartImageRibbon
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageOpenSource(control As IRibbonControl)
    ChartImageOpenSource
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnHyperMeshCaptureModelWindow(control As IRibbonControl)
    HyperMeshCaptureModelWindowToSlide
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnHyperMeshCaptureFocus(control As IRibbonControl)
    HyperMeshCaptureFocusToSlide
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnHyperMeshCaptureCustom(control As IRibbonControl)
    HyperMeshCaptureCustomToSlide
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnHyperMeshGetModelInfo(control As IRibbonControl)
    HyperMeshGetModelInfoToSlide
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnChartImageSwitchSheetChoice(control As IRibbonControl)
    ChartImageSwitchSheetToSelected control.tag
    RefreshChartImageRibbon
End Sub

Public Sub GetChartImageSwitchSheetLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageSwitchSheetLabel()
End Sub

Public Sub GetChartImageSwitchSheetContent(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageSwitchSheetMenuContent()
End Sub

Public Sub GetChartImageWorkbookLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageWorkbookLabel()
End Sub

Public Sub GetChartImageWorkbookSupertip(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ChartImageWorkbookSupertip()
End Sub

Public Sub GetChartImageSelectedEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (ChartImageSelectedLinkedCount() > 0)
End Sub

Public Sub GetChartImageAnyEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (ChartImagePresentationLinkedCount() > 0)
End Sub

Public Sub GetChartImageSlideEnabled(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (ChartImageSlideLinkedCount() > 0)
End Sub

Public Sub RefreshChartImageRibbon()
    On Error Resume Next
    If AppRibbonUI Is Nothing Then Exit Sub
    AppRibbonUI.InvalidateControl "btnChartImageRefreshSmart"
    AppRibbonUI.InvalidateControl "btnChartImageRefreshSelected"
    AppRibbonUI.InvalidateControl "btnChartImageRefreshSlide"
    AppRibbonUI.InvalidateControl "btnChartImageRefreshAll"
    AppRibbonUI.InvalidateControl "mnuChartImageRefreshMode"
    AppRibbonUI.InvalidateControl "tglChartImageModeFull"
    AppRibbonUI.InvalidateControl "tglChartImageModeDataAppearance"
    AppRibbonUI.InvalidateControl "tglChartImageAutoRefresh"
    AppRibbonUI.InvalidateControl "btnChartImageSetSource"
    AppRibbonUI.InvalidateControl "mnuChartImageChangeSource"
    AppRibbonUI.InvalidateControl "dmChartImageSwitchSheet"
    AppRibbonUI.InvalidateControl "btnChartImageChangeWorkbook"
    AppRibbonUI.InvalidateControl "btnChartImageChangeWorkbookSlide"
    AppRibbonUI.InvalidateControl "btnChartImageChangeWorkbookAll"
    AppRibbonUI.InvalidateControl "btnChartImageOpenSource"
    AppRibbonUI.InvalidateControl "grpChartSource"
    AppRibbonUI.InvalidateControl "btnChartImagePasteLinked"
    On Error GoTo 0
End Sub

Public Sub OnExportPptx(control As IRibbonControl)
    ExportActivePresentationToPptx
    ActivateMyTab "tabReportTool"
End Sub

Public Sub OnAlignObjectsLeft(control As IRibbonControl)
    AlignObjectsLeft
End Sub

Public Sub OnAlignObjectsCenter(control As IRibbonControl)
    AlignObjectsCenter
End Sub

Public Sub OnAlignObjectsRight(control As IRibbonControl)
    AlignObjectsRight
End Sub

Public Sub OnAlignObjectsTop(control As IRibbonControl)
    AlignObjectsTop
End Sub

Public Sub OnAlignObjectsMiddle(control As IRibbonControl)
    AlignObjectsMiddle
End Sub

Public Sub OnAlignObjectsBottom(control As IRibbonControl)
    AlignObjectsBottom
End Sub

Public Sub OnDistributeObjectsHorizontal(control As IRibbonControl)
    DistributeObjectsHorizontal
End Sub

Public Sub OnDistributeObjectsVertical(control As IRibbonControl)
    DistributeObjectsVertical
End Sub

Public Sub OnSameObjectHeight(control As IRibbonControl)
    SameObjectHeight
End Sub

Public Sub OnSameObjectWidth(control As IRibbonControl)
    SameObjectWidth
End Sub

Public Sub OnSameObjectHeightAndWidth(control As IRibbonControl)
    SameObjectHeightAndWidth
End Sub

Public Sub OnRemoveHorizontalGapLeft(control As IRibbonControl)
    RemoveHorizontalGapLeft
End Sub

Public Sub OnRemoveHorizontalGapRight(control As IRibbonControl)
    RemoveHorizontalGapRight
End Sub

Public Sub OnIncreaseHorizontalGap(control As IRibbonControl)
    IncreaseHorizontalGap
End Sub

Public Sub OnDecreaseHorizontalGap(control As IRibbonControl)
    DecreaseHorizontalGap
End Sub

Public Sub OnRemoveVerticalGapUp(control As IRibbonControl)
    RemoveVerticalGapUp
End Sub

Public Sub OnRemoveVerticalGapDown(control As IRibbonControl)
    RemoveVerticalGapDown
End Sub

Public Sub OnIncreaseVerticalGap(control As IRibbonControl)
    IncreaseVerticalGap
End Sub

Public Sub OnDecreaseVerticalGap(control As IRibbonControl)
    DecreaseVerticalGap
End Sub

Public Sub OnResizeAndSpaceHorizontalEven(control As IRibbonControl)
    ResizeAndSpaceHorizontalEven
End Sub

Public Sub OnResizeAndSpaceVerticalEven(control As IRibbonControl)
    ResizeAndSpaceVerticalEven
End Sub

Public Sub GetImageReplaceFitMode(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (control.tag = CurrentImageReplaceFitMode())
End Sub

Public Sub OnImageReplaceFitMode(control As IRibbonControl, pressed As Boolean)
    ImageReplaceFitMode = control.tag
    RefreshImageReplaceFitUI
End Sub

Private Sub RefreshImageReplaceFitUI()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "chkImageFitExact"
        AppRibbonUI.InvalidateControl "chkImageFitWidth"
        AppRibbonUI.InvalidateControl "chkImageFitHeight"
    End If
    On Error GoTo 0
End Sub

Public Sub OnFillPptTableDefault(control As IRibbonControl)
    EnsureFillDefaults
    FillPptTableFromExcelOptions FillMatchMode, FillKeepFontName, _
        FillKeepFontSize, FillKeepTextColor, FillKeepCellFill
End Sub

Public Sub OnFillPptTableMode(control As IRibbonControl)
    EnsureFillDefaults
    Select Case control.tag
        Case "Refresh"
            RefreshSelectedPptTable
        Case Else
            FillPptTableFromExcel control.tag, _
                (FillKeepFontName Or FillKeepFontSize Or _
                 FillKeepTextColor Or FillKeepCellFill)
    End Select
End Sub

Public Sub OnRefreshPptTable(control As IRibbonControl)
    RefreshSelectedPptTable
End Sub

Public Sub GetExcelPasteLabel(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    If ExcelPastePlacement = "Replace" Then
        returnedVal = "Replace Excel"
    Else
        returnedVal = "Paste Excel"
    End If
End Sub

Public Sub GetExcelPlacement(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelPastePlacement
End Sub

Public Sub OnExcelPlacementChange(control As IRibbonControl, selectedId As String, selectedIndex As Integer)
    EnsureExcelPasteDefaults
    ExcelPastePlacement = selectedId
End Sub

Public Sub GetExcelPasteTargetFlag(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = (ExcelPastePlacement = control.tag)
End Sub

Public Sub OnExcelPasteTargetChange(control As IRibbonControl, pressed As Boolean)
    EnsureExcelPasteDefaults
    ExcelPastePlacement = control.tag
    RefreshExcelPasteUI
End Sub

Public Sub GetExcelFirstRowHeader(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelFirstRowHeader
End Sub

Public Sub OnExcelFirstRowHeaderChange(control As IRibbonControl, pressed As Boolean)
    EnsureExcelPasteDefaults
    ExcelFirstRowHeader = pressed
End Sub

Public Sub GetExcelKeepSourceStyle(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelKeepSourceStyle
End Sub

Public Sub OnExcelKeepSourceStyleChange(control As IRibbonControl, pressed As Boolean)
    EnsureExcelPasteDefaults
    ExcelKeepSourceStyle = pressed
End Sub

Public Sub GetExcelKeepFont(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelKeepFont
End Sub

Public Sub OnExcelKeepFontChange(control As IRibbonControl, pressed As Boolean)
    EnsureExcelPasteDefaults
    ExcelKeepFont = pressed
    RefreshExcelPasteUI
End Sub

Public Sub GetExcelForceFont(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelForceFontText
End Sub

Public Sub OnExcelForceFontChange(control As IRibbonControl, selectedId As String, selectedIndex As Integer)
    EnsureExcelPasteDefaults
    ExcelForceFontText = selectedId
    RememberExcelFont ExcelForceFontText
End Sub

Public Sub GetExcelForceFontText(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelForceFontText
End Sub

Public Sub OnExcelForceFontTextChange(control As IRibbonControl, text As String)
    EnsureExcelPasteDefaults
    ExcelForceFontText = Trim$(text)
    RememberExcelFont ExcelForceFontText
    RefreshExcelPasteUI
End Sub

Public Sub GetExcelForcedFontButtonLabel(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = "Font: " & ExcelForceFontName()
End Sub

Public Sub OnExcelSetForcedFont(control As IRibbonControl)
    EnsureExcelPasteDefaults
    Dim enteredFont As String
    enteredFont = InputBox("Enter PowerPoint font name for pasted Excel tables.", _
        "Paste Table Font", ExcelForceFontName())
    enteredFont = Trim$(enteredFont)
    If Len(enteredFont) = 0 Then Exit Sub
    ExcelForceFontText = enteredFont
    ExcelKeepFont = False
    RememberExcelFont ExcelForceFontText
    RefreshExcelPasteUI
End Sub

Public Sub GetExcelFontItemCount(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelFontCount()
End Sub

Public Sub GetExcelFontItemLabel(control As IRibbonControl, index As Integer, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelFontAtIndex(index)
End Sub

Public Sub GetExcelFontItemID(control As IRibbonControl, index As Integer, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = "ExcelFont" & CStr(index)
End Sub

Public Sub GetExcelForceSize(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelForceSizeText
End Sub

Public Sub OnExcelForceSizeChange(control As IRibbonControl, selectedId As String, selectedIndex As Integer)
    EnsureExcelPasteDefaults
    ExcelForceSizeText = selectedId
End Sub

Public Sub OnExcelForceSizePreset(control As IRibbonControl)
    EnsureExcelPasteDefaults
    ExcelForceSizeText = Trim$(control.tag)
    ExcelUseForceSize = True
    ExcelKeepFont = False
    RefreshExcelPasteUI
End Sub

Public Sub GetExcelForceSizeText(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelForceSizeText
End Sub

Public Sub OnExcelForceSizeTextChange(control As IRibbonControl, text As String)
    EnsureExcelPasteDefaults
    ExcelForceSizeText = Trim$(text)
End Sub

Public Sub GetExcelForceFontEnabled(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = Not ExcelKeepFont
End Sub

Public Sub GetExcelUseForceSize(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = ExcelUseForceSize
End Sub

Public Sub OnExcelUseForceSizeChange(control As IRibbonControl, pressed As Boolean)
    EnsureExcelPasteDefaults
    ExcelUseForceSize = pressed
    RefreshExcelPasteUI
End Sub

Public Sub GetExcelForceSizeEnabled(control As IRibbonControl, ByRef returnedVal)
    EnsureExcelPasteDefaults
    returnedVal = (Not ExcelKeepFont) And ExcelUseForceSize
End Sub

Public Sub OnExcelUsePptFont(control As IRibbonControl)
    EnsureExcelPasteDefaults

    Dim fontObj As Object
    Set fontObj = ResolveExcelSelectedPptFont()
    If fontObj Is Nothing Then
        ShowError "Select PowerPoint text, a text box, or a table cell first."
        Exit Sub
    End If

    On Error Resume Next
    ExcelForceFontText = CStr(fontObj.name)
    ExcelForceSizeText = CStr(CSng(fontObj.Size))
    On Error GoTo 0

    If Len(ExcelForceFontText) = 0 Then ExcelForceFontText = "Calibri"
    If val(ExcelForceSizeText) <= 0 Then ExcelForceSizeText = "11"
    RememberExcelFont ExcelForceFontText
    ExcelKeepFont = False
    ExcelUseForceSize = True
    RefreshExcelPasteUI
End Sub

Public Sub OnExcelFontSettings(control As IRibbonControl)
    EnsureExcelPasteDefaults

    Dim currentList As String
    currentList = Replace(ExcelRecentFonts, "|", ", ")

    Dim enteredList As String
    enteredList = InputBox( _
        "Enter default font suggestions, separated by comma, semicolon, or pipe.", _
        "Paste Table Fonts", _
        currentList)

    If Len(Trim$(enteredList)) = 0 Then Exit Sub

    Dim normalizedList As String
    normalizedList = NormalizeExcelFontList(enteredList)
    If Len(normalizedList) = 0 Then
        ShowError "Enter at least one font name."
        Exit Sub
    End If

    ExcelRecentFonts = normalizedList
    SaveExcelFontList
    RefreshExcelPasteUI
End Sub

Private Sub EnsureExcelPasteDefaults()
    If ExcelPasteInitialized Then Exit Sub
    ExcelPasteMode = "Table"
    ExcelPastePlacement = "Original"
    ExcelFirstRowHeader = False
    ExcelKeepSourceStyle = True
    ExcelKeepFont = True
    ExcelForceFontText = "Calibri"
    ExcelForceSizeText = "11"
    ExcelUseForceSize = True
    ExcelLinkData = True
    ExcelLinkFont = False
    ExcelLinkSize = False
    ExcelLinkTextColor = False
    ExcelLinkCellFill = False
    ExcelRecentFonts = LoadExcelFontList()
    ExcelPasteInitialized = True
End Sub

Private Sub RememberExcelFont(ByVal fontName As String)
    fontName = Trim$(fontName)
    If Len(fontName) = 0 Then Exit Sub

    Dim parts() As String
    parts = Split(ExcelRecentFonts, "|")

    Dim rebuilt As String
    Dim item As Variant
    rebuilt = fontName
    For Each item In parts
        If Len(Trim$(CStr(item))) > 0 Then
            If StrComp(Trim$(CStr(item)), fontName, vbTextCompare) <> 0 Then
                If ExcelFontCountFromText(rebuilt) < 12 Then _
                    rebuilt = rebuilt & "|" & Trim$(CStr(item))
            End If
        End If
    Next item
    ExcelRecentFonts = rebuilt
    SaveExcelFontList
End Sub

Private Function LoadExcelFontList() As String
    On Error Resume Next
    Dim savedList As String
    savedList = ActivePresentation.Tags.item(EXCEL_FONT_TAG)
    On Error GoTo 0

    savedList = NormalizeExcelFontList(savedList)
    If Len(savedList) = 0 Then savedList = DEFAULT_EXCEL_FONTS
    LoadExcelFontList = savedList
End Function

Private Sub SaveExcelFontList()
    On Error Resume Next
    If Presentations.count = 0 Then Exit Sub
    ActivePresentation.Tags.Add EXCEL_FONT_TAG, ExcelRecentFonts
    On Error GoTo 0
End Sub

Private Function NormalizeExcelFontList(ByVal listText As String) As String
    listText = Replace(listText, vbCrLf, "|")
    listText = Replace(listText, vbCr, "|")
    listText = Replace(listText, vbLf, "|")
    listText = Replace(listText, ";", "|")
    listText = Replace(listText, ",", "|")

    Dim parts() As String
    Dim item As Variant
    Dim fontName As String
    Dim result As String
    parts = Split(listText, "|")

    For Each item In parts
        fontName = Trim$(CStr(item))
        If Len(fontName) > 0 Then
            If Not ExcelFontListContains(result, fontName) Then
                If ExcelFontCountFromText(result) < 20 Then
                    If Len(result) > 0 Then result = result & "|"
                    result = result & fontName
                End If
            End If
        End If
    Next item
    NormalizeExcelFontList = result
End Function

Private Function ExcelFontListContains(ByVal listText As String, _
                                       ByVal fontName As String) As Boolean
    Dim parts() As String
    Dim item As Variant
    parts = Split(listText, "|")
    For Each item In parts
        If StrComp(Trim$(CStr(item)), fontName, vbTextCompare) = 0 Then
            ExcelFontListContains = True
            Exit Function
        End If
    Next item
End Function

Private Function ExcelFontCount() As Long
    ExcelFontCount = ExcelFontCountFromText(ExcelRecentFonts)
End Function

Private Function ExcelFontCountFromText(ByVal listText As String) As Long
    Dim parts() As String
    Dim item As Variant
    parts = Split(listText, "|")
    For Each item In parts
        If Len(Trim$(CStr(item))) > 0 Then _
            ExcelFontCountFromText = ExcelFontCountFromText + 1
    Next item
End Function

Private Function ExcelFontAtIndex(ByVal index As Long) As String
    Dim parts() As String
    Dim item As Variant
    Dim currentIndex As Long
    parts = Split(ExcelRecentFonts, "|")
    currentIndex = 0
    For Each item In parts
        If Len(Trim$(CStr(item))) > 0 Then
            If currentIndex = index Then
                ExcelFontAtIndex = Trim$(CStr(item))
                Exit Function
            End If
            currentIndex = currentIndex + 1
        End If
    Next item
    ExcelFontAtIndex = "Calibri"
End Function

Private Function ExcelForceFontName() As String
    If Len(Trim$(ExcelForceFontText)) > 0 Then
        ExcelForceFontName = Trim$(ExcelForceFontText)
    Else
        ExcelForceFontName = "Calibri"
    End If
End Function

Private Function ExcelForceFontSize() As Single
    Dim sizeValue As Single
    Dim rawText As String
    rawText = Replace(Trim$(ExcelForceSizeText), ",", ".")
    sizeValue = CSng(val(rawText))
    If sizeValue <= 0 Then sizeValue = 11
    ExcelForceFontSize = sizeValue
End Function

Private Function ExcelForcedSizeForPaste() As Single
    If ExcelUseForceSize Then
        ExcelForcedSizeForPaste = ExcelForceFontSize()
    Else
        ExcelForcedSizeForPaste = 0
    End If
End Function

Private Function ResolveExcelSelectedPptFont() As Object
    On Error Resume Next
    Dim sel As Selection
    Set sel = ActiveWindow.Selection

    Set ResolveExcelSelectedPptFont = sel.TextRange.Font
    If Err.Number = 0 And Not ResolveExcelSelectedPptFont Is Nothing Then Exit Function
    Err.Clear

    Dim shp As Shape
    Set shp = GetActiveShape()
    If shp Is Nothing Then Exit Function

    If shp.HasTable Then
        Dim tbl As Table
        Set tbl = shp.Table
        Dim r As Long, c As Long
        Dim cel As Object
        Dim isSelected As Boolean
        For r = 1 To tbl.rows.count
            For c = 1 To tbl.Columns.count
                Err.Clear
                Set cel = tbl.cell(r, c)
                isSelected = False
                isSelected = CBool(cel.Selected)
                If Err.Number = 0 And isSelected Then
                    Set ResolveExcelSelectedPptFont = cel.Shape.TextFrame.TextRange.Font
                    Exit Function
                End If
            Next c
        Next r
        Set ResolveExcelSelectedPptFont = tbl.cell(1, 1).Shape.TextFrame.TextRange.Font
        Exit Function
    End If

    If shp.HasTextFrame Then
        If shp.TextFrame.HasText Then
            Set ResolveExcelSelectedPptFont = shp.TextFrame.TextRange.Font
        End If
    End If
    On Error GoTo 0
End Function

Private Sub EnsureFillDefaults()
    If FillInitialized Then Exit Sub
    FillMatchMode = "Position"
    FillKeepFontName = False
    FillKeepFontSize = False
    FillKeepTextColor = False
    FillKeepCellFill = False
    FillInitialized = True
End Sub

Public Sub GetFillMatchMode(control As IRibbonControl, ByRef returnedVal)
    EnsureFillDefaults
    returnedVal = FillMatchMode
End Sub

Public Sub OnFillMatchModeChange(control As IRibbonControl, selectedId As String, selectedIndex As Integer)
    EnsureFillDefaults
    FillMatchMode = selectedId
End Sub

Public Sub GetFillMatchFlag(control As IRibbonControl, ByRef returnedVal)
    EnsureFillDefaults
    returnedVal = (FillMatchMode = control.tag)
End Sub

Public Sub OnFillMatchFlagChange(control As IRibbonControl, pressed As Boolean)
    EnsureFillDefaults
    FillMatchMode = control.tag
    RefreshFillMatchUI
End Sub

Public Sub GetFillTableFlag(control As IRibbonControl, ByRef returnedVal)
    EnsureFillDefaults
    Select Case control.tag
        Case "FontName":   returnedVal = FillKeepFontName
        Case "FontSize":   returnedVal = FillKeepFontSize
        Case "TextColor":  returnedVal = FillKeepTextColor
        Case "CellFill":   returnedVal = FillKeepCellFill
    End Select
End Sub

Public Sub OnFillTableFlagChange(control As IRibbonControl, pressed As Boolean)
    EnsureFillDefaults
    Select Case control.tag
        Case "FontName":   FillKeepFontName = pressed
        Case "FontSize":   FillKeepFontSize = pressed
        Case "TextColor":  FillKeepTextColor = pressed
        Case "CellFill":   FillKeepCellFill = pressed
    End Select
End Sub

Private Sub RefreshFillMatchUI()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "chkFillMatchPosition"
        AppRibbonUI.InvalidateControl "chkFillMatchHeaders"
        AppRibbonUI.InvalidateControl "chkFillMatchRows"
        AppRibbonUI.InvalidateControl "chkFillMatchBoth"
    End If
    On Error GoTo 0
End Sub

Private Sub RefreshExcelPasteUI()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "btnPasteFromExcel"
        AppRibbonUI.InvalidateControl "chkExcelPasteNewTable"
        AppRibbonUI.InvalidateControl "chkExcelPasteReplace"
        AppRibbonUI.InvalidateControl "chkExcelKeepFont"
        AppRibbonUI.InvalidateControl "cbExcelForceFont"
        AppRibbonUI.InvalidateControl "btnExcelSetForcedFont"
        AppRibbonUI.InvalidateControl "chkExcelUseForceSize"
        AppRibbonUI.InvalidateControl "cbExcelForceSize"
        AppRibbonUI.InvalidateControl "btnExcelForceSize9"
        AppRibbonUI.InvalidateControl "btnExcelForceSize10"
        AppRibbonUI.InvalidateControl "btnExcelForceSize11"
        AppRibbonUI.InvalidateControl "btnExcelForceSize12"
        AppRibbonUI.InvalidateControl "btnExcelForceSize14"
        AppRibbonUI.InvalidateControl "btnExcelForceSize16"
        AppRibbonUI.InvalidateControl "btnExcelForceSize18"
        AppRibbonUI.InvalidateControl "btnExcelForceSize20"
        AppRibbonUI.InvalidateControl "btnExcelForceSize24"
    End If
    On Error GoTo 0
End Sub

' ===== Group 2: Object Format ====================================

Public Sub OnApplyStyle(control As IRibbonControl)
    ObjectApplyCorporateStyle
End Sub

Public Sub OnClearBorders(control As IRibbonControl)
    ObjectClearBorders
End Sub

Public Sub OnClearBackgrounds(control As IRibbonControl)
    ObjectClearBackgrounds
End Sub

' ===== Group 3: Text Style =======================================

Public Sub GetScopeSelected(control As IRibbonControl, ByRef returnedVal)
    If FontScopeID = "" Then FontScopeID = "scopeAll"
    returnedVal = FontScopeID
End Sub

Public Sub OnScopeChange(control As IRibbonControl, id As String, idx As Integer)
    FontScopeID = id
End Sub

Public Sub OnSyncFont(control As IRibbonControl)
    Select Case FontScopeID
        Case "scopeCurrent":  BatchSyncFontCurrent
        Case "scopeSelected": BatchSyncFontSelected
        Case Else:            BatchSyncFontAll
    End Select
End Sub

Public Sub OnTextStyleCapture(control As IRibbonControl)
    TextStyleCapture
End Sub

Public Sub OnTextStyleApplyDefault(control As IRibbonControl)
    Select Case CurrentTextStyleScope()
        Case "Current":  TextStyleApplyCurrentSlide
        Case "Selected": TextStyleApplySelectedSlides
        Case "All":      TextStyleApplyAllSlides
        Case Else:       TextStyleApplySelection
    End Select
End Sub

Public Sub GetTextStyleApplyLabel(control As IRibbonControl, ByRef returnedVal)
    Select Case CurrentTextStyleScope()
        Case "Current":  returnedVal = "Apply Slide"
        Case "Selected": returnedVal = "Apply Slides"
        Case "All":      returnedVal = "Apply All"
        Case Else:       returnedVal = "Apply Selection"
    End Select
End Sub

Public Sub GetTextStyleScope(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (control.tag = CurrentTextStyleScope())
End Sub

Public Sub OnTextStyleScopeChange(control As IRibbonControl, pressed As Boolean)
    TextStyleScopeID = control.tag
    RefreshTextStyleScopeUI
End Sub

Private Function CurrentTextStyleScope() As String
    If TextStyleScopeID = "" Then TextStyleScopeID = "Selection"
    CurrentTextStyleScope = TextStyleScopeID
End Function

Private Sub RefreshTextStyleScopeUI()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "btnTextStyleApply"
        AppRibbonUI.InvalidateControl "chkTextStyleScopeSelection"
        AppRibbonUI.InvalidateControl "chkTextStyleScopeCurrent"
        AppRibbonUI.InvalidateControl "chkTextStyleScopeSelected"
        AppRibbonUI.InvalidateControl "chkTextStyleScopeAll"
    End If
    On Error GoTo 0
End Sub

Public Sub GetTextStyleFlag(control As IRibbonControl, ByRef returnedVal)
    If Not (IncludeTextFont Or IncludeTextSize Or IncludeTextColor Or IncludeTextEmphasis) Then
        IncludeTextFont = True
        IncludeTextSize = True
        IncludeTextColor = True
        IncludeTextEmphasis = True
    End If

    Select Case control.tag
        Case "Font":     returnedVal = IncludeTextFont
        Case "Size":     returnedVal = IncludeTextSize
        Case "Color":    returnedVal = IncludeTextColor
        Case "Emphasis": returnedVal = IncludeTextEmphasis
    End Select
End Sub

Public Sub OnTextStyleFlagChange(control As IRibbonControl, pressed As Boolean)
    Select Case control.tag
        Case "Font":     IncludeTextFont = pressed
        Case "Size":     IncludeTextSize = pressed
        Case "Color":    IncludeTextColor = pressed
        Case "Emphasis": IncludeTextEmphasis = pressed
    End Select
End Sub

' ===== Group 4: Object Copy ======================================
' One generic checkBox callback pair, dispatched by control.Tag.
' This keeps the ribbon XML compact (no separate callback per attribute).

Public Sub OnCopyShape(control As IRibbonControl)
    CopyShape
    ActivateMyTab "tabArrange"
End Sub

Public Sub OnPasteShape(control As IRibbonControl)
    PasteShape
    ActivateMyTab "tabArrange"
End Sub

' ===== Group 5: Balloon Callouts =================================

Public Sub OnBalloonConvertSelectedLines(control As IRibbonControl)
    BalloonConvertSelectedLines
End Sub

Public Sub OnBalloonDrawLine(control As IRibbonControl, pressed As Boolean)
    BalloonToggleDrawMode pressed
End Sub

Public Sub GetBalloonDrawPressed(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDrawModeIsActive()
End Sub

Public Sub OnBalloonAddOne(control As IRibbonControl)
    BalloonAddOne
End Sub

Public Sub OnBalloonRenumberSlide(control As IRibbonControl)
    BalloonRenumberSlide
End Sub

Public Sub OnBalloonRenumberSelected(control As IRibbonControl)
    BalloonRenumberSelected
End Sub

Public Sub GetBalloonRenumberNextText(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonRenumberNextText()
End Sub

Public Sub OnBalloonRenumberNextChange(control As IRibbonControl, ByVal text As String)
    BalloonSetRenumberNextText text
End Sub

Public Sub GetBalloonClickNumber(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonClickNumberActive()
End Sub

Public Sub OnBalloonClickNumber(control As IRibbonControl, pressed As Boolean)
    BalloonClickNumberStart pressed
End Sub

Public Sub OnNumberInsert(control As IRibbonControl, pressed As Boolean)
    NumberInsertToggle pressed
End Sub

Public Sub GetNumberInsertPressed(control As IRibbonControl, ByRef returnedVal)
    returnedVal = NumberInsertIsActive()
End Sub

Public Sub OnNumberInsertScopeChange(control As IRibbonControl, pressed As Boolean)
    NumberInsertSetScope (control.tag = "All")
End Sub

Public Sub GetNumberInsertScope(control As IRibbonControl, ByRef returnedVal)
    If control.tag = "All" Then
        returnedVal = NumberInsertScopeIsAll()
    Else
        returnedVal = Not NumberInsertScopeIsAll()
    End If
End Sub

Public Sub OnNumberInsertSelectAll(control As IRibbonControl)
    NumberInsertSelectAll
End Sub

Public Sub GetNumberShapeMode(control As IRibbonControl, ByRef returnedVal)
    If control.tag = "Square" Then
        returnedVal = NumberInsertShapeIsSquare()
    Else
        returnedVal = Not NumberInsertShapeIsSquare()
    End If
End Sub

Public Sub OnNumberShapeMode(control As IRibbonControl, pressed As Boolean)
    NumberInsertSetShape (control.tag = "Square")
End Sub

Public Sub OnNumberCaptureDefault(control As IRibbonControl)
    NumberInsertCaptureSelectedAsDefault
End Sub

Public Sub OnBalloonApplyStandardStyle(control As IRibbonControl)
    BalloonApplyStandardStyle
End Sub

Public Sub OnBalloonSelectAll(control As IRibbonControl)
    SelectAllBalloonsOnSlide
End Sub

Public Sub OnBalloonAlignLabelsLeft(control As IRibbonControl)
    BalloonAlignLabelsLeft
End Sub

Public Sub OnBalloonAlignLabelsRight(control As IRibbonControl)
    BalloonAlignLabelsRight
End Sub

Public Sub OnBalloonAlignLabelsTop(control As IRibbonControl)
    BalloonAlignLabelsTop
End Sub

Public Sub OnBalloonAlignLabelsBottom(control As IRibbonControl)
    BalloonAlignLabelsBottom
End Sub

Public Sub OnBalloonDistributeLabelsHorizontal(control As IRibbonControl)
    BalloonDistributeLabelsHorizontal
End Sub

Public Sub OnBalloonDistributeLabelsVertical(control As IRibbonControl)
    BalloonDistributeLabelsVertical
End Sub

Public Sub OnBalloonNudgeLabelsLeft(control As IRibbonControl)
    BalloonNudgeLabelsLeft
End Sub

Public Sub OnBalloonNudgeLabelsRight(control As IRibbonControl)
    BalloonNudgeLabelsRight
End Sub

Public Sub OnBalloonNudgeLabelsUp(control As IRibbonControl)
    BalloonNudgeLabelsUp
End Sub

Public Sub OnBalloonNudgeLabelsDown(control As IRibbonControl)
    BalloonNudgeLabelsDown
End Sub

Public Sub OnBalloonCaptureStyle(control As IRibbonControl)
    BalloonCaptureSelectedStyleAsDefault
End Sub

' --- Draw Balloon shape mode: Circle or Square ---
Public Sub GetBalloonDrawLabel(control As IRibbonControl, ByRef returnedVal)
    If BalloonDrawShapeIsSquare() Then
        returnedVal = "Draw Balloon (Square)"
    Else
        returnedVal = "Draw Balloon (Circle)"
    End If
End Sub

Public Sub GetBalloonDrawShapeMode(control As IRibbonControl, ByRef returnedVal)
    If control.tag = "Square" Then
        returnedVal = BalloonDrawShapeIsSquare()
    Else
        returnedVal = Not BalloonDrawShapeIsSquare()
    End If
End Sub

Public Sub OnBalloonDrawShapeMode(control As IRibbonControl, pressed As Boolean)
    BalloonSetDrawShape (control.tag = "Square")
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "chkBalloonDrawCircle"
        AppRibbonUI.InvalidateControl "chkBalloonDrawSquare"
        AppRibbonUI.InvalidateControl "btnBalloonDrawLine"
    End If
    On Error GoTo 0
End Sub

' --- Set Default: one button, target toggles between Balloon and Table ---
Private Function BalloonCurrentSetDefaultTarget() As String
    If BalloonSetDefaultTarget = "Table" Then
        BalloonCurrentSetDefaultTarget = "Table"
    Else
        BalloonCurrentSetDefaultTarget = "Balloon"
    End If
End Function

Public Sub GetBalloonSetDefaultLabel(control As IRibbonControl, ByRef returnedVal)
    If BalloonCurrentSetDefaultTarget() = "Table" Then
        returnedVal = "Set Default Table"
    Else
        returnedVal = "Set Default Balloon"
    End If
End Sub

Public Sub OnBalloonSetDefault(control As IRibbonControl)
    If BalloonCurrentSetDefaultTarget() = "Table" Then
        BalloonListSaveSelectedTableAsStandard
    Else
        BalloonCaptureSelectedStyleAsDefault
    End If
End Sub

Public Sub GetBalloonSetDefaultTarget(control As IRibbonControl, ByRef returnedVal)
    returnedVal = (BalloonCurrentSetDefaultTarget() = control.tag)
End Sub

Public Sub OnBalloonSetDefaultTargetChange(control As IRibbonControl, pressed As Boolean)
    BalloonSetDefaultTarget = control.tag
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "btnBalloonSetDefault"
        AppRibbonUI.InvalidateControl "chkBalloonDefTargetBalloon"
        AppRibbonUI.InvalidateControl "chkBalloonDefTargetTable"
    End If
    On Error GoTo 0
End Sub

Public Sub OnBalloonApplyDefaultStyle(control As IRibbonControl)
    BalloonApplyDefaultStyleSelected
End Sub

Public Sub OnBalloonApplyDefaultStyleSlide(control As IRibbonControl)
    BalloonApplyDefaultStyleSlide
End Sub

Public Sub OnBalloonResetDefaultStyle(control As IRibbonControl)
    BalloonResetDefaultStyle
End Sub

Public Sub GetBalloonLabelSizeText(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDefaultLabelSizeText()
End Sub

Public Sub OnBalloonLabelSizeChange(control As IRibbonControl, ByVal text As String)
    BalloonSetDefaultLabelSize text
End Sub

Public Sub GetBalloonFontSizeText(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDefaultFontSizeText()
End Sub

Public Sub OnBalloonFontSizeChange(control As IRibbonControl, ByVal text As String)
    BalloonSetDefaultFontSize text
End Sub

Public Sub GetBalloonLineWeightText(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDefaultLeaderWeightText()
End Sub

Public Sub OnBalloonLineWeightChange(control As IRibbonControl, ByVal text As String)
    BalloonSetDefaultLeaderWeight text
End Sub

Public Sub GetBalloonDashIndex(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDefaultDashIndex()
End Sub

Public Sub OnBalloonDashChange(control As IRibbonControl, _
                               selectedId As String, _
                               selectedIndex As Integer)
    BalloonSetDefaultDash selectedIndex
End Sub

Public Sub GetBalloonDashID(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDefaultDashID()
End Sub

Public Sub OnBalloonDashIDChange(control As IRibbonControl, _
                                 selectedId As String, _
                                 selectedIndex As Integer)
    BalloonSetDefaultDashByID selectedId
End Sub

Public Sub GetBalloonMarkerIndex(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDefaultMarkerIndex()
End Sub

Public Sub OnBalloonMarkerChange(control As IRibbonControl, _
                                 selectedId As String, _
                                 selectedIndex As Integer)
    BalloonSetDefaultMarker selectedIndex
End Sub

Public Sub GetBalloonMarkerID(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDefaultMarkerID()
End Sub

Public Sub OnBalloonMarkerIDChange(control As IRibbonControl, _
                                   selectedId As String, _
                                   selectedIndex As Integer)
    BalloonSetDefaultMarkerByID selectedId
End Sub

Public Sub OnBalloonSizeSmall(control As IRibbonControl)
    BalloonSetDefaultLabelPreset "Small"
End Sub

Public Sub OnBalloonSizeMedium(control As IRibbonControl)
    BalloonSetDefaultLabelPreset "Medium"
End Sub

Public Sub OnBalloonSizeLarge(control As IRibbonControl)
    BalloonSetDefaultLabelPreset "Large"
End Sub

Public Sub OnBalloonArrowNone(control As IRibbonControl)
    BalloonSetDefaultArrowPreset "None"
End Sub

Public Sub OnBalloonArrowDot(control As IRibbonControl)
    BalloonSetDefaultArrowPreset "Dot"
End Sub

Public Sub OnBalloonArrowHead(control As IRibbonControl)
    BalloonSetDefaultArrowPreset "Arrow"
End Sub

Public Sub GetBalloonBold(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonDefaultBold()
End Sub

Public Sub OnBalloonBoldChange(control As IRibbonControl, pressed As Boolean)
    BalloonSetDefaultBold pressed
End Sub

Public Sub OnBalloonListOpen(control As IRibbonControl)
    BalloonListOpenManager
End Sub

Public Sub OnBalloonListSyncExcel(control As IRibbonControl)
    BalloonListRefreshFromExcel
End Sub

Public Sub OnBalloonListBuildExisting(control As IRibbonControl)
    BalloonListBuildFromExistingData
End Sub

Public Sub OnBalloonListSaveStandard(control As IRibbonControl)
    BalloonListSaveSelectedTableAsStandard
End Sub

Public Sub OnBalloonListQueueChange(control As IRibbonControl, pressed As Boolean)
    BalloonListToggleQueue pressed
End Sub

Public Sub GetBalloonListQueue(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListQueueIsActive()
End Sub

Public Sub OnBalloonListUpdateTable(control As IRibbonControl)
    BalloonListUpdateTable
End Sub

Public Sub OnBalloonListRefreshExcel(control As IRibbonControl)
    BalloonListRefreshFromExcel
End Sub

Public Sub OnBalloonListOpenSource(control As IRibbonControl)
    BalloonListOpenSourceFromRibbon
End Sub

Public Sub GetBalloonListOpenSourceLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListOpenSourceLabel()
End Sub

Public Sub GetBalloonListOpenSourceSupertip(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListOpenSourceSupertip()
End Sub

Public Sub OnBalloonListSourceDetails(control As IRibbonControl)
    BalloonListSourceDetailsFromRibbon
End Sub

Public Sub OnBalloonListSetSource(control As IRibbonControl)
    BalloonListSetSourceFromSelection
End Sub

Public Sub OnBalloonListPushOrder(control As IRibbonControl)
    BalloonListPushOrderToExcel
End Sub

Public Sub OnBalloonListWriteBack(control As IRibbonControl)
    BalloonListWriteBackToExcel
End Sub

Public Sub GetBalloonListHasSource(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListHasSavedSource()
End Sub

Public Sub GetBalloonListHasPartRows(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListHasPartRows()
End Sub

Public Sub GetBalloonListCanPushOrder(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListHasSavedSource() And BalloonListHasPartRows()
End Sub

Public Sub OnBalloonListBindExisting(control As IRibbonControl)
    BalloonListBindExistingFromRibbon
End Sub

Public Sub OnBalloonListUnlink(control As IRibbonControl)
    BalloonListUnlinkFromRibbon
End Sub

Public Sub GetBalloonListCanLink(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListCanLink()
End Sub

Public Sub GetBalloonListCanUseLinkedTools(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListCanUseLinkedTools()
End Sub

Public Sub GetBalloonListLinkLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListLinkLabel()
End Sub

Public Sub GetBalloonListSyncLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListSyncLabel()
End Sub

Public Sub GetBalloonListUnlinkLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListUnlinkLabel()
End Sub

Public Sub GetBalloonListLinkSupertip(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListLinkSupertip()
End Sub

Public Sub GetBalloonListSyncSupertip(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListSyncSupertip()
End Sub

Public Sub GetBalloonListUnlinkSupertip(control As IRibbonControl, ByRef returnedVal)
    returnedVal = BalloonListUnlinkSupertip()
End Sub

Public Sub OnBalloonListRefresh(control As IRibbonControl)
    BalloonListRefreshFromRibbon
End Sub

Public Sub OnBalloonListApplyOrder(control As IRibbonControl)
    BalloonListApplyTableOrderFromRibbon
End Sub

Public Sub OnBalloonListMoveRowDefault(control As IRibbonControl)
    EnsureBalloonListRowMoveDefault
    If BalloonListRowMoveMode = "Down" Then
        BalloonListMoveSelectedRow 1
    Else
        BalloonListMoveSelectedRow -1
    End If
End Sub

Public Sub GetBalloonListMoveRowLabel(control As IRibbonControl, ByRef returnedVal)
    EnsureBalloonListRowMoveDefault
    If BalloonListRowMoveMode = "Down" Then
        returnedVal = "Move Down"
    Else
        returnedVal = "Move Up"
    End If
End Sub

Public Sub GetBalloonListRowMoveMode(control As IRibbonControl, ByRef returnedVal)
    EnsureBalloonListRowMoveDefault
    returnedVal = (BalloonListRowMoveMode = control.tag)
End Sub

Public Sub OnBalloonListRowMoveModeChange(control As IRibbonControl, pressed As Boolean)
    EnsureBalloonListRowMoveDefault
    If pressed Then BalloonListRowMoveMode = control.tag
    RefreshBalloonListRowMoveUI
End Sub

Public Sub OnBalloonListMoveRowUp(control As IRibbonControl)
    BalloonListRowMoveMode = "Up"
    RefreshBalloonListRowMoveUI
    BalloonListMoveSelectedRow -1
End Sub

Public Sub OnBalloonListMoveRowDown(control As IRibbonControl)
    BalloonListRowMoveMode = "Down"
    RefreshBalloonListRowMoveUI
    BalloonListMoveSelectedRow 1
End Sub

Private Sub EnsureBalloonListRowMoveDefault()
    If Len(BalloonListRowMoveMode) = 0 Then BalloonListRowMoveMode = "Up"
End Sub

Private Sub RefreshBalloonListRowMoveUI()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "btnBalloonListMoveRowDefault"
        AppRibbonUI.InvalidateControl "chkBalloonListMoveRowUp"
        AppRibbonUI.InvalidateControl "chkBalloonListMoveRowDown"
    End If
    On Error GoTo 0
End Sub

Public Sub GetIncludeFlag(control As IRibbonControl, ByRef returnedVal)
    returnedVal = ReadIncludeFlag(control.tag)
End Sub

Public Sub OnIncludeFlagChange(control As IRibbonControl, pressed As Boolean)
    WriteIncludeFlag control.tag, pressed
End Sub

Private Function ReadIncludeFlag(name As String) As Boolean
    Select Case name
        Case "Position":    ReadIncludeFlag = IncludePosition
        Case "Width":       ReadIncludeFlag = IncludeWidth
        Case "Height":      ReadIncludeFlag = IncludeHeight
        Case "Rotation":    ReadIncludeFlag = IncludeRotation
        Case "LockAspect":  ReadIncludeFlag = IncludeLockAspect
        Case "Fill":        ReadIncludeFlag = IncludeFill
        Case "Line":        ReadIncludeFlag = IncludeLine
        Case "Shadow":      ReadIncludeFlag = IncludeShadow
        Case "TextFormat":  ReadIncludeFlag = IncludeTextFormat
        Case "Hyperlink":   ReadIncludeFlag = IncludeHyperlink
        Case "AltText":     ReadIncludeFlag = IncludeAltText
    End Select
End Function

Private Sub WriteIncludeFlag(name As String, val As Boolean)
    Select Case name
        Case "Position":    IncludePosition = val
        Case "Width":       IncludeWidth = val
        Case "Height":      IncludeHeight = val
        Case "Rotation":    IncludeRotation = val
        Case "LockAspect":  IncludeLockAspect = val
        Case "Fill":        IncludeFill = val
        Case "Line":        IncludeLine = val
        Case "Shadow":      IncludeShadow = val
        Case "TextFormat":  IncludeTextFormat = val
        Case "Hyperlink":   IncludeHyperlink = val
        Case "AltText":     IncludeAltText = val
    End Select
End Sub

' ===== Demo tab no-op ============================================

Public Sub OnDemoButton(control As IRibbonControl)
    EnsureDemoDefaults
    DemoClickCount = DemoClickCount + 1
    RefreshDemoUI
End Sub

Public Sub OnDemoToggle(control As IRibbonControl, pressed As Boolean)
    EnsureDemoDefaults
    Select Case control.id
        Case "dmTglLarge", "dmLiveToggle"
            DemoToggleMain = pressed
        Case Else
            DemoToggleMenu = pressed
    End Select
    RefreshDemoUI
End Sub

Public Sub GetDemoTogglePressed(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    Select Case control.id
        Case "dmTglLarge", "dmLiveToggle"
            returnedVal = DemoToggleMain
        Case Else
            returnedVal = DemoToggleMenu
    End Select
End Sub

Public Sub GetDemoToggleLabel(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    If DemoToggleMain Then
        returnedVal = "Toggle On"
    Else
        returnedVal = "Toggle Off"
    End If
End Sub

Public Sub OnDemoCheck(control As IRibbonControl, pressed As Boolean)
    EnsureDemoDefaults
    Select Case control.id
        Case "dmChkMain", "dmDynCheck"
            DemoCheckMain = pressed
        Case Else
            DemoCheckMenu = pressed
    End Select
    RefreshDemoUI
End Sub

Public Sub GetDemoCheckPressed(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    Select Case control.id
        Case "dmChkMain", "dmDynCheck"
            returnedVal = DemoCheckMain
        Case Else
            returnedVal = DemoCheckMenu
    End Select
End Sub

Public Sub OnDemoMode(control As IRibbonControl, pressed As Boolean)
    EnsureDemoDefaults
    DemoMode = control.tag
    RefreshDemoUI
End Sub

Public Sub GetDemoModePressed(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = (DemoMode = control.tag)
End Sub

Public Sub OnDemoDrop(control As IRibbonControl, selectedId As String, selectedIndex As Integer)
    EnsureDemoDefaults
    DemoDropIndex = CLng(selectedIndex)
    RefreshDemoUI
End Sub

Public Sub GetDemoDropIndex(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = DemoDropIndex
End Sub

Public Sub OnDemoComboChange(control As IRibbonControl, text As String)
    EnsureDemoDefaults
    DemoComboText = Trim$(text)
    RefreshDemoUI
End Sub

Public Sub GetDemoComboText(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = DemoComboText
End Sub

Public Sub OnDemoEditChange(control As IRibbonControl, text As String)
    EnsureDemoDefaults
    DemoEditText = Trim$(text)
    RefreshDemoUI
End Sub

Public Sub GetDemoEditText(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = DemoEditText
End Sub

Public Sub OnDemoGallery(control As IRibbonControl, selectedId As String, selectedIndex As Integer)
    EnsureDemoDefaults
    DemoGalleryIndex = CLng(selectedIndex)
    RefreshDemoUI
End Sub

Public Sub GetDemoGalleryIndex(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = DemoGalleryIndex
End Sub

Public Sub GetDemoLiveLabel(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = "Live " & CStr(DemoClickCount)
End Sub

Public Sub GetDemoLiveSupertip(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = "Callback-driven demo. Click count: " & CStr(DemoClickCount) & _
                  ". Drop index: " & CStr(DemoDropIndex) & _
                  ". Combo text: " & DemoComboText & _
                  ". Edit text: " & DemoEditText & _
                  ". No slide data is changed."
End Sub

Public Sub GetDemoStateText(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = "State: " & CStr(DemoClickCount) & _
                  " clicks, mode " & DemoMode
End Sub

Public Sub OnDemoDynamicMenu(control As IRibbonControl, ByRef returnedVal)
    EnsureDemoDefaults
    returnedVal = _
        "<menu xmlns=""http://schemas.microsoft.com/office/2006/01/customui"">" & _
        "<button id=""dmDynBtnA"" label=""Dynamic button"" imageMso=""HappyFace"" onAction=""OnDemoButton"" />" & _
        "<checkBox id=""dmDynCheck"" label=""Dynamic checkbox"" getPressed=""GetDemoCheckPressed"" onAction=""OnDemoCheck"" />" & _
        "<menuSeparator id=""dmDynSep"" />" & _
        "<button id=""dmDynBtnB"" label=""Generated at open"" imageMso=""Refresh"" onAction=""OnDemoButton"" />" & _
        "</menu>"
End Sub

Private Sub EnsureDemoDefaults()
    If DemoInitialized Then Exit Sub
    DemoMode = "A"
    DemoDropIndex = 0
    DemoComboText = "Aptos"
    DemoEditText = "demo text"
    DemoGalleryIndex = 0
    DemoInitialized = True
End Sub

Private Sub RefreshDemoUI()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "dmLiveButton"
        AppRibbonUI.InvalidateControl "dmLiveToggle"
        AppRibbonUI.InvalidateControl "dmLiveLabel"
        AppRibbonUI.InvalidateControl "dmTglLarge"
        AppRibbonUI.InvalidateControl "dmChkMain"
        AppRibbonUI.InvalidateControl "dmMenuChk"
        AppRibbonUI.InvalidateControl "dmMenuTgl"
        AppRibbonUI.InvalidateControl "dmModeA"
        AppRibbonUI.InvalidateControl "dmModeB"
        AppRibbonUI.InvalidateControl "dmModeC"
        AppRibbonUI.InvalidateControl "dmDrop"
        AppRibbonUI.InvalidateControl "dmCombo"
        AppRibbonUI.InvalidateControl "dmEdit"
        AppRibbonUI.InvalidateControl "dmGallery"
        AppRibbonUI.InvalidateControl "dmDynMenu"
    End If
    On Error GoTo 0
End Sub

