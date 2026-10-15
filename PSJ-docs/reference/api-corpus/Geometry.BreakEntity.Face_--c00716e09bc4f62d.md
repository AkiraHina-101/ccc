# Geometry.BreakEntity.Face()

Geometry.BreakEntity.Face()

説明​

フェースをエッジで囲まれた個別のユニットに分割します。

構文​

Geometry.BreakEntity.Face(...)

マクロ: BreakFace

リボン: Geometry » Break Entity » Face

入力​

crlFaces​

分割されるフェースを指定する Cursor のリスト。

これは必須の入力です。

戻り値​

分割操作後のフェースを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()

Geometry.Edge.Line(dllPoints=[[0.01, 0, 0.01], 
                              [0, 0.01, 0.01]], 
                   crlFaces=[Face(26)],
                   bBreakFace=False)

faces = Geometry.BreakEntity.Face(crlFaces=[Face(26)])

JPT.Debugger(faces)
