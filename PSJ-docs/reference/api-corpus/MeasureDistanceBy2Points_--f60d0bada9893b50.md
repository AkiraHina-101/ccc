# MeasureDistanceBy2Points()

MeasureDistanceBy2Points()

説明​

2点間の距離を計測します。

構文​

MeasureDistanceBy2Points(Point[] xyz,String Target,Integer N)

入力​

1. Point[]​

Point xyz座標（[[x1,y1,z1],[x2,y2,z2]]）

2. String​

目標（DistまたはXまたはYまたはZまたはALL）

3. Integer N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1"： 関数を実行できます

"0"： 関数を実行できません

サンプルコード​

MeasureDistanceBy2Points([[0.0066666,0.00333333,0.01],[0.004444440.0077777,0.01]],"X",6)

または

MeasureDistanceBy2Points([[0.0066666,0.00333333,0.01],[0.004444440.0077777,0.01]],"Dist",6)
