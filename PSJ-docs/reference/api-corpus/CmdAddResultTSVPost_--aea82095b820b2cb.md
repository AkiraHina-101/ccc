# CmdAddResultTSVPost()

CmdAddResultTSVPost()

説明​

現在のメッシュデータに結果を追加します。

構文​

CmdAddResultTSVPost(cursor Job, string[] path, int solverType, int offsetID)

入力​

1. cursor ​

ポストジョブ。

2. string[] ​

ファイルパス。

3. int ​

Solver type.

4. int ​

オフセットID。

戻り値​

なし。

サンプルコード​

CmdAddResultTSVPost(183:1, ["C:/temp/data.unv"], 4, 1)
