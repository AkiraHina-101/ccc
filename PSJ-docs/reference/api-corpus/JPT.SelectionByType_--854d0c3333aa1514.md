# JPT.SelectionByType()

JPT.SelectionByType()

説明​

種類別に存在するすべてのエンティティを選択します。

構文​

JPT.SelectionByType(DItemType, BoolType)

入力​

DItemType​

Jupiter内のエンティティの DItemType を指定する Enum です。

この入力は必須です。

BoolType​

選択モードを説明する BoolType を指定する Enum です：

True: IDと一緒に入力されたエンティティを選択します。

False: IDと一緒に入力されたエンティティを選択解除します。

この入力は必須です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルを準備
Geometry.Part.Cube(iPartColor=6974164)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=7599987)

# 作成したすべてのパートを選択
JPT.SelectionByType(JPT.DItemType.BODY, JPT.BoolType.TRUE_VAL)
