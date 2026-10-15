# ContourCopy()

ContourCopy()

説明​

指定されたPreドキュメント内で、現在のポストドキュメントの輪郭を表示します。

構文​

ContourCopy(string PostDocName, string PreDocName)

入力​

1. String​

輪郭をコピーするポストドキュメント名を指定する文字列です。

2. String​

輪郭をコピーするプレドキュメント名を指定する文字列です。

戻り値​

"1": 関数が実行可能です。

"0": 関数を実行できません。

サンプルコード​

ContourCopy("101_solid", "101_solid_Converted_Pre")
