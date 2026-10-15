# CmdPlotStrainGaugeNodePoint()

CmdPlotStrainGaugeNodePoint()

説明​

インポート

構文​

CmdPlotStrainGaugeNodePoint(cursor PostJob, int node, float[] point, vector[] Steps, string AxisXName, string AxisYName, float Height, float Width, float Factor, bool MaxPrincipal, int nPhaseType, float PhaseAngle, bool CreateMarkup)

入力​

1. cursor​

ポストジョブ

2. int​

節点のID

3. float[]​

位置ベクトル [x,y,z]

4. vector[]​

ステップ情報ベクトル

1. int​

解析タイプ

2. int​

結果セット

3. int​

タイムステップ

5. string​

X軸の名前

6. string​

Y軸の名前

7. float​

ゲージの長さ

8. float​

ゲージの幅

9. float​

ゲージの修正係数

10. bool​

方向

11. int​

位相設定 - 位相

12. float​

位相設定 - 角度

13. bool​

ノートの追加フラグ

戻り値​

なし

サンプルコード​

CmdPlotStrainGaugeNodePoint(183:1, 10361, [-0.00216074,-0.00044453,0.000788983], [[2,1,1], [2,1,2], [2,1,4], [2,1,6], [2,1,10]], "Time/Freq(Default)", "Stress(Node)", 0.003, 0.003, 1, -1, 0.000000, 1)
