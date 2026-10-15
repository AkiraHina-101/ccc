# Home.ExportResultToTXT()

Home.ExportResultToTXT()

Description​

Export the selected result file to text format (*.txt).

Syntax​

Home.ExportResultToTXT(...)

Macro: PostExportToTxt

Ribbon: Home » ExportResultToTXT

Inputs​

strFileName​

A String specifying the file path to be exported.

This is a required input.

iSpliterType​

An Integer specifying the method to delimit output values.

0: Space ( )

1: Comma (,)

2: Semicolon (;)

The default value is 0.

bAppend​

A Boolean specifying whether to append the results to the specified file.

The default value is False.

crlJobs​

A List of Cursor specifying the post job.

The default value is [].

ilAnalysisTypes​

A List of Integer specifying the analysis type.

The default value is [].

ilResultSets​

A List of Integer specifying the result set.

The default value is [].

ilTimeSteps​

A List of Integer specifying the time step.

The default value is [].

ilResultTypes​

A List of Integer specifying the result type.

The default value is [].

ilResultPos​

A List of Integer specifying result position.

The default value is [].

strlResultNames​

A List of String specifying the result name.

The default value is [].

strlCompNames​

A List of String specifying the component name.

The default value is [].

strlNames​

A List of String specifying the result name.

The default value is [].

strlTypes​

A List of String specifying the result type.

The default value is [].

crlEdit​

A List of Cursor specifying the edit target.

The default value is [].

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 

# Export result to txt
exportFile = Home.ExportResultToTXT(strFileName="C:/temp/ExportTXT.txt", 
                                    iSpliterType=1, 
                                    crlJobs=[TSVPostJob(1, 1)], 
                                    ilAnalysisTypes=[1, 1], 
                                    ilResultSets=[1, 1], 
                                    ilTimeSteps=[1, 1], 
                                    ilResultTypes=[3, 4], 
                                    ilResultPos=[1, 1], 
                                    strlResultNames=["", ""], 
                                    strlCompNames=["", ""], 
                                    strlNames=["RX", "RY"], 
                                    strlTypes=["TYPE_VIRTUAL_RESULT_ITEM", "TYPE_VIRTUAL_RESULT_ITEM"], 
                                    crlEdit=[Unknown(0, 0)])
JPT.Debugger(exportFile )
