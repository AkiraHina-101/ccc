# GeoImprintSplineS()

GeoImprintSplineS()

説明​

インプリントスプラインを作成します。

構文​

GeoImprintSplineS(double[] taPositions, cursor[] taTargetFace, bool bBreakFace)

入力​

1. Double[]​

インプリントの対象点 -> ポイント_n([xi, yi, zi])

2. Cursor[]​

対象フェースのカーソル([6:フェースID])

3. Bool​

フェースを分割するかどうか True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

GeoImprintSplineS([[0.01, 0.01, 0.004444444444444444], [0.006666666666666666, 0.01, 0], [0.004444444444444444, 0.01, 0.004444444444444444]], [6:22], 1)
