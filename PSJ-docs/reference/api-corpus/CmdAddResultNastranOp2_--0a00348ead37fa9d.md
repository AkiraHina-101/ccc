# CmdAddResultNastranOp2()

CmdAddResultNastranOp2()

説明​

現在のモデルにNastranの結果を追加します。

構文​

CmdAddResultNastranOp2(cursor postJob, string[] FilePath, int solverType, int offsetID, bool CreateAtMidNodes)

入力​

1. cursor​

ポストジョブ。

2. string[]​

ファイルパス

3. int​

ソルバータイプ

4. int​

オフセットID

5. bool​

中間節点での作成オプションフラグ。

戻り値​

なし。

サンプルコード​

CmdAddResultNastranOp2(183:1, ["C:/Users/USERNAME/Documents/TSData/11_Desktop/Solver/boltconnection_converted_bar-fix.op2"], 1, 1, 0)
