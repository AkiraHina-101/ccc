# ImprintCircleS()

ImprintCircleS()

説明​

インプリントサークルラインを作成します

構文​

ImprintCircleS(double[] taPositions, cursor[] taTargetFace, double dInRadius, double dOutRadius,
    int iNoofLayer, int iNoOfDiv, bool bBreakFace)

入力​

1. Double[]​

インプリント対象のポイント -> ポイントn([xi, yi, zi])

2. Cursor[]​

対象フェースカーソル([6:Face ID])

3. Double​

内径

4. Double​

外径

5. Int​

レイヤー数

6. Int​

分割数

7. Bool​

フェースを分割するかどうか True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImprintCircleS([[0.007777777777777778, 0.006666666666666666, 0.01]], [6:26], 0.001, 0.002, 1, 30, 1)
