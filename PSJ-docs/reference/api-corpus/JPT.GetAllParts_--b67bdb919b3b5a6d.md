# JPT.GetAllParts()

JPT.GetAllParts()

説明​

すべての既存パートの情報を取得します。

構文​

JPT.GetAllParts()

入力​

このユーティリティ関数には入力値が必要ありません。

戻り値​

すべての既存パートの情報を含む BodyVector オブジェクトまたは DBody オブジェクトのリストです。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存パートの情報を取得
listDBodies = JPT.GetAllParts()
JPT.Debugger(listDBodies)

# リスト内の各既存パートの関連情報をすべて表示
for part in listDBodies:
    JPT.Debugger(part)
