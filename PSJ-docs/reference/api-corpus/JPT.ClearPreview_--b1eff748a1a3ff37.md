# JPT.ClearPreview()

JPT.ClearPreview()

説明​

メイン画面でのクリアなプレビューレンダリング。

構文​

JPT.ClearPreview(...)

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.0, 0.01, 0.0], strName="Cube_2", iPartColor=13259210)
JPT.ViewFitToModel()

# プレビュー:
color = JPT.ConvertRGBToJPTColor(255,255,87) #yellow
parts = JPT.GetAllParts()
JPT.PreviewScaling(parts,[2,1.1,1.1],[0,0,0],color,0.2)

# プレビューをクリア:
JPT.ClearPreview()
