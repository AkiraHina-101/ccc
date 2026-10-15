# Analysis.AbaqusStep.TransientStep()

Analysis.AbaqusStep.TransientStep()

Description​

Create Abaqus step for Transient analysis.

Syntax​

Analysis.AbaqusStep.TransientStep(...)

Ribbon: Analysis » Abaqus

Inputs​

strName​

A String specifying the Transient step name.

This is a required input.

strDesp​

A String specifying the step description of the Transient analysis.

The default value is "".

iEnableAutomatic​

An Integer specifying the automatic increment method.

The default value is 0.

iMaxInc​

An Integer specifying the maximum number of increment.

The default value is 0.

dInitSize​

A Double specifying the initial increment value.

The default value is DFLT_DBL.

dMinSize​

A Double specifying the minimum increment value.

The default value is DFLT_DBL.

dMaxSize​

A Double specifying the maximum increment value.

The default value is DFLT_DBL.

dMaxAllowTChange​

A Double specifying the maximum allowable change.

The default value is DFLT_DBL.

iEndsteptBchecked​

An Integer specifying whether or not using End the step when the change is less than the dlEndsteptTlist.

The default value is 0.

dlEndsteptTlist​

A Double List specifying the end step value list.

The default value is [].

dMaxAllowEmissivityChange​

A Double specifying the maximum allowable emissivity change per increment.

The default value is DFLT_DBL.

iMethod​

An Integer specifying the solver.
0: Direct

1: Iterative

The default value is 0.

iMatrixStorage​

An Integer specifying the matrix storage setting.
0: Default

1: Unsymmetric

2: Symmetric

The default value is 0.

iSolutionTech​

An Integer specifying the solution technique.
0: Full Newton

1: Quasi-Newton

2: Contact iterations

The default value is 0.

iAllowedIters​

An Integer specifying the number of iterations allowed before the kernel matrix is reformed.

The default value is 0.

dAdjustFactor​

An Integer specifying the adjustment factor for the number of solutions in each iteration.

The default value is DFLT_DBL.

iMaxContactIter​

An Integer specifying the maximum number of contact iterations.

The default value is 0.

iEnableNlgeom​

An Integer specifying whether or not to consider geometric nonlinear (large deformation) analysis.

The default value is 0.

dTimePeriod​

A Double specifying the analysis time.

The default value is DFLT_DBL.

iConvertDscntIter​

An Integer specifying the conversion of severe discontinuity iterations.

The default value is 0.

iRamp​

An Integer specifying the number of linear change over step.

The default value is 0.

iExtrapolateMethod​

An Integer specifying the Extrapolate previous state at start of each increment.

The default value is 0.

listAbaqusOutputRequest​

An ABAQUS_OUTPUT_REQUEST list specifying the list of Abaqus output request.

The default value is ABAQUS_OUTPUT_REQUEST.

crEdit​

A Cursor specifying an existing Abaqus step.
If this parameter is used, the specified step will be modified.

If it is left None, a new step will be created.

The default value is None.

Return Code​

A Cursor specifying the newly created or the modified Abaqus Transient step.

Sample Code​

process = Analysis.AbaqusStep.TransientStep(strName="Step1", iMaxInc=100, dInitSize=1.0,
  dMinSize=1e-05, dMaxSize=1.0, dMaxAllowEmissivityChange=0.1, iAllowedIters=8,
  dAdjustFactor=1.0, iMaxContactIter=30, dTimePeriod=1.0, iRamp=1, listAbaqusOutputRequest=[])

print("Result Dynamic Process has ID: " + str(process)) #for checking return value
