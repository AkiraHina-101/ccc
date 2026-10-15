# JPT.PreviewBCPressureGeneral()

JPT.PreviewBCPressureGeneral()

説明​

ターゲットに一般的な圧力を適用した際のプレビュー結果を表示します。

構文​

JPT.PreviewBCPressureGeneral(...)

入力​

DItemVector​

圧力を適用するターゲットの情報を保存する DItem オブジェクトまたは DItemVector オブジェクト。

ターゲットはフェース、エッジ、または節点のいずれかです。

この入力は必須です。

iArrowDir​

ディスプレイ矢印の方向を指定する Integer の値。

0: 節点で始まる。

1: 節点で終わる。

デフォルト値は 0 です。

iColor​

プレビューされるエンティティの色を指定する Integer の値。

デフォルト値は 255 です。

dTransparency​

プレビューされるエンティティの透明度を指定する Double 型の値。

dTransparency の範囲は [0.0, 1.0] です。

デフォルト値は 0.5 です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# プレビューをクリア
JPT.ClearPreview()

# モデルを準備
Geometry.Part.Cube()

# プレビュー
color = JPT.ConvertRGBToJPTColor(255,255,87) #yellow
selFace = JPT.GetEntitiesByID(JPT.DItemType.FACE, 26)
JPT.PreviewBCPressureGeneral(selFace,1,color,0.8)
JPT.ViewFitToModel()
