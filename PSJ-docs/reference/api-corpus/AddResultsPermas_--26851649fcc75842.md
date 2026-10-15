# AddResultsPermas()

AddResultsPermas()

説明​

現在のJupiterデータベースにPermasの結果を追加します。

構文​

AddResultsPermas(str[] strlPaths, bool bMergeTree)

入力​

1. str[]​

Permasの結果ファイルを指定するStringのリストです。

2. bool​

既存の文書に含まれない違いを追加するかどうかを指定するブール値です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AddResultsPermas(["path/to/the/file"], 1)
