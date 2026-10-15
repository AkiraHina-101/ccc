# CmdExportLoad()

CmdExportLoad()

Description​

Export Load as file.

Syntax​

CmdExportLoad(cursor[] taEntity, int analysisType, int resultSet, int timeStep, vecResultLoad [] ResultLoads, int SolverType, string ExportFile)

Inputs​

1. cursor[] ​

Target entity.

2. int ​

Analysis type.

3. int ​

Result set.

4. int ​

Time step.

5. ResultLoad [] ​

ResultLoad consisted by:

vrType - vr type,

string - Result name,

string - Load name.

6. int ​

Solver type.

7. string ​

Exported file name.

Return Code​

Nothing.

Sample Code​

CmdExportLoad([10:1008], 1,1,1, [[6, Displacement,Initial Displacement]], 2, "C:/Temp/data.dat")
