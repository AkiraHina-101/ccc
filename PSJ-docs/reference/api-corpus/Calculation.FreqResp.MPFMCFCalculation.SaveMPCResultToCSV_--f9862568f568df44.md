# Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV()

Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV()

Description​

Save.

Syntax​

Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV(...)

Macro: SaveMPCResultToCSV

Ribbon: Calculation » FreqResp » MPFMCFCalculation » SaveMPCResultToCSV

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
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)])

# Create a load case
Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# Create a response condition
Calculation.FreqResp.ResponseCondition(crTargetAnalysis=PostFreqAnalysis(1), dDampingFactor=0.02, 
                                        dStyleParamMid=10.0, dStyleParamBot=200.0, strlResultNames=["TZ"], 
                                        crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(1), strChartTitle="Frequency Analysis Displacement", 
                strAxisTitleX="Frequency", strAxisTitleY="Amplitude")
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(3), strChartTitle="Frequency Analysis Displacement", 
                strAxisTitleX="Frequency", strAxisTitleY="Amplitude", bNewChart=False)

# MPFMCF calculation at frequency 
Calculation.FreqResp.MPFMCFCalculation.AtFrequency(crResponse=PostFreqResultCurve(3), dFrequency=70.0) 

# Save MPC result
resultFile = Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV(crResponse=PostFreqResultCurve(3), 
                                                                        dTime=-1, 
                                                                        strFilePath="C:/temp/Total_MPF_Info.csv")
JPT.Debugger(resultFile)
