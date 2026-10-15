# Chart.CreateGraph()

Chart.CreateGraph()

Description​

Make a graph of post result curve.

Syntax​

Chart.CreateGraph(...)

Macro: PostCreateGraph

Ribbon: Chart » CreateGraph

Inputs​

crTargetCurve​

A Cursor specifying the post result curve.

The default value is None.

iNumData​

An Integer specifying the number of data markers to plot the graph.

The default value is 0.

strLineTitle​

A String specifying the chart line title.

The default value is "".

dlAxisDataX​

A List of Double specifying the data value on X-Axis.

The default value is [].

dlAxisDataY​

A List of Double specifying the data value on Y-Axis.

The default value is [].

strChartTitle​

A String specifying the chart title.

The default value is "".

strAxisTitleX​

A String specifying the X-axis title.

The default value is "".

strAxisTitleY​

A String specifying the Y-axis title

The default value is "".

bNewChart​

A Boolean specifying whether to plot graph on a new chart window

The default value is True.

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 

# Create a load condition
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)]) 

# Create a load case
Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                    crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# Create a response condition
respCondition = Calculation.FreqResp.ResponseCondition(crTargetAnalysis=PostFreqAnalysis(1), 
                                                        dDampingFactor=0.02, dStyleParamMid=10.0, 
                                                        dStyleParamBot=200.0, strlResultNames=["TZ"], 
                                                        crlTargets=[Node(1516)])

# Plot chart
newChart = Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(1), 
                            strChartTitle="Frequency Analysis Displacement", 
                            strAxisTitleX="Frequency", 
                            strAxisTitleY="Amplitude", 
                            bNewChart=False)
JPT.Debugger(newChart)
