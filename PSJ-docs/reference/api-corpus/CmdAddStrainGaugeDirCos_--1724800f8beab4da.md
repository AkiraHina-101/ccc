# CmdAddStrainGaugeDirCos()

CmdAddStrainGaugeDirCos()

説明​

入力された方向ベクトルの方向余弦の応力/ひずみのグラフを表示します。

構文​

CmdAddStrainGaugeDirCos(int[] ilNodeIDs, double[] dlDirectionInput, double dWidth, double dHeight, double dAmendFactor, str strGaugeName)

入力​

1. int[]​

選択した節点のIDを指定する整数のリスト。

2. double[]​

結果を得るための方向を指定する倍精度浮動小数点数リスト。

3. double​

節点を選択する際の選択幅を指定する倍精度浮動小数点数。

4. double​

節点を選択する際の選択長さを指定する倍精度浮動小数点数。

5. double​

ひずみ解析結果に使用される修正係数を指定する倍精度浮動小数点数。

6. str​

ゲージ名を指定する文字列。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CmdAddStrainGaugeDirCos([], [0.0, 0.0, 1.0], 0.0, 0.0, 1.0, "strGaugeName")
