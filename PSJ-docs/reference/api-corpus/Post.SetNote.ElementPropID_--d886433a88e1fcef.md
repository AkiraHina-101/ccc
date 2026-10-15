# Post.SetNote.ElementPropID()

Post.SetNote.ElementPropID()

Description​

Set the display of the property ID in the element's notes window.

Syntax​

Post.SetNote.ElementPropID(...)

Macro: SetNoteElementPropID

Ribbon: Post » SetNote » ElementPropID

Inputs​

bNoteElemPropID​

A Boolean specifying whether to display the property ID in element's notes window.

The default value is True.

iNoteElemPropID​

An Integer specifying the method to display the property ID title as default or user-defined name.

0: Default

1: User-Defined

The default value is 0.

strNoteElemPropID​

A String specifying an arbitrary user-defined name for the property ID title. This option was used when iNoteElemPropID= 1.

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

# Hide Property ID information
Post.SetNote.ElementPropID(bNoteElemPropID=False)
# User defines Property ID title
Post.SetNote.ElementPropID(iNoteElemPropID=1, strNoteElemPropID="Property ID")
