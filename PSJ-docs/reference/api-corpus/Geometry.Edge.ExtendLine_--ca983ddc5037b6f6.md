# Geometry.Edge.ExtendLine()

Geometry.Edge.ExtendLine()

説明​

指定された境界まで指定されたエッジを延長します。

構文​

Geometry.Edge.ExtendLine(...)

マクロ：ImprintExtendLine

リボン：Geometry » Edge » Extend Line

入力​

crlEdges​

延長するエッジを指定する Cursor リスト。

これは必須の入力です。

iMethod​

延長方法を指定する Integer 。

iMethod = 0 の場合、指定されたエッジの最後のセグメントの方向に従います。

iMethod = 1 の場合、指定されたエッジの曲率方向を保持しようとします。

デフォルト値は 0 です。

iEnd​

エッジを延長する終了位置を指定する Integer 。

iEnd=0 の場合、端点から最も近いエッジまで延長します。

iEnd=1 の場合、指定されたエッジを境界エッジまで延長します。

デフォルト値は 0 です。

iNoFittingPoints​

フィッティングポイントの数を指定する Integer 。この引数は iMethod=1 の場合に使用されます。

デフォルト値は 3 です。

iDiv​

分割セグメント数を指定する Integer 。この引数は iMethod=1 の場合に使用されます。

デフォルト値は 2 です。

bBreakFace​

指定されたエッジが存在するフェースを可能な限り割るかどうかを指定する Boolean 型。

デフォルト値は True です。

戻り値​

延長されたエッジを指定する Cursor リスト。

サンプルコード​

Geometry.Part.Cube(iPartColor=6215639)

Geometry.Edge.ElementEdges(crplElemEdges=[CursorPair(Node(453), Node(461))])

extended_edges = Geometry.Edge.ExtendLine(crlEdges=[Edge(27)], iEnd=1)

JPT.Debugger(extended_edges)
