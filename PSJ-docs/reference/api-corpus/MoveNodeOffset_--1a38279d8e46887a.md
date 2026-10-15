# MoveNodeOffset()

MoveNodeOffset()

説明​

節点をオフセット位置に移動します

構文​

MoveNodeOffset(double dDeltaX, double dDeltaY, double dDeltaZ, cursor crCoord, int[] taNodeKey)

入力​

1. Double​

節点を移動するX座標

2. Double​

節点を移動するY座標

3. Double​

節点を移動するZ座標

4. Cursor​

ローカル座標を使用するかどうか True = 27:*、False = 0:0

5. Int[]​

節点キーのカーソル（[節点ID]）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MoveNodeOffset(0, 0, 0.0005, 0:0, [1068])
