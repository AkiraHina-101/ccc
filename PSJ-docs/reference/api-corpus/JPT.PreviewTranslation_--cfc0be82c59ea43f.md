# JPT.PreviewTranslation()

JPT.PreviewTranslation()

説明​

パート変換のプレビュー結果を表示します。

構文​

JPT.PreviewTranslation(...)

入力​

DBodyVector​

移動するパートの情報を格納する DBodyVector オブジェクトまたは DBody オブジェクトのリスト。

これは必須の入力です。

dlTranslationVector​

移動方向と移動量を定義する移動ベクトルを指定する Double のリスト。

これは必須の入力です。

iColor​

プレビューされるエンティティの色を指定する Integer。

デフォルト値は255です。

dTransparency​

プレビューされるエンティティの透過率を指定する Double。

dTransparency の範囲 = [0.0, 1.0]

デフォルト値は0.5です。

DCoord​

ローカル座標系を指定する DCoord オブジェクト。

デフォルト値はなし（グローバル座標系）です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# プレビューをクリア
JPT.ClearPreview()

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.0, 0.01, 0.0], strName="Cube_2", iPartColor=13259210)
Tools.Coordinates.ThreeNode(iOrder=-1, crlNodes=[Node(496, 578, 590)])

# プレビュー
color = JPT.ConvertRGBToJPTColor(255,255,87) #イエロー
parts = JPT.GetAllParts()
coord = JPT.GetAllCoordinates()
JPT.PreviewTranslation(parts,[0.02,0.01,0.01],color,1,coord[0])
JPT.ViewFitToModel()
