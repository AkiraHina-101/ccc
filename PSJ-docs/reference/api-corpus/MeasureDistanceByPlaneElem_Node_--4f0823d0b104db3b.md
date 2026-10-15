# MeasureDistanceByPlaneElem_Node()

MeasureDistanceByPlaneElem_Node()

説明​

節点と要素によって作成された面との距離を測定します。

構文​

MeasureDistanceByPlaneElem_Node(カーソル・節点, カーソル・エッジ, 整数 N)

入力​

1. Cursor​

節点のカーソル（10:,=節点ID）

2. Cursor​

エッジのカーソル（11:,=エッジID）

3. Int N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureDistanceByPlaneElem_Node(10:438,11:362,6)
