# Calculation.TransResp.OpenAnalysis()

Calculation.TransResp.OpenAnalysis()

Description​

Load the results of a transient response analysis (*.tsdv).

Syntax​

Calculation.TransResp.OpenAnalysis(...)

Macro: CmdSaveOpenTsdv

Ribbon: Calculation » TransResp » OpenAnalysis

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
loadcondition = Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, 
                                                    dlForce=[0.0, 0.0, 10.0], dAmplitude=10, dT1=0.1, 
                                                    dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])

# Create a loadcase
loadcase = Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), 
                                                    strName="LoadCase_1", 
                                                    crlSelectedLoad=[PostTransLoad(1)], 
                                                    dlTargetFactor=[1.0])

# Create response condition
Calculation.TransResp.ResponseCondition(crTargetAnalysis=PostTransAnalysis(1), dDampingFactor=0.02, 
                                        iCurveStyle=0, dStyleParamMid=80.0, dStyleParamBot=0.0125, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])

# Save Analysis
Calculation.TransResp.SaveAnalysis(strPath="C:/temp/TransRespAnalysis.tsdv", 
                                    crlTargets=[PostTransAnalysis(1)])

# Close current document and import the result file again
JPT.CloseDocumentByName("plate_eigen")
JPT.CreateNewDocument()
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Open the saved analysis
openFile = Calculation.TransResp.OpenAnalysis(strPath="C:/temp/TransRespAnalysis.tsdv")
JPT.Debugger(openFile)
