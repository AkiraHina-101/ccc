# CmdAddStrainGaugeMaxPrincipal()

CmdAddStrainGaugeMaxPrincipal()

説明​

ストレインゲージを実行します - 最大主応力。

構文​

CmdAddStrainGaugeMaxPrincipal(int[] nodes, double Width, double Height, double AmendFactor, string GaugeName)

入力​

1. int[]​

対象の節点。

2. double​

ゲージの幅。

3. double​

ゲージの高さ。

4. double​

修正係数。

5. string​

ゲージ名。

戻り値​

なし。

サンプルコード​

CmdAddStrainGaugeMaxPrincipal([9428], 0, 0, 1, "")
