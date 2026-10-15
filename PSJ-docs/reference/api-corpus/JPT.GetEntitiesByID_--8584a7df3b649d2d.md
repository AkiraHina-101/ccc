# JPT.GetEntitiesByID()

JPT.GetEntitiesByID()

説明​

入力されたエンティティIDの情報を取得します。

構文​

JPT.GetEntitiesByID(DItemType, itemID)

入力​

DItemType​

Jupiter内のエンティティの DItemType を指定する Enum です。

この入力は必須です。

itemID​

対象エンティティのIDを指定する Integer です。

この入力は必須です。

戻り値​

入力されたIDを持つエンティティの情報を含む DItemVector オブジェクトまたは List of DItem オブジェクト。

入力されたエンティティはこのリストの最初の要素であることに注意してください。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# ID = 2のパートの情報を取得してリストに格納
listParts = JPT.GetEntitiesByID(JPT.DItemType.BODY, 2)

# パートの情報を表示
JPT.Debugger(listParts[0])
