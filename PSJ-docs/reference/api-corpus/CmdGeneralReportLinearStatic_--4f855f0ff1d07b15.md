# CmdGeneralReportLinearStatic()

CmdGeneralReportLinearStatic()

説明​

線形静的解析のレポートを作成します。

構文​

CmdGeneralReportLinearStatic(string file, bool ExportPPT, bool ExportImgFile)

入力​

1. string ​

設定ファイルのCSVファイルパスです。

2.bool ​

PPTをエクスポートするフラグです。

3.bool ​

画像ファイルをエクスポートするフラグです。

戻り値​

なし。

サンプルコード​

CmdGeneralReportLinearStatic("C:/temp/gen_pre.csv", 1, 0)
