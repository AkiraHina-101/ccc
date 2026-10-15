# ImportUniversal()

ImportUniversal()

Description​

Import Universal result file.

Syntax​

ImportUniversal(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle)

Inputs​

1. str​

A String specifying Universal result file path.

2. int​

An Integer specifying import type.

3. double​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

4. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportUniversal("path/to/the/file", 1, 60.0, 60.0)
