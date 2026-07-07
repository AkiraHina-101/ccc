Attribute VB_Name = "ModHyperMeshCapture"
Option Explicit

' -----------------------------------------------------------------------------
' HANDOFF
' App     : PowerPoint
' Status  : DONE (2026-07-05 session)
' Done    : Sharp-axes overlay for high-res captures now measures the real
'           Global Axes bounding box in Tcl (read-only `image get`, never
'           writes/crops the PNG there - Tk's PNG writer washes out red/green)
'           and reports it as a fraction of image size; VBA applies the crop
'           natively via PictureFormat with a DPI-probe technique (see
'           CropCustomRatio for the original pattern) and flattens the main
'           capture + axis overlay into a single picture via Copy +
'           Shapes.PasteSpecial(ppPastePNG) - Shape.Export was proven to
'           silently ignore ScaleWidth/ScaleHeight/ExportMode in this
'           environment and must not be used for flattening.
'           HyperMesh's live Global Axes state is now fully decoupled from
'           captures: the Ribbon "Axes" checkbox (OnHyperMeshGlobalAxes) only
'           records intent for the next capture request and no longer sends a
'           live *showglobalaxes toggle; hm_ppt_request_watcher.tcl::capture
'           unconditionally forces Global Axes back ON in HyperMesh after
'           every capture, regardless of what axes_state/hide_axes/
'           sharp_axes did internally or was requested for the image.
'           CropCustomRatio (Capture Crop H:W ratio) now falls back to
'           cropping HEIGHT when the requested ratio is wider than the
'           native capture (previously silently no-op'd, leaving the wrong
'           ratio with no indication).
'           Removed dead code: GetHyperMeshCaptureResolution/
'           OnHyperMeshCaptureResolution (orphaned dropDown variant, never
'           referenced by ribbon.xml), CaptureResolutionScaleId,
'           SendSetAxesRequest/SendSetAxesRequestForPid, GetExportPixelSize,
'           and the Tcl "setaxes" mode handler (nothing sends it anymore).
'           Full package rebuilt via tools/import_compile_pptm.ps1 +
'           build_guard_static_zip.py inject (VBE compile clean, ribbon.xml
'           customUI re-injected so the Resolution menu's dynamic
'           "Resolution: Nx" label - GetHyperMeshCaptureResolutionLabel -
'           actually takes effect; a plain VBA hot-swap via
'           VBComponents.Import does NOT touch the ribbon customUI part).
' Next    : No open items from this session. If axis placement in HyperMesh
'           ever moves off the bottom-left corner, CropCustomRatio's
'           width-crop-keeps-LEFT assumption and FlattenSharpAxesIntoMain's
'           bottom-left overlay placement both need revisiting together.
' Known   : measure_axis_bbox's search window is a generous bottom-left
'           quarter of the image - safe for the corner-anchored HyperMesh
'           Global Axes glyph, but not a general-purpose bbox detector.
'           axes_state=0 requests (axes explicitly off in the image) still
'           rely on HyperMesh momentarily having axes off for that one
'           capture; live axes are always restored to ON afterward per the
'           "PPT axes must never affect the real HyperMesh session" rule.
' Entry   : HyperMeshCaptureModelWindowToSlide / HyperMeshCaptureFocusToSlide
'           / HyperMeshCaptureCustomToSlide / HyperMeshGetModelInfoToSlide.
' Objects : Slide shapes named "HM_Live_Capture_*" (final flattened picture),
'           transiently "HM_Sharp_Axes_*" (deleted after flatten), and
'           "HM_ModelInfo_*" (model info table). Counterpart Tcl bridge:
'           hm_ppt_bridge/hm_ppt_request_watcher.tcl.
' -----------------------------------------------------------------------------

Private Const HM_BRIDGE_DIR As String = "hm_ppt_bridge"
Private Const HM_REQUEST_FILE As String = "hm_ppt_request.txt"
Private Const HM_RESPONSE_FILE As String = "hm_ppt_response.txt"
Private Const HM_CAPTURE_TIMEOUT_SECONDS As Single = 30!
Private Const HM_FIXED_WIDTH As Long = 1600
Private Const HM_FIXED_HEIGHT As Long = 1600
Private Const HM_IMAGE_QUALITY As Long = 100
Private Const HM_SETTINGS_APP As String = "PPTX_TOOL"
Private Const HM_SETTINGS_SECTION As String = "HyperMeshCapture"

Private Declare PtrSafe Function EnumWindows Lib "user32" (ByVal lpEnumFunc As LongPtr, ByVal lParam As LongPtr) As Long
Private Declare PtrSafe Function IsWindowVisible Lib "user32" (ByVal hWnd As LongPtr) As Long
Private Declare PtrSafe Function GetWindowTextLengthW Lib "user32" (ByVal hWnd As LongPtr) As Long
Private Declare PtrSafe Function GetWindowTextW Lib "user32" (ByVal hWnd As LongPtr, ByVal lpString As LongPtr, ByVal nMaxCount As Long) As Long
Private Declare PtrSafe Function GetWindowThreadProcessId Lib "user32" (ByVal hWnd As LongPtr, ByRef lpdwProcessId As Long) As Long

Private mFoundHyperMeshPid As Long
Private mTransparentWhite As Boolean
Private mCustomRatioH As Double
Private mCustomRatioW As Double
Private mGlobalAxesOn As Boolean
Private mHideAxesForCapture As Boolean
Private mGlobalAxesInitialized As Boolean
Private mCaptureResolutionScale As Double
Private mCustomRatioInitialized As Boolean

Public Sub GetHyperMeshGlobalAxes(control As IRibbonControl, ByRef returnedVal)
    EnsureHyperMeshGlobalAxesDefaults
    returnedVal = mGlobalAxesOn
End Sub

' This only records the axes state to send with the NEXT capture request
' (see WriteHyperMeshRequest / HyperMeshGlobalAxesOn) - it deliberately does
' NOT toggle HyperMesh's live viewport in real time anymore. Axes shown in a
' PowerPoint capture must only ever affect that captured image, never the
' actual HyperMesh session state; the bridge (hm_ppt_request_watcher.tcl::
' capture) always forces Global Axes back ON in HyperMesh once a capture
' finishes, regardless of what axes_state was requested for the image.
Public Sub OnHyperMeshGlobalAxes(control As IRibbonControl, ByVal pressed As Boolean)
    mGlobalAxesOn = pressed
    mGlobalAxesInitialized = True
End Sub

Public Sub GetHyperMeshHideAxesForCapture(control As IRibbonControl, ByRef returnedVal)
    returnedVal = mHideAxesForCapture
End Sub

