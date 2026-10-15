# JPT.GetAllByTableTypeID()

JPT.GetAllByTableTypeID()

説明​

プリフィックス_DTableType_ を入力して、すべてのエンティティの情報を取得します。

構文​

JPT.GetAllByTableTypeID(DTableType)

入力​

DTableType​

ターゲットエンティティの DTableType を指定する Enum です。

これは必須の入力項目です。

戻り値​

入力されたIDによって見つかったすべてのエンティティの情報を含む DItemVector オブジェクトまたは DItem オブジェクトのリストです。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべてのパートを選択し、その情報を DItem のリストに格納します
listDTableParts = JPT.GetAllByTableTypeID(JPT.DTableType.DTABLE_BODY) # ID = 5
JPT.Debugger(listDTableParts)
