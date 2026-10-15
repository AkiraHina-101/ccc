# ForceGeneral()

ForceGeneral()

説明​

汎用力の作成

構文​

ForceGeneral(string name, vector force, vector moment, int arrowDir, int distributionMethod,
    cursor crCoordinate, cursor crTable, cursor crNodeSet, double phase, double delay,
    cursor crPhaseTable, string formulaFX, string formulaFY, string formulaFZ,
    string formulaMX, string formulaMY, string formulaMZ, Cursor[] targets, cursor crEdit)

入力​

1. String​

名前

2. ベクトル​

力

3. ベクトル​

モーメント

4. Int​

矢印の向き (0: 節点から始まる、1: 節点で終わる)

5. Int​

分布方法 (0: 選択されたエンティティごと、1: 節点ごと、2: 選択の合計)

6. Cursor​

座標系

7. Cursor​

テーブル

8. Cursor​

節点セット

9. 数値​

位相

10. 数値​

遅延

11. Cursor​

位相テーブル

12. String​

X方向の力の数式

13. String​

Y方向の力の数式

14. String​

Z方向の力の数式

15. String​

X方向のモーメントの数式

16. String​

Y方向のモーメントの数式

17. String​

Z方向のモーメントの数式

18. Cursor配列[]​

ターゲット

19. Cursor​

編集対象

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

ForceGeneral("Force2", [1, 2, 3], [0.004, 0.005, 0.006], 0, 0, 0:0, 0:0, 0:0,
    0, 0, 0:0, "", "", "", "", "", "", [6:25], 0:0)
