# Post.SetNote.ResultPos()

Post.SetNote.ResultPos()

Description​

Set the display of coordinates of the selected position in the note window.

Syntax​

Post.SetNote.ResultPos(...)

Macro: SetNoteResultPos

Ribbon: Post » SetNote » ResultPos

Inputs​

bNoteResultPos​

A Boolean specifying whether to display the coordinates of the selected position in the note window.

The default value is True.

iNoteResultPos​

An Integer specifying the method to display the coordinate title as default or user-defined name.

0: Default

1: User-Defined

The default value is 0.

strNoteResultPos​

A String specifying an arbitrary user-defined name for the coordinate title. This option was used when iNoteResultPos= 1.

The default value is "".

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
                strResultName="Stress", 
                strResultCompName="Mises", 
                iResultPos=2), 
                postDataOp=PostDataOp(iResultLocation=2))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Stress",
                     strResultCompName="Mises"))
Post.Note.Position(crElement=ROElem(448), dlPosition=[28.588114, 6.313289, 5.0])

# Hide Position information
Post.SetNote.ResultPos(bNoteResultPos=False)
# User defines Position title
Post.SetNote.ResultPos(iNoteResultPos=1, strNoteResultPos="Position")
