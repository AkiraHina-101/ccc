# MeasureAngleBy2Edges()

MeasureAngleBy2Edges()

説明​

2つのエッジによって作成された角度を測定します。

構文​

MeasureAngleBy2Edges(cursor edge1,cursor edge2,String Target,Integer N)

入力​

1. Cursor​

エッジのカーソル(5:;=エッジID)

2. Cursor​

エッジのカーソル(5:;=エッジID)

3. String​

ターゲット（角度またはXYまたはYZまたはZXまたはALL）

4. Integer N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureAngleBy2Edges(5:27,5:32,"Angle",6)

または

MeasureAngleBy2Edges(5:27,5:32,"ALL",6)
