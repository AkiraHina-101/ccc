# MeasureDistanceByPlane3Nodes_Node()

MeasureDistanceByPlane3Nodes_Node()

説明​

節点と3つの節点によって作成された平面の間の距離を測定します。

構文​

MeasureDistanceByPlane3Nodes_Node(cursor node1,cursor node2,cursor node3,cursor node,Integer N)

入力​

1. Cursor​

node1 cursor(10:,=node id)

2. Cursor​

node2 cursor(10:,=node id)

3. Cursor​

node3 cursor(10:,=node id)

4. Cursor​

node cursor(10:,=node id)

5. IntN​

小数点以下の桁数を指定してください (0<=N<=30)

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureDistanceByPlane3Nodes_Node(10:438,10:478,10:450,10:396,6)
