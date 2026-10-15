# JPT.SelectionByIDs()

JPT.SelectionByIDs()

説明​

IDリストを使用してエンティティを選択します。

構文​

JPT.SelectionByIDs(DItemType, entityIDs, BoolType)

入力​

DItemType​

Jupiter内でエンティティの DItemType を指定する Enum です。

この入力は必須です。

entityIDs​

選択するエンティティのIDリストを指定する Integer のリストです。

この入力は必須です。

BoolType​

選択モードを記述する BoolType を指定する Enum です：

True: 入力されたIDでエンティティを選択します。

False: 入力されたIDでエンティティの選択を解除します。

この入力は必須です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6974164)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=7599987)
JPT.ViewFitToModel()

# IDが[50, 51, 52]のフェースを選択
JPT.SelectionByIDs(JPT.DItemType.FACE, [50, 51, 52], JPT.BoolType.TRUE_VAL)
