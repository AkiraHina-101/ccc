# CmdAddStrainGaugeAxisAngle()

CmdAddStrainGaugeAxisAngle()

説明​

2つの軸から成る平面上の最初に定義された軸からの入力回転角に応じた応力/ひずみデータを表示します。

構文​

CmdAddStrainGaugeAxisAngle(int[] ilNodeIDs, int nAxis1, int nAxis2, double dAngle, double dWidth, double dHeight, double dAmendFactor, str strGaugeName)

入力​

1. int[]​

選択した節点のIDを指定する整数のリストです。

2. int​

最大主応力、最小主応力、中間主応力からの最初の軸を指定する整数です。

3. int​

最小主応力および中間主応力からの2番目の軸を指定する整数です。

4. double​

回転角の値を指定する倍精度浮動小数点数です。

5. double​

節点が選択されたときの選択幅を指定する倍精度浮動小数点数です。

6. double​

節点が選択されたときの選択長さを指定する倍精度浮動小数点数です。

7. double​

ひずみ解析結果に使用される修正係数を指定する倍精度浮動小数点数です。

8. str​

ゲージの名前を指定する文字列です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CmdAddStrainGaugeAxisAngle([], 0, 1, 0.0, 0.0, 0.0, 1.0, "strGaugeName")
