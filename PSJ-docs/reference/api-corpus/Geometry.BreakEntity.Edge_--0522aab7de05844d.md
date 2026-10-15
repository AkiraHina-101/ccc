# Geometry.BreakEntity.Edge()

Geometry.BreakEntity.Edge()

Description​

Break an edge into separate units at the given points or specified angle.

Syntax​

Geometry.BreakEntity.Edge(...)

Ribbon: Geometry » Break Entity » Edge

Inputs​

crlParts​

A List of Cursor specifying parts that the edges connecting to the faces will be divided. Either crlParts, crlFaces, or crlEdges must be specified when bAutoByAngle = True.

The default value is [].

crlFaces​

A List of Cursor specifying faces that the edges connecting to the faces will be divided. Either crlParts, crlFaces, or crlEdges must be specified when bAutoByAngle = True.

The default value is [].

crlEdges​

A List of Cursor specifying edges to be divided. Either crlParts, crlFaces, or crlEdges must be specified when bAutoByAngle = True.

The default value is [].

crlNodes​

A List of Cursor specifying the nodes at which edges pass through will be divided. This argument will be ignored if bAutoByAngle = False.

The default value is [].

bAutoByAngle​

A Boolean specifying whether to divide by edge angle.

If True, edge will be divided at the position where its angle is not greater than the given dEdgeAngle.

The default value is False.

dEdgeAngle​

A Double specifying the angle in degrees between line segments. If bAutoByAngle is not specified, this argument is ignored.

The default value is 60.0.

Return Code​

A List of Cursor specifying the edges after the function is executed.

Sample Code​

Geometry.Part.Cube(iPartColor=6215639)

edges = Geometry.BreakEntity.Edge(crlNodes=[Node(86, 83)])

JPT.Debugger(edges)
