# InsideHeatGeneration()

InsideHeatGeneration()

説明​

内部発熱を作成します

構文​

InsideHeatGeneration(string strName, double dInsideFlux, cursor crTable, cursor[] crTarget, cursor crEdit)

入力​

1. String​

内部発熱名

2. 小数​

内部フラックス値

3. Cursor​

テーブルフィールドデータのカーソル

4. Cursor[]​

対象エンティティのカーソル

5. Cursor​

編集用カーソル

戻り値​

"1": 関数を実行できる

"0": 関数を実行できません

サンプルコード​

InsideHeatGeneration("InsideHeatGeneration3", 0.001, 81:1, [3:1], 0:0)
