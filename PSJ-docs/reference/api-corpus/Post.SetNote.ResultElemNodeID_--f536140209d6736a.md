# Post.SetNote.ResultElemNodeID()

Post.SetNote.ResultElemNodeID()

Description​

Set the node ID or element ID of the entity to be displayed in the note window.

Syntax​

Post.SetNote.ResultElemNodeID(...)

Macro: SetNoteResultElemNodeID

Ribbon: Post » SetNote » ResultElemNodeID

Inputs​

bNoteResultElemNodeID​

A Boolean specifying whether to display the ID of Elements/Nodes in the note window.

The default value is True.

iNoteResultElemNodeID​

An Integer specifying the method to display the Element/Node ID title as default or user-defined name.

0: Default

1: User-Defined

The default value is 0.

strNoteResultElemNodeID​

A String specifying an arbitrary user-defined name for the Element/Node ID title. This option was used when iNoteResultElemNodeID= 1.

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

# Hide Element ID information
Post.SetNote.ResultElemNodeID(bNoteResultElemNodeID=False)
# User defines Element ID title
Post.SetNote.ResultElemNodeID(iNoteResultElemNodeID=1, strNoteResultElemNodeID="ELem/NodeID")
