# CreateWedge()

CreateWedge()

説明​

Wedge Body を作成します

構文​

CreateWedge(double[3] vdOriginXYZ, double[3] vdLength, int[3] vlNodeCnt,
    string strBodyName, color colBody, cursor crCoord)

入力​

1. Double[3]​

原点座標点([x, y, z])

2. Double[3]​

座標軸に沿った長さ Length([x_length, y_length, z_length])

3. int[3]​

座標軸に沿った節点数 Node([x_node, y_node, z_node])

4. String​

パート名

5. Color​

パートの色

6. Cursor​

ローカル座標を使用するかどうか True = 27:*, False = 0:0

戻り値​

"1": 関数は実行可能です

"0": 関数を実行できません

サンプルコード​

CreateWedge([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Wedge_1", 14276960, 0:0)
