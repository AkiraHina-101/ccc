# AddResultsSysnoise()

AddResultsSysnoise()

説明​

現在のJupiterデータベースにsysnoiseの結果を追加します。

構文​

AddResultsSysnoise(str[]strlPaths, bool bMergeTree)

入力​

1. str[]​

sysnoiseの結果ファイルを指定するStringのリストです。

2. bool​

既存のドキュメントに含まれていない差分を追加するかどうかを指定する真偽値です。

戻り値​

"1"： 関数を実行できます

"0"： 関数を実行できません

サンプルコード​

AddResultsSysnoise(["ファイルへのパス"], 1)
