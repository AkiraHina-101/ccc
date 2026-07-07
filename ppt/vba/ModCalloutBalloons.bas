Attribute VB_Name = "ModCalloutBalloons"
Option Explicit

' Balloon callout tools for technical image annotation.
' MVP workflow: draw/select leader lines, then convert them to numbered balloons.

Private Const BALLOON_TAG_KIND As String = "ReportToolBalloon"
Private Const BALLOON_TAG_NUMBER As String = "ReportToolBalloonNumber"
Private Const BALLOON_TAG_PART_X As String = "ReportToolBalloonPartX"
Private Const BALLOON_TAG_PART_Y As String = "ReportToolBalloonPartY"
Private Const BALLOON_TAG_BUBBLE_X As String = "ReportToolBalloonBubbleX"
Private Const BALLOON_TAG_BUBBLE_Y As String = "ReportToolBalloonBubbleY"
Private Const BALLOON_DEFAULT_TAG_PREFIX As String = "ReportToolBalloonDefault"
Private Const BALLOON_DEFAULT_VERSION As String = "1"
Private Const BALLOON_KIND_GROUP As String = "Group"
Private Const BALLOON_KIND_CIRCLE As String = "Circle"
Private Const BALLOON_KIND_LEADER As String = "Leader"

Private Const BALLOON_DIAMETER As Single = 24
Private Const BALLOON_LINE_WEIGHT As Single = 1
Private Const BALLOON_FONT_SIZE As Single = 14
Private Const BALLOON_FONT_NAME As String = "Arial"

Private Type BalloonLineSpec
    partX As Single
    partY As Single
    bubbleX As Single
    bubbleY As Single
End Type

Private Type BalloonStyle
    ' Shape geometry
    LabelShapeType As Long
    LabelWidth As Single
    LabelHeight As Single
    ' Fill
    FillType As Long
    FillVisible As Long
    FillForeColor As Long
    FillBackColor As Long
    FillTransparency As Single
    FillPattern As Long
    ' Gradient (used when FillType = msoFillGradient = 3)
    GradientStyle As Long
    GradientVariant As Long
    GradientAngle As Single
    GradientColorType As Long
    GradientDegree As Single
    GradientStopCount As Long
    GradStopColor1 As Long
    GradStopPos1 As Single
    GradStopTrans1 As Single
    GradStopColor2 As Long
    GradStopPos2 As Single
    GradStopTrans2 As Single
    GradStopColor3 As Long
    GradStopPos3 As Single
    GradStopTrans3 As Single
    GradStopColor4 As Long
    GradStopPos4 As Single
    GradStopTrans4 As Single
    ' Circle border line
    LabelLineVisible As Long
    LabelLineColor As Long
    LabelLineBkColor As Long
    LabelLineWeight As Single
    LabelLineTransparency As Single
    LabelLineDash As Long
    LabelLineStyle As Long
    ' Circle shadow
    ShadowVisible As Long
    ShadowColor As Long
    ShadowTransparency As Single
    ShadowOffsetX As Single
    ShadowOffsetY As Single
    ShadowSize As Single
    ShadowBlur As Single
    ' Glow
    GlowColor As Long
    GlowRadius As Single
    GlowTransparency As Single
    ' Soft edge
    SoftEdgeType As Long
    ' Reflection
    ReflectionType As Long
    ' Font
    fontName As String
    fontSize As Single
    FontColor As Long
    FontBold As Long
    FontItalic As Long
    FontUnderline As Long
    FontStrikethrough As Long
    FontShadow As Long
    FontSpacing As Single
    FontAllCaps As Long
    FontSubscript As Long
    FontSuperscript As Long
    FontEmboss As Long
    FontEngrave As Long
    ' Leader line
    LeaderVisible As Long
    LeaderColor As Long
    LeaderBkColor As Long
    LeaderWeight As Single
    LeaderTransparency As Single
    LeaderDash As Long
    LeaderStyle As Long
    ' Leader arrowheads
    PartMarker As Long
    PartMarkerLength As Long
    PartMarkerWidth As Long
    EndMarker As Long
    EndMarkerLength As Long
    EndMarkerWidth As Long
    ' Leader shadow
    LeaderShadowVisible As Long
    LeaderShadowColor As Long
    LeaderShadowTransparency As Single
    LeaderShadowOffsetX As Single
    LeaderShadowOffsetY As Single
    LeaderShadowBlur As Single
    ' Leader glow
    LeaderGlowColor As Long
    LeaderGlowRadius As Single
    LeaderGlowTransparency As Single
End Type

Private Type BalloonInfo
    shapeName As String
    Number As Long
    partX As Single
    partY As Single
    bubbleX As Single
    bubbleY As Single
    style As BalloonStyle
End Type

Public Sub BalloonInitializeEvents()
    On Error Resume Next
    If BalloonAppEvents Is Nothing Then
        Set BalloonAppEvents = New CBalloonAppEvents
    End If
    Set BalloonAppEvents.App = Application
    On Error GoTo 0
End Sub

Public Sub BalloonStartDrawMode(Optional ByVal keepBusy As Boolean = False)
    On Error GoTo ErrHandler
    If (BalloonDrawMode Or BalloonEventBusy) And Not keepBusy Then
        Exit Sub
    End If
    If BalloonClickNumberMode Then BalloonClickNumberStop

    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then
        ShowError "Open a slide first."
        Exit Sub
    End If

    BalloonInitializeEvents
    BalloonDrawMode = True
    If Not keepBusy Then BalloonEventBusy = False
    BalloonDrawSlideID = sld.slideId
    BalloonDrawShapeCount = sld.shapes.count

    Application.CommandBars.ExecuteMso "ShapeStraightConnector"
    RefreshBalloonDrawRibbon
    Exit Sub

ErrHandler:
    BalloonDrawMode = False
    RefreshBalloonDrawRibbon
    ShowError "Could not start balloon drawing mode."
End Sub

Public Sub BalloonStopDrawMode()
    BalloonDrawMode = False
    BalloonEventBusy = False
    BalloonDrawSlideID = 0
    BalloonDrawShapeCount = 0
    BalloonListQueueActive = False
    BalloonListQueueSlideID = 0
    BalloonExitNativeDrawTool
    RefreshBalloonDrawRibbon
End Sub

Public Sub BalloonToggleDrawMode(ByVal pressed As Boolean)
    If pressed Then
        BalloonListQueueActive = False
        BalloonListQueueSlideID = 0
        BalloonStartDrawMode
    Else
        BalloonStopDrawMode
    End If
End Sub

Public Function BalloonDrawModeIsActive() As Boolean
    BalloonDrawModeIsActive = BalloonDrawMode And Not BalloonListQueueActive
End Function

Public Sub BalloonHandleWindowSelectionChange(ByVal sel As Selection)
    On Error GoTo CleanFail
    If BalloonEventBusy Then Exit Sub
    If BalloonClickNumberMode Then
        BalloonClickNumberHandle sel
        Exit Sub
    End If
    If Not BalloonDrawMode Then Exit Sub
    If sel.Type <> ppSelectionShapes Then Exit Sub
    If sel.ShapeRange.count <> 1 Then Exit Sub

    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then GoTo CancelMode
    If sld.slideId <> BalloonDrawSlideID Then GoTo CancelMode

    Dim shp As Shape
    Set shp = sel.ShapeRange(1)
    If Not IsUsableLeaderLine(shp) Then GoTo CancelMode
    If sld.shapes.count <= BalloonDrawShapeCount Then Exit Sub

    BalloonEventBusy = True
    BalloonConvertSelectedLines True
    If BalloonDrawMode Then BalloonStartDrawMode True
    BalloonEventBusy = False
    RefreshBalloonDrawRibbon
    Exit Sub

CancelMode:
    BalloonStopDrawMode
    Exit Sub

CleanFail:
    BalloonDrawMode = False
    BalloonEventBusy = False
    RefreshBalloonDrawRibbon
End Sub

Public Sub BalloonConvertSelectedLines(Optional ByVal keepDrawing As Boolean = False)
    On Error GoTo ErrHandler

    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then
        ShowError "Open a slide and select one or more leader lines first."
        Exit Sub
    End If

    Dim sel As Selection
    Set sel = ActiveWindow.Selection
    If sel.Type <> ppSelectionShapes Then
        ShowError "Select one or more leader lines first."
        Exit Sub
    End If

    Dim specs() As BalloonLineSpec
    Dim lineNames() As String
    Dim count As Long
    count = CollectSelectedLineSpecs(sel.ShapeRange, specs, lineNames)
    If count = 0 Then
        ShowError "Select straight lines or connectors to convert."
        Exit Sub
    End If

    Dim startNumber As Long
    startNumber = NextBalloonNumber(sld)

    Dim createdNames() As Variant
    ReDim createdNames(1 To count)

    Dim i As Long
    Dim created As Shape
    For i = 1 To count
        On Error Resume Next
        sld.shapes(lineNames(i)).Delete
        On Error GoTo ErrHandler
        Set created = CreateBalloonFromSpec(sld, specs(i), startNumber + i - 1)
        createdNames(i) = created.name
    Next i

    Dim createdRange As ShapeRange
    Set createdRange = sld.shapes.Range(createdNames)
    If Not keepDrawing Then createdRange.Select
    BalloonListHandleCreatedBalloons createdRange
    Exit Sub

ErrHandler:
    ShowError "Could not convert selected lines to balloons: " & Err.Description
End Sub

Public Sub BalloonAddOne()
    On Error GoTo ErrHandler

    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then
        ShowError "Open a slide first."
        Exit Sub
    End If

    Dim spec As BalloonLineSpec
    spec.partX = ActivePresentation.PageSetup.slideWidth * 0.42
    spec.partY = ActivePresentation.PageSetup.slideHeight * 0.42
    spec.bubbleX = spec.partX - 90
    spec.bubbleY = spec.partY - 60

    Dim created As Shape
    Set created = CreateBalloonFromSpec(sld, spec, NextBalloonNumber(sld))
    created.Select
    Dim createdNames(0 To 0) As Variant
    createdNames(0) = created.name
    BalloonListHandleCreatedBalloons sld.shapes.Range(createdNames)
    Exit Sub

ErrHandler:
    ShowError "Could not add balloon: " & Err.Description
End Sub

Public Sub BalloonAlignLabelsLeft()
    BalloonAlignLabels "Left"
End Sub

Public Sub BalloonAlignLabelsRight()
    BalloonAlignLabels "Right"
End Sub

Public Sub BalloonAlignLabelsTop()
    BalloonAlignLabels "Top"
End Sub

Public Sub BalloonAlignLabelsBottom()
    BalloonAlignLabels "Bottom"
End Sub

Public Sub BalloonDistributeLabelsHorizontal()
    BalloonDistributeLabels "Horizontal"
End Sub

Public Sub BalloonDistributeLabelsVertical()
    BalloonDistributeLabels "Vertical"
End Sub

Public Sub BalloonNudgeLabelsLeft()
    BalloonNudgeLabels -3, 0
End Sub

Public Sub BalloonNudgeLabelsRight()
    BalloonNudgeLabels 3, 0
End Sub

Public Sub BalloonNudgeLabelsUp()
    BalloonNudgeLabels 0, -3
End Sub

Public Sub BalloonNudgeLabelsDown()
    BalloonNudgeLabels 0, 3
End Sub

Public Sub BalloonRenumberSlide()
    On Error GoTo ErrHandler
    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then Exit Sub

    Dim balloons As Collection
    Set balloons = GetSlideBalloons(sld)
    BalloonSetRenumberNextValue RenumberBalloonCollection(balloons, BalloonCurrentRenumberNext())
    Exit Sub

ErrHandler:
    ShowError "Could not renumber balloons: " & Err.Description
End Sub

