# Post.PartialContour()

Post.PartialContour()

Description​

Show contour only on the selected entities.

Syntax​

Post.PartialContour(...)

Macro: DisplayPartialContour

Ribbon: Post » PartialContour

Inputs​

crlTargets​

A List of Cursor specifying the targets to be displayed with contour. The targets can be part, face, bar, node, element, or groups.

This is a required input.

bUsePartColor​

A Boolean specifying whether to display part color on the unselected entities.

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

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

# Display contour only on Part(3)
Post.PartialContour(crlTargets=[Part(3)])
