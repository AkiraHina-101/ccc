# Geometry.Edge.NodeShortestPath()

Geometry.Edge.NodeShortestPath()

説明​

2つの節点間の要素エッジの最短経路を使用してエッジを作成します。

構文​

Geometry.Edge.NodeShortestPath(...)

リボン：Geometry » Edge » 2 Nodes Shortest Path

入力​

crFirstNode​

最初の節点を指定する Cursor です。

これは必須の入力です。

crSecondNode​

2番目の節点を指定する Cursor です。

これは必須の入力です。

bBreakFace​

最短エッジが存在する可能性のあるフェースを分割するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

新しく作成されたエッジを指定する Cursor のリストです。

サンプルコード​

Geometry.Part.Cube(iPartColor=6215639)

created_edges = Geometry.Edge.NodeShortestPath(crFirstNode=Node(79), 
                                               crSecondNode=Node(91), 
                                               bBreakFace=0)
JPT.Debugger(created_edges)
