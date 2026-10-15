# CmdMaxMinPlot()

CmdMaxMinPlot()

Description​

Execute Max/Min Plot

Syntax​

CmdMaxMinPlot(PostStepItem[] vecStep, bool ExportCsv, string File )

Inputs​

1. PostStepItem[] ​

List of results to plot. int analysisType, int resultSet, int timeStep

2. bool ​

Flag of Export CSV File.

3. string ​

Path of CSV file.

Return Code​

Nothing.

Sample Code​

CmdMaxMinPlot([[1,0,0], [1,0,1], [1,0,2], [1,0,3], [1,0,4], [1,0,5], [1,0,6], [1,0,7], [1,0,8], [1,0,9]], 0, "")
