# TemplateCopy

TemplateCopy TemplateCopy Description Template Copy (include Window to Window) Syntax TemplateCopy(cursor[] entityMaster, cursor[] entitySlave, int iMethod, bool bCopySub, double dTolerance) Inputs Cursor[] Target entity master cursor([CursorType:CursorType ID]) Cursor[] Target entity slave cursor([CursorType:CursorType ID]) Int Copy settings method* *0: By Shape &ensp;1: By Topology Bool Include sub entity bool flag True = 1, False = 0 Double Tolerance (m) Return Code 1 Succeeded 0 Failed Sample Code TemplateCopy([3:1], [3:2], 0, 1, 1e-06)