Public Sub BalloonRenumberSelected()
    On Error GoTo ErrHandler
    Dim balloons As Collection
    Set balloons = GetSelectedBalloons()
    If balloons.count = 0 Then
        ShowError "Select one or more balloons first."
        Exit Sub
    End If
    BalloonSetRenumberNextValue RenumberBalloonCollection(balloons, BalloonCurrentRenumberNext())
    Exit Sub

ErrHandler:
    ShowError "Could not renumber selected balloons: " & Err.Description
End Sub

' --- Click-order renumber ---
' Turn the mode on, then click balloons one by one in the wanted order.
' Each first click on a balloon assigns the current Next No. value.
' Clicking a balloon already numbered in this session is ignored, so stray
' selection events do not double-count.
Public Sub BalloonClickNumberStart(ByVal pressed As Boolean)
    If pressed Then
        If BalloonDrawMode Then BalloonStopDrawMode
        BalloonListQueueActive = False
        BalloonInitializeEvents
        BalloonClickNumberMode = True
        BalloonClickNumberNext = BalloonCurrentRenumberNext()
        Set BalloonClickNumberDone = New Collection
        BalloonEventBusy = False
    Else
        BalloonClickNumberStop
    End If
    RefreshBalloonClickNumberRibbon
End Sub

Public Sub BalloonClickNumberStop()
    BalloonClickNumberMode = False
    BalloonEventBusy = False
    BalloonClickNumberNext = BalloonCurrentRenumberNext()
    Set BalloonClickNumberDone = Nothing
    RefreshBalloonClickNumberRibbon
End Sub

Public Function BalloonClickNumberActive() As Boolean
    BalloonClickNumberActive = BalloonClickNumberMode
End Function

Public Function BalloonRenumberNextText() As String
    BalloonRenumberNextText = CStr(BalloonCurrentRenumberNext())
End Function

Public Sub BalloonSetRenumberNextText(ByVal text As String)
    On Error GoTo BadValue
    BalloonSetRenumberNextValue CLng(Fix(val(text)))
    Exit Sub

BadValue:
    BalloonSetRenumberNextValue 1
End Sub

Private Sub BalloonClickNumberHandle(ByVal sel As Selection)
    On Error GoTo Done
    If BalloonEventBusy Then Exit Sub
    If sel.Type <> ppSelectionShapes Then Exit Sub
    If sel.ShapeRange.count <> 1 Then Exit Sub

    Dim shp As Shape
    Set shp = sel.ShapeRange(1)
    If Not IsBalloonGroup(shp) Then Exit Sub
    If BalloonClickNumberDone Is Nothing Then Set BalloonClickNumberDone = New Collection
    If BalloonClickAlreadyDone(shp.name) Then Exit Sub

    BalloonEventBusy = True
    BalloonClickNumberNext = BalloonCurrentRenumberNext()
    SetBalloonNumber shp, BalloonClickNumberNext
    BalloonClickNumberDone.Add shp.name, shp.name
    BalloonSetRenumberNextValue BalloonClickNumberNext + 1
    BalloonEventBusy = False
    Exit Sub

Done:
    BalloonEventBusy = False
End Sub

Private Function BalloonClickAlreadyDone(ByVal nm As String) As Boolean
    On Error GoTo NotThere
    Dim v As Variant
    v = BalloonClickNumberDone.item(nm)
    BalloonClickAlreadyDone = True
    Exit Function
NotThere:
    BalloonClickAlreadyDone = False
End Function

Private Sub RefreshBalloonClickNumberRibbon()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "tglBalloonClickNumber"
        AppRibbonUI.InvalidateControl "txtBalloonNextNumber"
    End If
    On Error GoTo 0
End Sub

Private Function BalloonCurrentRenumberNext() As Long
    If BalloonRenumberNext < 1 Then BalloonRenumberNext = 1
    BalloonCurrentRenumberNext = BalloonRenumberNext
End Function

Private Sub BalloonSetRenumberNextValue(ByVal nextValue As Long)
    If nextValue < 1 Then nextValue = 1
    BalloonRenumberNext = nextValue
    BalloonClickNumberNext = nextValue
    RefreshBalloonClickNumberRibbon
End Sub

Public Function BalloonIsCalloutGroup(ByVal shp As Shape) As Boolean
    BalloonIsCalloutGroup = IsBalloonGroup(shp)
End Function

Public Function BalloonDisplayNumber(ByVal shp As Shape) As Long
    If Not IsBalloonGroup(shp) Then Exit Function
    BalloonDisplayNumber = CLng(val(shp.Tags.item(BALLOON_TAG_NUMBER)))
End Function

Public Sub BalloonSetDisplayNumber(ByVal shp As Shape, ByVal balloonNumber As Long)
    If Not IsBalloonGroup(shp) Then Exit Sub
    SetBalloonNumber shp, balloonNumber
End Sub

Public Sub BalloonApplyStandardStyle()
    On Error GoTo ErrHandler
    Dim standardStyle As BalloonStyle
    InitializeStandardBalloonStyle standardStyle

    Dim balloons As Collection
    Set balloons = GetSelectedBalloons()
    If balloons.count = 0 Then
        Dim sld As Slide
        Set sld = GetActiveSlide()
        If Not sld Is Nothing Then Set balloons = GetSlideBalloons(sld)
    End If
    If balloons.count = 0 Then
        ShowError "No balloons found on the current slide."
        Exit Sub
    End If

    ApplyStyleToBalloonCollection balloons, standardStyle
    Exit Sub

ErrHandler:
    ShowError "Could not apply balloon style: " & Err.Description
End Sub

Public Sub BalloonCaptureSelectedStyleAsDefault()
    On Error GoTo ErrHandler
    Dim balloons As Collection
    Set balloons = GetSelectedBalloons()
    If balloons.count = 0 Then
        ShowError "Select a balloon to capture its style."
        Exit Sub
    End If

    Dim info As BalloonInfo
    If Not GetBalloonInfo(balloons(1), info) Then
        ShowError "The selected balloon does not contain a label and leader."
        Exit Sub
    End If

    SaveDefaultBalloonStyle info.style
    RefreshBalloonFormatRibbon
    Exit Sub

ErrHandler:
    ShowError "Could not capture balloon style: " & Err.Description
End Sub

Public Sub BalloonApplyDefaultStyleSelected()
    On Error GoTo ErrHandler
    Dim balloons As Collection
    Set balloons = GetSelectedBalloons()
    If balloons.count = 0 Then
        ShowError "Select one or more balloons first."
        Exit Sub
    End If

    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    ApplyStyleToBalloonCollection balloons, style
    Exit Sub

ErrHandler:
    ShowError "Could not apply the default balloon style: " & Err.Description
End Sub

Public Sub BalloonApplyDefaultStyleSlide()
    On Error GoTo ErrHandler
    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then Exit Sub

    Dim balloons As Collection
    Set balloons = GetSlideBalloons(sld)
    If balloons.count = 0 Then
        ShowError "No balloons found on the current slide."
        Exit Sub
    End If

    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    ApplyStyleToBalloonCollection balloons, style
    Exit Sub

ErrHandler:
    ShowError "Could not apply the default balloon style: " & Err.Description
End Sub

Public Sub BalloonStyleDebugReport()
    Dim msg As String
    msg = "=== SAVED DEFAULT ===" & vbCrLf
    Dim saved As BalloonStyle
    GetDefaultBalloonStyle saved
    msg = msg & "FillType=" & saved.FillType & "  FillForeColor=" & saved.FillForeColor & vbCrLf
    msg = msg & "LabelLineWeight=" & saved.LabelLineWeight & "  LabelLineColor=" & saved.LabelLineColor & vbCrLf
    msg = msg & "GlowRadius=" & saved.GlowRadius & "  GlowColor=" & saved.GlowColor & vbCrLf
    msg = msg & "ShadowVisible=" & saved.ShadowVisible & vbCrLf
    msg = msg & "FontName=" & saved.fontName & "  FontSize=" & saved.fontSize & vbCrLf
    msg = msg & "LeaderWeight=" & saved.LeaderWeight & "  LeaderColor=" & saved.LeaderColor & vbCrLf

    Dim balloons As Collection
    Set balloons = GetSelectedBalloons()
    If balloons.count > 0 Then
        Dim info As BalloonInfo
        If GetBalloonInfo(balloons(1), info) Then
            msg = msg & vbCrLf & "=== CAPTURED FROM SELECTED ===" & vbCrLf
            msg = msg & "FillType=" & info.style.FillType & "  FillForeColor=" & info.style.FillForeColor & vbCrLf
            msg = msg & "LabelLineWeight=" & info.style.LabelLineWeight & "  LabelLineColor=" & info.style.LabelLineColor & vbCrLf
            msg = msg & "GlowRadius=" & info.style.GlowRadius & "  GlowColor=" & info.style.GlowColor & vbCrLf
            msg = msg & "ShadowVisible=" & info.style.ShadowVisible & vbCrLf
        End If
    End If

    MsgBox msg, vbInformation, "Balloon Style Debug"
End Sub

Public Sub BalloonResetDefaultStyle()
    Dim style As BalloonStyle
    InitializeStandardBalloonStyle style
    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
    RefreshBalloonFormatRibbon
End Sub

Public Function BalloonDefaultLabelSizeText() As String
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    BalloonDefaultLabelSizeText = SingleToTagText(style.LabelWidth)
End Function

Public Sub BalloonSetDefaultLabelSize(ByVal valueText As String)
    Dim value As Single
    value = CSng(val(valueText))
    If value < 6 Or value > 144 Then
        ShowError "Label size must be between 6 and 144 points."
        RefreshBalloonFormatRibbon
        Exit Sub
    End If

    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    style.LabelWidth = value
    style.LabelHeight = value
    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
    RefreshBalloonFormatRibbon
End Sub

Public Function BalloonDefaultFontSizeText() As String
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    BalloonDefaultFontSizeText = SingleToTagText(style.fontSize)
End Function

Public Sub BalloonSetDefaultFontSize(ByVal valueText As String)
    Dim value As Single
    value = CSng(val(valueText))
    If value < 4 Or value > 96 Then
        ShowError "Font size must be between 4 and 96 points."
        RefreshBalloonFormatRibbon
        Exit Sub
    End If

    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    style.fontSize = value
    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
    RefreshBalloonFormatRibbon
End Sub

Public Function BalloonDefaultLeaderWeightText() As String
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    BalloonDefaultLeaderWeightText = SingleToTagText(style.LeaderWeight)
End Function

Public Sub BalloonSetDefaultLeaderWeight(ByVal valueText As String)
    Dim value As Single
    value = CSng(val(valueText))
    If value < 0.25 Or value > 10 Then
        ShowError "Leader weight must be between 0.25 and 10 points."
        RefreshBalloonFormatRibbon
        Exit Sub
    End If

    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    style.LeaderWeight = value
    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
    RefreshBalloonFormatRibbon
End Sub

Public Function BalloonDefaultDashIndex() As Long
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    Select Case style.LeaderDash
        Case msoLineDash: BalloonDefaultDashIndex = 1
        Case msoLineRoundDot: BalloonDefaultDashIndex = 2
        Case msoLineDashDot: BalloonDefaultDashIndex = 3
        Case Else: BalloonDefaultDashIndex = 0
    End Select
End Function

Public Sub BalloonSetDefaultDash(ByVal selectedIndex As Long)
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    Select Case selectedIndex
        Case 1: style.LeaderDash = msoLineDash
        Case 2: style.LeaderDash = msoLineRoundDot
        Case 3: style.LeaderDash = msoLineDashDot
        Case Else: style.LeaderDash = msoLineSolid
    End Select
    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
    RefreshBalloonFormatRibbon
End Sub

