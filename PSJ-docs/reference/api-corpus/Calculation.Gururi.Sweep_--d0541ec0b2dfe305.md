# Calculation.Gururi.Sweep()

Calculation.Gururi.Sweep()

Description​

Output specified element/frequency result output to external file.

Syntax​

Calculation.Gururi.Sweep(...)

Macro: DYNAMIC_GURURI_ANALYSIS_SWEEP

Ribbon: Calculation » Gururi » Sweep

Inputs​

strExportPath​

A String specifying the path of result file to be exported.

This is a required input.

crlTargets​

A List of Cursor specifying the target solid elements.

This is a required input.

crTargetAnalysis​

A Cursor specifying the target job to be processed.

The default value is None.

crCoordinate​

A Cursor specifying the response points coordinate system.

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

dlInputFrequency​

A Double List specifying the frequency value for analysis.

The default value is [].

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

A Cursor specifying an existing Load condition

If this parameter is used, the specified Load condition will be modified.

If it is left None, a new Load condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created gururi sweep condition.

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

# Sweep calculation
sweepResponse = Calculation.Gururi.Sweep(strExportPath="C:/temp/SweepResult.csv", crlTargets=[ROElem(1486)], 
                                        crTargetAnalysis=PostFreqAnalysis(1), dlInputFrequency=[1000.0, 2000.0], 
                                        iStepNumber=30)
JPT.Debugger(sweepResponse)
