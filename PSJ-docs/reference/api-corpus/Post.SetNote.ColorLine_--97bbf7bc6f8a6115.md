# Post.SetNote.ColorLine()

Post.SetNote.ColorLine()

Description​

Set the color and thickness of the border in the Note window.

Syntax​

Post.SetNote.ColorLine(...)

Macro: SetNoteColorLine

Ribbon: Post » SetNote » ColorLine

Inputs​

iLineColor​

An Integer specifying the color of the border.

The default value is 0.

iLineSize​

An Integer specifying the thickness in pixels of the border.

The default value is 1.

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

# Modify the color and thickness of the border
Post.Note.Node(crlTargets=[RONode(133)])
Post.SetNote.ColorLine(iLineColor=255, iLineSize=2)
