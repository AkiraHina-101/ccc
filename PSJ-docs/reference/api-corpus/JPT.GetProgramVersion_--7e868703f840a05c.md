# JPT.GetProgramVersion()

JPT.GetProgramVersion()

説明​

現在のJupiterアプリケーションのすべてのバージョン情報を取得します。

構文​

JPT.GetProgramVersion()

入力​

このユーティリティ関数には入力値は不要です。

戻り値​

現在のJupiterアプリケーションのバージョン、リビジョン情報を含む VersionInfo オブジェクトが指定された List が返されます。情報は以下を含みます:

Major

Minor

Sub

Build.

サンプルコード​

# 現在のJupiterのバージョン情報を取得する
version = JPT.GetProgramVersion()
print(f"Jupiter {version.major}.{version.minor}.{version.sub}")
print(f"Revision {version.build}")
