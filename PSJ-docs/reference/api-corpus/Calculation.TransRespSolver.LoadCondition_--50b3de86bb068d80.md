# Calculation.TransRespSolver.LoadCondition()

Calculation.TransRespSolver.LoadCondition()

Description​

Set the arbitrary excitation input for transient response (Solver).

Syntax​

Calculation.TransRespSolver.LoadCondition(...)

Macro:

Ribbon: Calculation » TransRespSolver » LoadCondition

Inputs​

crTargetAnalysis​

A Cursor specifying the target analysis. A new analysis is created if this parameter is set as None.

The default value is None.

crCoordinate​

A Cursor specifying the output coordinate system.

The default value is None.

strName​

A String specifying the name of load condition to be created.

The default value is "TRNLoad".

iLoadType​

An Integer specifying the load type.

0: Table(TLOAD1)

1: Cosine(TLOAD2)

The default value is 0.

iResultType​

An Integer specifying the result type.

0: Force

1: Displacement

2: Velocity

3: Acceleration

The default value is 0.

iLoadDirection​

An Integer specifying the direction of vibration.

0: X

1: Y

2: Z

3: RX

4: RY

5: RZ

6: Normal

The default value is 0.

dlForce​

A List of Double specifying the vector of vibration force.

The default value is [1,0,0].

dAmplitude​

A Double specifying the amplitude of vibration force.

The default value is 1.0.

dInitialDisplacement​

A Double specifying the initial displacement.

The default value is 0.0.

dInitialVelocity​

A Double specifying the initial displacement.

The default value is 0.0.

dT1​

A Double specifying the vibration start time of load type Cosine(TLOAD2).

The default value is 0.0.

dT2​

A Double specifying the vibration end time of load type Cosine(TLOAD2).

The default value is 1.0.

dFrequency​

A Double specifying the value of frequency in load type Cosine(TLOAD2).

The default value is 0.0.

dPhase​

A Double specifying the value of phase delay (angle) in load type Cosine(TLOAD2)

The default value is 0.0.

dExponent​

A Double specifying the value of exponential function in load type Cosine (TLOAD2).

The default value is 0.0.

dPower​

A Double specifying the value of growth factor in load type Cosine (TLOAD2).

The default value is 0.0.

bFt​

A Boolean specifying whether to use the time history load as inputted value or table.

The default value is False.

dFt​

A Double specifying the value of the time history load.

The default value is 0.0.

crFtCurve​

A Cursor specifying the field data of the time history load.

The default value is None.

crlTargets​

A List of Cursor specifying the selected nodes which can be assigned the load condition.

The default value is [].

crEdit​

A Cursor specifying an existing Load condition

If this parameter is used, the specified Load condition will be modified.

If it is left None, a new Load condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created transient load condition (Solver).

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Command\\PostSample\\freq-solver\\103.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Create Transient Analysis Load - Solver
loadCondition = Calculation.TransRespSolver.LoadCondition(strName="TRNLoad_1", 
                                                        iLoadDirection=2, 
                                                        dlForce=[0.0, 0.0, 10.0], 
                                                        dAmplitude=10.0, 
                                                        crlTargets=[Node(514)])
JPT.Debugger(loadCondition) # for checking the return value
