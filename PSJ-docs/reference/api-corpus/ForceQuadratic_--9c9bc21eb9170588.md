# ForceQuadratic()

ForceQuadratic()

説明​

力を作成します（二次）

構文​

ForceQuadratic(String name, double totalForce, double a, double b, Cursor crCoordinate,
    int angleBase, double angleRange, int arrowDir, Cursor[] targets, Cursor crEdit)

入力​

1. String​

名前

2. Double​

合計力

3. Double​

a

4. Double​

b

5. Cursor​

座標系

6. Int​

角度基点

7. Double​

角度範囲

8. Int​

矢印方向（0：節点から開始、1：節点で終了）

9. Cursor[]​

対象

10. Cursor​

編集対象

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ForceQuadratic("Force2", 1, 2, 3, 0:0, 0, 1.5708, 0, [6:22], 0:0)
