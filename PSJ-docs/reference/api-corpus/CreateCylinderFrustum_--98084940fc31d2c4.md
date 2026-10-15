# CreateCylinderFrustum()

CreateCylinderFrustum()

説明​

円錐体パートを作成します

構文​

CreateCylinderFrustum(double[3] vdOriginXYZ, double TopRadius, double bottomRadius, double height, int circleNodeCount,
    int axisNodeCount, string bodyName, color bodyColor, cursor crCoord)

入力​

1. Double[3]​

ポイント [x,y,z]

2. Double​

上部半径

3. Double​

下部半径

4. Double​

高さ

5. Int​

円節点数

6. Int​

軸節点数

7. String​

パート名

8. Color​

パート色

9. Cursor​

座標カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateCylinderFrustum([0, 0, 0], 0.003, 0.01, 0.02, 20, 20, "Frustum_1", 14903267, 0:0)
