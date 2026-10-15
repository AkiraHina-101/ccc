# CmdImportTSVOp2Post()

CmdImportTSVOp2Post()

Description​

Import Nastran .op2 result file

Syntax​

CmdImportTSVOp2Post(string FilePath, int importType, float faceAngle, float edgeAngle, bool readLoadAndConst, bool readConnection bool createResultsAtMidNode)

Inputs​

1. string  ​

File path

2. int  ​

Import Type
0: Simple Topology
1: Standard Nastran Op2 by Property

3. float  ​

Face Angle

4. float  ​

Edge Angle

5. bool  ​

Read Load and Constraint flag

6. bool  ​

Read Connection flag

6. bool  ​

Create Results at Mid Nodes flag

Return Code​

Nothing.

Sample Code​

CmdImportTSVOp2Post("C:/temp/data.op2", 1, 1.0472, 1.0472, 0, 0, 0)
