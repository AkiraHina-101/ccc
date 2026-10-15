# ChangeTopologyFace()

ChangeTopologyFace()

説明​

トポロジフェースの変更

構文​

ChangeTopologyFace(int[] taFaceKey, int[] taBodyKey, bool bCreateNewBody)

入力​

1. Int[]​

フェースキーのカーソル（[フェース ID]）

2. Int[]​

パートキーのカーソル（[パート ID]）

3. Bool​

新しいパートを作成するかどうかのフラグ True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ChangeTopologyFace([8], [2], 1)
