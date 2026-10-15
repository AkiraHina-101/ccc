# JPT.GetAllFaces()

JPT.GetAllFaces()

説明​

すべての既存のフェースの情報を取得します。

構文​

JPT.GetAllFaces()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

すべての既存のフェースの情報を含む FaceVector オブジェクトまたは List of DFace オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存のフェースの情報を取得
listDFaces = JPT.GetAllFaces()
JPT.Debugger(listDFaces)

# リスト内の各既存フェースの関連情報をすべて表示
for face in listDFaces:
    JPT.Debugger(face)
