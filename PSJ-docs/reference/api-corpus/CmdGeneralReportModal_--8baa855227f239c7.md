# CmdGeneralReportModal()

CmdGeneralReportModal()

Description​

Capture the image of the displayed modal result of the eigenvalue analysis at each frequency within the specified range, and automatically paste it into Microsoft Office PowerPoint.

Syntax​

CmdGeneralReportModal(int ResultsInOnePage, bool UseCurrentView, bool ExportPPT, bool ExportImage, double StartFrequency, double EndFrequency, string ImgFilePath)

Inputs​

1. int ​

An Integer specifying the number of result images to paste on one page of the PowerPoint file.

2. bool ​

A Boolean specifying whether to use the current view as perspective.

3. bool ​

A Boolean specifying whether to export the result image to PowerPoint.

4. bool ​

A Boolean specifying whether to save the result image to file.
The default value is False.

5. double ​

A Double specifying the start frequency.

6. double ​

A Double specifying the end frequency.

7. string ​

A String specifying the path of image file to be saved in the specified format.

Return Code​

"1": The function can be executed.

"0": The function cannot be executed.

Sample Code​

CmdGeneralReportModal(2,False,True,False,0.0,100.0,"")
