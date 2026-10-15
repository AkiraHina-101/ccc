# CmdAddStrainGaugeExistingResult()

CmdAddStrainGaugeExistingResult()

説明​

ストレインゲージの実行 - 既存の結果。

構文​

CmdAddStrainGaugeExistingResult(int node, int analysisType, int resultSet, int timeStep, int resultType, double Width, double Height, double AmendFactor, string GaugeName)

入力​

1. int ​

対象節点。

2. int ​

解析タイプ。

3. int ​

結果セット。

4. int ​

タイムステップ。

5. int ​

結果の種類。

6. double ​

ゲージの幅。

7. double ​

ゲージの高さ。

8. double ​

修正係数。

9. string ​

ゲージの名前。

戻り値​

なし。

サンプルコード​

CmdAddStrainGaugeExistingResult(23237, 1, 1, 1, 6, 0.003, 0.003, 1, "")