Public Function BalloonDefaultDashID() As String
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    Select Case style.LeaderDash
        Case msoLineDash: BalloonDefaultDashID = "dash_dash"
        Case msoLineRoundDot: BalloonDefaultDashID = "dash_dot"
        Case msoLineDashDot: BalloonDefaultDashID = "dash_dashdot"
        Case Else: BalloonDefaultDashID = "dash_solid"
    End Select
End Function

Public Sub BalloonSetDefaultDashByID(ByVal selectedId As String)
    Select Case LCase$(Trim$(selectedId))
        Case "dash_dash": BalloonSetDefaultDash 1
        Case "dash_dot": BalloonSetDefaultDash 2
        Case "dash_dashdot": BalloonSetDefaultDash 3
        Case Else: BalloonSetDefaultDash 0
    End Select
End Sub

Public Function BalloonDefaultMarkerIndex() As Long
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    Select Case style.PartMarker
        Case msoArrowheadOval: BalloonDefaultMarkerIndex = 1
        Case msoArrowheadTriangle: BalloonDefaultMarkerIndex = 2
        Case msoArrowheadOpen: BalloonDefaultMarkerIndex = 3
        Case Else: BalloonDefaultMarkerIndex = 0
    End Select
End Function

Public Sub BalloonSetDefaultMarker(ByVal selectedIndex As Long)
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    Select Case selectedIndex
        Case 1: style.PartMarker = msoArrowheadOval
        Case 2: style.PartMarker = msoArrowheadTriangle
        Case 3: style.PartMarker = msoArrowheadOpen
        Case Else: style.PartMarker = msoArrowheadNone
    End Select
    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
    RefreshBalloonFormatRibbon
End Sub

Public Function BalloonDefaultMarkerID() As String
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    Select Case style.PartMarker
        Case msoArrowheadOval: BalloonDefaultMarkerID = "marker_dot"
        Case msoArrowheadTriangle: BalloonDefaultMarkerID = "marker_arrow"
        Case msoArrowheadOpen: BalloonDefaultMarkerID = "marker_open"
        Case Else: BalloonDefaultMarkerID = "marker_none"
    End Select
End Function

Public Sub BalloonSetDefaultMarkerByID(ByVal selectedId As String)
    Select Case LCase$(Trim$(selectedId))
        Case "marker_dot": BalloonSetDefaultMarker 1
        Case "marker_arrow": BalloonSetDefaultMarker 2
        Case "marker_open": BalloonSetDefaultMarker 3
        Case Else: BalloonSetDefaultMarker 0
    End Select
End Sub

Public Sub BalloonSetDefaultLabelPreset(ByVal presetName As String)
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style

    Select Case UCase$(Trim$(presetName))
        Case "SMALL"
            style.LabelWidth = 18
            style.LabelHeight = 18
            style.fontSize = 10
        Case "LARGE"
            style.LabelWidth = 32
            style.LabelHeight = 32
            style.fontSize = 18
        Case Else
            style.LabelWidth = 24
            style.LabelHeight = 24
            style.fontSize = 14
    End Select

    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
    RefreshBalloonFormatRibbon
End Sub

Public Sub BalloonSetDefaultArrowPreset(ByVal presetName As String)
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style

    style.PartMarkerLength = msoArrowheadLengthMedium
    style.PartMarkerWidth = msoArrowheadWidthMedium
    style.EndMarker = msoArrowheadNone

    Select Case UCase$(Trim$(presetName))
        Case "DOT"
            style.PartMarker = msoArrowheadOval
        Case "ARROW"
            style.PartMarker = msoArrowheadTriangle
        Case Else
            style.PartMarker = msoArrowheadNone
    End Select

    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
    RefreshBalloonFormatRibbon
End Sub

Public Function BalloonDefaultBold() As Boolean
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    BalloonDefaultBold = (style.FontBold = msoTrue)
End Function

Public Sub BalloonSetDefaultBold(ByVal pressed As Boolean)
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    If pressed Then
        style.FontBold = msoTrue
    Else
        style.FontBold = msoFalse
    End If
    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
End Sub

' Draw-shape mode: the number label is an oval (circle) or a rectangle
' (square). It reuses LabelShapeType, which is already threaded through
' creation, capture, and the saved default style.
Public Function BalloonDrawShapeIsSquare() As Boolean
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    BalloonDrawShapeIsSquare = (style.LabelShapeType = msoShapeRectangle)
End Function

Public Sub BalloonSetDrawShape(ByVal square As Boolean)
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    If square Then
        style.LabelShapeType = msoShapeRectangle
    Else
        style.LabelShapeType = msoShapeOval
    End If
    SaveDefaultBalloonStyle style
    ApplyDefaultStyleToSelectedQuiet style
End Sub

Public Sub SelectAllBalloonsOnSlide()
    On Error GoTo ErrHandler
    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then Exit Sub

    Dim balloons As Collection
    Set balloons = GetSlideBalloons(sld)
    If balloons.count = 0 Then
        ShowError "No balloons found on the current slide."
        Exit Sub
    End If

    Dim names() As Variant
    ReDim names(1 To balloons.count)

    Dim i As Long
    For i = 1 To balloons.count
        names(i) = balloons(i).name
    Next i

    sld.shapes.Range(names).Select
    Exit Sub

ErrHandler:
    ShowError "Could not select balloons: " & Err.Description
End Sub

Private Function CollectSelectedLineSpecs(ByVal rng As ShapeRange, _
                                          ByRef specs() As BalloonLineSpec, _
                                          ByRef lineNames() As String) As Long
    Dim i As Long
    Dim shp As Shape
    Dim count As Long

    ReDim specs(1 To rng.count)
    ReDim lineNames(1 To rng.count)

    For i = 1 To rng.count
        Set shp = rng(i)
        If IsUsableLeaderLine(shp) Then
            count = count + 1
            lineNames(count) = shp.name
            specs(count) = SpecFromLine(shp)
        End If
    Next i

    If count > 0 Then
        ReDim Preserve specs(1 To count)
        ReDim Preserve lineNames(1 To count)
    End If
    CollectSelectedLineSpecs = count
End Function

Private Function IsUsableLeaderLine(ByVal shp As Shape) As Boolean
    On Error Resume Next
    IsUsableLeaderLine = (shp.Type = msoLine Or shp.Connector = msoTrue)
    On Error GoTo 0
End Function

Private Function SpecFromLine(ByVal shp As Shape) As BalloonLineSpec
    Dim leftX As Single, rightX As Single
    Dim topY As Single, bottomY As Single
    leftX = shp.left
    topY = shp.Top
    rightX = shp.left + shp.width
    bottomY = shp.Top + shp.height

    If shp.HorizontalFlip = msoTrue Then
        SpecFromLine.partX = rightX
        SpecFromLine.bubbleX = leftX
    Else
        SpecFromLine.partX = leftX
        SpecFromLine.bubbleX = rightX
    End If

    If shp.VerticalFlip = msoTrue Then
        SpecFromLine.partY = bottomY
        SpecFromLine.bubbleY = topY
    Else
        SpecFromLine.partY = topY
        SpecFromLine.bubbleY = bottomY
    End If
End Function

Private Function CreateBalloonFromSpec(ByVal sld As Slide, _
                                       ByRef spec As BalloonLineSpec, _
                                       ByVal balloonNumber As Long) As Shape
    Dim style As BalloonStyle
    GetDefaultBalloonStyle style
    Set CreateBalloonFromSpec = CreateBalloonFromSpecWithStyle( _
                                    sld, spec, balloonNumber, style)
End Function

Private Function CreateBalloonFromSpecWithStyle(ByVal sld As Slide, _
                                                ByRef spec As BalloonLineSpec, _
                                                ByVal balloonNumber As Long, _
                                                ByRef style As BalloonStyle) As Shape
    NormalizeBalloonStyle style

    Dim edgeX As Single, edgeY As Single
    PointOnLabelToward spec.bubbleX, spec.bubbleY, _
                       spec.partX, spec.partY, _
                       style.LabelWidth / 2, style.LabelHeight / 2, _
                       style.LabelShapeType, edgeX, edgeY

    Dim leader As Shape
    Set leader = sld.shapes.AddLine(spec.partX, spec.partY, edgeX, edgeY)
    leader.name = UniqueShapeName(sld, "rtBalloonLeader")
    leader.Tags.Add BALLOON_TAG_KIND, BALLOON_KIND_LEADER

    Dim balloonCircle As Shape
    Set balloonCircle = sld.shapes.AddShape(style.LabelShapeType, _
                                            spec.bubbleX - style.LabelWidth / 2, _
                                            spec.bubbleY - style.LabelHeight / 2, _
                                            style.LabelWidth, _
                                            style.LabelHeight)
    balloonCircle.name = UniqueShapeName(sld, "rtBalloonCircle")
    balloonCircle.Tags.Add BALLOON_TAG_KIND, BALLOON_KIND_CIRCLE
    balloonCircle.Tags.Add BALLOON_TAG_NUMBER, CStr(balloonNumber)
    SetCircleText balloonCircle, CStr(balloonNumber)

    ApplyLeaderStyleData leader, style
    ApplyCircleStyleData balloonCircle, style

    Dim GroupNames(1 To 2) As Variant
    GroupNames(1) = leader.name
    GroupNames(2) = balloonCircle.name

    Dim grp As Shape
    Set grp = sld.shapes.Range(GroupNames).Group
    grp.name = UniqueShapeName(sld, "rtBalloon")
    grp.Tags.Add BALLOON_TAG_KIND, BALLOON_KIND_GROUP
    grp.Tags.Add BALLOON_TAG_NUMBER, CStr(balloonNumber)
    AddBalloonGeometryTags grp, spec

    ' Grouping resets effects on child shapes; re-apply after group is formed.
    Dim child As Shape
    For Each child In grp.GroupItems
        Select Case child.Tags.item(BALLOON_TAG_KIND)
            Case BALLOON_KIND_CIRCLE
                ApplyCircleEffectsAfterGroup child, style
            Case BALLOON_KIND_LEADER
                ApplyLeaderEffectsAfterGroup child, style
        End Select
    Next child

    Set CreateBalloonFromSpecWithStyle = grp
End Function

Private Sub ApplyCircleEffectsAfterGroup(ByVal shp As Shape, ByRef style As BalloonStyle)
    On Error Resume Next
    shp.Shadow.Visible = style.ShadowVisible
    If style.ShadowVisible <> msoFalse Then
        shp.Shadow.ForeColor.RGB = style.ShadowColor
        shp.Shadow.Transparency = style.ShadowTransparency
        shp.Shadow.OffsetX = style.ShadowOffsetX
        shp.Shadow.OffsetY = style.ShadowOffsetY
        shp.Shadow.Size = style.ShadowSize
        shp.Shadow.Blur = style.ShadowBlur
    End If
    shp.Glow.Radius = style.GlowRadius
    If style.GlowRadius > 0 Then
        shp.Glow.Color.RGB = style.GlowColor
        shp.Glow.Transparency = style.GlowTransparency
    End If
    shp.SoftEdge.Type = style.SoftEdgeType
    shp.Reflection.Type = style.ReflectionType
    On Error GoTo 0
End Sub

