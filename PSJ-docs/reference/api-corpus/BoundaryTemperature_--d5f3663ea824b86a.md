# BoundaryTemperature()

BoundaryTemperature()

説明​

境界温度を作成します

構文​

BoundaryTemparature(string strName, double fTemp, cursor crTable, cursor[] taTarget, cursor crEdit)

入力​

1. String​

境界温度の名前

2. Double​

温度値

3. Cursor​

テーブルフィールドデータのカーソル

4. Cursor[]​

対象エンティティのカーソル

5. Cursor​

編集用カーソル

返却コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

BoundaryTemperature("BoundaryTemperature_1", 373.15, 81:1, [3:1, 6:3], 0:0)
