# CmdPlotStrainGaugeAxisAngle()

CmdPlotStrainGaugeAxisAngle()

説明​

インポート

構文​

CmdPlotStrainGaugeAxisAngle(cursor PostJob, vector[] Steps, int[] nodes, int Axis1, int Axis2, float Angle, string AxisXName, string AxisYName, float Height, float Width, float Factor, int nPhaseType, float PhaseAngle, bool CreateMarkup)

時間/周波数（デフォルト）、'応力（節点）'、0.005、0.005、1、1、-1、0.000000、1)

入力​

1. cursor  ​

ポストジョブ

2. vector[]  ​

ステップ情報ベクトル。

1. int ​

解析タイプ

2. int ​

結果セット

3. int ​

時間ステップ

3. int[]  ​

対象節点ID。

4. int  ​

第1軸

5. int  ​

第2軸

6. float  ​

角度。

7. string  ​

X軸の名前。

8. string  ​

Y軸の名前。

9. float  ​

ゲージの長さ

10. float  ​

ゲージの幅

11. float  ​

ゲージの修正係数

12. int  ​

位相設定 - 位相

13. float  ​

位相設定 - 角度

14. bool  ​

ノート追加フラグ

戻り値​

なし

サンプルコード​

CmdPlotStrainGaugeAxisAngle(183:1, [[2,1,1], [2,1,2], [2,1,3], [2,1,4], [2,1,5], [2,1,6], [2,1,7], [2,1,8], [2,1,9], [2,1,10]], [2828], 0, 1, 30.000000, "時間/周波数（デフォルト）", "応力（節点）", 0.003, 0.003, 1, -1, 0.000000, 1)
