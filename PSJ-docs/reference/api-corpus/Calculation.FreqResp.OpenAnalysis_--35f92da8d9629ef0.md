# Calculation.FreqResp.OpenAnalysis()

Calculation.FreqResp.OpenAnalysis()

Description​

Load the results of a frequency response analysis (*.tsdv).

Syntax​

Calculation.FreqResp.OpenAnalysis(...)

Macro: CmdSaveOpenTsdv

Ribbon: Calculation » FreqResp » OpenAnalysis

Inputs​

strPath​

A String specifying the path of file will be opened.

This is a required input.

bBdfMode​

A Boolean specifying whether to use BDF mode.

The default value is False.

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
                                        dStyleParamMid=10.0, dStyleParamBot=200.0, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])

# Close current document and import the result file again
JPT.CloseDocumentByName("plate_eigen")
JPT.CreateNewDocument()
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Open the saved analysis (Please set path to your temp folder and saved analysis file.)
openFile = Calculation.FreqResp.OpenAnalysis(strPath="C:/temp/TransRespAnalysis.tsdv")
JPT.Debugger(openFile)
