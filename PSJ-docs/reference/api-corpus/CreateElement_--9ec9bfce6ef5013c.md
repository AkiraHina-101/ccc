# CreateElement()

CreateElement()

説明​

節点に基づいて要素を作成します。

構文​

CreateElement(int iElemType, int iParentEntity, int[] viNodeKey)

入力​

1. Int​

要素タイプを作成します

0：TRI3

1：QUAD4

2. Int​

親フェースキーのカーソル（フェースID）

3. Int[]​

節点キーカーソル（[節点ID]）

戻り値​

"1"：関数は実行可能です

"0"：関数を実行できません

サンプルコード​

CreateElement(0, 24, [85, 489, 83])
