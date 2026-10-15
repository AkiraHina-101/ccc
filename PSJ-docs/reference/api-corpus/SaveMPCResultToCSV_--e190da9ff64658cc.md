# SaveMPCResultToCSV()

SaveMPCResultToCSV()

説明​

MPCの結果をCSVファイルに保存します。

構文​

SaveMPCResultToCSV(cursor crResponse, double dTime, str strFilePath)

入力​

1. cursor​

保存する応答を指定するカーソルです。

2. double​

結果を保存する時刻を指定する倍精度です。

3. str​

保存するCSVファイルのパスを指定する文字列です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SaveMPCResultToCSV(0:0, 0.0, "path/to/the/file")
