# CreateBar()

CreateBar()

説明​

バー パートを作成します

構文​

CreateBar(string bodyName, int meshCount, cursor startNode, cursor endNode)

入力​

1. String​

パート名を挿入します

2. Int​

メッシュの個数を数えます

3. Cursor​

開始節点カーソル（10:節点ID）

4. Cursor​

終了節点カーソル（10:節点ID）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateBar("Bar_1", 7, 10:1, 10:2)
