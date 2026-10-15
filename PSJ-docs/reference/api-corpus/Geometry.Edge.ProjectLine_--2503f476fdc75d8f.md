# Geometry.Edge.ProjectLine()

Geometry.Edge.ProjectLine()

Description​

Create new edges by projecting the selected edges onto the selected faces.

Syntax​

Geometry.Edge.ProjectLine(...)

Ribbon: Geometry » Edge » Project Line

Inputs​

crlEdges​

A List of Cursor specifying the edges to projected.

This is a required input.

crlFaces​

A List of Cursor specifying the target faces to projects the edges onto.

This is a required input.

crlNodes​

A List of Cursor specifying two nodes to define the projection direction. This argument must be specified if iType=1.

The default value is [].

bBreakFace​

A Boolean whether to break the target faces after the project operation.

The default value is True.

iType​

An Integer specifying the method to be used to project onto target faces. This value must lie between (0,2).
If iType=0, project along to the face normal direction for the target faces.

If iType=1, project along to the direction defined by two nodes specified by the crlNodes member.

If iType=2, project onto the face closest to the selected edge.

The default value is 0.

bCheckGap​

A Boolean whether to limit the projection distance to the input value.

The default value is False.

dGap​

A Double specifying the gap value. This argument is to be used when bCheckGap=True.

The default value is 0.0.

Return Code​

A Cursor of Edge if success, or 0 if fail.

Sample Code​

test=Geometry.Part.Cube(iPartColor=13064794)
edge1=Geometry.Edge.Line(dllPoints=[[0.004444444444444444, 0.01, 0.01], [0.007777777777777778, 0, 0.01]], crlFaces=[Face(26)])
edge2=Geometry.Edge.ProjectLine(crlCrEdges=edge1, crlCrFaces=[Face(25)])
JPT.Debugger(edge2)
