# MeasureAngleBy2Nodes_Axis()

MeasureAngleBy2Nodes_Axis()

説明​

2つの節点と軸によって作成される角度を測定します。

構文​

MeasureAngleBy2Nodes_Axis(cursor node1, cursor node2, Axis xyz, String Target, Integer N)

入力​

1. Cursor​

節点カーソル(10:;=節点ID)

2. Cursor​

節点カーソル(10:;=節点ID)

3. Axis​

単位ベクトル([x, y, z])

4. String​

目標（AngleまたはXYまたはYZまたはZXまたはALL）

5. Integer N​

小数点以下の桁数を指定します（0≦N≦30）

戻り値​

"1"： 関数は実行可能です

"0"： 関数は実行できません

サンプルコード​

MeasureAngleBy2Nodes_Axis(10:331, 10:323, [0,0,1], "ALL", 6)

または

MeasureAngleBy2Nodes_Axis(10:331, 10:323, [0,0,1], "Angle", 6)
