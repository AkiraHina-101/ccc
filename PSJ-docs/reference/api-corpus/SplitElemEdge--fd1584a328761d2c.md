# SplitElemEdge

SplitElemEdge SplitElemEdge Description Split Element Edge Syntax SplitElemEdge(cursor[] vcrElemEdge, double dRatio, cursor crNodeRef, cursor crProjBody) Inputs Cursor[] Select (multiple) element edges cursor([10:Node ID-10:Node ID]) Double Split ratio Cursor Whether use node for reference or not True = 10:*, False = 0:0 Cursor Whether use reference CAD part or not True = 12:*, False = 0:0 Return Code 1 Succeeded 0 Failed Sample Code SplitElemEdge([10:462-10:471], 0.2, 0:0, 12:1)
