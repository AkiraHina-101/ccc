# ElemRelatedInfo_Conn()

ElemRelatedInfo_Conn()

説明​

ブッシュ/ギャップパラメータを設定します

構文​

ElemRelatedInfo_Conn(ERIConn_Ends[] ends, ERIConn_orientVec[] orientVec,
    ERIConn_cid[] CID, ERIConn_damperLoc[] damperLocs, ERIConn_ocid[] ocids,
    ERIConn_damperOffsetVec[] damperOffsetVecs, ERIConn_nodeId[] nodeIds)

入力​

1. ERIConn_Ends[]​

ERIConn_end リスト

2. ERIConn_orientVec[]​

ERIConn_orientVec リスト

3. ERIConn_cid[]​

ERIConn_CID リスト

4. ERIConn_damperLoc[]​

ERIConn_damperLoc リスト

5. ERIConn_ocid[]​

ERIConn_ocid リスト

6. ERIConn_damperOffsetVec[]​

ERIConn_damperOffsetVec リスト

7. ERIConn_nodeId[]​

ERIConn_nodeId リスト

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ElemRelatedInfo_Conn([[267, 14, 1]], [[267, 1, 0, 0]], [[267, 1]], [[267, 0.001]],
    [[267, 1]], [[267, 0, 0, 0.001]])
