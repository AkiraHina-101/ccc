# Post.SetNote.ResultDisp()

Post.SetNote.ResultDisp()

Description​

Set the display of displacement result in the note window.

Syntax​

Post.SetNote.ResultDisp(...)

Macro: SetNoteResultDisp

Ribbon: Post » SetNote » ResultDisp

Inputs​

bNoteResultDisp​

A Boolean specifying whether to display the displacement result in notes window.

The default value is True.

iNoteResultDisp​

An Integer specifying the method to display the displacement result title as default or user-defined name.

0: Default

1: User-Defined

The default value is 0.

strNoteResultDisp​

A String specifying an arbitrary user-defined name for the displacement result title. This option was used when iNoteResultDisp= 1.

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
Post.Note.Element(crlTargets=[ROElem(448)])

# Hide Displacement result information
Post.SetNote.ResultDisp(bNoteResultDisp=False)
# User defines Displacement result title
Post.SetNote.ResultDisp(iNoteResultDisp=1, strNoteResultDisp="Displacement")
