# Geometry.MergeEntities.Faces()

Geometry.MergeEntities.Faces()

説明​

選択したフェースを1つのフェースにマージします。

構文​

Geometry.MergeEntities.Faces(...)

リボン：Geometry » Merge Entities » Faces

入力​

crlFaces​

マージに使用するフェースを指定する Cursor のリスト。

これは必須の入力です。

bMergeEdge​

フェース間のエッジを連続したエッジにマージするかどうかの Boolean 値です。

デフォルト値は True です。

bRemoveNonBoundEdge​

境界エッジでないエッジを削除するかどうかの Boolean 値です。

デフォルト値は True です。

戻り値​

関数を実行した後のフェースのリストを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()
Geometry.Edge.Line(dllPoints=[[0.005, 0, 0.01],
                              [0.006, 0.01, 0.01]],
                   crlFaces=[Face(26)])
Geometry.Edge.Line(dllPoints=[[0.002, 0.002, 0.01],
                              [0.003, 0.005, 0.01]],
                   crlFaces=[Face(26)])
merged_faces = Geometry.MergeEntities.Faces(crlFaces=[Face(26, 28)])
JPT.Debugger(merged_faces)
