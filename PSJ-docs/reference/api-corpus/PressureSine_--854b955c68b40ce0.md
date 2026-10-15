# PressureSine()

PressureSine()

説明​

Pressure sineを作成します

構文​

PressureSine(String name, double a, Cursor crCoordinate, double angleRange, int distributionAxis,
    int pressureDirectionMode, int isTotalForceAdjustment, double totalForce, Vector pressureDirection,
    Cursor crCoordinateSystemForDirection, int isCornerNodesDistribution, String formulaForA,
    Cursor[] targets, Cursor crEdit)

入力​

1. String​

名前

2. double​

a

3. Cursor​

座標系

4. double​

角度範囲

5. int​

分布軸

6. int​

方向モード（0: ノーマル、1: ダイレクション）

7. int​

合計力の調整

8. double​

合計力

9. Vector​

圧力方向

10. Cursor​

方向の座標系

11. int​

コーナー節点の分布

12. String​

Aのための式

13. Cursor[]​

対象

14. Cursor​

編集対象

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

PressureSine("PressureSine1", 1e+07, 0:0, 0.523599, 0, 0, 0, 0, [0, 0, 0], 0:0, 0, "", [6:23], 0:0)
