# CmdAddStrainGaugeMaxPrincipal()

CmdAddStrainGaugeMaxPrincipal()

説明​

最大主応力の方向に応力またはひずみを表示します。

構文​

CmdAddStrainGaugeMaxPrincipal(int[] ilNodeIDs, double dWidth, double dHeight, double dAmendFactor, str strGaugeName)

入力​

1. int[]​

選択された節点のIDを指定する整数のリスト。

2. double​

節点を選択したときの選択幅を指定する倍精度浮動小数点数。

3. double​

節点を選択したときの選択長さを指定する倍精度浮動小数点数。

4. double​

ひずみ解析結果に使用される補正係数を指定する倍精度浮動小数点数。

5. str​

ゲージ名を指定する文字列。

戻り値コード​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

CmdAddStrainGaugeMaxPrincipal([], 0.0, 0.0, 1.0, "strGaugeName")
