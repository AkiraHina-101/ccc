# Calculation.Gururi.Response()

Calculation.Gururi.Response()

Description​

Output the Gururi result of the response point.

Syntax​

Calculation.Gururi.Response(...)

Macro: DYNAMIC_GURURI_ANALYSIS_RESPONSE

Ribbon: Calculation » Gururi » Response

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

The default value is 1.0.

crDampingFactor​

A Cursor specifying the field data of damping factor.

The default value is None.

dInputFrequency​

A Double specifying the frequency value for analysis.

The default value is 0.0.

dStartPhrase​

A Double specifying the starting phase to analyze.

The default value is 0.0.

iStepNumber​

An Integer specifying the number division of one cycle.

The default value is 10.

bOutputMaximumGururiResult​

A Boolean specifying whether to output the maximum result of the selected Principal type and store it in a separated tree of assembly window.

The default value is True.

iPrincipalType​

An Integer specifying the principal result type that will be analyzed.

The default value is 3.

bAllLoadCases​

A Boolean specifying whether to use all current load cases.

The default value is True.

crSelectedLoadCase​

A Cursor specifying the selected load case to analyze. This option was used if bAllLoadCases is False.

The default value is None.

crEdit​

A Cursor specifying an existing response condition

If this parameter is used, the specified response condition will be modified.

If it is left None, a new response condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created gururi response condition.

Sample Code​

# Please set path to your result sample file
samplePath = "C:/Temp/Sample.op2"

# Prepare result model
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60, dEdgeAngle=60)

# Create a load condition
Calculation.Gururi.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                dAmplitude=10.0, crlTargets=[Node(501)])

# Create a load case
loadCase = Calculation.Gururi.LoadCase(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                        crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# Response calculation
response = Calculation.Gururi.Response(crTargetAnalysis=PostFreqAnalysis(1), dInputFrequency=180.0, 
                                        iStepNumber=30)
JPT.Debugger(response)
