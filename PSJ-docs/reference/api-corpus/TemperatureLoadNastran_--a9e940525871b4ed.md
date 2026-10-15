# TemperatureLoadNastran()

TemperatureLoadNastran()

説明​

Nastranパンチファイルによる温度負荷を作成します。

構文​

TemperatureLoadNastran(string strName, string strFilePathName, cursor crTable,
    cursor[] taTarget, cursor crEdit, bool bUseAsMaterialReferenceTemp)

入力​

1. String​

温度負荷の名前

2. String​

ファイルパス

3. Cursor​

テーブルを選択

4. Cursorのリスト​

対象

5. Cursor​

編集用カーソル

6. Bool値​

材料参照温度として使用する場合

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

TemperatureLoadNastran("TemperatureLoadsPunch1", "D:/1_heat.pch", 0:0, [], 0:0, 0)
