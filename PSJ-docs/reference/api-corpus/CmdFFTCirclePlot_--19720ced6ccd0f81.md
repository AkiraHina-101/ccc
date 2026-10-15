# CmdFFTCirclePlot()

CmdFFTCirclePlot()

説明​

変形プロットグラフを表示します。

構文​

CmdFFTCirclePlot(int iKey, bool bOACircleOutput, str strOACircleLayers, bool bOADefine, str strOADefine, str strModeOutput, str strModesLayers)

入力​

1. int​

指定したFFT条件のIDを指定する整数

2. bool​

OA Circleオプションを使用するかどうかを指定するブール値

3. str​

OA結果の変形プロットグラフを表示するためのレイヤー数を指定する文字列

4. bool​

Define OA Circleオプションを使用するかどうかを指定するブール値

5. str​

OA曲線に使用するモードを指定する文字列

6. str​

変形プロットがグラフィカルに表示されるモードを指定する文字列

7. str​

各モードでグラフィカルに表示されるレイヤーを指定する文字列

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CmdFFTCirclePlot(1, 1, "2", 1, "2-4", "2", "2")
