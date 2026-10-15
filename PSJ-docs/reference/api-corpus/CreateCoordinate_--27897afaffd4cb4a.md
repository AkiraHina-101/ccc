# CreateCoordinate()

CreateCoordinate()

説明​

座標を作成します

構文​

CreateCoordinate(string name, int type, point point1, point point2, point point3, TCursor crRefCoord, TCursor crEdit)

入力​

1. String​

座標名

2. Int​

座標タイプ（0: 矩形, 1: 円柱, 2: 球面）

3. Point​

座標定義ポイント1

4. Point​

座標定義ポイント2

5. Point​

座標定義ポイント3

6. TCursor​

参照座標

7. TCursor​

編集対象座標

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateCoordinateThreeNode("CRect3", 0, 0, [10:466, 10:467, 10:475], [], 0:0, 0:0)
