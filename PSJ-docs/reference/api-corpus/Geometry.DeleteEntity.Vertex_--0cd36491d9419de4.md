# Geometry.DeleteEntity.Vertex()

Geometry.DeleteEntity.Vertex()

説明​

指定した頂点を削除します。

構文​

Geometry.DeleteEntity.Vertex(...)

リボン: Geometry » Delete Entity » Vertex

入力​

crlVertices​

削除する頂点を指定する Cursor のリストです。

この入力は必須です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()

Geometry.BreakEntity.Edge(crlEdges=[Edge(18)],
                          crlNodes=[Node(85)])

deleting_status = Geometry.DeleteEntity.Vertex(crlVertices=[Vertex(27)])

JPT.Debugger(deleting_status)
