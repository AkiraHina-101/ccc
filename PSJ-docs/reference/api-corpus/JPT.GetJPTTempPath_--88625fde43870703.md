# JPT.GetJPTTempPath()

JPT.GetJPTTempPath()

説明​

現在のJupiterプログラムの一時フォルダへのパスを取得します。

構文​

JPT.GetJPTTempPath()

入力​

このユーティリティ関数は入力値を必要としません。

戻り値​

現在のJupiter一時フォルダへのパスを指定する String です。

サンプルコード​

# 現在のJupiter一時フォルダを取得
path = JPT.GetJPTTempPath()
JPT.Debugger(path)