Private Sub ApplyLeaderEffectsAfterGroup(ByVal shp As Shape, ByRef style As BalloonStyle)
    On Error Resume Next
    ' Line properties (grouping may reset these on line shapes)
    shp.line.Visible = style.LeaderVisible
    shp.line.ForeColor.RGB = style.LeaderColor
    shp.line.BackColor.RGB = style.LeaderBkColor
    shp.line.Weight = style.LeaderWeight
    shp.line.Transparency = style.LeaderTransparency
    shp.line.dashStyle = style.LeaderDash
    shp.line.style = style.LeaderStyle
    shp.line.BeginArrowheadStyle = style.PartMarker
    shp.line.BeginArrowheadLength = style.PartMarkerLength
    shp.line.BeginArrowheadWidth = style.PartMarkerWidth
    shp.line.EndArrowheadStyle = style.EndMarker
    shp.line.EndArrowheadLength = style.EndMarkerLength
    shp.line.EndArrowheadWidth = style.EndMarkerWidth
    ' Shadow
    shp.Shadow.Visible = style.LeaderShadowVisible
    If style.LeaderShadowVisible <> msoFalse Then
        shp.Shadow.ForeColor.RGB = style.LeaderShadowColor
        shp.Shadow.Transparency = style.LeaderShadowTransparency
        shp.Shadow.OffsetX = style.LeaderShadowOffsetX
        shp.Shadow.OffsetY = style.LeaderShadowOffsetY
        shp.Shadow.Blur = style.LeaderShadowBlur
    End If
    ' Glow
    shp.Glow.Radius = style.LeaderGlowRadius
    If style.LeaderGlowRadius > 0 Then
        shp.Glow.Color.RGB = style.LeaderGlowColor
        shp.Glow.Transparency = style.LeaderGlowTransparency
    End If
    On Error GoTo 0
End Sub

Private Sub SetBalloonNumber(ByVal balloon As Shape, ByVal balloonNumber As Long)
    balloon.Tags.Add BALLOON_TAG_NUMBER, CStr(balloonNumber)

    Dim child As Shape
    For Each child In balloon.GroupItems
        If child.Tags.item(BALLOON_TAG_KIND) = BALLOON_KIND_CIRCLE Then
            child.Tags.Add BALLOON_TAG_NUMBER, CStr(balloonNumber)
            SetCircleText child, CStr(balloonNumber)
            Exit Sub
        End If
    Next child
End Sub

Private Sub BalloonAlignLabels(ByVal alignMode As String)
    On Error GoTo ErrHandler
    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then Exit Sub

    Dim infos() As BalloonInfo
    Dim count As Long
    count = CollectSelectedBalloonInfos(infos)
    If count < 2 Then
        ShowError "Select two or more balloons first."
        Exit Sub
    End If

    Dim target As Single
    Dim i As Long
    Select Case alignMode
        Case "Left"
            target = infos(1).bubbleX
            For i = 2 To count
                If infos(i).bubbleX < target Then target = infos(i).bubbleX
            Next i
            For i = 1 To count
                infos(i).bubbleX = target
            Next i
        Case "Right"
            target = infos(1).bubbleX
            For i = 2 To count
                If infos(i).bubbleX > target Then target = infos(i).bubbleX
            Next i
            For i = 1 To count
                infos(i).bubbleX = target
            Next i
        Case "Top"
            target = infos(1).bubbleY
            For i = 2 To count
                If infos(i).bubbleY < target Then target = infos(i).bubbleY
            Next i
            For i = 1 To count
                infos(i).bubbleY = target
            Next i
        Case "Bottom"
            target = infos(1).bubbleY
            For i = 2 To count
                If infos(i).bubbleY > target Then target = infos(i).bubbleY
            Next i
            For i = 1 To count
                infos(i).bubbleY = target
            Next i
    End Select

    RecreateBalloonsFromInfos sld, infos, count
    Exit Sub

ErrHandler:
    ShowError "Could not align balloon labels: " & Err.Description
End Sub

Private Sub BalloonDistributeLabels(ByVal distributeMode As String)
    On Error GoTo ErrHandler
    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then Exit Sub

    Dim infos() As BalloonInfo
    Dim count As Long
    count = CollectSelectedBalloonInfos(infos)
    If count < 3 Then
        ShowError "Select three or more balloons first."
        Exit Sub
    End If

    If distributeMode = "Horizontal" Then
        SortBalloonInfos infos, count, "X"
    Else
        SortBalloonInfos infos, count, "Y"
    End If

    Dim firstPos As Single
    Dim lastPos As Single
    Dim stepSize As Single
    Dim i As Long

    If distributeMode = "Horizontal" Then
        firstPos = infos(1).bubbleX
        lastPos = infos(count).bubbleX
        stepSize = (lastPos - firstPos) / (count - 1)
        For i = 2 To count - 1
            infos(i).bubbleX = firstPos + stepSize * (i - 1)
        Next i
    Else
        firstPos = infos(1).bubbleY
        lastPos = infos(count).bubbleY
        stepSize = (lastPos - firstPos) / (count - 1)
        For i = 2 To count - 1
            infos(i).bubbleY = firstPos + stepSize * (i - 1)
        Next i
    End If

    RecreateBalloonsFromInfos sld, infos, count
    Exit Sub

ErrHandler:
    ShowError "Could not distribute balloon labels: " & Err.Description
End Sub

Private Sub BalloonNudgeLabels(ByVal deltaX As Single, ByVal deltaY As Single)
    On Error GoTo ErrHandler
    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then Exit Sub

    Dim infos() As BalloonInfo
    Dim count As Long
    count = CollectSelectedBalloonInfos(infos)
    If count < 1 Then
        ShowError "Select one or more balloons first."
        Exit Sub
    End If

    Dim i As Long
    For i = 1 To count
        infos(i).bubbleX = infos(i).bubbleX + deltaX
        infos(i).bubbleY = infos(i).bubbleY + deltaY
    Next i

    RecreateBalloonsFromInfos sld, infos, count
    Exit Sub

ErrHandler:
    ShowError "Could not move balloon labels: " & Err.Description
End Sub

Private Sub SetCircleText(ByVal circleShape As Shape, ByVal textValue As String)
    With circleShape.TextFrame
        .AutoSize = ppAutoSizeNone
        .MarginLeft = 0
        .MarginRight = 0
        .MarginTop = 0
        .marginBottom = 0
        .HorizontalAnchor = msoAnchorCenter
        .VerticalAnchor = msoAnchorMiddle
        .TextRange.text = textValue
        .TextRange.ParagraphFormat.Alignment = ppAlignCenter
    End With
End Sub

Private Sub ApplyBalloonStyle(ByVal balloon As Shape)
    Dim style As BalloonStyle
    InitializeStandardBalloonStyle style

    Dim child As Shape
    For Each child In balloon.GroupItems
        Select Case child.Tags.item(BALLOON_TAG_KIND)
            Case BALLOON_KIND_CIRCLE
                ApplyCircleStyleData child, style
            Case BALLOON_KIND_LEADER
                ApplyLeaderStyleData child, style
        End Select
    Next child
End Sub

Private Sub ApplyGradientFill(ByVal f As Object, ByRef style As BalloonStyle)
    On Error Resume Next
    ' Use OneColorGradient as base to establish the gradient type
    f.OneColorGradient style.GradientStyle, style.GradientVariant, style.GradientDegree
    f.ForeColor.RGB = style.FillForeColor
    ' Overwrite individual stops for precise reproduction
    If style.GradientStopCount >= 2 Then
        Dim gs As Object
        Set gs = f.GradientStops
        ' Expand or shrink stop count to match
        Do While gs.count > style.GradientStopCount
            gs.Delete gs.count
        Loop
        Do While gs.count < style.GradientStopCount
            gs.Insert style.GradientStopCount, 1, 0
        Loop
        If gs.count >= 1 Then
            gs.item(1).Color.RGB = style.GradStopColor1
            gs.item(1).Position = style.GradStopPos1
            gs.item(1).Transparency = style.GradStopTrans1
        End If
        If gs.count >= 2 Then
            gs.item(2).Color.RGB = style.GradStopColor2
            gs.item(2).Position = style.GradStopPos2
            gs.item(2).Transparency = style.GradStopTrans2
        End If
        If gs.count >= 3 Then
            gs.item(3).Color.RGB = style.GradStopColor3
            gs.item(3).Position = style.GradStopPos3
            gs.item(3).Transparency = style.GradStopTrans3
        End If
        If gs.count >= 4 Then
            gs.item(4).Color.RGB = style.GradStopColor4
            gs.item(4).Position = style.GradStopPos4
            gs.item(4).Transparency = style.GradStopTrans4
        End If
        Set gs = Nothing
    End If
    f.GradientAngle = style.GradientAngle
    On Error GoTo 0
End Sub

Private Sub ApplyCircleStyle(ByVal circleShape As Shape)
    Dim style As BalloonStyle
    InitializeStandardBalloonStyle style
    ApplyCircleStyleData circleShape, style
End Sub

Private Sub ApplyLeaderStyle(ByVal leader As Shape)
    Dim style As BalloonStyle
    InitializeStandardBalloonStyle style
    ApplyLeaderStyleData leader, style
End Sub

Private Sub ApplyCircleStyleData(ByVal circleShape As Shape, _
                                 ByRef style As BalloonStyle)
    With circleShape
        ' Fill
        On Error Resume Next
        Select Case style.FillType
            Case msoFillBackground
                .Fill.Background
            Case msoFillPatterned
                .Fill.Patterned style.FillPattern
                .Fill.ForeColor.RGB = style.FillForeColor
                .Fill.BackColor.RGB = style.FillBackColor
            Case 3  ' msoFillGradient
                ApplyGradientFill .Fill, style
            Case Else  ' msoFillSolid and others
                .Fill.Solid
                .Fill.ForeColor.RGB = style.FillForeColor
                .Fill.BackColor.RGB = style.FillBackColor
                .Fill.Transparency = style.FillTransparency
        End Select
        If style.FillVisible = msoFalse Then .Fill.Visible = msoFalse
        On Error GoTo 0
        ' Border line
        .line.Visible = style.LabelLineVisible
        If style.LabelLineVisible <> msoFalse Then
            On Error Resume Next
            .line.ForeColor.RGB = style.LabelLineColor
            .line.BackColor.RGB = style.LabelLineBkColor
            .line.Weight = style.LabelLineWeight
            .line.Transparency = style.LabelLineTransparency
            .line.dashStyle = style.LabelLineDash
            .line.style = style.LabelLineStyle
            On Error GoTo 0
        End If
        ' Shadow
        On Error Resume Next
        .Shadow.Visible = style.ShadowVisible
        If style.ShadowVisible <> msoFalse Then
            .Shadow.ForeColor.RGB = style.ShadowColor
            .Shadow.Transparency = style.ShadowTransparency
            .Shadow.OffsetX = style.ShadowOffsetX
            .Shadow.OffsetY = style.ShadowOffsetY
            .Shadow.Size = style.ShadowSize
            .Shadow.Blur = style.ShadowBlur
        End If
        ' Glow
        .Glow.Radius = style.GlowRadius
        If style.GlowRadius > 0 Then
            .Glow.Color.RGB = style.GlowColor
            .Glow.Transparency = style.GlowTransparency
        End If
        ' Soft edge
        .SoftEdge.Type = style.SoftEdgeType
        ' Reflection
        .Reflection.Type = style.ReflectionType
        On Error GoTo 0
        ' Font: late binding for same reason as capture side
        Dim appFont As Object
        Set appFont = .TextFrame.TextRange.Font
        On Error Resume Next
        appFont.name = style.fontName
        appFont.Size = style.fontSize
        appFont.Color.RGB = style.FontColor
        appFont.Bold = style.FontBold
        appFont.Italic = style.FontItalic
        appFont.Underline = style.FontUnderline
        appFont.Strikethrough = style.FontStrikethrough
        appFont.Shadow = style.FontShadow
        appFont.Spacing = style.FontSpacing
        appFont.AllCaps = style.FontAllCaps
        appFont.Subscript = style.FontSubscript
        appFont.Superscript = style.FontSuperscript
        appFont.Emboss = style.FontEmboss
        appFont.Engrave = style.FontEngrave
        On Error GoTo 0
        Set appFont = Nothing
    End With
End Sub

