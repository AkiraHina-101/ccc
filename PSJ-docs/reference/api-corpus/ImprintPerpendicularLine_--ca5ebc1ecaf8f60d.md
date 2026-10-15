# ImprintPerpendicularLine()

ImprintPerpendicularLine()

説明​

垂直直線の印象を作成します

構文​

ImprintPerpendicularLine(cursor[] nodes, cursor[] faces, double offset, bool bBreakFace)

入力​

1. Cursor[]​

対象節点カーソル（[10:Node ID]）

2. Cursor[]​

対象フェースカーソル（[6:Face ID]）

3. Double​

挿入オフセット値

4. Bool​

フェースの分割を行うかどうか（True = 1、False = 0）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImprintPerpendicularLine([10:218, 10:190], [6:22], 0.002, 1)
