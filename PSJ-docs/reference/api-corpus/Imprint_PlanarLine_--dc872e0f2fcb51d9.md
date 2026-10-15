# Imprint_PlanarLine()

Imprint_PlanarLine()

説明​

平面線を作成します。

構文​

Imprint_PlanarLine(double[] Point_xyz, int[] FaceID,Cursor Coordinate, int PlaneType,
    bool BreakFace,Cursor[] BodyCursor)

入力​

1. Double[]​

xyz座標 [[x1,y1,z1]]

2. Int[]​

フェースID

3. Cursor​

座標系（[0:0]=グローバル）

4. Int​

平面タイプ（YZ=0,ZX=1,XY=2,3点=3）

5. Bool​

フラグ フェース分割 true = 1,false = 0

6. Cursor[]​

パートカーソル（[3:]= パートID）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Imprint_PlanarLine([[0.005, 0.0111111, 0.00866025]], [5], 0:0, 1, 1, [3:1])
