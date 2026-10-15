# ElementConv_Solid()

ElementConv_Solid()

説明​

パート内の固体要素の要素変換。

構文​

ElementConv_Solid(cursor[] taBody, int iType)

入力​

1. Cursor[]​

ターゲット パートカーソル（[3：パートID]）

2. Int​

変換タイプ

0：線形に（Tet4/Penta5/Hex8/Pyramid5）に変換

1：2次に（Tet10/Penta15/Hex20/Pyramid13）に変換

2：HexaをPenta5に変換

3：Hexa/PentaをTet4に変換

戻り値​

"1"：関数が実行可能です

"0"：関数が実行できません

サンプルコード​

ElementConv_Solid([3:2], 1)
