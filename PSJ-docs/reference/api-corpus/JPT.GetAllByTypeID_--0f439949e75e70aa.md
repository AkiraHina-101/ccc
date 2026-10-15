# JPT.GetAllByTypeID()

JPT.GetAllByTypeID()

説明​

_ [DItemType]（../data-type/psj-command/DItem-types）_ を入力して、すべてのエンティティの情報を取得します。

構文​

JPT.GetAllByTypeID（DItemType）

入力​

DItemType​

ターゲットエンティティの _ [DItemType]（../data-type/psj-command/DItem-types）_ を指定する Enum です。

これは必須の入力です。

戻り値​

入力されたIDによって見つかったすべてのエンティティの情報を含む _ [DItemVector]（../data-type/psj-utility/pre-utility/built-in-types/DItemVector）_ オブジェクトまたは _ [DItem]（../data-type/psj-utility/pre-utility/built-in-types/DItem）_ オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべてのパートを選択し、それらの情報を DItem のリストに保存
listDItemParts = JPT.GetAllByTypeID(JPT.DItemType.BODY) # ID = 3
JPT.Debugger(listDItemParts)
