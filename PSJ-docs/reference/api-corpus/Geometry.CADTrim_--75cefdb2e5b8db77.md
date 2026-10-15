# Geometry.CADTrim()

Geometry.CADTrim()

Description​

This method reduces the number of facets (triangle patch shape) for CAD shape. This can be obtained by recursively finding and collapsing adjacent element edges that are at an angle less than a specified angle or at an element edge length less than a specified size.

Syntax​

Geometry.CADTrim(crlFaces = [], crlParts = [], dTrimSize=1.0, dTrimAngle=15.0)

Macro: GeometryCADTrim

Ribbon: Geometry » CAD Trim

Inputs​

crlFaces​

A List of Cursor specifying faces to be trimmed. Either crlFaces, or crlParts must be specified.

The default value is [].

crlParts​

A List of Cursor specifying parts to be trimmed. Either crlFaces, or crlParts must be specified.

The default value is [].

dTrimSize​

A Double specifying the maximum length of element edge.

The default value is 1.0.

dTrimAngle​

A Double specifying the maximum angle in degrees between element edges.

The default value is 15.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Home.ImportCAD.Parasolid([JPT.GetProgramPath() + "SampleData\\bracket.x_t"],
    dAngleToleranceDegree=7.0, dScale=0.001)

Geometry.CADTrim(crlFaces=[Face(149)], crlParts=[Part(1)], dTrimSize=20.0, dTrimAngle=16.0)
