# CreateCube()

CreateCube()

説明​

この機能は、特定の場所に立方体の形状の パートを作成します。
ユーザーは座標系とその座標に対する相対位置を選択できます。

構文​

CreateCube(double[3] vdOriginXYZ, double[3] vdLength, int[3] vlNodeCnt, string strBodyName,
    color colBody, cursor crCoord)

入力​

1. Double[3]​

原点座標 ポイント([x, y, z])

2. Double[3]​

座標軸に沿った長さ レングス([x_length, y_length, z_length])

3. Int[3]​

座標軸にそっている節点の数 節点数([x_node, y_node, z_node])

4. String​

パート名

5. Color​

パートの色

6. Cursor​

ローカル座標を使用するかどうか True = 27:*、False = 0:0

戻り値コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 5093709, 0:0)
