# Calculation.FreqResp.ResponseCondition()

Calculation.FreqResp.ResponseCondition()

Description​

Output the result of the response point for frequency response.

Syntax​

Calculation.FreqResp.ResponseCondition(...)

Macro: ResponseCondition

Ribbon: Calculation » FreqResp » ResponseCondition

Inputs​

crTargetAnalysis​

A Cursor specifying the target job to be processed.

The default value is None.

crCoordinate​

A Cursor specifying the output coordinate system.

The default value is None.

bAllModesUsed​

A Boolean specifying whether to use all modes.

The default value is True.

strlModesSelected​

A List of String specifying the selected modes using for response calculation. This option was used if bAllModesUsed is False.

The default value is [].

bDampingFactor​

A Boolean specifying whether to use damping factor for calculation.

The default value is True.

dDampingFactor​

A Double specifying the value of damping factor.

The default value is 0.01.

crDampingFactor​

A Cursor specifying the field data of damping factor.

The default value is None.

iCurveStyle​

An Integer specifying the style of time range for the calculation.

0: Start + StepNumber + StepSize

1: Start + StepSize + End

2: Start + StepNumber + End

The default value is 1.

dStyleParamTop​

A Double specifying the analysis start value of the selected curve style.

The default value is 0.0.

dStyleParamMid​

A Double specifying the step size value of the selected curve style.

The default value is 1.0.

dStyleParamBot​

A Double specifying the analysis end value of the selected curve style.

The default value is 1.0.

bIncludeEigenValue​

A Boolean specifying whether to plot the frequency of eigen value.

The default value is False.

bCreateNewResult​

A Boolean specifying whether to create new results (displacement and stress) for the entire model.

The default value is False.

iResultType​

An Integer specifying the result type to be calculated.

0: Displacement

1: Velocity

2: Acceleration

3: Stress (Solid)

4: Stress (Shell)

5: Disp. + Stress. This result type was displayed when bCreateNewResult = True.

The default value is 0.

strlResultNames​

A List of String specifying the component results according to the selected result type.

The default value is ["TX"].

iResultPosition​

An Integer specifying the output position of the result.

The default value is 0.

bAllLoadCases​

A Boolean specifying whether to use all current load cases.

The default value is True.

crSelectedLoadCase​

A Cursor specifying the selected load case to analyze. This option was used if bAllLoadCases is False.

The default value is None.

bSeparateLoad​

A Boolean specifying whether to calculate the response to each set load.

The default value is False.

crlTargets​

A List of Cursor specifying the target to calculate the response. The target is node or solid element.

This is a required input.

crEdit​

A Cursor specifying an existing response condition

If this parameter is used, the specified response condition will be modified.

If it is left None, a new response condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created frequency response condition.

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
                                                        crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(1), strChartTitle="Frequency Analysis Displacement", 
                strAxisTitleX="Frequency", strAxisTitleY="Amplitude", bNewChart=False)
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(3), strChartTitle="Frequency Analysis Displacement", 
                strAxisTitleX="Frequency", strAxisTitleY="Amplitude", bNewChart=False)
JPT.Debugger(respCondition) # for checking the return value
