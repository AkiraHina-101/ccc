# MeasureAngleBy3Nodes()

MeasureAngleBy3Nodes()

説明​

3つの節点によって作成された角度を測定します。

構文​

MeasureAngleBy3Nodes(cursor node1,cursor node2,ccursor node3,Axis xyz,String Target,Integer N)

入力​

1. Cursor​

節点カーソル(10:;=節点 ID)

2. Cursor​

節点カーソル(10:;=節点 ID)

3. Cursor​

節点カーソル(10:;=節点 ID)

4. String​

ターゲット（角度、XY、YZ、ZX、ALL）

5. Integer N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureAngleBy3Nodes(10:331,10:323,10:340,"Angle",6)

または

MeasureAngleBy3Nodes(10:331,10:323,10:340,"ALL",6)
