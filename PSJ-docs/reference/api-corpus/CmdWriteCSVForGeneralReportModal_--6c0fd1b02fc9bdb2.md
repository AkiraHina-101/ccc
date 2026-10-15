# CmdWriteCSVForGeneralReportModal()

CmdWriteCSVForGeneralReportModal()

Description​

Export Modal report into CSV file.

Syntax​

CmdWriteCSVForGeneralReportModal(string strPathFile, int ResultsInOnePage, bool bCheckusecurrentview, double dStartFrequency, double dEndFrequency)

Inputs​

1. String​

The name of export CSV file.

2. int​

The number of images in one slide.

3. bool​

Whether use current view point or not.

4. double​

Start frequency.

5. double​

End frequency.

Return Code​

Nothing.

Sample Code​

CmdWriteCSVForGeneralReportModal("C:/Users/TECHNO~1/AppData/Local/Temp/TechnoStar/00/gen_post.csv", 1, 0, 30000, 60000)
