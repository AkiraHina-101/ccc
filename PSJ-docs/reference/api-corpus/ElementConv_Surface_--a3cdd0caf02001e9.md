# ElementConv_Surface()

ElementConv_Surface()

説明​

aper内のサーフェス要素の要素変換。

構文​

ElementConv_Surface(cursor[] taBody, int iType)

入力​

1. Cursor[]​

ターゲット パートのカーソル（[3:Part ID]）

2. Int​

変換タイプ

0: 線形に変換（Tri3/Quad4）

1: 二次に変換（Tri6/Quad8）

2: Tri3

7: 分割（Tri6to4Tri3s/Quad8to4Quad4s）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ElementConv_Surface([3:2], 1)
