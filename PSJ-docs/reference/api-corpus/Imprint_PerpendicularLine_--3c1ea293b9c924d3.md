# Imprint_PerpendicularLine()

Imprint_PerpendicularLine()

説明​

垂直線の印象を作成します。

構文​

Imprint_PerpendicularLine(double[] Point_xyz, int[] FaceID, double Offset,bool BreakFace,Cursor[] BodyCursor)

入力​

1. Double[]​

ポイント xyz [[x1,y1,z1],[x2,y2,z2]]

2. Int[]​

フェース ID

3. Double​

オフセット値

4. Bool​

フラグ ブレイク フェース true = 1, false = 0

5. Cursor[]​

パート カーソル([3:*]*= パート ID)

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Imprint_PerpendicularLine([[0.01, 0.00555556, 0.01], [0.01, 0.01, 0.00444444]], [24], 0, 1, [3:1])
