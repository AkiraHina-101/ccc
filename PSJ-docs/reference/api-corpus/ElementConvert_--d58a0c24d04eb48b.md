# ElementConvert()

ElementConvert()

説明​

要素変換

この機能はV5.0から中止され、ElementConv_SurfaceおよびElementConv_Solidに変更されました。

構文​

ElementConvert(cursor[] taBody, int iType)

入力​

1. Cursor[]​

ターゲット パートカーソル（[3：パートID]）

2. Int​

変換タイプ

0：線形（Tri3 / Quad4）に変換

1：2次（Tri6 / Quad8）に変換

2：Tri3

7：分割（Tri6to4Tri3s / Quad8to4Quad4s）

戻り値​

"1"：関数を実行できます

"0"：関数を実行できません

サンプルコード​

ElementConvert([3:2], 3)
