# CmdImportTSVBdfPost()

CmdImportTSVBdfPost()

Description​

Import Nastran BDF file to Post Document

Syntax​

CmdImportTSVBdfPost(string FilePath, int importType, float faceAngle, float edgeAngle, int readLoadAndConst, int readConnection)

Inputs​

1. string ​

File path

2. int ​

Import type. Set to 0.

3. float  ​

Face Angle

4. float  ​

Edge Angle

5. bool  ​

Read Load and Constraint flag

6. bool  ​

Read Connection flag

Return Code​

Nothing.

Sample Code​

CmdImportTSVBdfPost("C:/temp/sample.bdf", 1, 1.0472, 1.0472, 0, 0)
