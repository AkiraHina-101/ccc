# MergeNode

MergeNode MergeNode Description Merge Node Syntax MergeNode(double dTol, int iMergeType, cursor[] vcrTarget, bool createGroup, bool equivalenceNode) Inputs Double Tolerance value Int Merge node type* *0: First entity &ensp;1: Second entity &ensp;2: Highest ID &ensp;3: Lowest ID Cursor[] Target entity cursor Bool Create group bool flag True = 1, False = 0 Bool Equivalence node bool flag True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code MergeNode(0.001, 2, [3:1, 10:217, 11:471, 5:28, 6:18], 1, 1)
