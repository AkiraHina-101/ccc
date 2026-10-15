# Post.Plot.DistancePlot()

Post.Plot.DistancePlot()

Description​

Display the distance between two nodes in multiple steps as a step or time history graph.

Syntax​

Post.Plot.DistancePlot(...)

Macro: CmdDistancePlot

Ribbon: Post » Plot » DistancePlot

Inputs​

crFirstNode​

A Cursor specifying the first selected node.

This is a required input.

crSecondNode​

A Cursor specifying the second selected node.

This is a required input.

listPostStepItem​

A List of POST_STEP_ITEM specifying the attributes of each Post Step Item.

The default value is POST_STEP_ITEM().

bDistanceXYZ​

A Boolean specifying whether to display the distance in X, Y and Z direction when plotting.

The default value is False.

bPositionXYZ​

A Boolean specifying whether to display the coordinate values of the first and second nodes in the X, Y, and Z directions when plotting.

The default value is False.

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
Post.Plot.DistancePlot(crFirstNode=Node(127), crSecondNode=Node(133), 
                        listPostStepItem=[
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=1), 
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=2), 
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=3), 
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=4), 
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=5)], 
                        bDistanceXYZ=True)
JPT.SetActiveDocumentByName("103_solid",1)

# Distance Plot (X,Y,Z Position Plot)
Post.Plot.DistancePlot(crFirstNode=Node(127), crSecondNode=Node(133), 
                        listPostStepItem=[PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=1), 
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=2), 
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=3), 
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=4), 
                        PostStepItem(iAnalysisType=2, iResultSet=1, iTimeStep=5)], 
                        bPositionXYZ=True)
