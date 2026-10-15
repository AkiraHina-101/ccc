# JPT.HidePreview()

JPT.HidePreview()

説明​

メイン画面でプレビュー表示を非表示にします。プレビューはまだ存在していますが、非表示になります。

構文​

JPT.HidePreview(...)

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値はありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.0, 0.01, 0.0], strName="Cube_2", iPartColor=13259210)
JPT.ViewFitToModel()

# プレビュー：
color = JPT.ConvertRGBToJPTColor(255,255,87) #イエロー
parts = JPT.GetAllParts()
JPT.PreviewScaling(parts,[2,1.1,1.1],[0,0,0],color,0.2)

# プレビュー非表示：
JPT.HidePreview()
```  ​​​
