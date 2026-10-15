# ChangeTopologyElement()

ChangeTopologyElement()

説明​

トポロジー要素を変更します。

構文​

ChangeTopologyElement(int[] taElemKey, int[] taFaceKey, int[] taBodyKey, bool bCreateNewBody)

入力​

1. Int[]​

要素キー（[要素 ID]）のカーソル

2. Int[]​

フェースキー（[フェース ID]）のカーソル

3. Int[]​

パートキー（[パート ID]）のカーソル

4. Bool​

新しいパートを作成するかどうかのフラグ True = 1, False = 0

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

ChangeTopologyElement([2357, 2214, 2213, 2358], [], [1], 1)
