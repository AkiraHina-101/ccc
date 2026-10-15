# AcousticTLPCHResult()

AcousticTLPCHResult()

説明​

Nastran構造音響連成解析から出力された結合表面に関する情報が含まれる Punch ファイル (*.pch) を読み込み、音響モデルに節点グループを作成します。

構文​

AcousticTLPCHResult(str strPathName, cursor crEdit)

入力​

1. str​

(*.pch) ファイルのパスを指定する文字列です。

2. cursor​

編集を指定するカーソルです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AcousticTLPCHResult("ファイルへのパス", 0:0)
