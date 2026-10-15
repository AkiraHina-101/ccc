# Geometry.Edge.ElementEdges()

Geometry.Edge.ElementEdges()

Description​

Create edges from the selected element edges.

Syntax​

Geometry.Edge.ElementEdges(...)

Macro: CreateEdgeByElemEdge

Ribbon: Geometry » Edge » Element Edges

Inputs​

crplElemEdges​

A List of Pairs of Cursor specifying the element edges to be converted to edge.

This is a required input.

bBreakEdge​

A Boolean specifying whether to break the faces which the given element edges lie on where possible.

The default value is True.

Return Code​

A List of Cursor specifying the new created edges.

Sample Code​

Geometry.Part.Cube()

created_edges = Geometry.Edge.ElementEdges(crplElemEdges=[CursorPair(Node(443), Node(452)), 
                                                          CursorPair(Node(444), Node(445)), 
                                                          CursorPair(Node(454), Node(463))])
JPT.Debugger(created_edges)
