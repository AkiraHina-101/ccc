# BoundaryTemperature

BoundaryTemperature BoundaryTemperature Description create boundary temperature Syntax BoundaryTemparature(string strName, double fTemp, cursor crTable, cursor[] taTarget, cursor crEdit) Inputs String Boundary temperature name Double Temperature value Cursor Table field data cursor Cursor[] Target entities cursor Cursor N/A: Edit Cursor Return Code 1 Succeeded 0 Failed Sample Code BoundaryTemperature("BoundaryTemperature_1", 373.15, 81:1, [3:1, 6:3], 0:0)
