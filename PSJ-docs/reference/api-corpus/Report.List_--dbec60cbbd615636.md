# Report.List()

Report.List()

Description​

Export the selected results to a CSV file or a universal format.

Syntax​

Report.List(...)

Macro: ResultOutputList

Ribbon: Report » List

Inputs​

strPath​

A String specifying the file path to be exported.

This is a required input.

crlTargets​

A List of Cursor specifying the selected parts to be exported data.

The default value is [].

iResultType​

An Integer specifying the result type to be exported.

0: Displacement

1: Temperature

2: Energy

3: SPC Force

4: MPC Force

5: Stress

6: Strain

7: Other

The default value is 0.

iOutput​

An Integer specifying to output all selected subcases in one file or in separated files for each selected subcase.

0: Single.

1: Multiple.

The default value is 0.

iOutPutType​

An Integer specifying the format of the output file.

0: CSV

1: Unv

The default value is 0.

iResultPosition​

An Integer specifying the output position of the result.

0: Node

1: Element

The default value is 0.

bMidNode​

A Boolean specifying whether to enable/disable middle node for the exported results.

The default value is False.

listPostResultKey​

A List of POST_RESULT_KEY specifying the attributes of the selected result.

The default value is POST_RESULT_KEY().

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))
Post.EnableMiddleNodes()

# Make List report
reportList = Report.List(strPath="C:/temp/ReportList.csv", 
                        crlTargets=[Part(3)], 
                        iOutput=1, 
                        bMidNode=True, 
                        listPostResultKey=[[2, 1, 1, 0], [2, 1, 2, 0], [2, 1, 3, 0], [2, 1, 4, 0], [2, 1, 5, 0]])
JPT.Debugger(reportList)
