# Geometry.Edge.ProjectLine()

Geometry.Edge.ProjectLine()

Description​

Create new edges by projecting the selected edges onto the selected faces.

Syntax​

Geometry.Edge.ProjectLine(...)

Ribbon: Geometry » Edge » Project Line

Inputs​

crlEdges​

A List of Cursor specifying the edges to be projected.

This is a required input.

crlFaces​

A List of Cursor specifying the target faces on which the edges are imprinted.

This is a required input.

crlNodes​

A List of Cursor specifying two nodes to define the projection direction. This argument must be specified if iType=1.

The default value is [].

bBreakFace​

A Boolean specifying whether to break the given faces where possible.

The default value is True.

iType​

An Integer specifying the method to be used to project onto target faces.

If iType=0, project along to the face normal direction for the target faces.

If iType=1, project along to the direction defined by two nodes specified by the crlNodes.

If iType=2, project onto the face closest to the selected edge.

The default value is 0.

bCheckGap​

A Boolean whether to limit the projection distance to the input value.

The default value is False.

dGap​

A Double specifying the gap value. This argument is to be used when bCheckGap=True.

The default value is 0.0.

Return Code​

A List of Cursor specifying the new created edges.

Sample Code​

Geometry.Part.Cube(iPartColor=13064794)
line = Geometry.Edge.Line(dllPoints=[[0.004444444444444444, 0.01, 0.01], [0.007777777777777778, 0, 0.01]], 
                          crlFaces=[Face(26)])

project_lines = Geometry.Edge.ProjectLine(crlEdges=line, crlFaces=[Face(25)])
JPT.Debugger(project_lines)
