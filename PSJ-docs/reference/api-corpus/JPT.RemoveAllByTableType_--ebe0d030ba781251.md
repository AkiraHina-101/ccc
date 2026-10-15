# JPT.RemoveAllByTableType()

JPT.RemoveAllByTableType()

説明​

入力された_DTableType_ に関連するエンティティをすべて削除します。

構文​

JPT.RemoveAllByTableType(DTableType)

入力​

DTableType​

削除されるエンティティの DTableType を指定する Enum です。

これは必須の入力です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=5955674)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5682356)
Geometry.Part.Cube(strName="Cube_3", iPartColor=12237393)
Geometry.Part.Cube(strName="Cube_4", iPartColor=6740326)
Geometry.Part.Cube(strName="Cube_5", iPartColor=7335919)

# 作成されたパートをすべて削除
JPT.RemoveAllByTableType(JPT.DTableType.DTABLE_BODY)
