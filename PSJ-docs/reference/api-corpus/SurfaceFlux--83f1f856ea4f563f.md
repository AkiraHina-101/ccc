# SurfaceFlux

SurfaceFlux SurfaceFlux Description create surface flux Syntax SurfaceFlux(string strName, double dFlux, int iDistributionMethod, cursor crTable, cursor[] taTarget, cursor crEdit) Inputs String Surface flux name Double Surface flux value Int Input unit type* *0: MW/mm^2 &ensp;1: W/m^2 &ensp;2:MiuW/mm^2 &ensp;3: kcal/mm^2*h &ensp;4: Lbf/ft*s &ensp;5: Lbf/in*s Cursor Table field data cursor(81:FieldData ID) Cursor[] Target entities cursor Cursor N/A: Edit cursor Return Code 1 Succeeded 0 Failed Sample Code SurfaceFlux("SurfaceHeatFlux1", 1000, 1, 81:4, [6:3, 11:693], 0:0)
