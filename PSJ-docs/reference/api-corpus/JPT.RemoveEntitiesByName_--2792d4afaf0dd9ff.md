# JPT.RemoveEntitiesByName()

JPT.RemoveEntitiesByName()

説明​

入力された名前を使用してエンティティを削除します。

構文​

JPT.RemoveEntitiesByName(DTableType, itemName, BoolType)

入力​

DTableType​

Jupiter内のエンティティの DTableType を指定する Enum です。

この入力は必須です。

itemName​

削除する対象エンティティの名前を指定する String です。

この入力は必須です。

BoolType​

一致タイプを表す BoolType を指定する Enum です：

False：近似一致

True：完全一致

この入力は必須です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# パート名に"_"文字が含まれるすべてのパートを削除します
JPT.RemoveEntitiesByName(JPT.DTableType.DTABLE_BODY, "_", JPT.BoolType.FALSE_VAL)
