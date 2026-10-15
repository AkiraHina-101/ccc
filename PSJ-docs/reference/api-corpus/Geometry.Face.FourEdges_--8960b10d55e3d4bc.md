# Geometry.Face.FourEdges()

Geometry.Face.FourEdges()

説明​

与えられた4つのエッジを使用してフェースを作成します。与えられたエッジは閉じた輪郭を形成し、複数のループを含んではいけません。

構文​

Geometry.Face.FourEdges(...)

マクロ：CreateFaceFromFourEdges

Ribbon：Geometry » Face » Edges2 (4 Edges)

入力​

crlEdges​

新しいフェースを囲む4つのエッジを指定する Cursor リスト。エッジは閉じた輪郭を形成し、複数のループを含んではいけません。

この入力は必須です。

戻り値​

新しく作成されたフェースを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

Geometry.DeleteEntity.Face(crlFaces=[Face(26)])

created_face = Geometry.Face.FourEdges(crlEdges=[Edge(17, 18, 19, 20)])

JPT.Debugger(created_face)