Private Sub ApplyLeaderStyleData(ByVal leader As Shape, _
                                 ByRef style As BalloonStyle)
    With leader.line
        .Visible = style.LeaderVisible
        If style.LeaderVisible <> msoFalse Then
            On Error Resume Next
            .ForeColor.RGB = style.LeaderColor
            .BackColor.RGB = style.LeaderBkColor
            .Weight = style.LeaderWeight
            .Transparency = style.LeaderTransparency
            .dashStyle = style.LeaderDash
            .style = style.LeaderStyle
            On Error GoTo 0
        End If
        On Error Resume Next
        .BeginArrowheadStyle = style.PartMarker
        .BeginArrowheadLength = style.PartMarkerLength
        .BeginArrowheadWidth = style.PartMarkerWidth
        .EndArrowheadStyle = style.EndMarker
        .EndArrowheadLength = style.EndMarkerLength
        .EndArrowheadWidth = style.EndMarkerWidth
        On Error GoTo 0
    End With
    On Error Resume Next
    leader.Shadow.Visible = style.LeaderShadowVisible
    If style.LeaderShadowVisible <> msoFalse Then
        leader.Shadow.ForeColor.RGB = style.LeaderShadowColor
        leader.Shadow.Transparency = style.LeaderShadowTransparency
        leader.Shadow.OffsetX = style.LeaderShadowOffsetX
        leader.Shadow.OffsetY = style.LeaderShadowOffsetY
        leader.Shadow.Blur = style.LeaderShadowBlur
    End If
    On Error GoTo 0
End Sub

Private Sub InitializeStandardBalloonStyle(ByRef style As BalloonStyle)
    ' Shape
    style.LabelShapeType = msoShapeOval
    style.LabelWidth = BALLOON_DIAMETER
    style.LabelHeight = BALLOON_DIAMETER
    ' Fill
    style.FillType = msoFillSolid
    style.FillVisible = msoTrue
    style.FillForeColor = RGB(255, 255, 255)
    style.FillBackColor = RGB(255, 255, 255)
    style.FillTransparency = 0
    style.FillPattern = 0
    style.GradientStyle = 0
    style.GradientVariant = 1
    style.GradientAngle = 0
    style.GradientColorType = 0
    style.GradientDegree = 0.5
    style.GradientStopCount = 0
    ' Circle border
    style.LabelLineVisible = msoTrue
    style.LabelLineColor = RGB(0, 0, 0)
    style.LabelLineBkColor = RGB(255, 255, 255)
    style.LabelLineWeight = BALLOON_LINE_WEIGHT
    style.LabelLineTransparency = 0
    style.LabelLineDash = msoLineSolid
    style.LabelLineStyle = msoLineSingle
    ' Shadow
    style.ShadowVisible = msoFalse
    style.ShadowColor = RGB(0, 0, 0)
    style.ShadowTransparency = 0.5
    style.ShadowOffsetX = 2
    style.ShadowOffsetY = 2
    style.ShadowSize = 100
    style.ShadowBlur = 4
    ' Glow (off)
    style.GlowColor = RGB(0, 0, 0)
    style.GlowRadius = 0
    style.GlowTransparency = 0.5
    ' Soft edge (none)
    style.SoftEdgeType = 0
    ' Reflection (none = 0)
    style.ReflectionType = 0
    ' Font
    style.fontName = BALLOON_FONT_NAME
    style.fontSize = BALLOON_FONT_SIZE
    style.FontColor = RGB(0, 0, 0)
    style.FontBold = msoFalse
    style.FontItalic = msoFalse
    style.FontUnderline = msoFalse
    style.FontStrikethrough = msoFalse
    style.FontShadow = msoFalse
    style.FontSpacing = 0
    style.FontAllCaps = msoFalse
    style.FontSubscript = msoFalse
    style.FontSuperscript = msoFalse
    style.FontEmboss = msoFalse
    style.FontEngrave = msoFalse
    ' Leader
    style.LeaderVisible = msoTrue
    style.LeaderColor = RGB(0, 0, 0)
    style.LeaderBkColor = RGB(255, 255, 255)
    style.LeaderWeight = BALLOON_LINE_WEIGHT
    style.LeaderTransparency = 0
    style.LeaderDash = msoLineSolid
    style.LeaderStyle = msoLineSingle
    ' Leader arrowheads
    style.PartMarker = msoArrowheadNone
    style.PartMarkerLength = msoArrowheadLengthMedium
    style.PartMarkerWidth = msoArrowheadWidthMedium
    style.EndMarker = msoArrowheadNone
    style.EndMarkerLength = msoArrowheadLengthMedium
    style.EndMarkerWidth = msoArrowheadWidthMedium
    ' Leader shadow
    style.LeaderShadowVisible = msoFalse
    style.LeaderShadowColor = RGB(0, 0, 0)
    style.LeaderShadowTransparency = 0.5
    style.LeaderShadowOffsetX = 2
    style.LeaderShadowOffsetY = 2
    style.LeaderShadowBlur = 4
    style.LeaderGlowColor = RGB(0, 0, 0)
    style.LeaderGlowRadius = 0
    style.LeaderGlowTransparency = 0.5
End Sub

Private Sub NormalizeBalloonStyle(ByRef style As BalloonStyle)
    If style.LabelShapeType <= 0 Then style.LabelShapeType = msoShapeOval
    If style.LabelWidth < 1 Then style.LabelWidth = BALLOON_DIAMETER
    If style.LabelHeight < 1 Then style.LabelHeight = style.LabelWidth
    If style.LabelLineWeight < 0.25 Then style.LabelLineWeight = BALLOON_LINE_WEIGHT
    If style.LabelLineDash <= 0 Then style.LabelLineDash = msoLineSolid
    If style.LabelLineStyle <= 0 Then style.LabelLineStyle = msoLineSingle
    If style.LeaderWeight < 0.25 Then style.LeaderWeight = BALLOON_LINE_WEIGHT
    If style.LeaderDash <= 0 Then style.LeaderDash = msoLineSolid
    If style.LeaderStyle <= 0 Then style.LeaderStyle = msoLineSingle
    If Len(style.fontName) = 0 Then style.fontName = BALLOON_FONT_NAME
    If style.fontSize < 1 Then style.fontSize = BALLOON_FONT_SIZE
    If style.PartMarker <= 0 Then style.PartMarker = msoArrowheadNone
    If style.PartMarkerLength <= 0 Then style.PartMarkerLength = msoArrowheadLengthMedium
    If style.PartMarkerWidth <= 0 Then style.PartMarkerWidth = msoArrowheadWidthMedium
    If style.EndMarker <= 0 Then style.EndMarker = msoArrowheadNone
    If style.EndMarkerLength <= 0 Then style.EndMarkerLength = msoArrowheadLengthMedium
    If style.EndMarkerWidth <= 0 Then style.EndMarkerWidth = msoArrowheadWidthMedium
End Sub

Private Sub CaptureBalloonStyle(ByVal balloon As Shape, _
                                ByRef style As BalloonStyle)
    InitializeStandardBalloonStyle style

    Dim child As Shape
    Dim labelShape As Shape
    Dim leaderShape As Shape
    For Each child In balloon.GroupItems
        Select Case child.Tags.item(BALLOON_TAG_KIND)
            Case BALLOON_KIND_CIRCLE
                Set labelShape = child
            Case BALLOON_KIND_LEADER
                Set leaderShape = child
        End Select
    Next child

    If Not labelShape Is Nothing Then
        On Error Resume Next
        style.LabelShapeType = labelShape.AutoShapeType
        On Error GoTo 0
        style.LabelWidth = labelShape.width
        style.LabelHeight = labelShape.height
        ' Fill
        On Error Resume Next
        style.FillType = labelShape.Fill.Type
        style.FillVisible = labelShape.Fill.Visible
        style.FillForeColor = labelShape.Fill.ForeColor.RGB
        style.FillBackColor = labelShape.Fill.BackColor.RGB
        style.FillTransparency = labelShape.Fill.Transparency
        style.FillPattern = labelShape.Fill.Pattern
        If style.FillType = 3 Then  ' msoFillGradient
            style.GradientStyle = labelShape.Fill.GradientStyle
            style.GradientVariant = labelShape.Fill.GradientVariant
            style.GradientAngle = labelShape.Fill.GradientAngle
            style.GradientColorType = labelShape.Fill.GradientColorType
            style.GradientDegree = labelShape.Fill.GradientDegree
            Dim gs As Object
            Set gs = labelShape.Fill.GradientStops
            style.GradientStopCount = gs.count
            If gs.count >= 1 Then
                style.GradStopColor1 = gs.item(1).Color.RGB
                style.GradStopPos1 = gs.item(1).Position
                style.GradStopTrans1 = gs.item(1).Transparency
            End If
            If gs.count >= 2 Then
                style.GradStopColor2 = gs.item(2).Color.RGB
                style.GradStopPos2 = gs.item(2).Position
                style.GradStopTrans2 = gs.item(2).Transparency
            End If
            If gs.count >= 3 Then
                style.GradStopColor3 = gs.item(3).Color.RGB
                style.GradStopPos3 = gs.item(3).Position
                style.GradStopTrans3 = gs.item(3).Transparency
            End If
            If gs.count >= 4 Then
                style.GradStopColor4 = gs.item(4).Color.RGB
                style.GradStopPos4 = gs.item(4).Position
                style.GradStopTrans4 = gs.item(4).Transparency
            End If
            Set gs = Nothing
        End If
        On Error GoTo 0
        ' Border line
        style.LabelLineVisible = labelShape.line.Visible
        On Error Resume Next
        style.LabelLineColor = labelShape.line.ForeColor.RGB
        style.LabelLineBkColor = labelShape.line.BackColor.RGB
        style.LabelLineWeight = labelShape.line.Weight
        style.LabelLineTransparency = labelShape.line.Transparency
        style.LabelLineDash = labelShape.line.dashStyle
        style.LabelLineStyle = labelShape.line.style
        On Error GoTo 0
        ' Shadow
        On Error Resume Next
        style.ShadowVisible = labelShape.Shadow.Visible
        style.ShadowColor = labelShape.Shadow.ForeColor.RGB
        style.ShadowTransparency = labelShape.Shadow.Transparency
        style.ShadowOffsetX = labelShape.Shadow.OffsetX
        style.ShadowOffsetY = labelShape.Shadow.OffsetY
        style.ShadowSize = labelShape.Shadow.Size
        style.ShadowBlur = labelShape.Shadow.Blur
        ' Glow
        style.GlowRadius = labelShape.Glow.Radius
        style.GlowColor = labelShape.Glow.Color.RGB
        style.GlowTransparency = labelShape.Glow.Transparency
        ' Soft edge
        style.SoftEdgeType = labelShape.SoftEdge.Type
        ' Reflection
        style.ReflectionType = labelShape.Reflection.Type
        On Error GoTo 0
        ' Font: use Object (late binding) so PPT-only subset compiles;
        ' Word/Excel Font properties absent in PPT are caught by OERN at runtime.
        Dim capFont As Object
        Set capFont = labelShape.TextFrame.TextRange.Font
        On Error Resume Next
        style.fontName = capFont.name
        style.fontSize = capFont.Size
        style.FontColor = capFont.Color.RGB
        style.FontBold = capFont.Bold
        style.FontItalic = capFont.Italic
        style.FontUnderline = capFont.Underline
        style.FontStrikethrough = capFont.Strikethrough
        style.FontShadow = capFont.Shadow
        style.FontSpacing = capFont.Spacing
        style.FontAllCaps = capFont.AllCaps
        style.FontSubscript = capFont.Subscript
        style.FontSuperscript = capFont.Superscript
        style.FontEmboss = capFont.Emboss
        style.FontEngrave = capFont.Engrave
        On Error GoTo 0
        Set capFont = Nothing
    End If

    If Not leaderShape Is Nothing Then
        style.LeaderVisible = leaderShape.line.Visible
        On Error Resume Next
        style.LeaderColor = leaderShape.line.ForeColor.RGB
        style.LeaderBkColor = leaderShape.line.BackColor.RGB
        style.LeaderWeight = leaderShape.line.Weight
        style.LeaderTransparency = leaderShape.line.Transparency
        style.LeaderDash = leaderShape.line.dashStyle
        style.LeaderStyle = leaderShape.line.style
        style.PartMarker = leaderShape.line.BeginArrowheadStyle
        style.PartMarkerLength = leaderShape.line.BeginArrowheadLength
        style.PartMarkerWidth = leaderShape.line.BeginArrowheadWidth
        style.EndMarker = leaderShape.line.EndArrowheadStyle
        style.EndMarkerLength = leaderShape.line.EndArrowheadLength
        style.EndMarkerWidth = leaderShape.line.EndArrowheadWidth
        ' Leader shadow
        style.LeaderShadowVisible = leaderShape.Shadow.Visible
        style.LeaderShadowColor = leaderShape.Shadow.ForeColor.RGB
        style.LeaderShadowTransparency = leaderShape.Shadow.Transparency
        style.LeaderShadowOffsetX = leaderShape.Shadow.OffsetX
        style.LeaderShadowOffsetY = leaderShape.Shadow.OffsetY
        style.LeaderShadowBlur = leaderShape.Shadow.Blur
        ' Leader glow
        style.LeaderGlowRadius = leaderShape.Glow.Radius
        style.LeaderGlowColor = leaderShape.Glow.Color.RGB
        style.LeaderGlowTransparency = leaderShape.Glow.Transparency
        On Error GoTo 0
    End If

    NormalizeBalloonStyle style
