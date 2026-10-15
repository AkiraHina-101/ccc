# Post.Note.NodeSearchFromPoints()

Post.Note.NodeSearchFromPoints()

Description​

Search the nearest node from the specified point and markup its node note

Syntax​

Post.Note.NodeSearchFromPoints(...)

Macro: CmdMarkupSearchNodeFromPoint,
CmdMarkupSearchNodesFromMultiPoints,

Ribbon: Post » Note » NodeSearchFromPoints

Inputs​

dlPositions​

A List of Double specifying the coordinates of points to search the nearest nodes.

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

# Search nodes from points and markup notes
node = Post.Note.NodeSearchFromPoints(dlPositions=[[30.0, 3.0, 2.5], [28.0, 8.0, 4.0]])
if len(node) >=1:
    for i in range(len(node)):
        print("The searched node is:", str(node[i]))
else:
    print("Cannot search the node from point")
