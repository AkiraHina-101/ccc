# Geometry.FindFeature.Edge()

Geometry.FindFeature.Edge()

説明​

特性に応じて特定のエッジを見つけて選択します。

構文​

Geometry.FindFeature.Edge(...)

リボン：Geometry » Find Feature » Edges

入力​

crlParts​

特定のフェースを見つけるために指定する Cursor のリスト。iEdgeType 引数の値が 4 と等しくない場合は、この引数を指定する必要があります。

これは必須の入力です。

iEdgeType​

エッジの指定されたタイプを指定する Integer 。

iEdgeType=0 の場合、直線のエッジラインを見つけて選択します。

iEdgeType=1 の場合、閉じたプロファイルを形成するエッジを見つけて選択します。

iEdgeType=2 の場合、円形のエッジを見つけて選択します。

iEdgeType=3 の場合、半円形のエッジを見つけて選択します。

iEdgeType=4 の場合、ボルト穴のエッジを見つけて選択します。

iEdgeType=5 の場合、指定されたエッジの同心エッジを見つけて選択します。

デフォルト値は 0 です。

crlEdges​

iEdgeType=5 の場合にその同心エッジを見つけるために使用するエッジを指定する Cursor のリスト。この引数は指定する必要があります。

デフォルト値は [] です。

dDiameterMin​

ボルト穴の最小直径を指定する Double 。

デフォルト値は 1.0 です。

dDiameterMax​

ボルト穴の最大直径を指定する Double 。

デフォルト値は 2.0 です。

crlFaces​

ボルト穴のエッジを見つけるために使用するフェースを指定する Cursor のリスト。この引数は iEdgeType=4 の場合に使用します。

デフォルト値は [] です。

戻り値​

成功した場合はエッジの List Cursor、失敗した場合は None です。

サンプルコード​

cube=Geometry.Part.Cube()
edges = Geometry.FindFeature.Edge(crlParts=[cube])
JPT.Debugger(edges)