Public Sub OnHyperMeshHideAxesForCapture(control As IRibbonControl, ByVal pressed As Boolean)
    mHideAxesForCapture = pressed
End Sub

Public Sub GetHyperMeshTransparentWhite(control As IRibbonControl, ByRef returnedVal)
    returnedVal = mTransparentWhite
End Sub

Public Sub OnHyperMeshTransparentWhite(control As IRibbonControl, ByVal pressed As Boolean)
    mTransparentWhite = pressed
End Sub

Public Sub GetHyperMeshCaptureResolutionLabel(control As IRibbonControl, ByRef returnedVal)
    returnedVal = "Resolution: " & CaptureResolutionScaleText()
End Sub

Public Sub OnHyperMeshCaptureResolutionMenu(control As IRibbonControl)
    Select Case control.tag
        Case "1.5"
            mCaptureResolutionScale = 1.5
        Case "2"
            mCaptureResolutionScale = 2
        Case "3"
            mCaptureResolutionScale = 3
        Case Else
            mCaptureResolutionScale = 1
    End Select
    RefreshHyperMeshCaptureResolutionUI
End Sub

' Invalidates the menu's own face (its getLabel="GetHyperMeshCaptureResolutionLabel")
' plus every child button - some Office builds do not reliably repaint a <menu>
' control's own face label from InvalidateControl on just the parent id, but
' invalidating a child forces Office to recompute the whole control's tree.
Private Sub RefreshHyperMeshCaptureResolutionUI()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "mnuHyperMeshCaptureResolution"
        AppRibbonUI.InvalidateControl "btnHyperMeshCaptureRes1x"
        AppRibbonUI.InvalidateControl "btnHyperMeshCaptureRes15x"
        AppRibbonUI.InvalidateControl "btnHyperMeshCaptureRes2x"
        AppRibbonUI.InvalidateControl "btnHyperMeshCaptureRes3x"
    End If
    On Error GoTo 0
End Sub

Private Sub RefreshHyperMeshCustomRatioUI()
    On Error Resume Next
    If Not AppRibbonUI Is Nothing Then
        AppRibbonUI.InvalidateControl "txtHyperMeshCustomHeight"
        AppRibbonUI.InvalidateControl "txtHyperMeshCustomWidth"
        AppRibbonUI.InvalidateControl "chkHyperMeshDefaultRatio1x1"
        AppRibbonUI.InvalidateControl "chkHyperMeshDefaultRatio1x15"
        AppRibbonUI.InvalidateControl "chkHyperMeshDefaultRatio1x2"
        AppRibbonUI.InvalidateControl "chkHyperMeshDefaultRatio3x4"
    End If
    On Error GoTo 0
End Sub

Private Function CaptureResolutionScale() As Double
    If mCaptureResolutionScale < 1# Then mCaptureResolutionScale = 1#
    If mCaptureResolutionScale > 3# Then mCaptureResolutionScale = 3#
    CaptureResolutionScale = mCaptureResolutionScale
End Function

Private Function CaptureResolutionScaleText() As String
    If Abs(CaptureResolutionScale() - 1.5) < 0.01 Then
        CaptureResolutionScaleText = "1.5x"
    Else
        CaptureResolutionScaleText = CStr(CLng(CaptureResolutionScale())) & "x"
    End If
End Function

' Custom capture always keeps the HyperMesh window's FULL NATIVE HEIGHT and
' never fits/zooms/rotates the view (the user frames the model manually in
' HyperMesh first). H and W here are NOT pixels - they are an H:W ratio
' (e.g. H=9, W=16) used only to derive the capture WIDTH from that fixed
' native height. Blank/Auto input is normalized to 1:1.
Public Sub GetHyperMeshCustomHeight(control As IRibbonControl, ByRef returnedVal)
    EnsureHyperMeshCustomRatioDefaults
    returnedVal = CustomRatioText(mCustomRatioH)
End Sub

Public Sub OnHyperMeshCustomHeight(control As IRibbonControl, ByVal text As String)
    EnsureHyperMeshCustomRatioDefaults
    mCustomRatioH = ParseCustomRatio(text)
    RefreshHyperMeshCustomRatioUI
End Sub

Public Sub GetHyperMeshCustomWidth(control As IRibbonControl, ByRef returnedVal)
    EnsureHyperMeshCustomRatioDefaults
    returnedVal = CustomRatioText(mCustomRatioW)
End Sub

Public Sub OnHyperMeshCustomWidth(control As IRibbonControl, ByVal text As String)
    EnsureHyperMeshCustomRatioDefaults
    mCustomRatioW = ParseCustomRatio(text)
    RefreshHyperMeshCustomRatioUI
End Sub

Public Sub OnHyperMeshCustomRatioSaveDefault(control As IRibbonControl)
    EnsureHyperMeshCustomRatioDefaults
    SaveHyperMeshCustomRatioDefault mCustomRatioH, mCustomRatioW
    RefreshHyperMeshCustomRatioUI
End Sub

Public Sub GetHyperMeshCustomRatioDefaultPressed(control As IRibbonControl, ByRef returnedVal)
    EnsureHyperMeshCustomRatioDefaults
    returnedVal = RatioTagMatches(control.tag, mCustomRatioH, mCustomRatioW)
End Sub

Public Sub OnHyperMeshCustomRatioDefault(control As IRibbonControl, ByVal pressed As Boolean)
    If Not pressed Then Exit Sub
    ApplyHyperMeshCustomRatioTag control.tag, True
    RefreshHyperMeshCustomRatioUI
End Sub

Private Function CustomRatioText(ByVal value As Double) As String
    If value <= 0# Then value = 1#
    If value > 0# Then
        If Abs(value - CLng(value)) < 0.0001 Then
            CustomRatioText = CStr(CLng(value))
        Else
            CustomRatioText = Replace(Format$(value, "0.###"), ",", ".")
        End If
    End If
End Function

Private Function ParseCustomRatio(ByVal text As String) As Double
    Dim cleanText As String
    cleanText = Replace(Trim$(text), ",", ".")
    If Len(cleanText) = 0 Or LCase$(cleanText) = "auto" Then
        ParseCustomRatio = 1#
        Exit Function
    End If

    Dim value As Double
    value = val(cleanText)
    If value <= 0# Then value = 1#
    ParseCustomRatio = value
End Function

