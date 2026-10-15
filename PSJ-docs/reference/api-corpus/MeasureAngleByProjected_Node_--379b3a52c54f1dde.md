# MeasureAngleByProjected_Node()

MeasureAngleByProjected_Node()

説明​

節点と座標系の平面との角度を測定します。

構文​

MeasureAngleByProjected_Node(カーソル, 節点, 文字列 ターゲット, 整数 N)

入力​

1. Cursor​

節点のカーソル（10:;=節点のID）

2. String​

ターゲット（XYまたはYZまたはZXまたはALL）

3. Int N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1"：関数を実行できます

"0"：関数を実行できません

サンプルコード​

MeasureAngleByProjected_Node(10:331,"XY",6)

または

MeasureAngleByProjected_Node(10:331,"ALL",6)
