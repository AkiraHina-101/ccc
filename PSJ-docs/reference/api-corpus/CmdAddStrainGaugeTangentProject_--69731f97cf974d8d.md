# CmdAddStrainGaugeTangentProject()

CmdAddStrainGaugeTangentProject()

説明​

ストレインゲージ - 接線プロジェクトを実行します。

構文​

CmdAddStrainGaugeTangentProject(int node, double Width, double Height, double AmendFactor, int Dir, double Angle, float VecSize, string GaugeName)

入力​

1. int​

対象の節点。

2. double​

ゲージの幅。

3. double​

ゲージの高さ。

4. double​

修正係数。

5. int​

元の方向

6. double​

角度

7. double​

ベクトルサイズ

8. string​

ゲージ名。

戻り値​

なし。

サンプルコード​

CmdAddStrainGaugeTangentProject(9461, 0.006, 0.006, 2, 0, 0, 1, "")
