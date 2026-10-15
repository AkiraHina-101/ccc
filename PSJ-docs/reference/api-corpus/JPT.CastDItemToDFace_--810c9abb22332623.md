# JPT.CastDItemToDFace()

JPT.CastDItemToDFace()

説明​

選択した（入力された）フェースの情報を取得するために、 DItem オブジェクトを DFace オブジェクトに変換します。

構文​

JPT.CastDItemToDFace(DItemObject)

入力​

DItemObject​

変換に使用される DItem オブジェクト。

この入力は必須です。

戻り値​

関連情報を持つ DFace オブジェクト（フェース）。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
JPT.ViewFitToModel()

# 作成された DItem オブジェクトのリストから DItem オブジェクトを取得する
listDItemFaces = JPT.GetAllByTypeID(JPT.DItemType.FACE)
dItemFace = listDItemFaces[0]
JPT.Debugger(dItemFace)

# 上記の DItem オブジェクトから DFace オブジェクトに変換
dFace = JPT.CastDItemToDFace(dItemFace)
JPT.Debugger(dFace)
