# Post.Plot.MaxMinPlot()

Post.Plot.MaxMinPlot()

Description​

Display the maximum/minimum values in multiple steps on the graph in steps or time history.

Syntax​

Post.Plot.MaxMinPlot(...)

Macro: CmdMaxMinPlot

Ribbon: Post » Plot » MaxMinPlot

Inputs​

listPostStepItem​

A List of POST_STEP_ITEM specifying the attributes of each Post Step Item.

The default value is POST_STEP_ITEM().

bExportCSV​

A Boolean specifying whether to export the result to CSV file.

The default value is False.

strExportCSVPath​

A String specifying the path of CSV file to be exported.

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

# Distance Plot (X,Y,Z Distance Plot)
Post.Plot.MaxMinPlot(listPostStepItem=[
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=1), 
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=2), 
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=3), \
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=4), 
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=5)], 
                    bExportCSV=False)
