# Post.Note.Position()

Post.Note.Position()

Description​

Add a note indication to the arbitrary point specified on the main window, and input it to the data table in the Position tab of the Watch Data window.

Syntax​

Post.Note.Position(...)

Macro: CmdMarkupFacePoint

Ribbon: Post » Note » Position

Inputs​

crElement​

A Cursor specifying the element containing the specified point.

This is a required input.

dlPosition​

A List of Double specifying the coordinates of the specified point.

This is a required input.

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

# Display note at the selected point
Post.Note.Position(crElement=ROElem(448), dlPosition=[29.542965, 10.0, 1.642851])
