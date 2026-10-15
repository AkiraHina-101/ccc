# Post.SetNote.ResultData()

Post.SetNote.ResultData()

Description​

Set the display of result data title in the note window.

Syntax​

Post.SetNote.ResultData(...)

Macro: SetNoteResultData

Ribbon: Post » SetNote » ResultData

Inputs​

iNoteResultTitle​

An Integer specifying the method to display the result data title as default or user-defined name.

0: Default

1: User-Defined

The default value is 0.

strNoteResultTitle​

A String specifying an arbitrary user-defined name for result data title. This option was used when iNoteResultTitle= 1.

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

# User defines Result Data title
Post.SetNote.ResultData(iNoteResultTitle=1, strNoteResultTitle="Result Data")
