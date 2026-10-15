# RotateCoordinate()

RotateCoordinate()

説明​

座標を回転させます

構文​

CreateCoordinateRotate(string strName, int iCoordType, vector vecRotate, bool bCreateNew, cursor crRefCoord, position posCenterRot, cursor crEdit)

入力​

1. String​

座標名

2. Int​

座標タイプ（0：矩形、1：円柱、2：球面）

3. ベクトル​

座標回転

4. Bool​

新規作成ブールフラグ True = 1, False = 0

5. TCursor​

参照座標

6. ポジション​

回転中心の位置

7. TCursor​

編集対象座標

戻り値​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

CreateCoordinateRotate("CRect_2", 0, [1.570796326794412, 1.047197551196275, 1.570796326794412], 1, 27:1, [0.01, 0, 0.01], 27:1)
