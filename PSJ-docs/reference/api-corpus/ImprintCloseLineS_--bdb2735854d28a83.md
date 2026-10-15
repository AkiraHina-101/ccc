# ImprintCloseLineS()

ImprintCloseLineS()

説明​

閉じた線を刻印する

構文​

ImprintCloseLineS(double[] entitiesCoord, cursor[] crFace, bool bBrFace)

入力​

1. Double[]​

座標点

2. Cursor[]​

ターゲットフェースカーソル（[6: Face ID]）

3. Bool​

フェースを切断するかどうかのフラグ True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImprintCloseLineS([[0, 0, 0], [0, 0.002222222222222222, 0.001111111111111111], [0, 0.001111111111111111, 0.002222222222222222]], [6:23], 1)
