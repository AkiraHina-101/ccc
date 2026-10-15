# Geometry.Edge.PerpendicularLineOfEdge()

Geometry.Edge.PerpendicularLineOfEdge()

Description​

Create a perpendicular edge to the line defined by two nodes in the selected facs.

Syntax​

Geometry.Edge.PerpendicularLineOfEdge(...)

Macro: ImprintPerpendicularLine

Ribbon: Geometry » Edge » Perpendicular Line Of Edge

Inputs​

crlNodes​

A List of Cursor specifying 2 nodes in order from the screen to determine the direction. The first node is the origin of the offset amount. The imprint line is defined perpendicular to this direction.

This is a required input.

crlFaces​

A List of Cursor specifying the target faces on which the edges are imprinted.

This is a required input.

dOffsetDistance​

A Double specifying the offset distance.

The default value is 0.

bBreakFace​

A Boolean specifying whether to break the given faces where possible.

The default value is True.

Return Code​

A List of Cursor specifying the new created edge.

Sample Code​

Geometry.Part.Cube(iPartColor=6215639)

created_edges = Geometry.Edge.PerpendicularLineOfEdge(crlNodes=[Node(344, 339)], 
                                                     crlFaces=[Face(24, 
                                                                    22, 
                                                                    26, 
                                                                    25, 
                                                                    21, 
                                                                    23)])
JPT.Debugger(created_edges)
