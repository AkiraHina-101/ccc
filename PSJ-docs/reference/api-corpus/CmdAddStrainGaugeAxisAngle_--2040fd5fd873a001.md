# CmdAddStrainGaugeAxisAngle()

CmdAddStrainGaugeAxisAngle()

説明​

サイズミーターを実行する - 軸角度。

構文​

CmdAddStrainGaugeAxisAngle(int[] nodes, double Width, double Height, double AmendFactor, string GaugeName)

入力​

1. int[] ​

対象節点。

2. double ​

ゲージの幅。

3. double ​

ゲージの高さ。

4. double ​

修正係数。

5. string ​

ゲージ名。

戻り値​

なし。

サンプルコード​

CmdAddStrainGaugeAxisAngle([8538], 0, 1, 0, 0.004, 0.004, 1, "")
