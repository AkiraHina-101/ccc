# InitialTemperature()

InitialTemperature()

説明​

初期温度を作成します。

構文​

InitialTemperature(string strName, int nType, double dTemp, string strFilePathName,
    bool bUseDefault, cursor crTable, cursor[] taTarget, cursor crEdit)

入力​

1. String​

初期温度名

2. Int​

熱の種類

0: 一定

2: ADVCファイル

3: Nastran Punch

3. 実数​

温度値

4. String​

ディレクトリファイルパス

5. Bool​

デフォルト温度を使用するかどうかのブールフラグ True = 1、False = 0; Type 2、3に対応

6. Cursor​

テーブルカーソル

7. Cursor[]​

対象エンティティのカーソル

8. Cursor​

編集カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

InitialTemperature("InitialTemperature1", 3, 1.79769e+308, "D:/1_heat.pch", 0, 0:0, [3:1], 0:0)
