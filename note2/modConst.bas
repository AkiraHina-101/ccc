Attribute VB_Name = "modConst"
Option Explicit

' Single typography contract for cells, charts and shape-based controls.
Public Const UI_FONT_NAME As String = "Meiryo UI"

' Dashboard scale defaults used only to recover missing/non-numeric control state.
Public Const AXIS_X_MIN_DEFAULT As Double = 0#
Public Const AXIS_X_MAX_DEFAULT As Double = 3000#
Public Const AXIS_X_MAJOR_DEFAULT As Double = 500#
Public Const AXIS_X_MINOR_DEFAULT As Double = 100#
Public Const AXIS_Y_MIN_DEFAULT As Double = 0#
Public Const AXIS_Y_MAX_DEFAULT As Double = 100#
Public Const AXIS_Y_MAJOR_DEFAULT As Double = 10#
Public Const AXIS_Y_MINOR_DEFAULT As Double = 5#

' Tunable limits and default layout values.

' ---- Data ----
' Row cap of the tidy CALC table and scan depth of the FILTER
' formulas. Increase if real data exceeds it (currently ~25k of 300k).
Public Const MAX_DATA_ROWS As Long = 300000

' ---- Dashboard layout (PLOT sheet) ----
' NOTE: these are DEFAULTS only - RebuildDashboard uses them just when
' CREATING a new chart / model toggle. Existing charts & toggles keep
' whatever position/size you arranged; rebuild never repositions them.
Public Const CHART_W As Single = 600       ' chart width (points)
Public Const CHART_H As Single = 297       ' chart height
Public Const CHART_GAP_X As Single = 600   ' horizontal step between charts (>= CHART_W)
Public Const CHART_GAP_Y As Single = 315   ' vertical step between chart rows (>= CHART_H)
Public Const CHART_LEFT As Single = 60     ' left margin of the chart grid
Public Const CHARTS_PER_ROW As Long = 4    ' charts per row
Public Const CB_PER_ROW As Long = 8        ' model toggle shapes per row
Public Const CB_LEFT As Single = 90        ' x of the first model toggle
Public Const CB_TOP As Single = 52         ' y of the first model-toggle row
Public Const CB_W As Single = 105          ' default model-toggle width
Public Const CB_H As Single = 28           ' default model-toggle height
Public Const CB_STEP_X As Single = 112     ' horizontal step between model toggles
Public Const CB_STEP_Y As Single = 32      ' vertical step between model-toggle rows
Public Const GRID_TOP0 As Single = 125     ' leaves room for the PLOT axis-scale cell block

' ---- Per-model series-style table (offsets from the Model column) ----
' CONFIG layout: Model | NB(Color/Line/Weight) | OB(...) | Projection(...)
Public Const STYLE_NB_COLOR_OFS As Long = 1
Public Const STYLE_NB_LINE_OFS As Long = 2
Public Const STYLE_NB_WEIGHT_OFS As Long = 3
Public Const STYLE_OB_COLOR_OFS As Long = 4
Public Const STYLE_OB_LINE_OFS As Long = 5
Public Const STYLE_OB_WEIGHT_OFS As Long = 6
Public Const STYLE_PROJ_COLOR_OFS As Long = 7
Public Const STYLE_PROJ_LINE_OFS As Long = 8
Public Const STYLE_PROJ_WEIGHT_OFS As Long = 9
Public Const MODEL_STYLE_COLS As Long = 9

' Fallbacks used only when a CONFIG style cell is blank/invalid.
Public Const NB_WEIGHT As Single = 1
Public Const OB_WEIGHT As Single = 4
Public Const PROJ_WEIGHT As Single = 2

' ---- CALC tidy data schema (columns A..G) ----
' The backbone contract of the whole tool. Code refers to columns via
' these names instead of magic numbers. DO NOT renumber unless you
' also restructure both sheets and every formula.
Public Const COL_MODEL As Long = 1         ' A: model name
Public Const COL_RPM As Long = 2           ' B: rpm
Public Const COL_BAND As Long = 3          ' C: "NB" / "OB"
Public Const COL_MIC As Long = 4           ' D: mic number (1..n)
Public Const COL_FREQ As Long = 5          ' E: frequency [Hz]
Public Const COL_DB As Long = 6            ' F: SPL as read from the CSV
Public Const COL_FC As Long = 7            ' G: OB band center f_center (empty for NB)
Public Const N_SCHEMA_COLS As Long = 7     ' number of schema columns (A..G)

' ---- RAW_NB / RAW_OB source-lineage columns ----
' FullPath, FileName, Model, Band, Load, RPM precede the untouched CSV columns.
Public Const RAW_META_COLS As Long = 6

' ---- Internal plumbing (rarely needs changes) ----
' DEFAULT anchor of the FILTER-block region (B31). Three header rows and one
' unit row precede the dynamic-array formulas on row 33. The real
' location is the movable named cell "blkAnchor".
Public Const BLK_COL0 As Long = 2          ' B; PLOT (2) chart-data layout
Public Const BLK_ROW0 As Long = 31         ' field-header row; units and formulas follow
