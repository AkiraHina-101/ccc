# SurfaceLoads

SurfaceLoads SurfaceLoads Description create surface load Syntax SurfaceLoads(string strName, cursor[] crPressure, int arrowDir, cursor coordinate, cursor[] taTarget, cursor crEdit) Inputs String Surface loads name Cursor[] Force R, theta, Z cursor Int Arrow direction* &ensp;*0: Start at node &ensp;1: End at node Cursor Table field data cursor(81:FieldData ID) Cursor[] Target entities cursor Cursor N/A: Edit cursor Return Code 1 Succeeded 0 Failed Sample Code SurfaceLoads("SurfaceLoads3", [1, 2, 3], 1, 27:1, [6:5, 11:771, 11:772], 0:0)
