# Post.AreaMaxMin()

Post.AreaMaxMin()

Description​

Detect the maximum and minimum values of nodes within a specified range.

Syntax​

Post.AreaMaxMin(...)

Macro: CmdPostAreaMaxMin

Ribbon: Post » AreaMaxMin

Inputs​

crlTargets​

A List of Cursor specifying the selected nodes to detect max/min value.

This is a required input.

bCheckMax​

A Boolean specifying whether to enable/disable detecting and displaying the maximum value.

The default value is True.

bCheckMin​

A Boolean specifying whether to enable/disable detecting and displaying the minimum value.

The default value is True.

bSave​

A Boolean specifying whether to save the detected max/min result into AreaMax/Min tab of the Watch Data Window.

The default value is False.

Return Code​

A Dictionary containing the Max/Min values.

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

# Detect the Max/Min value in the selected range
MaxMinArea = Post.AreaMaxMin(crlTargets=[Node(45, 53, 133, 132, 48, 130, 127, 39, 47, 38, 28, 46)])
print("The Max value in range is:", MaxMinArea['Max']['value']) 
print("The Min value in range is:", MaxMinArea['Min']['value'])
