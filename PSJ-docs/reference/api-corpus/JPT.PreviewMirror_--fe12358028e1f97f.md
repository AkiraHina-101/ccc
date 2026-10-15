# JPT.PreviewMirror()

JPT.PreviewMirror()

説明​

Body mirrorのプレビュー結果を表示します。

構文​

JPT.PreviewMirror(...)

入力​

DBodyVector​

鏡像化する部分の情報を格納する DBodyVector オブジェクトまたは DBody オブジェクトのリストです。

必須の入力です。

veclPoint​

ミラープレーンを形成する3つの節点の位置を指定する TVector3D オブジェクトのリストです。

必須の入力です。

dOffset​

偏差値を指定する Double です。

必須の入力です。

iColor​

プレビューされるエンティティの色を指定する Integer です。

デフォルト値は255です。

dTransparency​

プレビューされるエンティティの透明度を指定する Double です。

dTransparency の範囲は [0.0, 1.0] です。

デフォルト値は0.5です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# プレビューをクリア
JPT.ClearPreview()

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=13259210)

# プレビュー
color = JPT.ConvertRGBToJPTColor(255,255,87) #yellow
parts = JPT.GetAllParts()
JPT.PreviewMirror(parts,[[0.0055,0.01,0.0055],[0.005,0.01,0.0044],[0.0044,0.01,0.0044]],0,color,0.8)
JPT.ViewFitToModel()
