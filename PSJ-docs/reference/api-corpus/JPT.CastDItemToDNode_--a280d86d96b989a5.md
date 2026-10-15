# JPT.CastDItemToDNode()

JPT.CastDItemToDNode()

説明​

選択した節点の情報を取得するために、 DItem オブジェクトを DNode オブジェクトに変換します。

構文​

JPT.CastDItemToDNode(DItemObject)

入力​

DItemObject​

変換に使用される DItem オブジェクト。

これは必須の入力です。

戻り値​

関連する情報を持つ DNode オブジェクト（節点付き）。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
JPT.ViewFitToModel()

# 作成したDItemオブジェクトのリストからDItemオブジェクト（圧力）を取得
listDItemNodes = JPT.GetAllByTypeID(JPT.DItemType.NODE)
dItemNode = listDItemNodes[0]
JPT.Debugger(dItemNode)

# 上記のDItemオブジェクトからDNodeオブジェクトに変換
dNode = JPT.CastDItemToDNode(dItemNode)
JPT.Debugger(dNode)
