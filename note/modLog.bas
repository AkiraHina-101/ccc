Attribute VB_Name = "modLog"
Option Explicit

' Runtime diagnostics are intentionally kept in the VBA Immediate Window.

Public Sub LogMsg(ByVal msg As String)
    Debug.Print Format$(Now, "yyyy-mm-dd hh:nn:ss"), "INFO", msg
End Sub

Public Sub ReportStage(ByVal procedureName As String, ByVal stageName As String)
    Debug.Print Format$(Now, "yyyy-mm-dd hh:nn:ss"), "RUNNING", procedureName, stageName
End Sub

Public Sub ReportSuccess(ByVal procedureName As String, ByVal detail As String)
    Debug.Print Format$(Now, "yyyy-mm-dd hh:nn:ss"), "OK", procedureName, detail
End Sub

Public Sub ReportWarning(ByVal procedureName As String, ByVal stageName As String, _
                         ByVal detailText As String)
    Debug.Print Format$(Now, "yyyy-mm-dd hh:nn:ss"), "WARNING", procedureName, stageName, detailText
End Sub

Public Function ReportError(ByVal procedureName As String, ByVal stageName As String, _
                            ByVal errorNumber As Long, ByVal description As String) As String
    Dim msg As String
    Debug.Print String$(70, "-")
    Debug.Print Format$(Now, "yyyy-mm-dd hh:nn:ss"), "ERROR", procedureName
    Debug.Print "Stage=" & stageName, "Number=" & errorNumber
    Debug.Print "Description=" & description
    Debug.Print "Open the Immediate Window (Ctrl+G) and run PrintDiagnostics for context."
    msg = procedureName & " failed at [" & stageName & "]." & vbCrLf & _
          "Error " & errorNumber & ": " & description & vbCrLf & vbCrLf & _
          "Open the VBA Immediate Window (Ctrl+G) and run PrintDiagnostics."
    ReportError = msg
End Function

Public Sub PrintDiagnostics()
    Dim ws As Worksheet, fileCount As Long
    Debug.Print String$(70, "=")
    Debug.Print "SPL diagnostics", Format$(Now, "yyyy-mm-dd hh:nn:ss")
    Debug.Print "Workbook=" & ThisWorkbook.FullName
    Debug.Print "Active sheet=" & ActiveSheet.Name, "Excel=" & Application.Version
    On Error Resume Next
    Set ws = ThisWorkbook.Worksheets("FILES")
    fileCount = Application.Max(0, ws.Cells(ws.Rows.Count, 1).End(xlUp).Row - 1)
    Debug.Print "FILES input count=" & fileCount
    Debug.Print "selRPM=" & ThisWorkbook.Names("selRPM").RefersToRange.Text
    Debug.Print "selQty=" & ThisWorkbook.Names("selQty").RefersToRange.Text
    On Error GoTo 0
    Debug.Print String$(70, "=")
End Sub
