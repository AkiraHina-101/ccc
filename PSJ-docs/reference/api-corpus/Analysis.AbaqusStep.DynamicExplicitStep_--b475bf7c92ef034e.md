# Analysis.AbaqusStep.DynamicExplicitStep()

Analysis.AbaqusStep.DynamicExplicitStep()

Description​

Create Abaqus Step - Dynamic Explicit Type.

Syntax​

Analysis.AbaqusStep.DynamicExplicitStep(...)

Ribbon: Analysis » Abaqus

Inputs​

strName​

A String specifying the Dynamic Explicit step name.

This is a required input.

strDesp​

A String specifying the step description of Dynamic Explicit analysis.

The default value is "".

iEnableAutomatic​

An Integer specifying the increment method.

The default value is 1.

iIncrmtEstimator​

An Integer specifying the use of the stable increment estimator.

0: Global

1: Element by element

The default value is 0.

abaqusPair1​

An ABAQUS_PAIR specifying the maximum time increment value.

The default value is ABAQUS_PAIR.

dTimeScalfactor​

A Double specifying the time scaling factor.

The default value is 1.0.

abaqusPair2​

A ABAQUS_PAIR specifying the user-defined time increment.

The default value is ABAQUS_PAIR.

iEnableNlgeom​

An Integer specifying whether or not to consider geometric nonlinear (large deformation) analysis.

0: Not consider

1: Consider

The default value is 1.

dTimePeriod​

A Double specifying the analysis time.

The default value is 1.0.

iEnableIncludeHeatEffect​

An Integer specifying whether or not include adiabatic heating effects.

The default value is 0.

dLinearBlkVisco​

A Double specifying the linear bulk viscosity parameter.

The default value is 0.06.

dQuadrBlkVisco​

A Double specifying the quadratic bulk viscosity parameter.

The default value is 1.2.

listAbaqusOutputRequest​

An ABAQUS_OUTPUT_REQUEST list specifying the list of Abaqus output request.

The default value is ABAQUS_OUTPUT_REQUEST.

crEdit​

A Cursor specifying an existing Abaqus step.

If this parameter is used, the specified step will be modified.

If it is left None, a new step will be created.

The default value is None.

Return Code​

A Cursor specifying the newly created or the modified Abaqus Dynamic Explicit step.

Sample Code​

process = Analysis.AbaqusStep.DynamicExplicitStep(strName="Step1",
  abaqusPair1=ABAQUS_PAIR(dlTList=[0.0]), listAbaqusOutputRequest=[])

print("Result Dynamic Process has ID: " + str(process)) #for checking return value
