# JPT.GetAppPathInfo()

JPT.GetAppPathInfo()

説明​

現在のJupiterプログラムのパス情報を取得します。

構文​

JPT.GetAppPathInfo(PathType)

入力​

PathType​

利用可能なパスの種類　PathType　を指定する Enum 。

この入力は必須です。

戻り値​

入力された PathType に関連するパスを指定する String です。

サンプルコード​

# インストールフォルダへのパス
print(JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH))
