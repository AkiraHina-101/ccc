# Post.Plot.NStepsPlot()

Post.Plot.NStepsPlot()

Description​

Get results within multiple subcases for a particular node/element/arbitrary point and plot the graph by steps or time history.

Syntax​

Post.Plot.NStepsPlot(...)

Macro: CmdNStepPlotNode,
CmdNStepPlotElement,
CmdNStepPlotPoint

Ribbon: Post » Plot » NStepsPlot

Inputs​

crPostJob​

A Cursor specifying the processing post job.

This is a required input.

crlTargets​

A List of Cursor specifying the selected nodes to plot graph.

This is a required input.

listPostStepItem​

A List of POST_STEP_ITEM specifying the attributes of each Post Step Item.

The default value is POST_STEP_ITEM().

bCreateMarkup​

A Boolean specifying whether to markup label for the selected note when plotting graph.

The default value is True.

strXResult​

A String specifying the result type to display on the X-axis.

The default value is "".

strXComponent​

A String specifying the direction of the selected result to display on the X-axis.

The default value is "".

iDataLocation​

An Integer specifying the data location (Node & Element) that the result will display on.

The default value is 0.

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
Post.Plot.NStepsPlot(crPostJob=TSVPostJob(1), crlTargets=[Node(133)], listPostStepItem=[
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=1), 
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=2), 
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=3), 
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=4), 
                    PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=5)], 
                    strXResult="Displacement", 
                    strXComponent="Translational", 
                    iDataLocation=1)
