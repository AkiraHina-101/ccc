# JPT.GetLastCreatedCursor()

JPT.GetLastCreatedCursor()

説明​

最後に作成されたエンティティの情報を取得します。

構文​

JPT.GetLastCreatedCursor()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

最後に作成されたオブジェクトの情報を含む DItemVector オブジェクトまたは List of DItem オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# 最後に作成されたパートの情報を取得
lastCreatedCursor = JPT.GetLastCreatedCursor()
JPT.Debugger(lastCreatedCursor[0]) # Cube_3
