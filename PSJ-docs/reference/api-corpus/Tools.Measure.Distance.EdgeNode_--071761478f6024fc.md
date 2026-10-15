# Tools.Measure.Distance.EdgeNode()

Tools.Measure.Distance.EdgeNode()

説明​

節点からエッジまでの距離を測定します

構文​

Tools.Measure.Distance.EdgeNode(crEdge, crNode, iPrecision=6)

リボン: Tools » Measure » Distance » EdgeNode

入力​

crEdge​

エッジを指定する Cursor です。

この入力は必須です。

crNode​

節点を指定する Cursor です。

この入力は必須です。

iPrecision​

精度を指定する Integer です。

デフォルト値は6です。

戻り値​

成功時に1の文字列、失敗時に0の文字列です。

サンプルコード​

Geometry.Part.Trapezoid()
dist=Tools.Measure.Distance.EdgeNode(crEdge=Edge(20), crNode=Node(85), iPrecision=15)
print(dist)
