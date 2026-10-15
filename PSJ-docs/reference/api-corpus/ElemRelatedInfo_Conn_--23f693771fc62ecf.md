# ElemRelatedInfo_Conn()

ElemRelatedInfo_Conn()

Description​

Set Bush/Gap Parameter

Syntax​

ElemRelatedInfo_Conn(ERIConn_Ends[] ends, ERIConn_orientVec[] orientVec,
    ERIConn_cid[] CID, ERIConn_damperLoc[] damperLocs, ERIConn_ocid[] ocids,
    ERIConn_damperOffsetVec[] damperOffsetVecs, ERIConn_nodeId[] nodeIds)

Inputs​

1. ERIConn_Ends[]​

ERIConn_end list

2. ERIConn_orientVec[]​

ERIConn_orientVec list

3. ERIConn_cid[]​

ERIConn_CID list

4. ERIConn_damperLoc[]​

ERIConn_damperLoc list

5. ERIConn_ocid[]​

ERIConn_ocid list

6. ERIConn_damperOffsetVec[]​

ERIConn_damperOffsetVec list

7. ERIConn_nodeId[]​

ERIConn_nodeId list

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ElemRelatedInfo_Conn([[267, 14, 1]], [[267, 1, 0, 0]], [[267, 1]], [[267, 0.001]],
    [[267, 1]], [[267, 0, 0, 0.001]])
