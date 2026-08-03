Attribute VB_Name = "modConst"
Option Explicit

' Maximum number of Model controls shared by SPL and OVERALL.
' So Model toi da dung chung cho SPL va OVERALL.
Public Const MAX_MODEL_COUNT As Long = 10

' Fixed SPL series layout inside each Model: NB, then OB.
' So series co dinh trong moi Model SPL: NB, sau do OB.
Public Const SPL_SERIES_PER_MODEL As Long = 2

' Reserved SPL result-data rectangle used by the worksheet event.
' Vung du lieu ket qua SPL duoc event cua sheet su dung.
Public Const SPL_DATA_FIRST_COL As Long = 43
Public Const SPL_SLOT_WIDTH As Long = 5
Public Const SPL_BLOCK_GAP_COLS As Long = 2
Public Const SPL_DATA_FIRST_ROW As Long = 6
Public Const SPL_DATA_LAST_ROW As Long = 234
