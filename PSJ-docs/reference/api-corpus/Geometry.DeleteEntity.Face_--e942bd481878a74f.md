# Geometry.DeleteEntity.Face()

Geometry.DeleteEntity.Face()

説明​

フェースを削除します。

構文​

Geometry.DeleteEntity.Face(...)

リボン: Geometry » Delete Entity » Face

入力​

crlFaces​

削除するフェースを指定する Cursor のリストです。

これは必須入力です。

戻り値​

成功するとTrue、失敗するとFalseです。

サンプルコード​

Geometry.Part.Cube()

flag = Geometry.DeleteEntity.Face(crlFaces=[Face(26)])

JPT.Debugger(flag)
