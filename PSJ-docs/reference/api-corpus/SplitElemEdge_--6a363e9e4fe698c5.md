# SplitElemEdge()

SplitElemEdge()

Description​

Split Element Edge

Syntax​

SplitElemEdge(cursor[] vcrElemEdge, double dRatio, cursor crNodeRef, cursor crProjBody)

Inputs​

1. Cursor[]​

Select (multiple) element edges cursor([10:Node ID-10:Node ID])

2. Double​

Split ratio

3. Cursor​

Whether use node for reference or not True = 10:*, False = 0:0

4. Cursor​

Whether use reference CAD part or not True = 12:*, False = 0:0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

SplitElemEdge([10:462-10:471], 0.2, 0:0, 12:1)
