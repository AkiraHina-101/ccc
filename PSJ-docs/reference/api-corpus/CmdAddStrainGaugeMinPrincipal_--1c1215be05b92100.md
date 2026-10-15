# CmdAddStrainGaugeMinPrincipal()

CmdAddStrainGaugeMinPrincipal()

説明​

最小主応力の方向に応力または歪みを表示します。

構文​

CmdAddStrainGaugeMinPrincipal(int[] ilNodeIDs, double dWidth, double dHeight, double dAmendFactor, str strGaugeName)

入力​

1. int[]​

選択した節点のIDを指定する整数のリストです。

2. double​

節点が選択されたときの幅を指定する倍精度浮動小数点数です。

3. double​

節点が選択されたときの長さを指定する倍精度浮動小数点数です。

4. double​

歪み解析結果に使用される修正係数を指定する倍精度浮動小数点数です。

5. str​

ゲージの名前を指定する文字列です。

戻り値コード​

"1": 関数を実行できる場合

"0": 関数を実行できない場合

サンプルコード​

CmdAddStrainGaugeMinPrincipal([], 0.0, 0.0, 1.0, "strGaugeName")
