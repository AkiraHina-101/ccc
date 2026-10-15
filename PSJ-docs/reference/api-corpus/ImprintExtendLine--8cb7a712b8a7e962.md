# ImprintExtendLine

ImprintExtendLine ImprintExtendLine Description Create imprint Extend line Syntax ImprintExtendLine(cursor[] vcrEdge, int iMethod, int iPosition, int iNoFittingPoints, int iDiv, bool bBreakFace) Inputs Cursor[] Target edges for extending line cursor([5:Edge ID]) Int Method type* *0: Straight &ensp;1: Same Curvature Int Position to extend type* *0: Nearest Edge &ensp;1: Boundary Edge Int Number of fitting points Int Number of divisions Bool Whether break face or not True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code ImprintExtendLine([5:27], 0, 0, 3, 2, 1)
