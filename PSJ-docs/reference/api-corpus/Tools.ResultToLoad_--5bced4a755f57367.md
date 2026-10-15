# Tools.ResultToLoad()

Tools.ResultToLoad()

Description​

Export the selected result name to solver information (as solver keyword card) for the selected entities. Depending on selection of convert load type, the analysis result will be exported to solver card information respectively.

Syntax​

Tools.ResultToLoad(...)

Macro: CmdExportLoad

Ribbon: Tools » ResultToLoad

Inputs​

crlTargets​

A List of Cursor specifying the selected entities. The entities can be Part, Face, Node, Element or Group.

This is a required input.

listPostStepItem​

A List of POST_STEP_ITEM specifying the attributes of each Post Step Item.

The default value is POST_STEP_ITEM().

vecResultLoad​

A Vector of RESULT_LOAD specifying the components of the selected result.

The default value is RESULT_LOAD().

strExportPath​

A String specifying the path of file to be exported.

This is a required input.

iSolverType​

An Integer specifying the solver type.

The default value is 2 (Nastran).

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\Post\\Static_Renkon.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=1, 
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
                    iAnalysisType=1, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))

# Result to load
sampleFile = Tools.ResultToLoad(crlTargets=[Face(10)], 
                                postStepItem=PostStepItem(iAnalysisType=1, iResultSet=1, iTimeStep=1), 
                                vecResultLoad=[ResultLoad(iVrType=6, strResultName="Displacement", strLoadName="Enforced Displacement")], 
                                strExportPath="C:/temp/ResultToLoadFile")
JPT.Debugger(sampleFile)