End Sub

Private Sub ApplyStyleToBalloonCollection(ByVal balloons As Collection, _
                                          ByRef style As BalloonStyle)
    If balloons.count = 0 Then Exit Sub

    Dim infos() As BalloonInfo
    ReDim infos(1 To balloons.count)

    Dim count As Long
    Dim i As Long
    For i = 1 To balloons.count
        If GetBalloonInfo(balloons(i), infos(count + 1)) Then
            count = count + 1
            infos(count).style = style
        End If
    Next i
    If count = 0 Then Exit Sub
    If count < balloons.count Then ReDim Preserve infos(1 To count)

    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then Exit Sub
    RecreateBalloonsFromInfos sld, infos, count
End Sub

Private Sub ApplyDefaultStyleToSelectedQuiet(ByRef style As BalloonStyle)
    On Error Resume Next
    Dim balloons As Collection
    Set balloons = GetSelectedBalloons()
    If Not balloons Is Nothing Then
        If balloons.count > 0 Then ApplyStyleToBalloonCollection balloons, style
    End If
    On Error GoTo 0
End Sub

Private Sub GetDefaultBalloonStyle(ByRef style As BalloonStyle)
    InitializeStandardBalloonStyle style
    On Error GoTo Done
    If Presentations.count = 0 Then Exit Sub
    If ActivePresentation.Tags.item(DefaultStyleTag("Version")) <> _
       BALLOON_DEFAULT_VERSION Then Exit Sub

    With ActivePresentation.Tags
        style.LabelShapeType = CLng(val(.item(DefaultStyleTag("ShapeType"))))
        style.LabelWidth = CSng(val(.item(DefaultStyleTag("LabelWidth"))))
        style.LabelHeight = CSng(val(.item(DefaultStyleTag("LabelHeight"))))
        ' Fill
        style.FillType = CLng(val(.item(DefaultStyleTag("FillType"))))
        style.FillVisible = CLng(val(.item(DefaultStyleTag("FillVisible"))))
        style.FillForeColor = CLng(val(.item(DefaultStyleTag("FillForeColor"))))
        style.FillBackColor = CLng(val(.item(DefaultStyleTag("FillBackColor"))))
        style.FillTransparency = CSng(val(.item(DefaultStyleTag("FillTransparency"))))
        style.FillPattern = CLng(val(.item(DefaultStyleTag("FillPattern"))))
        style.GradientStyle = CLng(val(.item(DefaultStyleTag("GradientStyle"))))
        style.GradientVariant = CLng(val(.item(DefaultStyleTag("GradientVariant"))))
        style.GradientAngle = CSng(val(.item(DefaultStyleTag("GradientAngle"))))
        style.GradientColorType = CLng(val(.item(DefaultStyleTag("GradientColorType"))))
        style.GradientDegree = CSng(val(.item(DefaultStyleTag("GradientDegree"))))
        style.GradientStopCount = CLng(val(.item(DefaultStyleTag("GradientStopCount"))))
        style.GradStopColor1 = CLng(val(.item(DefaultStyleTag("GradStopColor1"))))
        style.GradStopPos1 = CSng(val(.item(DefaultStyleTag("GradStopPos1"))))
        style.GradStopTrans1 = CSng(val(.item(DefaultStyleTag("GradStopTrans1"))))
        style.GradStopColor2 = CLng(val(.item(DefaultStyleTag("GradStopColor2"))))
        style.GradStopPos2 = CSng(val(.item(DefaultStyleTag("GradStopPos2"))))
        style.GradStopTrans2 = CSng(val(.item(DefaultStyleTag("GradStopTrans2"))))
        style.GradStopColor3 = CLng(val(.item(DefaultStyleTag("GradStopColor3"))))
        style.GradStopPos3 = CSng(val(.item(DefaultStyleTag("GradStopPos3"))))
        style.GradStopTrans3 = CSng(val(.item(DefaultStyleTag("GradStopTrans3"))))
        style.GradStopColor4 = CLng(val(.item(DefaultStyleTag("GradStopColor4"))))
        style.GradStopPos4 = CSng(val(.item(DefaultStyleTag("GradStopPos4"))))
        style.GradStopTrans4 = CSng(val(.item(DefaultStyleTag("GradStopTrans4"))))
        ' Circle border
        style.LabelLineVisible = CLng(val(.item(DefaultStyleTag("LabelLineVisible"))))
        style.LabelLineColor = CLng(val(.item(DefaultStyleTag("LabelLineColor"))))
        style.LabelLineBkColor = CLng(val(.item(DefaultStyleTag("LabelLineBkColor"))))
        style.LabelLineWeight = CSng(val(.item(DefaultStyleTag("LabelLineWeight"))))
        style.LabelLineTransparency = CSng(val(.item(DefaultStyleTag("LabelLineTransparency"))))
        style.LabelLineDash = CLng(val(.item(DefaultStyleTag("LabelLineDash"))))
        style.LabelLineStyle = CLng(val(.item(DefaultStyleTag("LabelLineStyle"))))
        ' Shadow
        style.ShadowVisible = CLng(val(.item(DefaultStyleTag("ShadowVisible"))))
        style.ShadowColor = CLng(val(.item(DefaultStyleTag("ShadowColor"))))
        style.ShadowTransparency = CSng(val(.item(DefaultStyleTag("ShadowTransparency"))))
        style.ShadowOffsetX = CSng(val(.item(DefaultStyleTag("ShadowOffsetX"))))
        style.ShadowOffsetY = CSng(val(.item(DefaultStyleTag("ShadowOffsetY"))))
        style.ShadowSize = CSng(val(.item(DefaultStyleTag("ShadowSize"))))
        style.ShadowBlur = CSng(val(.item(DefaultStyleTag("ShadowBlur"))))
        ' Glow
        style.GlowColor = CLng(val(.item(DefaultStyleTag("GlowColor"))))
        style.GlowRadius = CSng(val(.item(DefaultStyleTag("GlowRadius"))))
        style.GlowTransparency = CSng(val(.item(DefaultStyleTag("GlowTransparency"))))
        ' Soft edge / Reflection
        style.SoftEdgeType = CLng(val(.item(DefaultStyleTag("SoftEdgeType"))))
        style.ReflectionType = CLng(val(.item(DefaultStyleTag("ReflectionType"))))
        ' Font
        style.fontName = .item(DefaultStyleTag("FontName"))
        style.fontSize = CSng(val(.item(DefaultStyleTag("FontSize"))))
        style.FontColor = CLng(val(.item(DefaultStyleTag("FontColor"))))
        style.FontBold = CLng(val(.item(DefaultStyleTag("FontBold"))))
        style.FontItalic = CLng(val(.item(DefaultStyleTag("FontItalic"))))
        style.FontUnderline = CLng(val(.item(DefaultStyleTag("FontUnderline"))))
        style.FontStrikethrough = CLng(val(.item(DefaultStyleTag("FontStrikethrough"))))
        style.FontShadow = CLng(val(.item(DefaultStyleTag("FontShadow"))))
        style.FontSpacing = CSng(val(.item(DefaultStyleTag("FontSpacing"))))
        style.FontAllCaps = CLng(val(.item(DefaultStyleTag("FontAllCaps"))))
        style.FontSubscript = CLng(val(.item(DefaultStyleTag("FontSubscript"))))
        style.FontSuperscript = CLng(val(.item(DefaultStyleTag("FontSuperscript"))))
        style.FontEmboss = CLng(val(.item(DefaultStyleTag("FontEmboss"))))
        style.FontEngrave = CLng(val(.item(DefaultStyleTag("FontEngrave"))))
        ' Leader
        style.LeaderVisible = CLng(val(.item(DefaultStyleTag("LeaderVisible"))))
        style.LeaderColor = CLng(val(.item(DefaultStyleTag("LeaderColor"))))
        style.LeaderBkColor = CLng(val(.item(DefaultStyleTag("LeaderBkColor"))))
        style.LeaderWeight = CSng(val(.item(DefaultStyleTag("LeaderWeight"))))
        style.LeaderTransparency = CSng(val(.item(DefaultStyleTag("LeaderTransparency"))))
        style.LeaderDash = CLng(val(.item(DefaultStyleTag("LeaderDash"))))
        style.LeaderStyle = CLng(val(.item(DefaultStyleTag("LeaderStyle"))))
        ' Leader arrowheads
        style.PartMarker = CLng(val(.item(DefaultStyleTag("PartMarker"))))
        style.PartMarkerLength = CLng(val(.item(DefaultStyleTag("MarkerLength"))))
        style.PartMarkerWidth = CLng(val(.item(DefaultStyleTag("MarkerWidth"))))
        style.EndMarker = CLng(val(.item(DefaultStyleTag("EndMarker"))))
        style.EndMarkerLength = CLng(val(.item(DefaultStyleTag("EndMarkerLength"))))
        style.EndMarkerWidth = CLng(val(.item(DefaultStyleTag("EndMarkerWidth"))))
        ' Leader shadow
        style.LeaderShadowVisible = CLng(val(.item(DefaultStyleTag("LeaderShadowVisible"))))
        style.LeaderShadowColor = CLng(val(.item(DefaultStyleTag("LeaderShadowColor"))))
        style.LeaderShadowTransparency = CSng(val(.item(DefaultStyleTag("LeaderShadowTransparency"))))
        style.LeaderShadowOffsetX = CSng(val(.item(DefaultStyleTag("LeaderShadowOffsetX"))))
        style.LeaderShadowOffsetY = CSng(val(.item(DefaultStyleTag("LeaderShadowOffsetY"))))
        style.LeaderShadowBlur = CSng(val(.item(DefaultStyleTag("LeaderShadowBlur"))))
        style.LeaderGlowColor = CLng(val(.item(DefaultStyleTag("LeaderGlowColor"))))
        style.LeaderGlowRadius = CSng(val(.item(DefaultStyleTag("LeaderGlowRadius"))))
        style.LeaderGlowTransparency = CSng(val(.item(DefaultStyleTag("LeaderGlowTransparency"))))
    End With

Done:
    NormalizeBalloonStyle style
End Sub

