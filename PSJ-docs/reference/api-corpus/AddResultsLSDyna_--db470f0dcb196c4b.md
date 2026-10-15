# AddResultsLSDyna()

AddResultsLSDyna()

説明​

現在のJupiterデータベースにLS-Dynaのd3plot結果を追加します。

構文​

AddResultsLSDyna(str[] strlPaths, bool bMergeTree)

入力​

1. str[]​

インポートに使用されるd3plotファイルのリストを指定する文字列のリスト。

2. bool​

既存のドキュメントに含まれない差分を追加するかどうかを指定する真偽値。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AddResultsLSDyna(["ファイルへのパス"], 1)
