# JPT.GetEntitiesByName()

JPT.GetEntitiesByName()

説明​

入力されたエンティティ名の情報を取得します。

構文​

JPT.GetEntitiesByName(DTableType, itemName, BoolType)

入力​

DTableType​

Jupiter内のエンティティの DTableType を指定する Enum です。

これは必須の入力です。

itemName​

対象エンティティの名前を指定する String です。

これは必須の入力です。

BoolType​

一致タイプを説明する BoolType を指定する Enum です：

False: 近似一致

True: 完全一致

これは必須の入力です。

戻り値​

入力された名前を持つエンティティの情報を含む DItemVector オブジェクトまたは DItem オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# 名前が "_" のパートの情報を取得してリストに保存
listParts = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "_", JPT.BoolType.FALSE_VAL)
print(listParts[0].name) # Cube_1
print(listParts[2].name) # Cube_3
print(listParts[2].id) # 3
