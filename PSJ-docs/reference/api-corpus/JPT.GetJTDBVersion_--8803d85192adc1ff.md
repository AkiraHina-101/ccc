# JPT.GetJTDBVersion()

JPT.GetJTDBVersion()

説明​

現在のJupiterファイルのすべてのバージョン情報を取得します。

構文​

JPT.GetJTDBVersion()

入力​

このユーティリティ機能には入力値は必要ありません。

戻り値​

現在のJupiterファイルのバージョン情報を含む VersionInfo オブジェクトを指定する List が含まれています。バージョン情報には以下が含まれます：

Build

Major

Minor

Sub

サンプルコード​

# 現在のJupiterのバージョン情報を取得
version = JPT.GetJTDBVersion()
JPT.Debugger(version)
