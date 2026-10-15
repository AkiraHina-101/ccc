# ForceSine()

ForceSine()

説明​

Force（Sine）を作成します。

構文​

ForceSine(String name, double totalForce, double a, Cursor crCoordinate, int angleBase,
    double angleRange, int arrowDir, int distributeInAxis, Cursor[] targets, Cursor crEdit)

入力​

1. String​

名前

2. double​

合計力

3. Double​

a

4. Cursor​

座標系

5. Int​

角度基準

6. Double​

角度範囲

7. Int​

矢印の向き（0: 節点で開始, 1: 節点で終了）

8. Int​

軸に分散（0: 偽, 1: 真）

9. Cursor[]​

対象

10. Cursor​

編集対象

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ForceSine("Force3", 1, 2, 0:0, 0, 1.5708, 0, 0, [6:22], 0:0)
