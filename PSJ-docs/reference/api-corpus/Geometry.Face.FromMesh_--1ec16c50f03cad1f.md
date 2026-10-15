# Geometry.Face.FromMesh()

Geometry.Face.FromMesh()

説明​

特定のメッシュフェースから新しい幾何学的フェースを含む新しいパートエンティティを作成します。

構文​

Geometry.Face.FromMesh(...)

マクロ: CreateFaceFromMeshFace

リボン: Geometry » Face » Face from Mesh Face

入力​

crFace​

新しいフェースが作成されるメッシュフェースを指定する Cursor です。

これは必須の入力です。

戻り値​

新しく作成されたフェースを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

created_face = Geometry.Face.FromMesh(crFace=Face(26))
JPT.Debugger(created_face)
