# CmdAddStrainGaugeNodePoint()

CmdAddStrainGaugeNodePoint()

説明​

ストレインゲージ - 節点を実行します。

構文​

CmdAddStrainGaugeNodePoint(int node, vector position, double Width, double Height, double AmendFactor, string GaugeName)

入力​

1. int ​

対象の節点1。

2. vector ​

位置 x、y、z。

3. double ​

ゲージの幅。

4. double ​

ゲージの高さ。

5. double ​

修正係数。

6. string ​

ゲージ名。

戻り値​

なし。

サンプルコード​

CmdAddStrainGaugeNodePoint(8647, [-0.00256365, -0.00125307, 0.000465], 5, 5, 1, "")
