# JPT.GetEntitiesByPosition()

JPT.GetEntitiesByPosition()

説明​

与えられた条件（X、Y、Z）を満たすエンティティを取得します。

構文​

JPT.GetEntitiesByPosition(AssociateType, xCoordValue, yCoordValue, zCoordValue)

入力​

AssociateType​

ジュピター内で関連付けの種類を記述する AssociateType を指定する Enum。

これは必須入力です。

xCoordValue​

カーテシアン座標系のX座標の値をミリメートル[mm]で指定する Double。

これは必須入力です。

yCoordValue​

カーテシアン座標系のY座標の値をミリメートル[mm]で指定する Double。

これは必須入力です。

zCoordValue​

カーテシアン座標系のZ座標の値をミリメートル[mm]で指定する Double。

これは必須入力です。

戻り値​

満たされたエンティティの情報を含む DItemVector オブジェクトまたは DItem オブジェクトのリスト。

満たされたエンティティを取得するには、作成された DItemVector の2番目の要素を取得してください。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
JPT.ViewFitToModel()

# 作成された立方体の情報を取得
selPart = JPT.GetEntitiesByPosition(JPT.AssociateType.AS_BODY, 10, 10, 10)
JPT.Debugger(selPart[1]) # 作成したリストの2番目の要素
