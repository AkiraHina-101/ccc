# Report.LinearStatic()

Report.LinearStatic()

Description​

Search for parts (components) whose displayed static analysis results are outside the result thresholds set for parts and materials, captures images and automatically pastes them into Microsoft Office PowerPoint.

Syntax​

Report.LinearStatic(...)

Macro: CmdGeneralReportLinearStatic

Ribbon: Report » LinearStatic

Inputs​

iCalculateValue​

An Integer specifying the evaluation value.

0: Mises.

1: Maximum principal.

2: Minimum principal.

3: Displacement.

The default value is 0.

iEvaluationValue​

An Integer specifying the evaluation expression.

O: A/B for A is evaluation value and B is standard value.

1: B/A for A is evaluation value and B is standard value.

The default value is 0.

listPartInformation​

A List of GENERAL_REPORT_LINEAR_STATIC_DATA specifying the attribute of components.

The default value is GENERAL_REPORT_LINEAR_STATIC_DATA().

bUseCurrentView​

A Boolean specifying whether to use the current view as perspective.

The default value is False.

bExportPPT​

A Boolean specifying whether to export the result image to PowerPoint.

The default value is True.

bExportImage​

A Boolean specifying whether to save the result image to file.

The default value is False.

strImagePath​

A String specifying the path of image file to be saved in the specified format.

The default value is "".

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)

# Make Linear Static report
reportLinearStatic = Report.LinearStatic(iCalculateValue=1, 
                                        listPartInformation=[
                                        General_Report_LinearStatic_Data(
                                            strPartName="All", 
                                            strPropName="-", 
                                            strMatName="-", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="Part - PSOLID (1)", 
                                            strPropName="PSOLID (1)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="Part - PSOLID (2)", 
                                            strPropName="PSOLID (2)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="Part - PSOLID (3)", 
                                            strPropName="PSOLID (3)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="Part - PSOLID (4)", 
                                            strPropName="PSOLID (4)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="Part - PSOLID (5)", 
                                            strPropName="PSOLID (5)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000), 
                                        General_Report_LinearStatic_Data(
                                            strPartName="Part - PSOLID (6)", 
                                            strPropName="PSOLID (6)", 
                                            strMatName="MAT (1)", 
                                            dValue=0.000000)], 
                                            bExportPPT=True)
JPT.Debugger(reportLinearStatic)
