# Geometry.DeleteEntity.Edge()

Geometry.DeleteEntity.Edge()

説明​

指定したエッジを削除します。

構文​

Geometry.DeleteEntity.Edge(...)

リボン: Geometry » Delete Entity » Edge

入力​

crlEdges​

削除されるエッジを指定する カーソルのリスト。

これは必須の入力です。

戻り値コード​

成功した場合はTrue、失敗した場合はFalseです。

サンプルコード​

Geometry.Part.Cube()

flag = Geometry.DeleteEntity.Edge(crlEdges=[Edge(15, 18, 19)])

JPT.Debugger(flag)
