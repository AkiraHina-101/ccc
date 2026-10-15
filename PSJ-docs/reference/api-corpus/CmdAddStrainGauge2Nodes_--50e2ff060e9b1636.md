# CmdAddStrainGauge2Nodes()

CmdAddStrainGauge2Nodes()

説明​

2つの節点を結ぶ方向で応力とひずみを表示します。

構文​

CmdAddStrainGauge2Nodes(int iNode1, int iNode2, double dWidth, double dHeight, double dAmendFactor, str strGaugeName)

入力​

1. int​

選択された1番目の節点のIDを指定する整数。この引数は、2つの節点または節点-ポイント選択方法の両方に使用できます。

2. int​

選択された2番目の節点のIDを指定する整数。この引数は、選択方法が2Nodesの場合に使用されます。

3. double​

節点が選択されたときの選択幅を指定する倍精度浮動小数点数。

4. double​

節点が選択されたときの選択長さを指定する倍精度浮動小数点数。

5. double​

ひずみ解析結果に使用される補正係数を指定する倍精度浮動小数点数。

6. str​

ゲージ名を指定する文字列。

戻り値コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CmdAddStrainGauge2Nodes(0, 0, 0.0, 0.0, 1.0, "strGaugeName")
