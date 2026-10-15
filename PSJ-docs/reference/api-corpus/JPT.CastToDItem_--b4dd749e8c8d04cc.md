# JPT.CastToDItem()

JPT.CastToDItem()

説明​

選択されたオブジェクトを DItem オブジェクトに変換して、関連するすべての情報を取得します。

構文​

JPT.CastToDItem(Object)

入力​

Object​

DBody、DFace、DElem、DEdge、DGroup、DNode などの Jupiter の Object。

これは必須の入力です。

戻り値​

情報がすべて含まれた DItem オブジェクト（基本オブジェクト）。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
JPT.ViewFitToModel()

# 作成された DBody オブジェクトのリストから DBody オブジェクトとして Part オブジェクトを取得
listDBodyParts = JPT.GetAllParts()
dBodyPart = listDBodyParts[0]
JPT.Debugger(dBodyPart)

# 上記の DBody オブジェクトから DItem オブジェクトに変換
dItemPart = JPT.CastToDItem(dBodyPart)
JPT.Debugger(dItemPart)
