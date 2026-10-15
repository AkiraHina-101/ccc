# MoveNodeAbsolute()

MoveNodeAbsolute()

説明​

節点（複数）を絶対位置に移動します。

構文​

MoveNodeAbsolute(double dDeltaX, double dDeltaY, double dDeltaZ, bool b1stCoord,
    bool b2ndCoord, bool b3rdCoord, int[] taNodeKey, cursor crCoord)

入力​

1. Double​

節点を移動するX座標

2. Double​

節点を移動するY座標

3. Double​

節点を移動するZ座標

4. Bool​

X座標のブールフラグ True = 1, False = 0

5. Bool​

Y座標のブールフラグ True = 1, False = 0

6. Bool​

Z座標のブールフラグ True = 1, False = 0

7. Int[]​

節点キーのカーソル（[節点ID]）

8. Cursor​

ローカル座標を使用するかどうか True = 27:*, False = 0:0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MoveNodeAbsolute(-0.015, 0.015, 0.015, 1, 1, 1, [1069], 0:0)
