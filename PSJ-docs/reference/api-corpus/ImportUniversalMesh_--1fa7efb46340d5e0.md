# ImportUniversalMesh()

ImportUniversalMesh()

説明​

JupiterデータベースにUniversalファイル（*.unv）をインポートします（メッシュ、境界条件など）。

構文​

ImportUniversalMesh(str[] strlPaths, double dFaceAngle, double dEdgeAngle)

入力​

1. str[]​

インポートに使用されるUniversalファイル（*.unvファイル）のリストを指定するStringのリスト。

2. double​

フェース分割を決定するための角度許容度を指定するDouble。

3. double​

エッジ分割を決定するための角度許容度を指定するDouble。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportUniversalMesh(["path/to/the/file"], 60.0, 60.0)
