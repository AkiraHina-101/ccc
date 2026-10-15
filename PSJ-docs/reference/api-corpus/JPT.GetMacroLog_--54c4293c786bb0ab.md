# JPT.GetMacroLog()

JPT.GetMacroLog()

説明​

マクロウィンドウに存在する現在のテキストを取得します。

構文​

JPT.GetMacroLog()

入力​

このユーティリティ関数には入力値は不要です。

戻り値​

マクロウィンドウに存在するすべてのテキストを含む String です。

サンプルコード​

# ダイアログを開いたり、何かを作成してそのマクロをマクロウィンドウに保存するなどの操作を行います
# マクロダイアログが空白の場合、戻り値は""
# マクロウィンドウに保存されたマクロを取得
storedMacro = JPT.GetMacroLog()
JPT.Debugger(storedMacro)
