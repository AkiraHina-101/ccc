# Post.ShowMaxMin()

Post.ShowMaxMin()

Description​

Show the label of the Max/Min value of the currently displayed result model.

Syntax​

Post.ShowMaxMin(...)

Macro: CmdShowHideMaxMin

Ribbon: Post » ShowMaxMin

Inputs​

bShowHide​

A Boolean specifying whether to show/hide the max/min labels.

The default value is True.

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

# Show Max/Min
Post.ShowMaxMin()
