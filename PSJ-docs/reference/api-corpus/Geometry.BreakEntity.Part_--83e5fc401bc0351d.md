# Geometry.BreakEntity.Part()

Geometry.BreakEntity.Part()

説明​

各閉じたジオメトリに基づいて部分を別々の単位に分けます。

構文​

Geometry.BreakEntity.Part(...)

リボン: Geometry » Break Entity » Part

入力​

crlParts​

分離するパートを指定する Cursor リストです。

これは必須の入力です。

戻り値​

分離された パートを指定する Cursor リストです。

サンプルコード​

Geometry.Part.Cube(iPartColor=16147556)
Geometry.DeleteEntity.Face([Face(24, 22, 26, 21, 25)])
Geometry.Edge.Line(dllPoints=[[0, 0.0022, 0], 
                              [0, 0.0022, 0.01]], 
                   crlFaces=[Face(23)])
Geometry.Edge.Line(dllPoints=[[0, 0.0067, 0], 
                              [0, 0.0067, 0.01]], 
                   crlFaces=[Face(23)])
Geometry.DeleteEntity.Face([Face(23)])

bodies = Geometry.BreakEntity.Part(crlParts=[Part(1)])

JPT.Debugger(bodies)
