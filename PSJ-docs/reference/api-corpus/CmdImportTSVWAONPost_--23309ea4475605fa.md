# CmdImportTSVWAONPost()

CmdImportTSVWAONPost()

Description​

Import WAON result file to the Jupiter Database.

Syntax​

CmdImportTSVWAONPost(str strPath, str strFPMFilePath, str strResultFolderPath, int iImportType, double dFaceAngle, double dEdgeAngle, bool bReadLoadAndConstraint, bool bReadConnection, bool bCreateResultsAtMidNode)

Inputs​

1. str​

A String specifying BEM file (.bdf).

2. str​

A String specifying FPM file (.bdf).

3. str​

A String specifying result folder.

4. int​

An Integer specifying import type. For WAON file, it is always set to 1.

5. double​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

6. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

7. bool​

A Boolean specifying whether or not read load and contraint.

8. bool​

A Boolean specifying whether or not read connection.

9. bool​

A Boolean specifying whether or not create results at mid node.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CmdImportTSVWAONPost("C:/Temp/", "C:/Temp/BEM.bdf", "C:/Temp/FPM.bdf", 1, 60.0, 60.0, 0, 0, 0)
