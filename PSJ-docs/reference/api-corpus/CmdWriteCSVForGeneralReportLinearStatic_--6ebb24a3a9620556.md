# CmdWriteCSVForGeneralReportLinearStatic()

CmdWriteCSVForGeneralReportLinearStatic()

Description​

Export Linear Static report into CSV file.

Syntax​

CmdWriteCSVForGeneralReportLinearStatic(string strCSVFile, string strCalculateValue, string strEvaluationValue, bool bCheckusecurrentview, 
string strfilePath, string strfileName, string strfileExt, string[] listGridData)

Inputs​

1. string ​

The name of export CSV file.

2. string ​

Calculation value.

3. string ​

Evaluation value.

4. bool ​

Flag whether use current view.

5. string ​

Folder path to export images.

6. string ​

File name of export images.

7. string ​

File extension of export images.

8. string[] ​

Grid information.

Return Code​

Nothing.

Sample Code​

JPT.Exec('CmdWriteCSVForGeneralReportLinearStatic("C:/Users/TECHNO~1/AppData/Local/Temp/TechnoStar/01/gen_pre.csv", "Mises", "A/B", 0, "", "", "", [["All", "-", "-", "0.000000"]])')
