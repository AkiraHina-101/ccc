# JPT.PreviewBCForceNormal()

JPT.PreviewBCForceNormal()

説明​

対象に正規力を適用したときのプレビュー結果を表示します。

構文​

JPT.PreviewBCForceNormal(...)

入力​

DElemForNormal​

2D要素情報を指定する DElem オブジェクトです。

この要素は、力の方向の法線ベクトルを計算するために使用されます。

これは必須入力です。

DItemVector​

力を適用する対象の情報を保存する DItemVector オブジェクトまたは DItem オブジェクトのリストです。

これらの対象には、フェース、エッジ、または節点が含まれます。

これは必須入力です。

iArrowDir​

表示矢印の方向を指定する Integer です。

0: 節点から開始

1: 節点で終了

デフォルト値は0です。

iColor​

プレビューされるエンティティの色を指定する Integer です。

デフォルト値は255です。

dTransparency​

プレビューされるエンティティの透明度を指定する Double です。

dTransparencyの範囲は [0.0、1.0] です。

デフォルト値は0.5です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# プレビューをクリア
JPT.ClearPreview()

# モデルを準備
Geometry.Part.Cube()

# プレビュー
color = JPT.ConvertRGBToJPTColor(255,255,87) #黄色
selFace = JPT.GetEntitiesByID(JPT.DItemType.FACE, 26)
normalElem = JPT.GetEntitiesByID(JPT.DItemType.ELEM, 1065)
normalElem = JPT.CastDItemToDElem(normalElem[0])
JPT.PreviewBCForceNormal(normalElem,selFace,0,color,0.8)
JPT.ViewFitToModel()
