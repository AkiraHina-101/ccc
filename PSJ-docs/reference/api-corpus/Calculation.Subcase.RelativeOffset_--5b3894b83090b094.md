# Calculation.Subcase.RelativeOffset()

Calculation.Subcase.RelativeOffset()

Description​

Create a subcase of relative displacement with zero displacement for any selected nodal ID.

Syntax​

Calculation.Subcase.RelativeOffset(...)

Macro: PostToolsSubcaseRelativeOffset

Ribbon: Calculation » Subcase » RelativeOffset

Inputs​

iAnalysisType​

An Integer specifying the analysis type.

The default value is 1.

iResultSet​

An Integer specifying the result set.

The default value is 1.

iTimeStep​

An Integer specifying the time step.

The default value is 0.

iNodeID​

An Integer specifying the ID of the selected node.

The default value is 0.

iSubcaseID​

An Integer specifying the ID of the subcase to be created.

The default value is 0.

strSubcaseName​

A String specifying the name of subcase to be created.

The default value is "Subcase1PeakHold".

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Subcase.RelativeOffset
relativeOffset = Calculation.Subcase.RelativeOffset(iAnalysisType=2, iTimeStep=1, iNodeID=133, iSubcaseID=11, \
                                                    strSubcaseName="Relative Offset 11  Subcase 1")
JPT.Debugger(relativeOffset)
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(iAnalysisType=2, \
                iResultSet=1, iTimeStep=11, strResultName="Displacement", strResultCompName="Translational", \
                iResultPos=1), postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=1))])
