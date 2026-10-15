# MeasureDistanceBy2Nodes()

MeasureDistanceBy2Nodes()

説明​

2つの節点間の距離を計測します

構文​

MeasureDistanceBy2Nodes(cursor[] Cursors,String Target,Integer N)

入力​

1. cursor[]​

節点のカーソル([10:*,10:**]*,** = 節点ID)

2. String​

ターゲット(距離またはXまたはYまたはZまたはすべて)

3. Integer N​

小数点以下の桁数を指定します(N<=30)

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureDistanceBy2Nodes([10:447,10:468],"X",6)

MeasureDistanceBy2Nodes([10:447,10:468],"Dist",6)
