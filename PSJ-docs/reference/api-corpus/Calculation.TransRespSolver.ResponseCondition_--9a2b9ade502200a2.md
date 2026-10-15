# Calculation.TransRespSolver.ResponseCondition()

Calculation.TransRespSolver.ResponseCondition()

Description​

Output the result of the response point for transient response (Solver).

Syntax​

Calculation.TransRespSolver.ResponseCondition(...)

Macro:

Ribbon: Calculation » TransRespSolver » ResponseCondition

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

0: On Node

1: On Element

2: On Element Node

The default value is 0.

strDBFileName​

A String specifying the SunShine DB file (*.mdb).

The default value is "".

strDBVersion​

A String specifying the DB version.

The default value is "".

strMethodId​

A String specifying the method ID.

The default value is "".

strSPCID​

A String specifying the SPC ID.

The default value is "".

strMPCID​

A String specifying the MPC ID.

The default value is "".

iResidualVector​

An Integer specifying residual vector option.
0: No
1: Yes
2: Blank

The default value is 0.

strPath​

A String specifying the directory path used to store the result data (*.bdf file).

The default value is "".

crlTargets​

A List of Cursor specifying the target to calculate the response. The target is node or solid element.

The default value is [].

crEdit​

A Cursor specifying an existing response condition

If this parameter is used, the specified response condition will be modified.

If it is left None, a new response condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created transient response condition (Solver).

Sample Code​

# Prepare result model
inputPath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Command\\PostSample\\freq-solver\\103.bdf"
outputFolder = "C:\\temp"
JPT.RunSunShine(inputPath,outputFolder,2,1,False,True,False)

Home.ImportResults.Nastran(strPath = outputFolder + "\\103.op2", dFaceAngle=60.16, dEdgeAngle=60.16) 

# Create Transient Analysis Load - Solver
Calculation.TransRespSolver.LoadCondition(strName="TRNLoad_1", 
                                        iLoadDirection=2, 
                                        dlForce=[0.0, 0.0, 10.0], 
                                        dAmplitude=10.0, 
                                        crlTargets=[Node(514)])

# Create Transient Analysis Response - Solver
respCondition = Calculation.TransRespSolver.ResponseCondition(crTargetAnalysis=PostTransAnalysisSolver(1), 
                                                            bDampingFactor=False, 
                                                            dDampingFactor=0.02, 
                                                            iCurveStyle=2, 
                                                            dStyleParamMid=20.0, 
                                                            dStyleParamBot=5000.0, 
                                                            strlResultNames=["TZ"], 
                                                            strDBFileName="103", 
                                                            strDBVersion="1", 
                                                            strMethodId="2", 
                                                            strPath="C:/temp/111.bdf", 
                                                            crlTargets=[Node(517)])
JPT.Debugger(respCondition) # for checking the return value
