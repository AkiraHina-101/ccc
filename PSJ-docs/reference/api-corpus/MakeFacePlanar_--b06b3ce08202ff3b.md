# MakeFacePlanar()

MakeFacePlanar()

説明​

与えられた平面の点で平面上のフェースを作成します

構文​

MakeFacePlanar(double[3] dPlanePt1, double[3] dPlanePt2, double[3] dPlanePt3, int[] nFaceIDs, bool mergeFace)

入力​

1. Double[3]​

平面点1

2. Double[3]​

平面点2

3. Double[3]​

平面点3

4. Int[]​

平面曲面を作成するターゲットフェース（[フェースID]）

5. Bool​

フェースをマージするかどうか 真 = 1、偽 = 0

戻り値​

"1": 関数が実行できます

"0": 関数を実行できません

サンプルコード​

MakeFacePlanar([0.01, 0.01, 0.007272871569190634], [0.01, 0.01, 0], [0.003333333333333333, 0.01, 0], [47], 0)