Private Sub SaveDefaultBalloonStyle(ByRef style As BalloonStyle)
    NormalizeBalloonStyle style
    On Error GoTo Done
    If Presentations.count = 0 Then Exit Sub

    With ActivePresentation.Tags
        .Add DefaultStyleTag("Version"), BALLOON_DEFAULT_VERSION
        .Add DefaultStyleTag("ShapeType"), CStr(style.LabelShapeType)
        .Add DefaultStyleTag("LabelWidth"), SingleToTagText(style.LabelWidth)
        .Add DefaultStyleTag("LabelHeight"), SingleToTagText(style.LabelHeight)
        ' Fill
        .Add DefaultStyleTag("FillType"), CStr(style.FillType)
        .Add DefaultStyleTag("FillVisible"), CStr(style.FillVisible)
        .Add DefaultStyleTag("FillForeColor"), CStr(style.FillForeColor)
        .Add DefaultStyleTag("FillBackColor"), CStr(style.FillBackColor)
        .Add DefaultStyleTag("FillTransparency"), SingleToTagText(style.FillTransparency)
        .Add DefaultStyleTag("FillPattern"), CStr(style.FillPattern)
        .Add DefaultStyleTag("GradientStyle"), CStr(style.GradientStyle)
        .Add DefaultStyleTag("GradientVariant"), CStr(style.GradientVariant)
        .Add DefaultStyleTag("GradientAngle"), SingleToTagText(style.GradientAngle)
        .Add DefaultStyleTag("GradientColorType"), CStr(style.GradientColorType)
        .Add DefaultStyleTag("GradientDegree"), SingleToTagText(style.GradientDegree)
        .Add DefaultStyleTag("GradientStopCount"), CStr(style.GradientStopCount)
        .Add DefaultStyleTag("GradStopColor1"), CStr(style.GradStopColor1)
        .Add DefaultStyleTag("GradStopPos1"), SingleToTagText(style.GradStopPos1)
        .Add DefaultStyleTag("GradStopTrans1"), SingleToTagText(style.GradStopTrans1)
        .Add DefaultStyleTag("GradStopColor2"), CStr(style.GradStopColor2)
        .Add DefaultStyleTag("GradStopPos2"), SingleToTagText(style.GradStopPos2)
        .Add DefaultStyleTag("GradStopTrans2"), SingleToTagText(style.GradStopTrans2)
        .Add DefaultStyleTag("GradStopColor3"), CStr(style.GradStopColor3)
        .Add DefaultStyleTag("GradStopPos3"), SingleToTagText(style.GradStopPos3)
        .Add DefaultStyleTag("GradStopTrans3"), SingleToTagText(style.GradStopTrans3)
        .Add DefaultStyleTag("GradStopColor4"), CStr(style.GradStopColor4)
        .Add DefaultStyleTag("GradStopPos4"), SingleToTagText(style.GradStopPos4)
        .Add DefaultStyleTag("GradStopTrans4"), SingleToTagText(style.GradStopTrans4)
        ' Circle border
        .Add DefaultStyleTag("LabelLineVisible"), CStr(style.LabelLineVisible)
        .Add DefaultStyleTag("LabelLineColor"), CStr(style.LabelLineColor)
        .Add DefaultStyleTag("LabelLineBkColor"), CStr(style.LabelLineBkColor)
        .Add DefaultStyleTag("LabelLineWeight"), SingleToTagText(style.LabelLineWeight)
        .Add DefaultStyleTag("LabelLineTransparency"), SingleToTagText(style.LabelLineTransparency)
        .Add DefaultStyleTag("LabelLineDash"), CStr(style.LabelLineDash)
        .Add DefaultStyleTag("LabelLineStyle"), CStr(style.LabelLineStyle)
        ' Shadow
        .Add DefaultStyleTag("ShadowVisible"), CStr(style.ShadowVisible)
        .Add DefaultStyleTag("ShadowColor"), CStr(style.ShadowColor)
        .Add DefaultStyleTag("ShadowTransparency"), SingleToTagText(style.ShadowTransparency)
        .Add DefaultStyleTag("ShadowOffsetX"), SingleToTagText(style.ShadowOffsetX)
        .Add DefaultStyleTag("ShadowOffsetY"), SingleToTagText(style.ShadowOffsetY)
        .Add DefaultStyleTag("ShadowSize"), SingleToTagText(style.ShadowSize)
        .Add DefaultStyleTag("ShadowBlur"), SingleToTagText(style.ShadowBlur)
        ' Glow
        .Add DefaultStyleTag("GlowColor"), CStr(style.GlowColor)
        .Add DefaultStyleTag("GlowRadius"), SingleToTagText(style.GlowRadius)
        .Add DefaultStyleTag("GlowTransparency"), SingleToTagText(style.GlowTransparency)
        ' Soft edge / Reflection
        .Add DefaultStyleTag("SoftEdgeType"), CStr(style.SoftEdgeType)
        .Add DefaultStyleTag("ReflectionType"), CStr(style.ReflectionType)
        ' Font
        .Add DefaultStyleTag("FontName"), style.fontName
        .Add DefaultStyleTag("FontSize"), SingleToTagText(style.fontSize)
        .Add DefaultStyleTag("FontColor"), CStr(style.FontColor)
        .Add DefaultStyleTag("FontBold"), CStr(style.FontBold)
        .Add DefaultStyleTag("FontItalic"), CStr(style.FontItalic)
        .Add DefaultStyleTag("FontUnderline"), CStr(style.FontUnderline)
        .Add DefaultStyleTag("FontStrikethrough"), CStr(style.FontStrikethrough)
        .Add DefaultStyleTag("FontShadow"), CStr(style.FontShadow)
        .Add DefaultStyleTag("FontSpacing"), SingleToTagText(style.FontSpacing)
        .Add DefaultStyleTag("FontAllCaps"), CStr(style.FontAllCaps)
        .Add DefaultStyleTag("FontSubscript"), CStr(style.FontSubscript)
        .Add DefaultStyleTag("FontSuperscript"), CStr(style.FontSuperscript)
        .Add DefaultStyleTag("FontEmboss"), CStr(style.FontEmboss)
        .Add DefaultStyleTag("FontEngrave"), CStr(style.FontEngrave)
        ' Leader
        .Add DefaultStyleTag("LeaderVisible"), CStr(style.LeaderVisible)
        .Add DefaultStyleTag("LeaderColor"), CStr(style.LeaderColor)
        .Add DefaultStyleTag("LeaderBkColor"), CStr(style.LeaderBkColor)
        .Add DefaultStyleTag("LeaderWeight"), SingleToTagText(style.LeaderWeight)
        .Add DefaultStyleTag("LeaderTransparency"), SingleToTagText(style.LeaderTransparency)
        .Add DefaultStyleTag("LeaderDash"), CStr(style.LeaderDash)
        .Add DefaultStyleTag("LeaderStyle"), CStr(style.LeaderStyle)
        ' Leader arrowheads
        .Add DefaultStyleTag("PartMarker"), CStr(style.PartMarker)
        .Add DefaultStyleTag("MarkerLength"), CStr(style.PartMarkerLength)
        .Add DefaultStyleTag("MarkerWidth"), CStr(style.PartMarkerWidth)
        .Add DefaultStyleTag("EndMarker"), CStr(style.EndMarker)
        .Add DefaultStyleTag("EndMarkerLength"), CStr(style.EndMarkerLength)
        .Add DefaultStyleTag("EndMarkerWidth"), CStr(style.EndMarkerWidth)
        ' Leader shadow
        .Add DefaultStyleTag("LeaderShadowVisible"), CStr(style.LeaderShadowVisible)
        .Add DefaultStyleTag("LeaderShadowColor"), CStr(style.LeaderShadowColor)
        .Add DefaultStyleTag("LeaderShadowTransparency"), SingleToTagText(style.LeaderShadowTransparency)
        .Add DefaultStyleTag("LeaderShadowOffsetX"), SingleToTagText(style.LeaderShadowOffsetX)
        .Add DefaultStyleTag("LeaderShadowOffsetY"), SingleToTagText(style.LeaderShadowOffsetY)
        .Add DefaultStyleTag("LeaderShadowBlur"), SingleToTagText(style.LeaderShadowBlur)
        .Add DefaultStyleTag("LeaderGlowColor"), CStr(style.LeaderGlowColor)
        .Add DefaultStyleTag("LeaderGlowRadius"), SingleToTagText(style.LeaderGlowRadius)
        .Add DefaultStyleTag("LeaderGlowTransparency"), SingleToTagText(style.LeaderGlowTransparency)
    End With

Done:
End Sub

Private Function DefaultStyleTag(ByVal suffix As String) As String
    DefaultStyleTag = BALLOON_DEFAULT_TAG_PREFIX & suffix
End Function

Private Function SingleToTagText(ByVal value As Single) As String
    SingleToTagText = Trim$(Str$(value))
End Function

Private Sub RefreshBalloonFormatRibbon()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "cbBalloonLabelSize"
        AppRibbonUI.InvalidateControl "cbBalloonFontSize"
        AppRibbonUI.InvalidateControl "cbBalloonLineWeight"
        AppRibbonUI.InvalidateControl "ddBalloonDash"
        AppRibbonUI.InvalidateControl "ddBalloonMarker"
        AppRibbonUI.InvalidateControl "tglBalloonBold"
    End If
    On Error GoTo 0
End Sub

Private Sub RefreshBalloonDrawRibbon()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "btnBalloonDrawLine"
        AppRibbonUI.InvalidateControl "tglBalloonDrawQueue"
    End If
    On Error GoTo 0
End Sub

Private Sub BalloonExitNativeDrawTool()
    On Error Resume Next
    Application.CommandBars.ExecuteMso "ObjectsSelect"
    If Err.Number <> 0 Then
        Err.Clear
        ActiveWindow.Selection.Unselect
    End If
    On Error GoTo 0
End Sub

Private Function RenumberBalloonCollection(ByVal balloons As Collection, ByVal startNumber As Long) As Long
    If balloons.count = 0 Then
        RenumberBalloonCollection = startNumber
        Exit Function
    End If
    SortBalloonsTopLeft balloons

    Dim i As Long
    For i = 1 To balloons.count
        SetBalloonNumber balloons(i), startNumber + i - 1
    Next i
    RenumberBalloonCollection = startNumber + balloons.count
End Function

Private Function GetSlideBalloons(ByVal sld As Slide) As Collection
    Dim result As New Collection
    Dim shp As Shape
    For Each shp In sld.shapes
        If IsBalloonGroup(shp) Then result.Add shp
    Next shp
    Set GetSlideBalloons = result
End Function

Private Function GetSelectedBalloons() As Collection
    Dim result As New Collection
    On Error GoTo Done

    Dim sel As Selection
    Set sel = ActiveWindow.Selection
    If sel.Type <> ppSelectionShapes Then GoTo Done

    Dim i As Long
    Dim shp As Shape
    For i = 1 To sel.ShapeRange.count
        Set shp = sel.ShapeRange(i)
        If IsBalloonGroup(shp) Then result.Add shp
    Next i

Done:
    Set GetSelectedBalloons = result
End Function

Private Function IsBalloonGroup(ByVal shp As Shape) As Boolean
    On Error Resume Next
    IsBalloonGroup = (shp.Type = msoGroup And _
                      shp.Tags.item(BALLOON_TAG_KIND) = BALLOON_KIND_GROUP)
    On Error GoTo 0
End Function

Private Function CollectSelectedBalloonInfos(ByRef infos() As BalloonInfo) As Long
    Dim balloons As Collection
    Set balloons = GetSelectedBalloons()
    If balloons.count = 0 Then Exit Function

    ReDim infos(1 To balloons.count)

    Dim i As Long
    Dim count As Long
    For i = 1 To balloons.count
        count = count + 1
        If Not GetBalloonInfo(balloons(i), infos(count)) Then
            count = count - 1
        End If
    Next i

    If count > 0 Then ReDim Preserve infos(1 To count)
    CollectSelectedBalloonInfos = count
