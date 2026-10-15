# NodeMovedByDirection()

NodeMovedByDirection()

説明​

指定された方向に節点（複数）を移動します

構文​

NodeMovedByDirection(Cursor[] crNode, Cursor crElem, Cursor crFace, double[3] vctDirection,
    double dMoveAmount, bool BDestiByFaceOrElem)

入力​

1. Cursor[]​

対象節点カーソル（[10:節点ID]）

2. Cursor​

対象要素カーソル（11:要素ID）

3. Cursor​

対象フェースカーソル（6:フェースID）

4. Double[3]​

ベクトル方向 DX、DY、DZ

5. Double​

移動量ユーザー入力

6. Bool​

フェースまたは要素による移動先フラグ 真 = 1、偽 = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

NodeMovedByDirection([10:1420], 11:3167, 6:78, [0.196116135138184, 0.98058067569092, 0], 0.005, 1)