Private Sub EnsureHyperMeshCustomRatioDefaults()
    If mCustomRatioInitialized Then Exit Sub
    mCustomRatioH = ReadHyperMeshCustomRatioSetting("CustomRatioH", 1#)
    mCustomRatioW = ReadHyperMeshCustomRatioSetting("CustomRatioW", 1#)
    If mCustomRatioH <= 0# Then mCustomRatioH = 1#
    If mCustomRatioW <= 0# Then mCustomRatioW = 1#
    mCustomRatioInitialized = True
End Sub

Private Function ReadHyperMeshCustomRatioSetting(ByVal key As String, ByVal defaultValue As Double) As Double
    Dim raw As String
    raw = GetSetting(HM_SETTINGS_APP, HM_SETTINGS_SECTION, key, Replace(CStr(defaultValue), ",", "."))
    raw = Replace(Trim$(raw), ",", ".")
    ReadHyperMeshCustomRatioSetting = val(raw)
    If ReadHyperMeshCustomRatioSetting <= 0# Then ReadHyperMeshCustomRatioSetting = defaultValue
End Function

Private Sub SaveHyperMeshCustomRatioDefault(ByVal ratioH As Double, ByVal ratioW As Double)
    If ratioH <= 0# Then ratioH = 1#
    If ratioW <= 0# Then ratioW = 1#
    SaveSetting HM_SETTINGS_APP, HM_SETTINGS_SECTION, "CustomRatioH", Replace(CStr(ratioH), ",", ".")
    SaveSetting HM_SETTINGS_APP, HM_SETTINGS_SECTION, "CustomRatioW", Replace(CStr(ratioW), ",", ".")
End Sub

Private Sub ApplyHyperMeshCustomRatioTag(ByVal tag As String, ByVal saveAsDefault As Boolean)
    Select Case tag
        Case "1:1.5"
            mCustomRatioH = 1#
            mCustomRatioW = 1.5
        Case "1:2"
            mCustomRatioH = 1#
            mCustomRatioW = 2#
        Case "3:4"
            mCustomRatioH = 3#
            mCustomRatioW = 4#
        Case Else
            mCustomRatioH = 1#
            mCustomRatioW = 1#
    End Select
    mCustomRatioInitialized = True
    If saveAsDefault Then SaveHyperMeshCustomRatioDefault mCustomRatioH, mCustomRatioW
End Sub

Private Function RatioTagMatches(ByVal tag As String, ByVal ratioH As Double, ByVal ratioW As Double) As Boolean
    Select Case tag
        Case "1:1.5"
            RatioTagMatches = (Abs(ratioH - 1#) < 0.0001 And Abs(ratioW - 1.5) < 0.0001)
        Case "1:2"
            RatioTagMatches = (Abs(ratioH - 1#) < 0.0001 And Abs(ratioW - 2#) < 0.0001)
        Case "3:4"
            RatioTagMatches = (Abs(ratioH - 3#) < 0.0001 And Abs(ratioW - 4#) < 0.0001)
        Case Else
            RatioTagMatches = (Abs(ratioH - 1#) < 0.0001 And Abs(ratioW - 1#) < 0.0001)
    End Select
End Function

Public Sub HyperMeshGetModelInfoToSlide()
    On Error GoTo EH

    Dim targetPid As Long
    targetPid = FindActiveHyperMeshProcessId()
    If targetPid = 0 Then
        ShowError "No HyperMesh window found. Open HyperMesh and try again."
        Exit Sub
    End If

    Dim bridgeDir As String
    bridgeDir = HyperMeshBridgeDir()
    EnsureFolderExists bridgeDir

    Dim watcherPath As String
    watcherPath = JoinPath(bridgeDir, "hm_ppt_request_watcher.tcl")
    If Not FileExists(watcherPath) Then
        ShowError "This tool's bridge folder is missing the Tcl watcher." & vbCrLf & vbCrLf & _
            "Expected watcher file here:" & vbCrLf & watcherPath & vbCrLf & vbCrLf & _
            "Copy hm_ppt_bridge (with hm_ppt_request_watcher.tcl) next to this " & _
            "PPTX_TOOL_SHARE.ppam/.pptm file, then in HyperMesh's Tcl console run:" & vbCrLf & _
            "source {" & ToTclPath(watcherPath) & "}"
        Exit Sub
    End If

    Dim requestPath As String
    Dim responsePath As String
    requestPath = JoinPath(bridgeDir, HM_REQUEST_FILE)
    responsePath = JoinPath(bridgeDir, HM_RESPONSE_FILE)
    DeleteFileIfExists responsePath

    Dim requestId As String
    requestId = NewRequestId()
    WriteHyperMeshRequest requestPath, requestId, "modelinfo", targetPid, False, HyperMeshGlobalAxesOn(), HM_FIXED_WIDTH, HM_FIXED_HEIGHT

    Dim info As Object
    Set info = WaitForHyperMeshInfoResponse(responsePath, requestId)
    If info Is Nothing Then Exit Sub

    InsertModelInfoTable info
    Exit Sub

EH:
    ShowError "Could not get model info from HyperMesh: " & Err.Description
End Sub

Private Function WaitForHyperMeshInfoResponse(ByVal responsePath As String, _
                                              ByVal requestId As String) As Object
    Dim startTime As Single
    startTime = Timer

    Do
        DoEvents
        If FileExists(responsePath) Then
            Dim response As Object
            Set response = ReadKeyValueFile(responsePath)
            If response.Exists("id") Then
                If CStr(response("id")) = requestId Then
                    If response.Exists("status") And CStr(response("status")) = "ok" Then
                        Set WaitForHyperMeshInfoResponse = response
                        Exit Function
                    Else
                        Dim errText As String
                        If response.Exists("error") Then errText = CStr(response("error"))
                        If Len(errText) = 0 Then errText = "HyperMesh returned an unknown model info error."
                        ShowError errText
                        Exit Function
                    End If
                End If
            End If
        End If

        If ElapsedSeconds(startTime) >= HM_CAPTURE_TIMEOUT_SECONDS Then
            ShowError "HyperMesh model info request timed out." & vbCrLf & vbCrLf & _
                "This tool expects its bridge folder here:" & vbCrLf & _
                HyperMeshBridgeDir() & vbCrLf & vbCrLf & _
                "In THAT HyperMesh window's Tcl console (each open HyperMesh window " & _
                "needs its own source once), run:" & vbCrLf & _
                "source {" & ToTclPath(JoinPath(HyperMeshBridgeDir(), "hm_ppt_request_watcher.tcl")) & "}"
            Exit Function
        End If
    Loop
End Function

' Same order as the "by config" candidate list tried in
' hm_ppt_request_watcher.tcl::get_model_info, so config rows appear in a
' stable, sensible order. Only configs the watcher found with count > 0
' are present as "cfg_<name>" keys in info - anything else is skipped
' entirely instead of printing a hardcoded zero row.
Private Function HyperMeshConfigOrder() As Variant
    HyperMeshConfigOrder = Array("rod", "bar2", "bar3", "tria3", "tria6", _
        "quad4", "quad8", "tetra4", "tetra10", "penta6", "penta15", _
        "hex8", "hex20", "pyramid5", "pyramid13", "mass", "rigid", _
        "rigidlink", "spring", "joint", "gap", "rbe3")
End Function

Private Sub InsertModelInfoTable(ByVal info As Object)
    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then
        ShowError "Open a slide before getting HyperMesh model info."
        Exit Sub
    End If

    Dim configKeys As Collection
    Dim configLabels As Collection
    Set configKeys = New Collection
    Set configLabels = New Collection

    Dim cfg As Variant
    For Each cfg In HyperMeshConfigOrder()
        Dim key As String
        key = "cfg_" & CStr(cfg)
        If info.Exists(key) Then
            configKeys.Add key
            configLabels.Add UCase$(left$(CStr(cfg), 1)) & Mid$(CStr(cfg), 2)
        End If
    Next cfg

    Dim rowCount As Long
    rowCount = 1 + 3 + configKeys.count ' header + Nodes/Elements/Total Mass + configs

    Dim tbl As Shape
    Set tbl = sld.shapes.AddTable(rowCount, 2, 60, 60, 260, 20 * rowCount)
    tbl.name = UniqueShapeName(sld, "HM_ModelInfo")

    tbl.Table.cell(1, 1).Shape.TextFrame.TextRange.text = "Field"
    tbl.Table.cell(1, 2).Shape.TextFrame.TextRange.text = "Value (displayed)"

    SetModelInfoRow tbl, 2, "Nodes", info, "nodes"
    SetModelInfoRow tbl, 3, "Elements", info, "elems"
    tbl.Table.cell(4, 1).Shape.TextFrame.TextRange.text = "Total Mass"
    tbl.Table.cell(4, 2).Shape.TextFrame.TextRange.text = FormatMassKg(InfoValue(info, "mass"))

    Dim i As Long
    For i = 1 To configKeys.count
        tbl.Table.cell(4 + i, 1).Shape.TextFrame.TextRange.text = configLabels(i)
        tbl.Table.cell(4 + i, 2).Shape.TextFrame.TextRange.text = InfoValue(info, configKeys(i))
    Next i

    tbl.Select
End Sub

Private Function InfoValue(ByVal info As Object, ByVal key As String) As String
    If info.Exists(key) Then InfoValue = CStr(info(key))
End Function

Private Sub SetModelInfoRow(ByVal tbl As Shape, ByVal rowIndex As Long, _
                            ByVal label As String, ByVal info As Object, ByVal key As String)
    tbl.Table.cell(rowIndex, 1).Shape.TextFrame.TextRange.text = label
    tbl.Table.cell(rowIndex, 2).Shape.TextFrame.TextRange.text = InfoValue(info, key)
End Sub

' HyperMesh reports mass in tonnes for this model's unit system; convert to
' kg (x1000) and round to 3 decimal places for the table.
Private Function FormatMassKg(ByVal rawMassTon As String) As String
    If Len(Trim$(rawMassTon)) = 0 Then
        FormatMassKg = ""
        Exit Function
    End If
    On Error GoTo Fallback
    ' Val() always parses "." as the decimal separator regardless of the
    ' user's Windows locale; CDbl would misparse in comma-decimal locales.
    Dim massKg As Double
    massKg = val(rawMassTon) * 1000#
    FormatMassKg = Format$(massKg, "0.000") & " kg"
    Exit Function

Fallback:
    FormatMassKg = rawMassTon
End Function

Public Sub HyperMeshCaptureModelWindowToSlide()
    HyperMeshCaptureToSlide "window"
End Sub

Public Sub HyperMeshCaptureFocusToSlide()
    HyperMeshCaptureToSlide "fixed"
End Sub

Public Sub HyperMeshCaptureCustomToSlide()
    HyperMeshCaptureToSlide "custom"
End Sub

Private Sub HyperMeshCaptureToSlide(ByVal mode As String)
    On Error GoTo EH

    Dim targetPid As Long
    targetPid = FindActiveHyperMeshProcessId()
    If targetPid = 0 Then
        ShowError "No HyperMesh window found. Open HyperMesh and try again."
        Exit Sub
    End If

    Dim bridgeDir As String
    bridgeDir = HyperMeshBridgeDir()
    EnsureFolderExists bridgeDir

    Dim watcherPath As String
    watcherPath = JoinPath(bridgeDir, "hm_ppt_request_watcher.tcl")
    If Not FileExists(watcherPath) Then
        ShowError "This tool's bridge folder is missing the Tcl watcher." & vbCrLf & vbCrLf & _
            "Expected watcher file here:" & vbCrLf & watcherPath & vbCrLf & vbCrLf & _
            "Copy hm_ppt_bridge (with hm_ppt_request_watcher.tcl) next to this " & _
            "PPTX_TOOL_SHARE.ppam/.pptm file, then in HyperMesh's Tcl console run:" & vbCrLf & _
            "source {" & ToTclPath(watcherPath) & "}"
        Exit Sub
    End If

    Dim requestPath As String
    Dim responsePath As String
    requestPath = JoinPath(bridgeDir, HM_REQUEST_FILE)
    responsePath = JoinPath(bridgeDir, HM_RESPONSE_FILE)

    DeleteFileIfExists responsePath

    Dim requestId As String
    requestId = NewRequestId()

    Dim reqWidth As Long, reqHeight As Long
    reqWidth = CLng(HM_FIXED_WIDTH * CaptureResolutionScale())
    reqHeight = CLng(HM_FIXED_HEIGHT * CaptureResolutionScale())

    WriteHyperMeshRequest requestPath, requestId, mode, targetPid, mHideAxesForCapture, HyperMeshGlobalAxesOn(), reqWidth, reqHeight

    Dim imagePath As String
    Dim axisImagePath As String
    Dim axisCropLeftFrac As Double, axisCropBottomFrac As Double
    Dim axisCropWidthFrac As Double, axisCropHeightFrac As Double
    imagePath = WaitForHyperMeshResponse(responsePath, requestId, mode, axisImagePath, _
        axisCropLeftFrac, axisCropBottomFrac, axisCropWidthFrac, axisCropHeightFrac)
    If Len(imagePath) = 0 Then Exit Sub

    InsertCapturedImage imagePath, (mode = "custom"), axisImagePath, _
        axisCropLeftFrac, axisCropBottomFrac, axisCropWidthFrac, axisCropHeightFrac
    Exit Sub

EH:
    ShowError "Could not capture from HyperMesh: " & Err.Description
End Sub

Private Function HyperMeshBridgeDir() As String
    Dim addInPath As String
    addInPath = CurrentAddInFolder()
    If Len(addInPath) > 0 Then
        HyperMeshBridgeDir = addInPath & "\" & HM_BRIDGE_DIR
        If Dir$(HyperMeshBridgeDir, vbDirectory) <> vbNullString Then Exit Function
    End If

    Dim presPath As String
    presPath = ActivePresentation.path
    If Len(presPath) = 0 Then
        HyperMeshBridgeDir = CurDir$() & "\" & HM_BRIDGE_DIR
    Else
        HyperMeshBridgeDir = ParentFolder(presPath) & "\" & HM_BRIDGE_DIR
    End If
End Function

Private Function CurrentAddInFolder() As String
    On Error GoTo EH

    Dim addIn As Object
    For Each addIn In Application.AddIns
        If InStr(1, addIn.name, "PPTX_TOOL", vbTextCompare) > 0 Then
            If Len(addIn.path) > 0 Then
                CurrentAddInFolder = addIn.path
                Exit Function
            End If
            If Len(addIn.FullName) > 0 Then
                CurrentAddInFolder = ParentFolder(addIn.FullName)
                Exit Function
            End If
        End If
    Next addIn

EH:
End Function

Private Sub WriteHyperMeshRequest(ByVal requestPath As String, _
                                  ByVal requestId As String, _
                                  ByVal mode As String, _
                                  ByVal targetPid As Long, _
                                  ByVal hideAxesForCapture As Boolean, _
                                  ByVal axesOn As Boolean, _
                                  ByVal reqWidth As Long, _
                                  ByVal reqHeight As Long)
    Dim fso As Object
    Dim ts As Object
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set ts = fso.CreateTextFile(requestPath, True, False)
    ts.WriteLine "id=" & requestId
    ts.WriteLine "mode=" & mode
    ts.WriteLine "width=" & CStr(reqWidth)
    ts.WriteLine "height=" & CStr(reqHeight)
    ts.WriteLine "quality=" & CStr(HM_IMAGE_QUALITY)
    ts.WriteLine "target_pid=" & CStr(targetPid)
    ts.WriteLine "hide_axes=" & IIf(hideAxesForCapture, "1", "0")
    ts.WriteLine "axes_state=" & IIf(axesOn, "1", "0")
    ts.WriteLine "sharp_axes=" & IIf(axesOn And Not hideAxesForCapture And CaptureResolutionScale() > 1.01, "1", "0")
    ts.WriteLine "resolution_scale=" & Replace(CStr(CaptureResolutionScale()), ",", ".")
    ts.Close
End Sub

Private Sub EnsureHyperMeshGlobalAxesDefaults()
    If Not mGlobalAxesInitialized Then
        mGlobalAxesOn = True
        mGlobalAxesInitialized = True
    End If
End Sub

Private Function HyperMeshGlobalAxesOn() As Boolean
    EnsureHyperMeshGlobalAxesDefaults
    HyperMeshGlobalAxesOn = mGlobalAxesOn
End Function

' Returns the process id of the most recently active top-level window whose
' title looks like a HyperMesh/HyperWorks window. EnumWindows walks windows in
' Z-order (topmost first), so the first match is whichever HyperMesh window
' the user clicked into most recently (even though PowerPoint is now
' foreground). Returns 0 if no HyperMesh window is currently open.
Private Function FindActiveHyperMeshProcessId() As Long
    mFoundHyperMeshPid = 0
    EnumWindows AddressOf HyperMeshEnumWindowsProc, 0
    FindActiveHyperMeshProcessId = mFoundHyperMeshPid
End Function

Private Function HyperMeshEnumWindowsProc(ByVal hWnd As LongPtr, ByVal lParam As LongPtr) As Long
    HyperMeshEnumWindowsProc = 1 ' continue enumeration by default

    If IsWindowVisible(hWnd) = 0 Then Exit Function

    Dim title As String
    title = GetWindowTitle(hWnd)
    If Len(title) = 0 Then Exit Function

    If InStr(1, title, "HyperMesh", vbTextCompare) > 0 _
        Or InStr(1, title, "HyperWorks", vbTextCompare) > 0 Then
        Dim pid As Long
        GetWindowThreadProcessId hWnd, pid
        mFoundHyperMeshPid = pid
        HyperMeshEnumWindowsProc = 0 ' stop, first (topmost) match wins
    End If
End Function

Private Function GetWindowTitle(ByVal hWnd As LongPtr) As String
    Dim length As Long
    length = GetWindowTextLengthW(hWnd)
    If length <= 0 Then Exit Function

    Dim buffer As String
    buffer = String$(length + 1, vbNullChar)
    Dim written As Long
    written = GetWindowTextW(hWnd, StrPtr(buffer), length + 1)
    If written > 0 Then GetWindowTitle = left$(buffer, written)
End Function

Private Function WaitForHyperMeshResponse(ByVal responsePath As String, _
                                          ByVal requestId As String, _
                                          ByVal mode As String, _
                                          ByRef axisImagePath As String, _
                                          ByRef axisCropLeftFrac As Double, _
                                          ByRef axisCropBottomFrac As Double, _
                                          ByRef axisCropWidthFrac As Double, _
                                          ByRef axisCropHeightFrac As Double) As String
    Dim startTime As Single
    startTime = Timer

    Do
        DoEvents
        If FileExists(responsePath) Then
            Dim response As Object
            Set response = ReadKeyValueFile(responsePath)
            If response.Exists("id") Then
                If CStr(response("id")) = requestId Then
                    If response.Exists("status") And CStr(response("status")) = "ok" Then
                        If response.Exists("image") Then
                            WaitForHyperMeshResponse = NormalizeWindowsPath(CStr(response("image")))
                            If response.Exists("axis_image") Then
                                axisImagePath = NormalizeWindowsPath(CStr(response("axis_image")))
                            End If
                            If response.Exists("axis_crop_left") Then
                                axisCropLeftFrac = val(CStr(response("axis_crop_left")))
                            End If
                            If response.Exists("axis_crop_bottom") Then
                                axisCropBottomFrac = val(CStr(response("axis_crop_bottom")))
                            End If
                            If response.Exists("axis_crop_width") Then
                                axisCropWidthFrac = val(CStr(response("axis_crop_width")))
                            End If
                            If response.Exists("axis_crop_height") Then
                                axisCropHeightFrac = val(CStr(response("axis_crop_height")))
                            End If
                            Exit Function
                        End If
                    Else
                        Dim errText As String
                        If response.Exists("error") Then errText = CStr(response("error"))
                        If Len(Trim$(errText)) = 0 Or Trim$(errText) = "0" Then
                            errText = "HyperMesh returned an unknown capture error for mode '" & mode & "'." & vbCrLf & _
                                "Response file: " & responsePath
                        End If
                        ShowError errText
                        Exit Function
                    End If
                End If
            End If
        End If

        If ElapsedSeconds(startTime) >= HM_CAPTURE_TIMEOUT_SECONDS Then
            ShowError "HyperMesh capture timed out." & vbCrLf & vbCrLf & _
                "This tool expects its bridge folder here:" & vbCrLf & _
                HyperMeshBridgeDir() & vbCrLf & vbCrLf & _
                "In THAT HyperMesh window's Tcl console (each open HyperMesh window " & _
                "needs its own source once), run:" & vbCrLf & _
                "source {" & ToTclPath(JoinPath(HyperMeshBridgeDir(), "hm_ppt_request_watcher.tcl")) & "}" & vbCrLf & vbCrLf & _
                "If that path does not exist on this machine, move/copy the " & _
                "hm_ppt_bridge folder there, or move this .ppam/.pptm so its own " & _
                "folder contains hm_ppt_bridge."
            Exit Function
        End If
    Loop
End Function

Private Sub InsertCapturedImage(ByVal imagePath As String, ByVal isCustom As Boolean, _
    Optional ByVal axisImagePath As String = "", _
    Optional ByVal axisCropLeftFrac As Double = 0#, _
    Optional ByVal axisCropBottomFrac As Double = 0#, _
    Optional ByVal axisCropWidthFrac As Double = 0#, _
    Optional ByVal axisCropHeightFrac As Double = 0#)
    If Not FileExists(imagePath) Then
        ShowError "HyperMesh capture image was not found: " & imagePath
        Exit Sub
    End If

    Dim sld As Slide
    Set sld = GetActiveSlide()
    If sld Is Nothing Then
        ShowError "Open a slide before capturing from HyperMesh."
        Exit Sub
    End If

    Dim targetLeft As Single
    Dim targetTop As Single
    Dim targetWidth As Single
    Dim hasTarget As Boolean
    hasTarget = GetSelectedPictureBounds(targetLeft, targetTop, targetWidth)

    If hasTarget Then
        DeleteSelectedPicture
    End If

    Dim shp As Shape
    Set shp = sld.shapes.AddPicture(imagePath, msoFalse, msoTrue, 0, 0)
    shp.name = UniqueShapeName(sld, "HM_Live_Capture")

    ' Crop BEFORE resizing/fitting: PowerPoint crop amounts are computed
    ' against the shape's CURRENT (native, pre-resize) size, so this must
    ' run while shp.Width/Height still match imagePath's native pixel size.
    If isCustom Then CropCustomRatio shp

    If ShouldFlattenSharpAxes(axisImagePath) And axisCropWidthFrac > 0# And axisCropHeightFrac > 0# Then
        ' Flatten while the capture is still at its native inserted size.
        ' Flattening after fitting into a small selected frame makes
        ' PowerPoint rasterize the clipboard PNG at that small display size.
        FlattenSharpAxesIntoMain sld, shp, axisImagePath, _
            axisCropLeftFrac, axisCropBottomFrac, axisCropWidthFrac, axisCropHeightFrac
    End If

    If hasTarget Then
        shp.LockAspectRatio = msoTrue
        shp.width = targetWidth
        shp.left = targetLeft
        shp.Top = targetTop
    Else
        FitShapeInsideSlide shp
    End If

    If mTransparentWhite Then ApplyTransparentWhite shp

    shp.Select
End Sub

Private Function ShouldFlattenSharpAxes(ByVal axisImagePath As String) As Boolean
    ShouldFlattenSharpAxes = (Len(axisImagePath) > 0 _
        And FileExists(axisImagePath) _
        And HyperMeshGlobalAxesOn() _
        And Not mHideAxesForCapture _
        And CaptureResolutionScale() > 1.01)
End Function

' axisImagePath is the RAW, uncropped 1x Global Axes capture. Cropping it via
' Tcl/Tk's `image` (create photo/copy/write) was tried and rejected: it
' washes out red/green into near-white/gray on this HyperMesh's embedded Tk
' PNG codec (a Tk-cropped axis image lost its red X / green Y arrows,
' leaving only blue Z). `image get` for READING pixels does not have this
' problem, so hm_ppt_request_watcher.tcl::measure_axis_bbox measures the
' real bounding box of the axis glyph (read-only) and reports it as
' FRACTIONS of the image's own pixel size via axisCropLeftFrac/
' BottomFrac/WidthFrac/HeightFrac - fractions avoid a pixel-vs-point and
' requested-vs-actual-capture-size unit mismatch entirely.
'
' The actual crop is applied here with PowerPoint's own native PictureFormat
' crop (metadata only, zero pixel re-encode), which keeps the axis colors
' correct. PowerPoint does not shrink Shape.Width by the same amount you set
' in CropRight/CropTop when the image's DPI isn't 96 (HyperMesh captures are
' ~96 but not exactly) - CropCustomRatio below already works around this by
' probing a test crop and measuring the actual resulting shrink; the same
' probe technique is reused here for both CropRight (width) and CropTop
' (height), since a naive "points = target fraction * native size" formula
' produced a visibly wrong (distorted) crop when verified against a real
' capture.
Private Sub FlattenSharpAxesIntoMain(ByVal sld As Slide, ByRef mainShp As Shape, ByVal axisImagePath As String, _
    ByVal axisCropLeftFrac As Double, ByVal axisCropBottomFrac As Double, _
    ByVal axisCropWidthFrac As Double, ByVal axisCropHeightFrac As Double)
    On Error GoTo CleanFail

    Dim axisShp As Shape
    Set axisShp = sld.shapes.AddPicture(axisImagePath, msoFalse, msoTrue, 0, 0)
    axisShp.name = UniqueShapeName(sld, "HM_Sharp_Axes")

    Dim nativeAxisW As Single, nativeAxisH As Single
    nativeAxisW = axisShp.width
    nativeAxisH = axisShp.height
    If nativeAxisW < 1 Or nativeAxisH < 1 Then GoTo CleanFail

    ' The bbox's left/bottom offsets are only ever a few px (glyph anchors
    ' ~11px in from the corner) - fold them into the target width/height
    ' fraction and always crop from the true (0,0) bottom-left corner,
    ' rather than cropping all 4 sides independently. This matches the
    ' proven CropCustomRatio pattern (which only ever sets CropRight,
    ' leaving CropLeft at 0) instead of needing to probe 4 independent
    ' crop-to-shrink factors.
    Dim targetWFrac As Double, targetHFrac As Double
    targetWFrac = axisCropLeftFrac + axisCropWidthFrac
    targetHFrac = axisCropBottomFrac + axisCropHeightFrac
    If targetWFrac > 1# Then targetWFrac = 1#
    If targetHFrac > 1# Then targetHFrac = 1#

    Dim targetW As Single, targetH As Single
    targetW = nativeAxisW * targetWFrac
    targetH = nativeAxisH * targetHFrac

    Const PROBE As Single = 50!

    axisShp.PictureFormat.CropRight = PROBE
    Dim factorW As Double
    factorW = (nativeAxisW - axisShp.width) / PROBE
    axisShp.PictureFormat.CropRight = 0!
    If factorW < 0.01 Then factorW = 1#
    Dim finalCropRight As Single
    finalCropRight = (nativeAxisW - targetW) / factorW
    If finalCropRight < 0 Then finalCropRight = 0!

    axisShp.PictureFormat.CropTop = PROBE
    Dim factorH As Double
    factorH = (nativeAxisH - axisShp.height) / PROBE
    axisShp.PictureFormat.CropTop = 0!
    If factorH < 0.01 Then factorH = 1#
    Dim finalCropTop As Single
    finalCropTop = (nativeAxisH - targetH) / factorH
    If finalCropTop < 0 Then finalCropTop = 0!

    axisShp.PictureFormat.cropLeft = 0!
    axisShp.PictureFormat.cropBottom = 0!
    axisShp.PictureFormat.CropRight = finalCropRight
    axisShp.PictureFormat.CropTop = finalCropTop

    axisShp.LockAspectRatio = msoTrue
    axisShp.height = mainShp.height * targetHFrac

    ' Bottom-left corner of the high-res main capture, matching where
    ' HyperMesh always renders the Global Axes glyph.
    Dim margin As Single
    margin = mainShp.height * 0.004!
    axisShp.left = mainShp.left + margin
    axisShp.Top = mainShp.Top + mainShp.height - axisShp.height - margin
    ApplyTransparentWhite axisShp
    axisShp.ZOrder msoBringToFront

    ' Flatten to a single picture via Copy + PasteSpecial(ppPastePNG), NOT
    ' Shape.Export: Shape.Export's ScaleWidth/ScaleHeight (and even
    ' ExportMode:=ppScaleXY) were verified to be silently ignored in this
    ' environment - exporting a 806.88x492pt shape (aspect 1.64) at an
    ' explicitly requested pixel size still produced a completely
    ' different, wrong-aspect file every time (e.g. 3767x2491, aspect
    ' 1.51), visibly squishing the model when the exported PNG was
    ' reinserted and refit. Copy+PasteSpecial renders through PowerPoint's
    ' clipboard picture pipeline instead and was verified to preserve the
    ' exact source aspect ratio (806.95x492.04, i.e. 1.6400 vs the
    ' original 1.6400) - the same clipboard-based approach already proven
    ' reliable for linked chart image refresh elsewhere in this add-in
    ' (see ModLinkedChartImages.bas / LESSONS.md).
    Dim names(1 To 2) As Variant
    names(1) = mainShp.name
    names(2) = axisShp.name

    Dim grp As Shape
    Set grp = sld.shapes.Range(names).Group

    Dim outLeft As Single, outTop As Single, outWidth As Single
    outLeft = grp.left
    outTop = grp.Top
    outWidth = grp.width

    grp.Copy
    Dim pasted As ShapeRange
    Set pasted = sld.shapes.PasteSpecial(ppPastePNG)
    grp.Delete

    Set mainShp = pasted.item(1)
    mainShp.name = UniqueShapeName(sld, "HM_Live_Capture")
    mainShp.LockAspectRatio = msoTrue
    mainShp.width = outWidth
    mainShp.left = outLeft
    mainShp.Top = outTop
    Exit Sub

CleanFail:
    On Error Resume Next
    If Not axisShp Is Nothing Then axisShp.Delete
    On Error GoTo 0
End Sub

' Custom Ratio: crops the native capture to the H:W ratio using PowerPoint's
' own native picture crop (metadata only, no pixel decode/re-encode) - the
' previous approach re-encoded the PNG in Tcl via Tk's `image` command,
' which corrupted colors (washed-out/pastel) on this HyperMesh's embedded
' Tcl/Tk PNG codec. Native crop touches zero pixels, so colors are
' guaranteed correct.
'
' Preferred behavior is to keep FULL HEIGHT and crop WIDTH down (off the
' RIGHT edge, keeping LEFT - matches the HyperMesh bridge's assumption that
' Global Axes sits in a left-side corner of the window). This only works
' when the requested ratio is NARROWER than the native capture (target
' width <= native width) - cropping can only remove pixels, never add
' them. If the requested ratio is WIDER than native (target width would
' exceed native width, e.g. asking for 1:2 out of a ~1.65:1 native
' capture), there is no way to reach it by cropping width, so this falls
' back to cropping HEIGHT down instead (off the TOP, keeping BOTTOM - same
' left/bottom-corner-has-axes assumption). Previously this case was
' silently skipped entirely (`Exit Sub`), leaving the image at its native
' ratio with no indication that the requested ratio was not achievable.
'
' Does NOT touch LockAspectRatio, Width, or Height - leaves PowerPoint's
' own picture scale untouched. Only ever sets CropRight or CropTop, so the
' picture's own aspect handling stays in control (earlier attempts
' manually forcing Width/Height after cropping produced squeezed/distorted
' content).
'
' PowerPoint interprets CropRight/CropTop (in points) via a 96-DPI
' conversion against the image's pixel width/height, so setting
' CropRight = (nativeW - targetW) does NOT shrink shp.Width by that same
' amount when the image has a non-96 DPI (HyperMesh captures come out
' around 141 DPI). The actual factor is 96/imageDPI. To be image-
' independent, we probe that factor at runtime: set a small test crop,
' measure the resulting Width/Height change, reset, then solve for the
' crop value that actually gives the desired final size. All PowerPoint's
' own crop/scale math - we never write Width or Height.
Private Sub CropCustomRatio(ByVal shp As Shape)
    EnsureHyperMeshCustomRatioDefaults

    Dim ratioH As Double, ratioW As Double
    ratioH = mCustomRatioH
    ratioW = mCustomRatioW
    If ratioH <= 0# Or ratioW <= 0# Then
        ratioH = 1#
        ratioW = 1#
    End If

    Const PROBE As Single = 50!

    Dim targetW As Single
    targetW = shp.height * ratioW / ratioH

    If targetW < shp.width Then
        If targetW < 1 Then Exit Sub
        Dim nativeW As Single
        nativeW = shp.width

        shp.PictureFormat.cropLeft = 0
        shp.PictureFormat.CropRight = PROBE
        Dim factorW As Double
        factorW = (nativeW - shp.width) / PROBE
        shp.PictureFormat.CropRight = 0
        If factorW < 0.01 Then factorW = 1#

        Dim finalCropRight As Single
        finalCropRight = (shp.width - targetW) / factorW
        If finalCropRight < 0 Then finalCropRight = 0
        shp.PictureFormat.CropRight = finalCropRight
    Else
        ' Requested ratio is wider than the native capture - width alone
        ' cannot reach it, so crop height down until the native width
        ' matches the requested ratio at that (now shorter) height.
        Dim targetH As Single
        targetH = shp.width * ratioH / ratioW
        If targetH < 1 Or targetH >= shp.height Then Exit Sub
        Dim nativeH As Single
        nativeH = shp.height

        shp.PictureFormat.cropBottom = 0
        shp.PictureFormat.CropTop = PROBE
        Dim factorH As Double
        factorH = (nativeH - shp.height) / PROBE
        shp.PictureFormat.CropTop = 0
        If factorH < 0.01 Then factorH = 1#

        Dim finalCropTop As Single
        finalCropTop = (shp.height - targetH) / factorH
        If finalCropTop < 0 Then finalCropTop = 0
        shp.PictureFormat.CropTop = finalCropTop
    End If
End Sub

Private Sub ApplyTransparentWhite(ByVal shp As Shape)
    On Error Resume Next
    shp.PictureFormat.TransparencyColor = RGB(255, 255, 255)
    shp.PictureFormat.TransparentBackground = msoTrue
    On Error GoTo 0
End Sub

' If exactly one picture shape is selected on the active slide when Capture is
' pressed, the new capture replaces it in place: same Left/Top/Width, height
' recomputed from the new image's aspect ratio (keeps the same horizontal
' footprint instead of dropping a second image on top of the old one).
Private Function GetSelectedPictureBounds(ByRef outLeft As Single, _
                                          ByRef outTop As Single, _
                                          ByRef outWidth As Single) As Boolean
    On Error GoTo NoSelection

    If ActiveWindow.Selection.Type <> ppSelectionShapes Then GoTo NoSelection
    If ActiveWindow.Selection.ShapeRange.count <> 1 Then GoTo NoSelection

    Dim shp As Shape
    Set shp = ActiveWindow.Selection.ShapeRange(1)
    If shp.Type <> msoPicture And shp.Type <> msoLinkedPicture Then GoTo NoSelection

    outLeft = shp.left
    outTop = shp.Top
    outWidth = shp.width
    GetSelectedPictureBounds = True
    Exit Function

NoSelection:
    GetSelectedPictureBounds = False
End Function

Private Sub DeleteSelectedPicture()
    On Error Resume Next
    ActiveWindow.Selection.ShapeRange(1).Delete
    On Error GoTo 0
End Sub

Private Sub FitShapeInsideSlide(ByVal shp As Shape)
    Dim slideW As Single
    Dim slideH As Single
    Dim maxW As Single
    Dim maxH As Single
    Dim margin As Single

    slideW = ActivePresentation.PageSetup.slideWidth
    slideH = ActivePresentation.PageSetup.slideHeight
    margin = 24!
    maxW = slideW - (margin * 2!)
    maxH = slideH - (margin * 2!)

    shp.LockAspectRatio = msoTrue
    If shp.width / shp.height > maxW / maxH Then
        shp.width = maxW
    Else
        shp.height = maxH
    End If
    shp.left = (slideW - shp.width) / 2!
    shp.Top = (slideH - shp.height) / 2!
End Sub

Private Function ReadKeyValueFile(ByVal path As String) As Object
    Dim result As Object
    Set result = CreateObject("Scripting.Dictionary")

    Dim fso As Object
    Dim ts As Object
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set ts = fso.OpenTextFile(path, 1, False)

    Do While Not ts.AtEndOfStream
        Dim line As String
        Dim p As Long
        line = ts.ReadLine
        p = InStr(1, line, "=", vbBinaryCompare)
        If p > 0 Then result(left$(line, p - 1)) = Mid$(line, p + 1)
    Loop
    ts.Close

    Set ReadKeyValueFile = result
End Function

Private Function NewRequestId() As String
    NewRequestId = Format$(Now, "yyyymmddhhnnss") & "_" & CStr(CLng(Timer * 1000!))
End Function

Private Function FileExists(ByVal path As String) As Boolean
    FileExists = (Len(Dir$(path, vbNormal)) > 0)
End Function

Private Sub DeleteFileIfExists(ByVal path As String)
    On Error Resume Next
    If FileExists(path) Then Kill path
    On Error GoTo 0
End Sub

Private Sub EnsureFolderExists(ByVal folderPath As String)
    Dim parts() As String
    Dim cur As String
    Dim i As Long

    parts = Split(folderPath, "\")
    cur = parts(0)
    For i = 1 To UBound(parts)
        cur = cur & "\" & parts(i)
        If Len(Dir$(cur, vbDirectory)) = 0 Then MkDir cur
    Next i
End Sub

Private Function ParentFolder(ByVal folderPath As String) As String
    Dim p As Long
    p = InStrRev(folderPath, "\")
    If p > 0 Then
        ParentFolder = left$(folderPath, p - 1)
    Else
        ParentFolder = folderPath
    End If
End Function

Private Function JoinPath(ByVal leftPath As String, ByVal rightPath As String) As String
    If right$(leftPath, 1) = "\" Then
        JoinPath = leftPath & rightPath
    Else
        JoinPath = leftPath & "\" & rightPath
    End If
End Function

Private Function NormalizeWindowsPath(ByVal path As String) As String
    NormalizeWindowsPath = Replace(path, "/", "\")
End Function

Private Function ToTclPath(ByVal path As String) As String
    ToTclPath = Replace(path, "\", "/")
End Function

Private Function ElapsedSeconds(ByVal startTime As Single) As Single
    If Timer >= startTime Then
        ElapsedSeconds = Timer - startTime
    Else
        ElapsedSeconds = (86400! - startTime) + Timer
    End If
End Function

Private Function UniqueShapeName(ByVal sld As Slide, ByVal baseName As String) As String
    Dim i As Long
    Dim candidate As String
    For i = 1 To 10000
        candidate = baseName & "_" & Format$(Now, "yyyymmdd_hhnnss") & "_" & CStr(i)
        If Not ShapeNameExists(sld, candidate) Then
            UniqueShapeName = candidate
            Exit Function
        End If
    Next i
    UniqueShapeName = baseName
End Function

Private Function ShapeNameExists(ByVal sld As Slide, ByVal shapeName As String) As Boolean
    Dim shp As Shape
    For Each shp In sld.shapes
        If shp.name = shapeName Then
            ShapeNameExists = True
            Exit Function
        End If
    Next shp
End Function

