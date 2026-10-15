# ASMSeparateSolid()

ASMSeparateSolid()

説明​

ソリッドモデル内の組み立てられたパートを分離します

構文​

ASMSeparateSolid(int[] bodyID, int[] faceID, bool createGroup)

入力​

1. Int[]​

分離するためのパートID

2. Int[]​

組み立てるためのフェースID

3. Bool​

グループ作成オプション

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ASMSeparateSolid([2, 29], [], 0)
