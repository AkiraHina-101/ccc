# Tools.ContourCopy()

Tools.ContourCopy()

Description​

Display the contour of the current Post document in the specified Pre document.

Syntax​

Tools.ContourCopy(...)

Macro: ContourCopy

Ribbon: Tools » ContourCopy

Inputs​

strPostDocName​

A String specifying the Post document name to copy the contour.

This is a required input.

strPreDocName​

A String specifying the Pre document name to be copied the contour.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)

# Prepare Pre model
Tools.ToPre(strName="101_solid", ilOptions=[0, 1, 2, 3, 4])
# Plot the result
JPT.SetActiveDocumentByName("101_solid",1)
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=1, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=1, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))
Post.EnableMiddleNodes()

# Copy contour
dataCopy = Tools.ContourCopy(strPostDocName="101_solid", strPreDocName="101_solid_Converted_Pre")
JPT.Debugger(dataCopy)
