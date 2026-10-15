# Calculation.TransResp.MPFMCFCalculation.AtTime()

Calculation.TransResp.MPFMCFCalculation.AtTime()

Description​

Display MPC result of specific time in Model Participation Factor dialog.

Syntax​

Calculation.TransResp.MPFMCFCalculation.AtTime(...)

Macro: CalculateMPCAtTime

Ribbon: Calculation » TransResp » MPFMCFCalculation » AtTime

Inputs​

crResponse​

A Cursor specifying the response to calculate MPC.

The default value is None.

dTime​

A Double specifying the time to calculate MPC.

The default value is 0.0.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Create a load condition
Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10, dT1=0.1, dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])

# Create a load case
Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), strName="LoadCase_1", 
                                        crlSelectedLoad=[PostTransLoad(1)], dlTargetFactor=[1.0])

# Create response condition
Calculation.TransResp.ResponseCondition(crTargetAnalysis=PostTransAnalysis(1), dDampingFactor=0.02, 
                                        iCurveStyle=0, dStyleParamMid=80.0, dStyleParamBot=0.0125, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostTransResultCurve(1), strChartTitle="Transient Analysis Displacement", 
                    strAxisTitleX="Time", strAxisTitleY="Data")
Chart.CreateGraph(crTargetCurve=PostTransResultCurve(3), strChartTitle="Transient Analysis Displacement", 
                    strAxisTitleX="Time", strAxisTitleY="Data", bNewChart=False)

# MPFMCF Calculation At Time
atTime = Calculation.TransResp.MPFMCFCalculation.AtTime(crResponse=PostTransResultCurve(1), dTime=0.1625)
JPT.Debugger(atTime)
