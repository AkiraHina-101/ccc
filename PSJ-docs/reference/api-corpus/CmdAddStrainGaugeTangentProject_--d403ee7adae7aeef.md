# CmdAddStrainGaugeTangentProject()

CmdAddStrainGaugeTangentProject()

説明​

各節点で接線ひずみを表示します。

構文​

CmdAddStrainGaugeTangentProject(int[] ilNodeIDs, double dWidth, double dHeight, int nDirection, double dAngle, double dVectorSize, double dAmendFactor, str strGaugeName)

入力​

1. int[]​

選択した節点のIDを指定する整数のリストです。

2. double​

節点を選択したときの選択幅を指定する倍精度浮動小数型です。

3. double​

節点を選択したときの選択長さを指定する倍精度浮動小数型です。

4. int​

最大主応力、最小主応力、X軸、Y軸、Z軸から選択された元の方向を指定する整数です。

5. double​

回転角の値を指定する倍精度浮動小数型です。

6. double​

ベクトルサイズを指定する倍精度浮動小数型です。

7. double​

ひずみ解析結果に使用される補正係数を指定する倍精度浮動小数型です。

8. str​

ゲージ名を指定する文字列です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CmdAddStrainGaugeTangentProject([], 0.0, 0.0, 0, 0.0, 1.0, 1.0, "strGaugeName")
