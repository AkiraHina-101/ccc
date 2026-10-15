# Tools.Measure.Distance.FaceNode()

Tools.Measure.Distance.FaceNode()

説明​

面節点による距離の計測

構文​

Tools.Measure.Distance.FaceNode(crlFaces, crlNodes, iPrecision=6)

リボン: Tools » Measure » Distance » FaceNode

入力​

crlFaces​

面を指定する Cursor リストです。

これは必須の入力です。

crlNodes​

節点を指定する Cursor リストです。

これは必須の入力です。

iPrecision​

精度を指定する Integer です。

デフォルト値は6です。

戻り値​

成功すると1の文字列、失敗すると0の文字列。

サンプルコード​

Geometry.Part.Trapezoid()
dist=Tools.Measure.Distance.FaceNode(crlFaces=[Face(23)], crlNodes=[Node(306)],iPrecision=15)
print(dist)
