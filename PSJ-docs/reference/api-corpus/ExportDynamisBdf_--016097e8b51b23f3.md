# ExportDynamisBdf()

ExportDynamisBdf()

説明​

Dynamisのbdfファイルをエクスポートします。

構文​

ExportDynamisBdf(string strPath, TCursor job)

入力​

1. String​

bdfファイルのパス

2. Cursor​

ジョブカーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ExportDynamisBdf("D:/TS-Solver.bdf", 148:2)
