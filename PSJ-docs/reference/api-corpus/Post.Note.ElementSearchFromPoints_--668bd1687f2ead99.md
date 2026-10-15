# Post.Note.ElementSearchFromPoints()

Post.Note.ElementSearchFromPoints()

Description​

Search the nearest element from the specified point and markup its element note.

Syntax​

Post.Note.ElementSearchFromPoints(...)

Macro: CmdMarkupSearchElementFromPoint,
CmdMarkupSearchElementsFromMultiPoints,

Ribbon: Post » Note » ElementSearchFromPoints

Inputs​

dlPositions​

A List of Double specifying the coordinates of points to search the nearest elements.

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

# Search elements from points and markup notes
element = Post.Note.ElementSearchFromPoints(dlPositions=[[30.0, 3.0, 2.5], [28.0, 8.0, 4.0]])
if len(element) >=1:
    for i in range(len(element)):
        print("The searched element is:", str(element[i]))
else:
    print("Cannot search the element from point")
