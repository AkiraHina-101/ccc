# AddResultsActran()

AddResultsActran()

説明​

現在のJupiterデータベースにActran Op2の結果を追加します。JupiterドキュメントはPostドキュメントである必要があります。

構文​

AddResultsActran(str[] strlPaths, bool bMergeTree)

入力​

1. str[]​

インポートに使用されるActranファイル（*.op2ファイル）のリストを指定するString型のリスト。

2. bool​

既存のドキュメントに含まれない差分が追加されるかどうかを指定する真偽値。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AddResultsActran(["path/to/the/file"], 1)
