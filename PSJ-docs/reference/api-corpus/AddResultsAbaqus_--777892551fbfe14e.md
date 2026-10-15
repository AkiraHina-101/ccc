# AddResultsAbaqus()

AddResultsAbaqus()

説明​

現在のJupiterデータベースにAbaqusの.odb結果を追加します。

構文​

AddResultsAbaqus(str strlPaths, bool bMergeTree, int iVersion)

入力​

1. str[]​

インポートに使用されるAbaqusファイル（*.odbファイル）のリストを指定する String のリスト。

2. bool​

既存のドキュメントに含まれていない差異を追加するかどうかを指定するブール値。

3. int​

Abaqusファイルのバージョンを指定する整数。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AddResultsAbaqus(["path/to/the/file"], 1, 2019)
