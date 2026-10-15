# CmdAddStrainGaugeNodePoint()

CmdAddStrainGaugeNodePoint()

説明​

2点を結ぶ方向での応力とひずみを表示します。

構文​

CmdAddStrainGauge2Nodes(int iNode1, double[] dlPosition, double dWidth, double dHeight, double dAmendFactor, str strGaugeName)

入力​

1. int​

1番目に選択された節点のIDを指定する整数型です。この引数は2NodesまたはNode-Point選択方法の両方に使用できます。

2. double[]​

選択した点の座標を指定する Double型リストです。この引数はNode-Point選択方法の場合に使用されました。

3. double​

節点が選択されたときの選択幅を指定する Double型です。

4. double​

節点が選択されたときの選択長さを指定する Double型です。

5. double​

ひずみ解析結果に使用される修正係数を指定する Double型です。

6. str​

ゲージ名を指定する文字列型です。

戻り値​

"1": 関数を実行できる場合

"0": 関数を実行できない場合

サンプルコード​

CmdAddStrainGaugeNodePoint(0, [0.0,0.0,0.0], 0.0, 0.0, 1.0, "strGaugeName")
