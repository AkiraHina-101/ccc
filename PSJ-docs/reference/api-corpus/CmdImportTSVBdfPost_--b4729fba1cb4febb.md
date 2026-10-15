# CmdImportTSVBdfPost()

CmdImportTSVBdfPost()

Description​

Import a Nastran mesh file to the Jupiter Database as Post document to add result to the mesh.

Syntax​

CmdImportTSVBdfPost(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle, bool bReadLoadAndConstraint, bool bReadConnection, bool bReadNX)

Inputs​

1. str​

A String specifying a Nastran files which will be used for importing.

2. int​

An Integer specifying import type.

3. double​

An Integer specifying import type. Here is set to always 1.

4. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

5. bool​

A Boolean specifying whether or not to read loads and constraint.

6. bool​

A Boolean specifying whether or not to read connections.

7. bool​

A Boolean specifying whether or not to read NX.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CmdImportTSVBdfPost("path/to/the/file", 1, 60.0, 60.0, 1, 1, 1)
