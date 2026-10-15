# JPT.CastDItemToDGroup()

JPT.CastDItemToDGroup()

説明​

選択したグループの情報を取得するために、 DItem オブジェクトを DGroup オブジェクトに変換します。

構文​

JPT.CastDItemToDGroup(DItemObject)

入力​

DItemObject​

変換に使用される DItem オブジェクト。

これは必須入力です。

戻り値​

関連情報を持つ DGroup オブジェクト（グループ）。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Face(26)])
JPT.ViewFitToModel()

# 作成された DItem オブジェクトのリストから DItem オブジェクトとしてグループオブジェクトを取得
listDItemGroups = JPT.GetAllByTypeID(JPT.DItemType.GROUP)
dItemGroup = listDItemGroups[0]
JPT.Debugger(dItemGroup)

# 上記の DItem オブジェクトから DGroup オブジェクトに変換
dGroup = JPT.CastDItemToDGroup(dItemGroup)
JPT.Debugger(dGroup)
