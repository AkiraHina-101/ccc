# Imprint_ClosedLine()

Imprint_ClosedLine()

説明​

印字された閉じたラインを作成します。

構文​

Imprint_ClosedLine(double[] Point_xyz,bool BreakFace,Cursor[] bodyCursor)

入力​

1. Double[]​

Point xyz [[x1,y1,z1],[x2,y2,z2],[x3,y3,z3]]

2. Bool​

フラグ true = 1,false=0

3. Cursor[]​

パートカーソル（[3:*]*= パートID）

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

Imprint_ClosedLine([[0.00444444, 0.00222222, 0.01], [0.00666667, 0.00333333, 0.01],
     [0.00666667, 0.00666667, 0.01], [0.00333333, 0.00555556, 0.01]], 1, [3:1])
