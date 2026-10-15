# Post.Note.SearchPositions()

Post.Note.SearchPositions()

Description​

Search point and markup its position note.

Syntax​

Post.Note.SearchPositions(...)

Macro: CmdMarkupSearchPoint,
CmdMarkupSearchMultiPoints

Ribbon: Post » Note » SearchPositions

Inputs​

dlPositions​

A List of Double specifying the coordinates of points for searching.

This is a required input.

dTolerance​

A Double specifying the tolerance value for searching.

The default value is 0.0.

bSearch​

A Boolean specifying whether to search only on the displayed parts or all parts of the model.

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# Plot the result
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
                iOptionCoord=4))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))

# Search and display note at points
Post.Note.SearchPositions(dlPositions=[[30.0, 5.0, 2.0]], dTolerance=0.01, bSearch=True)
