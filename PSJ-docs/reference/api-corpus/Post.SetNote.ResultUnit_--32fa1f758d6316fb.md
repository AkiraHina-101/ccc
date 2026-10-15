# Post.SetNote.ResultUnit()

Post.SetNote.ResultUnit()

Description​

Set to display the unit of data in the note window

Syntax​

Post.SetNote.ResultUnit(...)

Macro: SetNoteResultUnit

Ribbon: Post » SetNote » ResultUnit

Inputs​

bNoteResultUnit​

A Boolean specifying whether to display the unit of data in the note window.

The default value is True.

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
                postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=4))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))
Post.Note.Node(crlTargets=[RONode(133)])

# Hide Unit of data
Post.SetNote.ResultUnit(bNoteResultUnit=False)
