# Calculation.FreqRespSolver.LoadCondition()

Calculation.FreqRespSolver.LoadCondition()

Description​

Set the steady-state excitation input for frequency response (Solver).

Syntax​

Calculation.FreqRespSolver.LoadCondition(...)

Macro: DYNAMIC_FREQ_ANALYSIS_LOAD_SOLVER

Ribbon: Calculation » FreqRespSolver » LoadCondition

Inputs​

iAnalysisType​

An Integer specifying the analysis type.

The default value is 0.

crTargetAnalysis​

A Cursor specifying the target analysis. A new analysis is created if this parameter is set as None.

The default value is None.

crCoordinate​

A Cursor specifying the output coordinate system.

The default value is None.

strName​

A String specifying the name of load condition to be created.

The default value is "FRQLOAD".

iLoadDirection​

An Integer specifying the direction of vibration.

The default value is 0.

dlForce​

A List of Double specifying the vector of vibration force.

The default value is [1,0,0].

dAmplitude​

A Double specifying the amplitude of vibration force.

The default value is 1.0.

dDelay​

A Double specifying the value of time delay (seconds).

The default value is 0.0.

dPhase​

A Double specifying the value of phase delay (angle).

The default value is 0.0.

bBf​

A Boolean specifying whether to use frequency-dependent load as Table input.

The default value is False.

dBf​

A Double specifying the value of frequency-dependent load (Bf).

The default value is 1.0.

crBfCurve​

A Cursor specifying the field data of frequency-dependent load.

The default value is None.

bFf​

A Boolean specifying whether to use frequency-dependent phase as Table input.

The default value is False.

dFf​

A Double specifying the value of Frequency-dependent phase.

The default value is 0.0.

crFfCurve​

A Cursor specifying the field data of frequency-dependent phase.

The default value is None.

crlTargets​

A List of Cursor specifying the selected nodes which can be assigned the load condition.

The default value is [].

iLoadType​

An Integer specifying the load type.

0: Force

1: Displacement

2: Velocity

3: Acceleration

The default value is 0.

crEdit​

A Cursor specifying an existing load condition

If this parameter is used, the specified load condition will be modified.

If it is left None, a new load condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created frequency load condition (Solver).

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Command\\PostSample\\freq-solver\\103.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Create Frequency Analysis Load - Solver
loadCondition = Calculation.FreqRespSolver.LoadCondition(strName="FRQLoad_1", 
                                                        iLoadDirection=2, 
                                                        dlForce=[0.0, 0.0, 10.0], 
                                                        dAmplitude=10.0, 
                                                        crlTargets=[Node(514)])
JPT.Debugger(loadCondition) # for checking the return value
