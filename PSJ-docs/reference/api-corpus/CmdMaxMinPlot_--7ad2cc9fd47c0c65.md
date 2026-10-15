# CmdMaxMinPlot()

CmdMaxMinPlot()

説明​

Max/Min Plotを実行します。

構文​

CmdMaxMinPlot(PostStepItem[] vecStep, bool ExportCsv, string File )

入力​

1. PostStepItem[]​

プロットする結果のリスト。int analysisType、int resultSet、int timeStep

2. bool​

CSVファイルをエクスポートするフラグ。

3. string​

CSVファイルのパス。

戻り値​

なし。

サンプルコード​

CmdMaxMinPlot([[1,0,0], [1,0,1], [1,0,2], [1,0,3], [1,0,4], [1,0,5], [1,0,6], [1,0,7], [1,0,8], [1,0,9]], 0, "")
