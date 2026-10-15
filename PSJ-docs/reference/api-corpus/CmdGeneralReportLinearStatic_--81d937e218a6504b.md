# CmdGeneralReportLinearStatic()

CmdGeneralReportLinearStatic()

Description​

Search for parts (components) whose displayed static analysis results are outside the result thresholds set for parts and materials, captures images and automatically pastes them into Microsoft Office PowerPoint.

Syntax​

CmdGeneralReportLinearStatic(int CalculateValue, int EvaluationValue, int[] listPartInformation, bool UseCurrentView, bool ExportPPT, bool ExportImage, string ImgFilePath)

Inputs​

1. Int​

An Integer specifying the evaluation value.

2. Int​

An Integer specifying the evaluation expression.

3. Int[]​

A List of GENERAL_REPORT_LINEAR_STATIC_DATA specifying the attribute of components.

4. Bool​

A Boolean specifying whether to use the current view as perspective.

5. Bool​

A Boolean specifying whether to export the result image to PowerPoint.

6. Bool​

A Boolean specifying whether to save the result image to file.

7. String​

A String specifying the path of image file to be saved in the specified format.

Return Code​

"1": The function can be executed.

"0": The function cannot be executed.

Sample Code​

CmdGeneralReportLinearStatic(0, 0, [], False, True, False, "")
