# Post.SetNote.ResultPrnVector()

Post.SetNote.ResultPrnVector()

Description​

Set the display of principal stress/principal strain unit vector in the note window.

Syntax​

Post.SetNote.ResultPrnVector(...)

Macro: SetNoteResultPrnVector

Ribbon: Post » SetNote » ResultPrnVector

Inputs​

bNoteResultPrnVector​

A Boolean specifying whether to display the principal stress/principal strain unit vector in the note window.

The default value is True.

iNoteResultPrnVector​

An Integer specifying the method to display the principal stress/principal strain unit vector title as default or user-defined name.

0: Default

1: User-Defined

The default value is 0.

strNoteResultPrnVector​

A String specifying an arbitrary user-defined name for the principal stress/principal strain vector. This option was used when iNoteResultPrnVector= 1.

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
                strResultCompName="Max Principal Stress", 
                iResultPos=4), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=1, 
                iOptionConversion=1, 
                iOptionContinuous=8))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Stress", 
                    strResultCompName="Max Principal Stress"))
Post.Note.Node(crlTargets=[RONode(133)])

# Hide Principal stress direction
Post.SetNote.ResultPrnVector(bNoteResultPrnVector=False)
# User defines Principal stress direction title
Post.SetNote.ResultPrnVector(iNoteResultPrnVector=1, strNoteResultPrnVector="Direction")
