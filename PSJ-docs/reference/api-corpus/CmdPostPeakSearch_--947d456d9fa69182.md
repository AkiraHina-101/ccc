# CmdPostPeakSearch()

CmdPostPeakSearch()

説明​

モデル内の各節点で、近くの頂点よりも高いまたは低い結果（ピーク）を持つピーク節点を検出し、フラグを立てます。

構文​

CmdPostPeakSearch(int iOption, double dParameter, boolbStep)

入力​

1. int​

ピークオプションを指定する整数です。

2. double​

マイクロピーク除去のための値を指定する倍精度浮動小数点です。

3. bool​

ステップオプションを使用するかどうかを指定するブール値です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CmdPostPeakSearch(0, 0.1, 1)
