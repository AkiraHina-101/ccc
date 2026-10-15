# CmdAddStrainGaugeMinPrincipal()

CmdAddStrainGaugeMinPrincipal()

説明​

ひずみゲージを実行します - 最小主成分。

構文​

CmdAddStrainGaugeMinPrincipal(int[] nodes, double Width, double Height, double AmendFactor, string GaugeName)

入力​

1. int[]​

対象節点。

2. double​

ゲージ幅。

3. double​

ゲージ高さ。

4. double​

修正係数。

5. string​

ゲージ名。

戻り値​

なし。

サンプルコード​

CmdAddStrainGaugeMinPrincipal([9428], 0, 0, 1, "")
