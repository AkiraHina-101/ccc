# CmdGeneralReportModal()

CmdGeneralReportModal()

Description​

Create report of modal analysis.

Syntax​

CmdGeneralReportModal(string file, bool ExportPPT, bool ExportImgFile, double startFreq, double endFreq)

Inputs​

1. string ​

CSV file path for setting file.

2.bool ​

Export PPT flag.

3.bool ​

Export Image File flag.

4. double ​

Start Frequency.

5.double ​

End Frequency.

Return Code​

Nothing.

Sample Code​

CmdGeneralReportModal("C:/temp/gen_post.csv", 1, 1, 0, 10000)
