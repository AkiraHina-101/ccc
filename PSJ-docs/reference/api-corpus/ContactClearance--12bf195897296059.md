# ContactClearance

ContactClearance ContactClearance Description create contact clearance Syntax ContactClearance(string strName, double dClearanceVal, int iLocalUnit, int iSolverType, cursor[] taTarget, cursor crEdit) Inputs String Structural name Double Clearance value Int Input Unit* *0: Mm &ensp;1: M &ensp;2: Ft &ensp;3: In &ensp;4: Cm Int N/A: Solver type Cursor[] Target entities cursor Cursor N/A: Edit cursor Return Code 1 Succeeded 0 Failed Sample Code ContactClearance("ContactClearance1", 0.002, 0, 0, [10:452, 6:26], 0:0)
