# JPT.GetAllFieldData()

JPT.GetAllFieldData()

説明​

ドキュメント内の全てのフィールドデータを取得します。

構文​

JPT.GetAllFieldData()

入力​

このユーティリティ関数は入力値を必要としません。

戻り値​

既存の全てのフィールドデータの情報を含む FieldDataVector オブジェクトまたは DFieldData オブジェクトのリスト。

サンプルコード​

# データの準備
BoundaryConditions.FieldData(
    strName="TimeTable",
    iType=2,
    ilSheet=[4, 2, 0, 0, 0.1, 10, 5, 50, 10, 70])

BoundaryConditions.FieldData(
    strName="FreqTable",
    iType=4,
    ilSheet=[3, 2, 1000, 100, 2000, 110, 3000, 120])

BoundaryConditions.FieldData(
    strName="TemparatureTable",
    iType=7,
    ilSheet=[3, 2, 0, 0.1, 100, 0.3, 300, 0.5])

# 既存の全てのフィールドデータの情報を取得
listDFieldData = JPT.GetAllFieldData()
JPT.Debugger(listDFieldData)

# リスト内の各既存フィールドデータの関連情報を全て出力
for fieldData in listDFieldData:
    JPT.Debugger(fieldData)
