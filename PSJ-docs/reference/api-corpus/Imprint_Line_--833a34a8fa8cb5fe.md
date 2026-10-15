# Imprint_Line()

Imprint_Line()

説明​

印行（ポイント）を作成します。

構文​

Imprint_Line(double[] Point_xyz,bool BreakFace,Cursor[] BodyCursor)

入力​

1. Double[]​

ポイント xyz [[x1,y1,z1],[x2,y2,z2],[x3,y3,z3]]

2. Bool​

フラグ true = 1, false = 0

3. Cursor[]​

パート カーソル([3:*]*= パート ID)

戻り値​

"1": 関数の実行が可能です

"0": 関数の実行が不可能です

サンプルコード​

Imprint_Line([[0.00555556, 0.00333333, 0.01], [0.00555556, 0.00666667, 0.01]], 1, [3:1])
