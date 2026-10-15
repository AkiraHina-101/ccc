# Geometry.DeleteEntity.Part()

Geometry.DeleteEntity.Part()

説明​

指定したパートを削除します。

構文​

Geometry.DeleteEntity.Part(...)

リボン: Geometry » Delete Entity » Part

入力​

crlParts​

削除するパートを指定する Cursor のリストです。

これは必須の入力です。

戻り値​

成功した場合はTrue、失敗した場合はFalseです。

サンプルコード​

cube = Geometry.Part.Cube()

flag = Geometry.DeleteEntity.Part(crlParts=[cube])

JPT.Debugger(flag)
