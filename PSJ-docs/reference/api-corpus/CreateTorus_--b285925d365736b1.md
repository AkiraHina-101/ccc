# CreateTorus()

CreateTorus()

説明​

トーラス パートを作成します。

構文​

CreateTorus(double[3] vdOriginXYZ, double dInnerRadius, double dRingRadius, int nLatitudeNodeCnt,
    int nLongitudeNodeCnt, string strBodyName, color colBody, cursor crCoord)

入力​

1. Double[3]​

原点座標ポイント（[x、y、z]）

2. Double​

内半径値（m）

3. Double​

リング半径値（m）

4. Int​

緯度節点の数

5. Int​

経度節点の数

6. String​

パートの名前

7. Color​

パートの色

8. Cursor​

ローカル座標を使用するかどうか（True = 27:*、False = 0:0）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateTorus([0, 0, 0], 0.015, 0.02, 20, 20, "Torus_1", 11882677, 0:0)
