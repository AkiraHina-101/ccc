# Geometry.Edge.ExtendLine()

Geometry.Edge.ExtendLine()

Description​

Extend the specified edges to the specified boundary.

Syntax​

Geometry.Edge.ExtendLine(...)

Macro: ImprintExtendLine

Ribbon: Geometry » Edge » Extend Line

Inputs​

crlEdges​

A List of Cursor specifying an edge to be extended..

This is a required input.

iMethod​

An Integer specifying the Extend method.
If iMethod = 0, following the direction of the last segments of the given Edge.

If iMethod = 1, attempting to retain the curvature direction of the given Edge.

The default value is 0.

iEnd​

An Integer specifying the end position to extend the Edge.
If iEnd=0, extend from its endpoints to the closest Edge.

If iEnd=1, extend the given Edge to boundary Edges .

The default value is 0.

iNoFittingPoints​

An Integer specifying number of fitting points. This argument is to be used when the iMethod=1.

The default value is 3.

iDiv​

An Integer specifying division segments. This argument is to be used when the iMethod=1.

The default value is 2.

iEnableBreakFace​

An Integer specifying whether to break the face which the given edge lies on. Possible values are 0 and 1.

The default value is 1.

Return Code​

A List of Cursor specifying the extended edges.

Sample Code​

Geometry.Part.Cube(iPartColor=6215639)

Geometry.Edge.ElementEdges(crplElemEdges=[CursorPair(Node(453), 
                                                     Node(461))])

extended_edges = Geometry.Edge.ExtendLine(crlEdges=[Edge(27)], 
                                          iEnd=1)

JPT.Debugger(extended_edges)
