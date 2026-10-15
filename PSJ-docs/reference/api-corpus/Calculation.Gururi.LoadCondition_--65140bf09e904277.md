# Calculation.Gururi.LoadCondition()

Calculation.Gururi.LoadCondition()

Description​

Set the frequency response steady-state excitation input for the Gururi.

Syntax​

Calculation.Gururi.LoadCondition(...)

Macro: DYNAMIC_FREQ_ANALYSIS_LOAD

Ribbon: Calculation » Gururi » LoadCondition

Inputs​

crTargetAnalysis​

A Cursor specifying the target analysis. A new analysis is created if this parameter is set as None.

The default value is None.

crCoordinate​

A Cursor specifying the coordinate system.

The default value is None.

strName​

A String specifying the name of load condition to be created.

The default value is "FRQLOAD1".

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

bUnitLoad​

A Boolean specifying whether to create a load and load case under the condition that each selected node is subjected to unit vibration.

The default value is False.

bCentrifugalForce​

A Boolean specifying whether to use the centrifugal force.

The default value is False.

crlTargets​

A List of Cursor specifying the selected nodes which can be assigned the load condition.

This is a required input.

crEdit​

A Cursor specifying an existing load condition

If this parameter is used, the specified load condition will be modified.

If it is left None, a new load condition will be created.

The default value is None.

Return Code​

A Cursor specifying the created gururi load condition.

Sample Code​

# Please set path to your result sample file
samplePath = "C:/Temp/Sample.op2"

# Prepare result model
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60, dEdgeAngle=60)

# Create a load condition
loadcondition = Calculation.Gururi.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, 
                                                dlForce=[0.0, 0.0, 10.0], dAmplitude=10.0, 
                                                crlTargets=[Node(501)])
JPT.Debugger(loadcondition)
