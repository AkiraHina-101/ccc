# ImportAbaqus()

ImportAbaqus()

Description​

Import Abaqus result file.

Syntax​

ImportAbaqus(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle, int iVersion)

Inputs​

1. str​

A String specifying abaqus result file path.

2. int​

An Integer specifying import type.

3. double​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

4. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

5. int​

An Integer specifying version of abaqus file to import.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportAbaqus("path/to/the/file", 1, 60.0, 60.0, 2023)
