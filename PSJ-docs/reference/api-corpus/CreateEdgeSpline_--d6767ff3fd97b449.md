# CreateEdgeSpline()

CreateEdgeSpline()

説明​

エッジ・スプラインを作成します

構文​

CreateEdgeSpline(Cursor[] node_list, int arc, Cursor body_cursor, String name)

入力​

1. Cursor[]​

対象節点リストのカーソル（[10:節点ID]）

2. Int​

円弧タイプ

0: スプライン

1: 円弧（3つの節点）

3. Cursor​

対象 パートのカーソル（[3:パートID]）

4. String​

バー名

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateEdgeSpline([10:455, 10:462, 10:461, 10:469, 10:468], 0, 0:0, "curve")
