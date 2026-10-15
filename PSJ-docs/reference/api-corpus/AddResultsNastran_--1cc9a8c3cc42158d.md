# AddResultsNastran()

AddResultsNastran()

説明​

現在のJupiterデータベースにNastran Op2の結果を追加します。Jupiter文書はPost文書である必要があります。

構文​

AddResultsNastran(str[] strlPaths, bool bMergeTree, bool bCreateResultAtMidNode)

入力​

1. str[]​

インポートに使用されるNastranファイル（*.op2ファイル）のリストを指定するStringのリスト。

2. bool​

既存の文書に含まれない差分を追加するかどうかを指定するBoolean。

3. bool​

Mid節点で結果を作成するかどうかを指定するBoolean。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AddResultsNastran(["path/to/the/file"], 1, 1)
