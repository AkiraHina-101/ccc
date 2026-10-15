# MoveNodePoint()

MoveNodePoint()

説明​

節点をフェース（エッジ）ポイント位置に移動します

構文​

MoveNodePoint(double dDeltaX, double dDeltaY, double dDeltaZ, int[] taNodeKey)

入力​

1. Double​

節点を移動するX座標

2. Double​

節点を移動するY座標

3. Double​

節点を移動するZ座標

4. Int[]​

節点キーのカーソル（[節点ID]）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MoveNodePoint(0.0044675, 0.0056845, -3.46945e-18, [410, 369])
