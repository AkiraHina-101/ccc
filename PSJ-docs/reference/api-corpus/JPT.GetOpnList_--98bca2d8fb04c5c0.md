# JPT.GetOpnList()

JPT.GetOpnList()

説明​

GUIを持つ関数の名前を格納した String のリストを取得します。

構文​

JPT.GetOpnList()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

GUIを持つ関数を指定する StringVector です。

サンプルコード​

# GUIを持つすべての関数を取得
allFuncsWithGUI = JPT.GetOpnList()
JPT.Debugger(allFuncsWithGUI)
JPT.Debugger(allFuncsWithGUI[3])
