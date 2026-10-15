# ImportInpToPost()

ImportInpToPost()

Description​

Import an Abaqus mesh file (*.inp) to the Jupiter Database (Mesh, boundary conditions, etc.) as Post document to add result to the mesh.

Syntax​

ImportInpToPost(str strPath, double dFaceAngle, double dEdgeAngle, int iImportType)

Inputs​

1. str​

A String specifying specifying an Abaqus file (*.inp file) which will be used for importing.

2. double​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

3. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

4. int​

A interger specifying the type of

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportInpToPost("path/to/the/file", 60.0, 60.0, 1)
