# ImprintPlannarLineS()

ImprintPlannarLineS()

説明​

プレーンラインの印象作成

構文​

ImprintPlannarLineS(double[] taPositions, cursor[] taTargetFace, cursor crLocalCoor, int iType, bool bBreakFace)

入力​

1. Double[]​

印象作成の対象ポイント -> Point_n([xi, yi, zi])

2. Cursor[]​

対象のフェースカーソル([6:Face ID])

3. Cursor​

ローカル座標を使用するかどうか True = 27:*, False = 0:0

4. Int​

タイプオプション

5. Bool​

フェースを割るかどうか True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImprintPlannarLineS([[0.0017364817766693, 0.004444444444444444, -0.009848077530122082]], [6:5], 0:0, 1, 0)
