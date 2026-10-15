# ACM_ACSpace()

ACM_ACSpace()

説明​

ACM_ACSpace

構文​

ACM_ACSpace(cursor crBodyKey, double dGradingFact, int iRegion, bool bIntNode, bool bSafeMode,
    bool bIntMeshOnly, bool bPML, bool bSweGrd, double dWidth, int iLayer, int iAxis,
    double dSweCoord, double dSweMeshSize, int iLayer)

入力​

1. Cursor​

パートキーのカーソル（[パート ID]）

2. Double​

グレーディングファクター

3. Int​

領域タイプ：

0: メイン領域

1: すべての領域

4. Bool​

内部節点のブールフラグ 真 = 1, 偽 = 0

5. Bool​

安全モードのブールフラグ 真 = 1, 偽 = 0

6. Bool​

内部メッシュのみのブールフラグ 真 = 1, 偽 = 0

7. Bool​

PMLのブールフラグ 真 = 1, 偽 = 0

8. Bool​

グランドにスイープするブールフラグ 真 = 1, 偽 = 0

9. Double​

PMLの幅

10. Int​

PMLのレイヤー

11. Int​

軸タイプ：

0: X

1: Y

2: Z

12. Double​

グラウンドにスイープする座標

13. Double​

グラウンドにスイープするメッシュサイズ

14. Int​

グラウンドにスイープするレイヤー

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ACM_ACSpace([1, 2], 10, 0, 0, 0, 0, 1, 0, 0.015, 3, 0, -0.02, 0.02, 1)
