# Post.NStepsPlotForStrainGauge.DirectionCosine()

Post.NStepsPlotForStrainGauge.DirectionCosine()

Description​

Display a graph of the stress/strain in the direction cosine of the entered direction vector.

Syntax​

Post.NStepsPlotForStrainGauge.DirectionCosine(...)

Macro: CmdPlotStrainGaugeDirCos

Ribbon: Post » NStepsPlotForStrainGauge » DirectionCosine

Inputs​

crPostJob​

A Cursor specifying the processing post job.

This is a required input.

crlTargets​

A List of Cursor specifying the selected nodes to get the result and plot chart.

This is a required input.

listPostStepItem​

A List of POST_STEP_ITEM specifying the attributes of each Post Step Item.

The default value is POST_STEP_ITEM().

strXAxisType​

A String specifying the result type to plot on X-axis.

This is a required input.

strYAxisType​

A String specifying the result type to plot on Y-axis.

This is a required input.

dLength​

A Double specifying the length of the selection when the node is picked.

The default value is 0.0.

dWidth​

A Double specifying the width of the selection when the node is picked.

The default value is 0.0.

dAmendFactor​

A Double specifying the coefficient for correction that is used for strain analysis results.

The default value is 1.0.

dlDirection​

A List of Double specifying the direction vector in (X, Y, Z) format.

The default value is [1,0,0].

iPhaseType​

An Integer specifying the way to get the phase information when obtaining the strain (stress) in the specified direction for the frequency response result.

0: User Defined

1: Peak (Max)

2: Peak (Min)

The default value is 0.

dPhaseAngle​

A Double specifying the value of phase angle.

The default value is 0.0.

bCreateMarkup​

A Boolean specifying whether to markup label for the selected node when plotting graph.

The default value is True.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\111_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# NStepsPlotForStrainGauge > MaxMinPrincipal
plot = Post.NStepsPlotForStrainGauge.MaxMinPrincipal(crPostJob=TSVPostJob(1), 
                                                    listPostStepItem=[
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=1), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=2), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=3), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=4), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=5), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=6), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=7), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=8), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=9), 
                                                    PostStepItem(iAnalysisType=4, iResultSet=1, iTimeStep=10)], 
                                                    crlTargets=[Node(133, 132)], 
                                                    strXAxisType="Time/Freq(Default)", 
                                                    strYAxisType="Stress(Node)")
JPT.Debugger(plot)
