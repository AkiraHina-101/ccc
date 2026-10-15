# NASTRAN_ANALYSIS

NASTRAN_ANALYSIS

Description​

A data type uses to control parameters of Nastran Analysis

Attributes​

iSolverType​

An Integer specifying solver type.
0: Unknown solver type.

1: MSC Nastran solver type.

2: NX Nastran solver type.

3: Dynamic solver type.

4: Dynamic solver type for Designer.

5: Abaqus solver type.

6: Sunshine Solver type.

7: Sunshine Solver type for Designer.

The default value is 0.

iWriteType​

An Integer specifying the writing type of solver input file.
0: Writing by model.

1: Writing by each body.

2: Writing by bodies.

The default value is 0.

iGridFormatType​

An Integer specifying the Grid output format.
0: Single. Small field format output.

1: Double. Large field format output.

2: Single F.P. Specify the floating-point number small field format output.

The default value is 0.

bDeleteFloatingNodes​

A Boolean enable/disable delete floating nodes at the time of exporting output data.

The default value is False.

bContinuanceMarker​

A Boolean enable/disable Output the continuation pointer + at the time of exporting output data.

The default value is False.

bDefineLbcId​

A Boolean enable/disable the input load, single point contraint and multi-point contraint ID.

The default value is False.

iDefinedLoadId​

An Integer specifying defined load ID.

The default value is 0.

iDefinedSpcId​

An Integer specifying defined single point contraint ID.

The default value is 0.

iDefinedMpcId​

An Integer specifying multi-point contraint ID.

The default value is 0.

bUniqueLbcId​

A Boolean enable/disable the unique boundary ID option.

The default value is False.

bUseCASI​

A Boolean enable/disable Direct solution/Iterative solution.

The default value is False.

dEpsilon​

A Double specifying the convergence parameter in the iterative method.

The default value is 0.0.

iMaxNumOfIter​

An Integer specifying maximum number of iterator.

The default value is 0.

iNumberOfThreads​

An Integer specifying number of threads which use for parallelize.

The default value is 0.

iMemory​

An Integer specifying Define the memory allocation amount(MB).

The default value is 0.

bParamInrel​

A Boolean enable/disable initia relief option which use to simulate unconstrained structures in a static analysis .

The default value is False.

iNcpu​

An Integer specifying number of CPU.

The default value is 0.

iSolNo​

An Integer specifying solver number.

The default value is 0.

strIncludeFilePath​

A String specifying include bdf file path.

The default value is "".

nastranEigen​

A NASTRAN_EIGEN specifying the  Eigenvalues parameter of normal mode Nastran analysis .

The default value is NASTRAN_EIGEN().

nastranEigen126​

A NASTRAN_EIGEN126 specifying the eigenvalue parameter of Nastran nonlinear frequency analysis.

The default value is NASTRAN_EIGEN126().

nastranFrequency​

A NASTRAN_FREQUENCY specifying the frequency range and number of modes for eigenvalue extraction.

The default value is NASTRAN_FREQUENCY().

nastranFreqTimestep​

A NASTRAN_FREQ_TIMESTEP specifying the response frequency setting.

The default value is NASTRAN_FREQ_TIMESTEP().

nastranOutputRequest​

A NASTRAN_OUTPUT_REQUEST specifying the output request of solver.

The default value is NASTRAN_OUTPUT_REQUEST().

nastranExecControl​

A NASTRAN_EXEC_CONTROL specifying the executive control option.

The default value is NASTRAN_EXEC_CONTROL().

nastranCaseControl​

A NASTRAN_CASE_CONTROL specifying the Case Control Option.

The default value is NASTRAN_CASE_CONTROL().

nastranMainLbcSet​

A NASTRAN_MAIN_LBC_SET specifying main boundary condition setting.

The default value is NASTRAN_MAIN_LBC_SET().

nastranSettings​

A NASTRAN_SETTINGS specifying the nastran settings.

The default value is NASTRAN_SETTINGS().

nastranNonlinear​

A NASTRAN_NONLINEAR specifying the nastran nonlinear setting.

The default value is NASTRAN_NONLINEAR().

nastranNonlinearTimestep​

A NASTRAN_NONLINEAR_TIMESTEP specifying the nastran nonlinear timestep setting.

The default value is NASTRAN_NONLINEAR_TIMESTEP().

nastranSubcase​

A NASTRAN_SUBCASE specifying the subcases.

The default value is [].

strSystemCellText​

A String specifying directly the card to Nastran (System) section.

The default value is "".

strFileManagementText​

A String specifying directly the text data in file management statement section.

The default value is "".

strExecutiveControlText​

A String specifying directly the text data to the executive control section.

The default value is "".

strGlobalCaseControlText​

A String specifying directly the global case control text to solver input file.

The default value is "".

strBulkDataText​

A String specifying directly the bulk data text to solver input file.

The default value is "".
