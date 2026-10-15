# CmdExportLoad()

CmdExportLoad()

Description​

Export the selected result name to solver information (as solver keyword card) for the selected entities. Depending on selection of convert load type, the analysis result will be exported to solver card information respectively.

Syntax​

CmdExportLoad(cursor[] Targets, int AnalysisType, int ResultSet, int TimeStep, vector ResultLoad, int SolverType, string ExportPath)

Inputs​

1. cursor[]​

A Cursor List specifying the selected entities.

2. int​

Choose type of analysis.

3. int​

An Integer specifying the set of results.

4. int​

An Integer specifying the time step.

5. vector​

A Vector of RESULT_LOAD specifying the components of the selected result.

6. int​

An Integer specifying the solver type.

7. string​

A String specifying the path of file to be exported.

Return Code​

"1": The function can be executed.

"0": The function cannot be executed.

Sample Code​

CmdExportLoad([3:1,3:2,3:3], 0, 0, 0, [], 2, "C:/temp/ResultToLoadFile")
