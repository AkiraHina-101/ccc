# JPT.ClearAllSelection()

JPT.ClearAllSelection()

説明​

選択したエンティティをすべてクリアします。

構文​

JPT.ClearAllSelection()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値はありません。

サンプルコード​

# モデルを準備する
Geometry.Part.Cube(iPartColor=6974164)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=7599987)
JPT.ViewFitToModel()

# ID = 51 のフェースを選択する
JPT.SelectionByID(JPT.DItemType.FACE, 51, True)

# 選択したエンティティをすべて選択解除する
JPT.ClearAllSelection()
