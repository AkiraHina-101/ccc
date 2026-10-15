# JPT.CastDItemToDElem()

JPT.CastDItemToDElem()

説明​

選択した要素の情報を取得するために、[DItem](../data-type/psj-utility/pre-utility/built-in-types/DItem) オブジェクトを [DElem](../data-type/psj-utility/pre-utility/built-in-types/DElem) オブジェクトに変換します。

構文​

JPT.CastDItemToDElem(DItemObject)

入力​

DItemObject​

変換に使用される [DItem](../data-type/psj-utility/pre-utility/built-in-types/DItem) オブジェクトです。

これは必須の入力です。

戻り値​

関連情報を持つ [DElem](../data-type/psj-utility/pre-utility/built-in-types/DElem) オブジェクト（要素）。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
JPT.ViewFitToModel()

# 作成された DItem オブジェクトのリストから DItem オブジェクトを要素オブジェクトとして取得
listDItemElems = JPT.GetAllByTypeID(JPT.DItemType.ELEM)
dItemElem = listDItemElems[0]
JPT.Debugger(dItemElem)

# 上記の DItem オブジェクトから DElem オブジェクトに変換
dElem = JPT.CastDItemToDElem(dItemElem)
JPT.Debugger(dElem)
