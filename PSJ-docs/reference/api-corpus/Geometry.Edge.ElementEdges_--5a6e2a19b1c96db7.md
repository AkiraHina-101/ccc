# Geometry.Edge.ElementEdges()

Geometry.Edge.ElementEdges()

Description​

Create edges by selecting individual element edges.

Syntax​

Geometry.Edge.ElementEdges(...)

Macro: CreateEdgeByElemEdge

Ribbon: Geometry » Edge » Element Edges

Inputs​

crplElemEdges​

A List of Pairs of Cursor specifying the element edges to be converted to Edge entity.

This is a required input.

bBreakEdge​

A Boolean specifying whether to break the faces which the given element edges lie on.

The default value is True.

Return Code​

A List of Cursor of new edges if success, or None if fail.

Sample Code​

Geometry.Part.Cube()

created_edges = Geometry.Edge.ElementEdges(crplElemEdges=[CursorPair(Node(443), 
                                                                     Node(452)), 
                                                          CursorPair(Node(444), 
                                                                     Node(445)), 
                                                          CursorPair(Node(454), 
                                                                     Node(463))])

JPT.Debugger(created_edges)
