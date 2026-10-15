# TemperatureLoadADVCFile()

TemperatureLoadADVCFile()

説明​

advcファイルによる温度負荷の作成です。

構文​

TemperatureLoadADVCFile(string strName, string strFilePathName, cursor crTable, cursor[] taTarget, cursor crEdit)

入力​

1. String​

温度負荷の名前です。

2. String​

ファイルパスです。

3. Cursor​

選択テーブルです。

4. Cursor[]​

対象です。

5. Cursor​

編集用カーソルです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

TemperatureLoadGeneral("TemperatureLoadsConstant1", 303.15, 0:0, [6:21], 0:0, 0)
