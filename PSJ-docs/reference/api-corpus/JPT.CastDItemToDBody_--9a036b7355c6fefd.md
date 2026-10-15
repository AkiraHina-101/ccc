# JPT.CastDItemToDBody()

JPT.CastDItemToDBody()

説明​

選択した パートの情報を取得するために、_ [DItem]（../data-type/psj-utility/pre-utility/built-in-types/DItem）_ オブジェクトを DBody オブジェクトに変換します。

構文​

JPT.CastDItemToDBody(DItemObject)

入力​

DItemObject​

変換に使用される DItem オブジェクト

これは必須の入力です。

戻り値​

関連情報を持つ DBody オブジェクト（パート）。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
JPT.ViewFitToModel()

# 作成したDItemオブジェクトリストからDItemオブジェクトとしてパートオブジェクトを取得
listDItemParts = JPT.GetAllByTypeID(JPT.DItemType.BODY)
dItemPart = listDItemParts[0]
JPT.Debugger(dItemPart)

# 上記のDItemオブジェクトからDBodyオブジェクトに変換
dBodyPart = JPT.CastDItemToDBody(dItemPart)
JPT.Debugger(dBodyPart)
