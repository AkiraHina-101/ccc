# JPT.GetProgramPath()

JPT.GetProgramPath()

説明​

現在のJupiterインストールフォルダへのパスを取得します。

構文​

JPT.GetProgramPath()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在のJupiterインストールフォルダへのパス。

サンプルコード​

# 現在のJupiterインストールフォルダを取得
path = JPT.GetProgramPath()
JPT.Debugger(path)
