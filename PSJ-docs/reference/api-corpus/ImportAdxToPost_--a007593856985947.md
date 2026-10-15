# ImportAdxToPost()

ImportAdxToPost()

Description​

Import an ADVC file (*.adx) to the Jupiter Database (Mesh, boundary conditions, etc.) as Post document.

Syntax​

ImportAdxToPost(str strPath, double dFaceAngle, double dEdgeAngle)

Inputs​

1. str​

A String specifying an ADVC file (*.adx file) which will be used for importing.

2. double​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

3. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportAdxToPost(strPath, dFaceAngle, dEdgeAngle)