End Function

Private Function GetBalloonInfo(ByVal balloon As Shape, ByRef info As BalloonInfo) As Boolean
    If Not IsBalloonGroup(balloon) Then Exit Function

    info.shapeName = balloon.name
    info.Number = CLng(val(balloon.Tags.item(BALLOON_TAG_NUMBER)))
    If info.Number <= 0 Then info.Number = 1

    ' Read the displayed geometry first. Tags describe the creation geometry and
    ' become stale after the user moves, resizes, flips, or rotates a group.
    If ReadDisplayedBalloonGeometry(balloon, info) Then
        CaptureBalloonStyle balloon, info.style
        GetBalloonInfo = True
        Exit Function
    End If

    ' Keep tag fallback for older or partially edited balloon groups.
    If ReadBalloonGeometryTags(balloon, info) Then
        CaptureBalloonStyle balloon, info.style
        GetBalloonInfo = True
    End If
End Function

Private Function ReadDisplayedBalloonGeometry(ByVal balloon As Shape, _
                                               ByRef info As BalloonInfo) As Boolean
    On Error GoTo Failed

    Dim child As Shape
    Dim labelShape As Shape
    Dim leaderShape As Shape

    For Each child In balloon.GroupItems
        Select Case child.Tags.item(BALLOON_TAG_KIND)
            Case BALLOON_KIND_CIRCLE
                Set labelShape = child
            Case BALLOON_KIND_LEADER
                Set leaderShape = child
        End Select
    Next child

    If labelShape Is Nothing Or leaderShape Is Nothing Then Exit Function

    info.bubbleX = labelShape.left + labelShape.width / 2
    info.bubbleY = labelShape.Top + labelShape.height / 2

    FindLeaderPartEndpoint leaderShape, info.bubbleX, info.bubbleY, _
                           info.partX, info.partY

    ReadDisplayedBalloonGeometry = True
    Exit Function

Failed:
    ReadDisplayedBalloonGeometry = False
End Function

Private Sub FindLeaderPartEndpoint(ByVal leaderShape As Shape, _
                                   ByVal bubbleX As Single, _
                                   ByVal bubbleY As Single, _
                                   ByRef partX As Single, _
                                   ByRef partY As Single)
    Dim leftX As Single, topY As Single
    Dim rightX As Single, bottomY As Single
    leftX = leaderShape.left
    topY = leaderShape.Top
    rightX = leaderShape.left + leaderShape.width
    bottomY = leaderShape.Top + leaderShape.height

    ' A line occupies one of the two diagonals of its bounding box. Choose the
    ' diagonal whose nearest endpoint is closest to the circle center, then use
    ' the opposite endpoint as the fixed part anchor.
    Dim a1Distance As Double, a2Distance As Double
    Dim b1Distance As Double, b2Distance As Double
    a1Distance = DistanceSquared(leftX, topY, bubbleX, bubbleY)
    a2Distance = DistanceSquared(rightX, bottomY, bubbleX, bubbleY)
    b1Distance = DistanceSquared(leftX, bottomY, bubbleX, bubbleY)
    b2Distance = DistanceSquared(rightX, topY, bubbleX, bubbleY)

    If MinDouble(a1Distance, a2Distance) <= MinDouble(b1Distance, b2Distance) Then
        If a1Distance >= a2Distance Then
            partX = leftX
            partY = topY
        Else
            partX = rightX
            partY = bottomY
        End If
    Else
        If b1Distance >= b2Distance Then
            partX = leftX
            partY = bottomY
        Else
            partX = rightX
            partY = topY
        End If
    End If
End Sub

Private Function MinDouble(ByVal valueA As Double, ByVal valueB As Double) As Double
    If valueA < valueB Then
        MinDouble = valueA
    Else
        MinDouble = valueB
    End If
End Function

Private Function ReadBalloonGeometryTags(ByVal balloon As Shape, _
                                         ByRef info As BalloonInfo) As Boolean
    Dim rawPartX As String
    rawPartX = balloon.Tags.item(BALLOON_TAG_PART_X)
    If Len(rawPartX) = 0 Then Exit Function

    info.partX = CSng(val(rawPartX))
    info.partY = CSng(val(balloon.Tags.item(BALLOON_TAG_PART_Y)))
    info.bubbleX = CSng(val(balloon.Tags.item(BALLOON_TAG_BUBBLE_X)))
    info.bubbleY = CSng(val(balloon.Tags.item(BALLOON_TAG_BUBBLE_Y)))
    ReadBalloonGeometryTags = True
End Function

Private Sub AddBalloonGeometryTags(ByVal balloon As Shape, _
                                   ByRef spec As BalloonLineSpec)
    balloon.Tags.Add BALLOON_TAG_PART_X, CStr(spec.partX)
    balloon.Tags.Add BALLOON_TAG_PART_Y, CStr(spec.partY)
    balloon.Tags.Add BALLOON_TAG_BUBBLE_X, CStr(spec.bubbleX)
    balloon.Tags.Add BALLOON_TAG_BUBBLE_Y, CStr(spec.bubbleY)
End Sub

Private Sub RecreateBalloonsFromInfos(ByVal sld As Slide, _
                                      ByRef infos() As BalloonInfo, _
                                      ByVal count As Long)
    Dim i As Long
    Dim spec As BalloonLineSpec
    Dim created As Shape
    Dim newNames() As Variant
    Dim oldBusy As Boolean

    oldBusy = BalloonEventBusy
    BalloonEventBusy = True
    On Error GoTo CleanFail

    ReDim newNames(1 To count)

    For i = 1 To count
        On Error Resume Next
        sld.shapes(infos(i).shapeName).Delete
        On Error GoTo 0
    Next i
    On Error GoTo CleanFail

    For i = 1 To count
        spec.partX = infos(i).partX
        spec.partY = infos(i).partY
        spec.bubbleX = infos(i).bubbleX
        spec.bubbleY = infos(i).bubbleY

        Set created = CreateBalloonFromSpecWithStyle( _
                        sld, spec, infos(i).Number, infos(i).style)
        newNames(i) = created.name
    Next i

    sld.shapes.Range(newNames).Select
    BalloonEventBusy = oldBusy
    Exit Sub

CleanFail:
    Dim errNumber As Long
    Dim errDescription As String
    errNumber = Err.Number
    errDescription = Err.Description
    BalloonEventBusy = oldBusy
    Err.Raise errNumber, "RecreateBalloonsFromInfos", errDescription
End Sub

Private Sub SortBalloonInfos(ByRef infos() As BalloonInfo, _
                             ByVal count As Long, _
                             ByVal axis As String)
    Dim i As Long, j As Long
    For i = 1 To count - 1
        For j = i + 1 To count
            If BalloonInfoComesAfter(infos(i), infos(j), axis) Then
                SwapBalloonInfos infos(i), infos(j)
            End If
        Next j
    Next i
End Sub

Private Function BalloonInfoComesAfter(ByRef a As BalloonInfo, _
                                       ByRef b As BalloonInfo, _
                                       ByVal axis As String) As Boolean
    If axis = "X" Then
        BalloonInfoComesAfter = (a.bubbleX > b.bubbleX)
    Else
        BalloonInfoComesAfter = (a.bubbleY > b.bubbleY)
    End If
End Function

Private Sub SwapBalloonInfos(ByRef a As BalloonInfo, ByRef b As BalloonInfo)
    Dim temp As BalloonInfo
    temp = a
    a = b
    b = temp
End Sub

Private Function NextBalloonNumber(ByVal sld As Slide) As Long
    Dim maxNumber As Long
    Dim shp As Shape
    Dim rawNumber As String

    For Each shp In sld.shapes
        If IsBalloonGroup(shp) Then
            rawNumber = shp.Tags.item(BALLOON_TAG_NUMBER)
            If val(rawNumber) > maxNumber Then maxNumber = CLng(val(rawNumber))
        End If
    Next shp

    NextBalloonNumber = maxNumber + 1
End Function

Private Sub SortBalloonsTopLeft(ByVal balloons As Collection)
    Dim i As Long, j As Long
    For i = 1 To balloons.count - 1
        For j = i + 1 To balloons.count
            If BalloonComesAfter(balloons(i), balloons(j)) Then
                SwapCollectionItems balloons, i, j
            End If
        Next j
    Next i
End Sub

Private Function BalloonComesAfter(ByVal a As Shape, ByVal b As Shape) As Boolean
    If Abs(a.Top - b.Top) > 4 Then
        BalloonComesAfter = (a.Top > b.Top)
    Else
        BalloonComesAfter = (a.left > b.left)
    End If
End Function

Private Sub SwapCollectionItems(ByVal items As Collection, ByVal indexA As Long, ByVal indexB As Long)
    Dim values() As Shape
    Dim i As Long
    ReDim values(1 To items.count)

    For i = 1 To items.count
        Set values(i) = items(i)
    Next i

    Dim temp As Shape
    Set temp = values(indexA)
    Set values(indexA) = values(indexB)
    Set values(indexB) = temp

    For i = items.count To 1 Step -1
        items.Remove i
    Next i

    For i = 1 To UBound(values)
        items.Add values(i)
    Next i
End Sub

Private Sub PointOnLabelToward(ByVal centerX As Single, _
                               ByVal centerY As Single, _
                               ByVal targetX As Single, _
                               ByVal targetY As Single, _
                               ByVal radiusX As Single, _
                               ByVal radiusY As Single, _
                               ByVal ShapeType As Long, _
                               ByRef edgeX As Single, _
                               ByRef edgeY As Single)
    Dim dx As Single, dy As Single
    dx = targetX - centerX
    dy = targetY - centerY
    If Abs(dx) <= 0.01 And Abs(dy) <= 0.01 Then
        edgeX = centerX
        edgeY = centerY
        Exit Sub
    End If

    Dim edgeScale As Double
    If ShapeType = msoShapeOval Then
        edgeScale = 1 / Sqr((CDbl(dx) * dx) / (CDbl(radiusX) * radiusX) + _
                            (CDbl(dy) * dy) / (CDbl(radiusY) * radiusY))
    Else
        Dim horizontalScale As Double, verticalScale As Double
        horizontalScale = 1E+30
        verticalScale = 1E+30
        If Abs(dx) > 0.01 Then horizontalScale = radiusX / Abs(dx)
        If Abs(dy) > 0.01 Then verticalScale = radiusY / Abs(dy)
        edgeScale = MinDouble(horizontalScale, verticalScale)
    End If

    edgeX = centerX + CSng(dx * edgeScale)
    edgeY = centerY + CSng(dy * edgeScale)
End Sub

Private Function DistanceSquared(ByVal x1 As Single, ByVal y1 As Single, _
                                 ByVal x2 As Single, ByVal y2 As Single) As Double
    DistanceSquared = CDbl(x1 - x2) * CDbl(x1 - x2) + _
                      CDbl(y1 - y2) * CDbl(y1 - y2)
End Function

Private Function UniqueShapeName(ByVal sld As Slide, ByVal prefix As String) As String
    Dim candidate As String
    Do
        candidate = prefix & "_" & Format$(Timer * 1000, "0") & "_" & CStr(Int(Rnd() * 100000))
    Loop While ShapeNameExists(sld, candidate)
    UniqueShapeName = candidate
End Function

Private Function ShapeNameExists(ByVal sld As Slide, ByVal shapeName As String) As Boolean
    On Error Resume Next
    Dim shp As Shape
    Set shp = sld.shapes(shapeName)
    ShapeNameExists = Not (shp Is Nothing)
    On Error GoTo 0
End Function

