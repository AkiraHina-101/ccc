# CreateSphere()

CreateSphere()

説明​

球体 パートを作成します。

構文​

CreateSphere(double[3] vdOriginXYZ, double dRadius, int nLatitudeNodeCnt, int nLongitudeNodeCnt,
    string strBodyName, color colBody, cursor crCoord)

入力​

1. Double[3]​

原点座標点（[x、y、z]）

2. Double​

球体の半径値（m）

3. Int​

緯度節点数

4. Int​

経度節点数

5. String​

パート名

6. Color​

パートの色

7. Cursor​

ローカル座標を使用するかどうか True = 27:*、False = 0:0

戻り値コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateSphere([0, 0, 0], 0.005, 50, 100, "Sphere_1", 11908427, 0:0)
