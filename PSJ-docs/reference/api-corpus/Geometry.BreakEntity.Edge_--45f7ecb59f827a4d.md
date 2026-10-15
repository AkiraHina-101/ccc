# Geometry.BreakEntity.Edge()

Geometry.BreakEntity.Edge()

説明​

指定された点または角度でエッジを個別の単位に分割します。

構文​

Geometry.BreakEntity.Edge(...)

リボン：Geometry » Break Entity » Edge

入力​

crlParts​

フェースに接続するエッジが分割されるパートを指定する Cursor のリスト。bAutoByAngle = True の場合は、crlParts、crlFaces、または crlEdges のいずれかを指定する必要があります。

デフォルト値は [] です。

crlFaces​

フェースに接続するエッジが分割されるフェースを指定する Cursor のリスト。bAutoByAngle = True の場合は、crlParts、crlFaces、または crlEdges のいずれかを指定する必要があります。

デフォルト値は [] です。

crlEdges​

分割されるエッジを指定する Cursor のリスト。bAutoByAngle = True の場合は、crlParts、crlFaces、または crlEdges のいずれかを指定する必要があります。

デフォルト値は [] です。

crlNodes​

エッジが通過する節点を指定する Cursor のリスト。bAutoByAngle = False の場合、この引数は無視されます。

デフォルト値は [] です。

bAutoByAngle​

エッジの角度で分割するかどうかを指定する Boolean。

True の場合、エッジは、与えられた dEdgeAngle よりも角度が大きくない位置で分割されます。

デフォルト値は False です。

dEdgeAngle​

線分間の角度を度で指定する Double。bAutoByAngle が指定されていない場合、この引数は無視されます。

デフォルト値は 60.0 です。

戻り値​

関数が実行された後のエッジを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube(iPartColor=6215639)

edges = Geometry.BreakEntity.Edge(crlNodes=[Node(86, 83)])

JPT.Debugger(edges)
