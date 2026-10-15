# PressureQuadratic()

PressureQuadratic()

説明​

Pressure quadraticを作成します

構文​

PressureQuadratic(string name, double a, double b, Cursor crCoordinate, double angleRange,
    int pressureDirectionMode, Vector pressureDirection, Cursor[] targets, Cursor crEdit)

入力​

1. String​

名前

2. double​

a

3. double​

b

4. Cursor​

座標系

5. double​

角度範囲

6. int​

方向モード（0: 通常、1: 方向）

7. Vector​

圧力方向

8. Cursor[]​

対象

9. Cursor​

編集対象

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

PressureQuadratic("PressureQuadratic1", 1e+06, 2e+06, 0:0, 0.523599, 0, [0, 0, 0], [6:23], 0:0)
