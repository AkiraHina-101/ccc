# AddResultsMappedMeshFile()

AddResultsMappedMeshFile()

説明​

現在のJupiterデータベースにマッピングされたメッシュの結果を追加します。

構文​

AddResultsMappedMeshFile(str[] strlPaths, bool bMergeTree)

入力​

1. str[]​

マッピングされたメッシュファイルを指定するStringのリスト。

2. bool​

既存のドキュメントに含まれていない差異を追加するかどうかを指定するBoolean。

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

AddResultsMappedMeshFile(["path/to/the/file"], 1)
