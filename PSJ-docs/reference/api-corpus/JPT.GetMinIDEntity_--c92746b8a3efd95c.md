# JPT.GetMinIDEntity()

JPT.GetMinIDEntity()

説明​

入力されたDItemTypeの最小IDを取得します。

構文​

JPT.GetMinIDEntity(DItemType)

入力​

DItemType​

Jupiter内のエンティティの DItemType を指定する Enum です。

この入力は必須です。

戻り値​

入力されたDItemTypeの最小IDを指定する Integer です。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# 作成したパートの最小IDを取得
iMinID = JPT.GetMinIDEntity(JPT.DItemType.BODY)
JPT.Debugger(iMinID) # 1
