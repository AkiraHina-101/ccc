# CmdPlotStrainGauge2Nodes()

CmdPlotStrainGauge2Nodes()

説明​

インポート

構文​

CmdPlotStrainGauge2Nodes(cursor PostJob, int node1, int node2 vector[] Steps, string AxisXName, string AxisYName, float Height, float Width, float Factor, bool MaxPrincipal, int nPhaseType, float PhaseAngle, bool CreateMarkup)

入力​

1. cursor​

Post Job

2. int​

節点1のID。

3. int​

節点2のID。

4. vector[]​

ステップ情報のベクトル。

1. int​

解析タイプ

2. int​

結果セット

3. int​

タイムステップ

5. string​

X軸の名前。

6. string​

Y軸の名前。

7. float​

ゲージ - 長さ

8. float​

ゲージ - 幅

9. float​

ゲージ - 訂正係数

10. bool​

方向

11. int​

位相設定 - 位相

12. float​

位相設定 - 角度

13. bool​

注釈フラグの追加

戻り値​

なし。

サンプルコード​

CmdPlotStrainGauge2Nodes(183:1, 13388, 13226, [[2,1,1], [2,1,2], [2,1,3], [2,1,4], [2,1,5], [2,1,6], [2,1,7], [2,1,8], [2,1,9], [2,1,10]], "Stress(Element)", "Stress(Element)", 0, 0, 1, -1, 0.000000, 1)
