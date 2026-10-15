# Calculation.TransResp.LoadCaseCondition()

Calculation.TransResp.LoadCaseCondition()

Description​

Create a load case for transient response analysis.

Syntax​

Calculation.TransResp.LoadCaseCondition(...)

Macro: DYNAMIC_TRANS_ANALYSIS_LOADCASE

Ribbon: Calculation » TransResp » LoadCaseCondition

Inputs​

crTargetAnalysis​

A Cursor specifying the target analysis to be create a load case. A new analysis is created if this parameter is set as None.

The default value is None.

strName​

A String specifying the name of load case to be created.

The default value is "LoadCase1".

dFactor​

A Double specifying the load coefficient for the entire load cases to be created.

The default value is 1.0.

iNewID​

An Integer specifying the ID of the load case to be created.

The default value is 1.

crlSelectedLoad​

A List of Cursor specifying the selected loads will be used in the load case to be created.

The default value is [].

dlTargetFactor​

A Double List specifying the coefficient for each selected load in the corresponding order.

The default value is [].

crEdit​

A Cursor specifying an existing load case condition

If this parameter is used, the specified load case condition will be modified.

If it is left None, a new load case condition will be created.

The default value is None.

Return Code​

A Cursor specifying the create transient load case condition.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Create a load condition
loadcondition = Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, 
                                                    dlForce=[0.0, 0.0, 10.0], dAmplitude=10, dT1=0.1, 
                                                    dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])

# Create a loadcase
loadcase = Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), strName="LoadCase_1",
                                                 crlSelectedLoad=[PostTransLoad(1)], dlTargetFactor=[1.0])
JPT.Debugger(loadcase)
