# JPT.ShowPreview()

JPT.ShowPreview()

説明​

メイン画面でプレビューレンダリングを表示します。

構文​

JPT.ShowPreview(...)

入力​

このユーティリティ関数は入力値を必要としません。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルを準備する
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.0, 0.01, 0.0], strName="Cube_2", iPartColor=13259210)
JPT.ViewFitToModel()

# プレビュー:
color = JPT.ConvertRGBToJPTColor(255,255,87) #yellow
parts = JPT.GetAllParts()
JPT.PreviewScaling(parts,[2,1.1,1.1],[0,0,0],color,0.2)

# プレビューを表示する:
JPT.HidePreview()
JPT.ShowPreview()
