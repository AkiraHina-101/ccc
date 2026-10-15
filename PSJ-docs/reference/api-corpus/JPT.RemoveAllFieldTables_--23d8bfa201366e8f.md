# JPT.RemoveAllFieldTables()

JPT.RemoveAllFieldTables()

説明​

すべてのフィールドデータを削除します。

構文​

JPT.RemoveAllFieldTables()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値はありません。

サンプルコード​

# サンプルのフィールドデータを作成
BoundaryConditions.FieldData(strName="test_1", iType=1,
                             ilSheet=[3, 4, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3])
BoundaryConditions.FieldData(strName="test_2", iType=4,
                             ilSheet=[3, 2, 1, 1, 2, 2, 3, 3])
BoundaryConditions.FieldData(strName="test_3", iType=3,
                             ilSheet=[3, 2, 1, 1, 2, 2, 3, 3])

# 作成されたすべてのフィールドデータを削除
JPT.RemoveAllFieldTables()
