# Analysis.AbaqusStep.ModalStep()

Analysis.AbaqusStep.ModalStep()

Description​

Create Abaqus Step - Modal Type.

Syntax​

Analysis.AbaqusStep.ModalStep(...)

Ribbon: Analysis » AbaqusStep » ModalStep

Inputs​

strName​

A String specifying the Modal step name.

This is a required input.

strDesp​

A String specifying the step description of Modal analysis.

The default value is "".

iEigenSolver​

An Integer specifying the Modal analysis method.
0: Lanczos

1: Subspace

The default value is 0.

iNFreqRequestbchecked​

An Integer specifying the number of modes to obtain.
0: Obtain all modes in the frequency range.

Other: specify the number of modes to obtain.

The default value is 0.

ilNFreqRequestTList​

A List of Integer specifying the frequency range.

The default value is [].

iFreqShiftbchecked​

An Integer specifying the frequency shift value (cycles/time)2(cycles/time)^2(cycles/time)2.

The default value is 0.

ilFreqShiftTList​

A List of Integer specifying the the frequency shift range.

The default value is [].

iFreqRangebchecked​

An Integer specifying the minimum frequency of interest (cycles/time)(cycles/time)(cycles/time).

The default value is 0.

ilFreqRangeTList​

A List of Integer specifying the minimum frequency of interest value list.

The default value is [].

iIncldAcoustic​

An Integer specifying the inclusion of acoustic-structural coupling.

The default value is 0.

iBlockSizebchecked​

An Integer specifying whether or not use block size.

The default value is 0.

ilBlockSizeTList​

A List of Integer specifying the block size value list.

The default value is [].

iMaxBlkNumofLanczosStepbchecked​

An Integer specifying the maximum number of block Lanczos steps.

The default value is 0.

ilMaxBlkNumofLanczosStepTList​

A List of Integer specifying the maximum number of block Lanczos steps value list.

The default value is [].

iEnableUseSIM​

An Integer specifying the usage of SIM-Based linear dynamic procedures.

The default value is 0.

iEnableIncludeResMods​

An Integer specifying the inclusion of residual modes.

The default value is 0.

iNEigenRequest​

An Integer specifying the number of modes request.

The default value is 2147483647.

iMaxItersUsed​

An Integer specifying the number of iterations allowed before the kernel matrix is reformed.

The default value is 30.

iVectorsUsed​

An Integer specifying the number of vectors used in the iteration.

The default value is 2147483647.

iMethod​

An Integer specifying the solver method.
0: Direct.

1: Iterative.

The default value is 0.

iMatrixStorage​

An Integer specifying how to store the matrix.
0: Default

1: Unsymmetric

2: Symmetric

The default value is 0.

iNormalizeEigenBy​

An Integer specifying the normalization of eigenvectors.
0: Displacement

1: Mass

The default value is 1.

iEvalPropFreqbchecked​

An Integer specifying the frequency for evaluating frequency dependent properties.

The default value is 0.

ilEvalPropFreqTList​

A List of Integer specifying the frequency for evaluating frequency dependent properties value list.

The default value is [].

abaqusOutputRequest​

An ABAQUS_OUTPUT_REQUEST list specifying the list of Abaqus output request.

The default value is ABAQUS_OUTPUT_REQUEST.

crEdit​

A Cursor specifying an existing Abaqus step.
If this parameter is used, the specified step will be modified.

If it is left None, a new step will be created.

The default value is None.

Return Code​

A Cursor specifying the newly created or the modified Abaqus Modal step.

Sample Code​

process = Analysis.AbaqusStep.ModalStep(strName="Step1", ilNFreqRequestTList=[DFLT_INT],
  ilFreqShiftTList=[DFLT_DBL], ilFreqRangeTList=[DFLT_DBL, DFLT_DBL],
  ilBlockSizeTList=[DFLT_DBL], ilMaxBlkNumofLanczosStepTList=[0], ilEvalPropFreqTList=[DFLT_DBL])

print("Result Dynamic Process has ID: " + str(process)) #for checking return value
