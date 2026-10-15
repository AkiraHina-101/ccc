# CmdImportTSVPost()

CmdImportTSVPost()

Description​

Import Result or Mesh file to Post Document

Syntax​

CmdImportTSVPost(string FilePath, int solverType, int importType, float faceAngle, float edgeAngle)

Inputs​

1. string  ​

File path

2. int ​

Solver type.

3. int  ​

Import type

4. float  ​

Face Angle

5. float  ​

Edge Angle

Return Code​

Nothing.

Sample Code​

CmdImportTSVPost("C:/Temp/sample.dat", 9, 1, 1.0472, 1.0472)
