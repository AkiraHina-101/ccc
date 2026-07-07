Attribute VB_Name = "ModRibbonState"
Option Explicit

' Runtime state of checkBox / dropDown controls in the ribbon.
' Memory-only - resets when PowerPoint restarts.
' VBA defaults (Boolean=False, String="") match the desired startup state.

Public AppRibbonUI         As IRibbonUI

' --- Group: Excel to PPT ---
' Defaults are initialized lazily by ModRibbonCallbacks.
Public ExcelPasteMode        As String    ' Smart | Table | Vector | Bitmap | Embed | Link
Public ExcelPastePlacement   As String    ' Original | FitWidth | FitSlide | Replace
Public ExcelFirstRowHeader   As Boolean
Public ExcelKeepSourceStyle  As Boolean
Public ExcelKeepFont         As Boolean
Public ExcelForceFontText    As String
Public ExcelForceSizeText    As String
Public ExcelUseForceSize     As Boolean
Public ExcelRecentFonts      As String
Public ExcelLinkData         As Boolean
Public ExcelLinkFont         As Boolean
Public ExcelLinkSize         As Boolean
Public ExcelLinkTextColor    As Boolean
Public ExcelLinkCellFill     As Boolean
Public ExcelPasteInitialized As Boolean
Public WorkbookAutoRefresh   As Boolean
Public WorkbookAutoBusy      As Boolean
Public WorkbookAutoLastTick  As Single
Public ChartAutoRefresh      As Boolean
Public ChartAutoBusy         As Boolean
Public ChartAutoLastTick     As Single

' --- Group: Fill PPT Table ---
' Defaults are initialized lazily by ModRibbonCallbacks.
Public FillMatchMode         As String    ' Position | Headers | Rows | Both
Public FillKeepFontName      As Boolean
Public FillKeepFontSize      As Boolean
Public FillKeepTextColor     As Boolean
Public FillKeepCellFill      As Boolean
Public FillInitialized       As Boolean

' --- Group: Sync Font ---
Public FontScopeID          As String    ' "scopeAll" | "scopeCurrent" | "scopeSelected"

' --- Group: Shape Copy ---
' Each flag = which attribute of the source shape gets pasted onto the target.
Public IncludePosition      As Boolean
Public IncludeWidth         As Boolean
Public IncludeHeight        As Boolean
Public IncludeRotation      As Boolean
Public IncludeLockAspect    As Boolean
Public IncludeFill          As Boolean
Public IncludeLine          As Boolean
Public IncludeShadow        As Boolean
Public IncludeTextFormat    As Boolean
Public IncludeHyperlink     As Boolean
Public IncludeAltText       As Boolean

' --- Group: Text Style ---
' Captured style is memory-only - use Capture again after PowerPoint restarts.
Public HasCapturedTextStyle As Boolean
Public CapturedFontName     As String
Public CapturedFontSize     As Single
Public CapturedFontColor    As Long
Public CapturedBold         As Long
Public CapturedItalic       As Long
Public CapturedUnderline    As Long

Public IncludeTextFont      As Boolean
Public IncludeTextSize      As Boolean
Public IncludeTextColor     As Boolean
Public IncludeTextEmphasis  As Boolean
Public TextStyleScopeID     As String    ' "Selection" | "Current" | "Selected" | "All"

' --- Group: Paste Image ---
Public ImageReplaceFitMode  As String    ' Exact | Width | Height

' --- Group: Balloon Callouts ---
Public BalloonDrawMode       As Boolean
Public BalloonDrawSlideID    As Long
Public BalloonDrawShapeCount As Long
Public BalloonEventBusy      As Boolean
Public BalloonAppEvents      As CBalloonAppEvents
Public BalloonListQueueActive As Boolean
Public BalloonListQueueSlideID As Long
Public BalloonListManagerLoaded As Boolean
Public BalloonListRowMoveMode As String    ' Up | Down
Public BalloonSetDefaultTarget As String   ' Balloon | Table
Public BalloonRenumberNext As Long
Public BalloonClickNumberMode As Boolean
Public BalloonClickNumberNext As Long
Public BalloonClickNumberDone As Collection

' --- Group: Click-to-place Numbering ---
Public NumberInsertMode       As Boolean
Public NumberInsertBusy       As Boolean
Public NumberInsertSlideID    As Long
Public NumberInsertShapeCount As Long
Public NumberInsertNext       As Long
Public NumberInsertScopeAll   As Boolean   ' False = this slide, True = all slides

' --- Demo Controls tab ---
' Active no-op catalog state. Memory-only, never touches slides.
Public DemoInitialized     As Boolean
Public DemoClickCount      As Long
Public DemoToggleMain      As Boolean
Public DemoToggleMenu      As Boolean
Public DemoCheckMain       As Boolean
Public DemoCheckMenu       As Boolean
Public DemoMode            As String
Public DemoDropIndex       As Long
Public DemoComboText       As String
Public DemoEditText        As String
Public DemoGalleryIndex    As Long
