# AddResultsUniversal()

AddResultsUniversal()

説明​

現在のJupiter-Postデータベースに、Universalファイル（*.unv）に記載された結果を追加します。

構文​

AddResultsUniversal(str[] strlPaths, bool bMergeTree)

入力​

1. str[]​

.unvファイルパスを指定するStringのリスト。

2. bool​

既存のドキュメントに含まれない差分を追加するかどうかを指定するBoolean。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AddResultsUniversal(["ファイルへのパス"], 1)
