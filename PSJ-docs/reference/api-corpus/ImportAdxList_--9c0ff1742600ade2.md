# ImportAdxList()

ImportAdxList()

Description​

Import an ADVC file (*.adx) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

ImportAdxList(str[] strlPaths, double dFaceAngle, double dEdgeAngle, bool bReadCommentsForJupiter_b)

Inputs​

1. str[]​

A List of String specifying a list of the ADVC files (*.adx files) which will be used for importing.

2. double​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

3. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

4. bool​

A Bool specifying whether Jupiter enables to read Material, Property, LBC, Contact, Job name, and related group names.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportAdxList(["path/to/the/file"], 1.0471975511962746, 1.0471975511962746)
