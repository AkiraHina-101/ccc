# MergeBodyFace()

MergeBodyFace()

説明​

パートフェースをマージします。

構文​

MergeBodyFace(int[] taBodyKey, int[] taFaceKey, bool bAngle, double dToleranceAngle, bool bWidth, double dToleranceWidth)

入力​

1. Int[]​

パートカーソル（[パートID]）

2. Int[]​

フェースカーソル（[フェースID]）

3. Bool​

角度を選択するかどうか（True = 1、False = 0）

4. Double​

許容角度値を挿入します

5. Bool​

幅を選択するかどうか（True = 1、False = 0）

6. Double​

許容幅値を挿入します

戻り値​

"1"： 関数を実行できます

"0"： 関数を実行できません

サンプルコード​

MergeBodyFace([1], [29], 1, 20, 1, 0.0002)
