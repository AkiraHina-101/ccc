# ChangeTopologyElement

ChangeTopologyElement ChangeTopologyElement Description Change Topology Element Syntax ChangeTopologyElement(int[] taElemKey, int[] taFaceKey, int[] taBodyKey, bool bCreateNewBody) Inputs Int[] Element key cursor([Element ID]) Int[] Face key cursor([Face ID]) Int[] Part key cursor([Part ID]) Bool Create new part bool flag True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code ChangeTopologyElement([2357, 2214, 2213, 2358], [], [1], 1)
