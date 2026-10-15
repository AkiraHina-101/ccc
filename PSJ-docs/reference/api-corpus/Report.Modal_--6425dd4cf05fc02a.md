# Report.Modal()

Report.Modal()

Description​

Capture the image of the displayed modal result of the eigenvalue analysis at each frequency within the specified range, and automatically paste it into Microsoft Office PowerPoint.

Syntax​

Report.Modal(...)

Macro: CmdGeneralReportModal

Ribbon: Report » Modal

Inputs​

iResultInOnePage​

An Integer specifying the number of result images to paste on one page of the PowerPoint file. The option is 1, 2, 4 and 6.

The default value is 1.

bUseCurrentView​

A Boolean specifying whether to use the current view as perspective.

The default value is False.

bExportPPT​

A Boolean specifying whether to export the result image to PowerPoint.

The default value is True.

bExportImage​

A Boolean specifying whether to save the result image to file.

The default value is False.

dStartFrequency​

A Double specifying the start frequency. Any frequency less than this value will be ignored.

The default value is 0.0.

dEndFrequency​

A Double specifying the end frequency. Any frequency greater than this value will be ignored.

The default value is 100.0.

strImagePath​

A String specifying the path of image file to be saved in the specified format.

The default value is "".

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60, dEdgeAngle=60)

# Make Modal report
reportModal = Report.Modal(iResultInOnePage=2, dStartFrequency=10000.0, dEndFrequency=100000.0)
JPT.Debugger(reportModal)
