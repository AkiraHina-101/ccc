# Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV()

Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV()

Description​

Save the MPC results in CSV format.

Syntax​

Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV(...)

Macro: SaveMPCResultToCSV

Ribbon: Calculation » TransResp » MPFMCFCalculation » SaveMPCResultToCSV

Inputs​

crResponse​

A Cursor specifying the response to be saved.

The default value is None.

dTime​

A Double specifying the time at which the result will be saved.

The default value is 0.0.

strFilePath​

A String specifying the path of CSV file to be saved.

This is a required input.

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

# Total MPC
Calculation.TransResp.MPFMCFCalculation.TotalMPC(crResponse=PostTransResultCurve(1))

# Save MPC Result
resultFile = Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV(crResponse=PostTransResultCurve(1), 
                                                        dTime=-1, strFilePath="C:/temp/Total_MPF_Info.csv")
JPT.Debugger(resultFile)
