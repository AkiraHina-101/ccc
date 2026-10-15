# MoveNodeAlongCylinder()

MoveNodeAlongCylinder()

説明​

所望の円柱に節点を移動します。

構文​

MoveNodeAlongCylinder(cursor[] taFace, cursor[] taNode, double dirX, double dirY,
    double dirZ, double circleX, double circleY, double circleZ, double radius, double height)

入力​

1. Cursor[]​

対象フェースカーソル（[6:Face ID]）

2. Cursor[]​

対象節点カーソル（[10:Node ID]）

3. Double​

仮想円柱のX方向ベクトル

4. Double​

仮想円柱のY方向ベクトル

5. Double​

仮想円柱のZ方向ベクトル

6. Double​

仮想円柱のX方向中心

7. Double​

仮想円柱のY方向中心

8. Double​

仮想円柱のZ方向中心

9. Double​

仮想円柱の半径

10. Double​

仮想円柱の高さ

戻り値コード​

"1": 関数は実行可能です

"0": 関数は実行不可能です

サンプルコード​

MoveNodeAlongCylinder([], [10:333, 10:341, 10:342, 10:334], 0, 1, 0, 0, 0, 0, 0.01, 0.02)
