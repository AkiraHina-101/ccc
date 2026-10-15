# ImportSunShineUStar()

ImportSunShineUStar()

Description​

Import a SunShine UStar file (*.op2) to the Jupiter Database.

Syntax​

ImportSunShineUStar(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle, bool bReadLoadAndConstraint, bool bReadConnection, bool bCreateResultsAtMidNode)

Inputs​

1. str​

A String specifying the path to the SunShine UStar file.

2. int​

An Integer specifying import type.

3. double​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

4. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

5. bool​

A Boolean specifying whether or not read load and contraint.

6. bool​

A Boolean specifying whether or not read connection.

7. bool​

A Boolean specifying whether or not create results at mid node.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportSunShineUStar("path/to/the/file", 1, 60.0, 60.0, 0, 0, 0)
