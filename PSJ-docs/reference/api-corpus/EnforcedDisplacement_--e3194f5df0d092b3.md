# EnforcedDisplacement()

EnforcedDisplacement()

説明​

強制変位を作成します

構文​

強制変位(string strName, int dwDof, double dTransR, double dTransTheta,
    double dTransZ, double dRotR, double dRotTheta, double dRotZ, cursor crCoord,
    int iArrowDir, cursor crTable, cursor crNodeSet, double dPhase, double dDelay,
    cursor crPhaseTable, cursor[] taTarget, cursor crEdit)

入力​

1. String​

強制変位の名前

2. Int​

参照DOFの属性

3. 浮動小数​

変位 R

4. 浮動小数​

変位 Theta

5. 浮動小数​

変位 Z

6. 浮動小数​

回転 R

7. 浮動小数​

回転 Theta

8. 浮動小数​

回転 Z

9. Cursor​

ローカル座標を使用するかどうか True = 27:, False = 0:0

10. Int​

矢印の向き

0: 節点で開始

1: 節点で終了

11. Cursor​

テーブルフィールドデータカーソル(81:フィールドデータID)

12. Cursor​

テーブル節点セット

13. 浮動小数​

位相値

14. 浮動小数​

遅延値

15. Cursor​

位相テーブルカーソル

16. Cursor[]​

対象エンティティーズカーソル

17. Cursor​

編集カーソル

戻り値​

"1": 関数が実行可能です

"0": 関数が実行不可です

サンプルコード​

強制変位("EnforcedDisplacement1", 63, 0.001, 0.002, 0.003, 1, 2, 3, 27:1,
    0, 81:1, 0:0, 1, 1, 0:0, [6:3, 5:1, 10:70], 0:0)
