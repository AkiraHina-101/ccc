# Post.SetNote.ElementMatID()

Post.SetNote.ElementMatID()

Description​

Set the display of the material ID in the element's notes window.

Syntax​

Post.SetNote.ElementMatID(...)

Macro: SetNoteElementMatID

Ribbon: Post » SetNote » ElementMatID

Inputs​

bNoteElemMatID​

A Boolean specifying whether to display the material ID in element's notes window.

The default value is True.

iNoteElemMatID​

An Integer specifying the method to display the material ID title as default or user-defined name.

0: Default

1: User-Defined

The default value is 0.

strNoteElemMatID​

A String specifying an arbitrary user-defined name for the material ID title. This option was used when iNoteElemMatID= 1.

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

# Hide Material ID information
Post.SetNote.ElementMatID(bNoteElemMatID=False)
# User defines Material ID title
Post.SetNote.ElementMatID(iNoteElemMatID=1, strNoteElemMatID="Material ID")
