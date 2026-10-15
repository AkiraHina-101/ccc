# ImportUniversalMesh()

ImportUniversalMesh()

Description​

Import an Universal file (*.unv) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

ImportUniversalMesh(str[] strlPaths, doubledFaceAngle, double dEdgeAngle)

Inputs​

1. str[]​

A List of String specifying a list of the Universal files (*.unv file) which will be used for importing.

2. double​

A Double specifying the angle tolerance in order to determine the face division.

3. double​

A Double specifying the angle tolerance in order to determine the edge division.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportUniversalMesh(["path/to/the/file"], 60.0, 60.0)
