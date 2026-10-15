# GeometoryImprintEdgeSpline()

GeometoryImprintEdgeSpline()

説明​

インプリントスプラインを作成します

構文​

GeometoryImprintEdgeSpline(double[] ポイントxyz, bool フラグブレークフェース, Cursor[] パートカーソル)

入力​

1. Double[]​

ポイントxyz [[x1,y1,z1],[x2,y2,z2],[x3,y3,z3]]

2. Bool​

フラグ true = 1, false = 0

3. Int​

パートカーソル([3:*]*=パート ID)

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

GeometoryImprintEdgeSpline([0.00666667, 0.00222222, 0.01, 0.00777778, 0.00444444, 0.01, 0.00333333, 0.00666667, 0.01], 1, [3:1])
