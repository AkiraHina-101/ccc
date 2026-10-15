# JPT.GetCurrentDocumentPath()

JPT.GetCurrentDocumentPath()

説明​

現在の作業中のJupiterファイルのパスを取得します。

構文​

JPT.GetCurrentDocumentPath()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

現在のJupiterファイルへの完全なパスを指定する String です。

サンプルコード​

# 以下のコードを実行する前に既存のJupiterファイル（*.jtdb）または（*.jth5）を開いてください
path = JPT.GetCurrentDocumentPath()
print(path)
