# Geometry.Edge.PerpendicularLineToEdge()

Geometry.Edge.PerpendicularLineToEdge()

Description​

Create a perpendicular line on the given faces and through a specified point. The created lines can be started from the specified point or extend to the closest edge object.

Syntax​

Geometry.Edge.PerpendicularLineToEdge(...)

Ribbon: Geometry » Edge » Perpendicular Line To Edge

Inputs​

crNode​

A Cursor specifying the start node of new edge. If bAuto or scale is specified, this argument is ignored.

The default value is None.

crEdge​

A Cursor specifying the edge that the new edge should be extended up to. If bAuto or scale is specified, this argument is ignored.

The default value is None.

crlFaces​

A List of Cursor specifying the faces to be imprinted.

This is a required input.

bBreakFace​

A Boolean specifying whether to break the faces after the imprint operation.

The default value is True.

bExtend​

A Boolean specifying whether to extend the new edge through the given node up to the closest edge object.

The default value is True.

bAuto​

A Boolean specifying whether to specify the node and edge automatically from the pair of edges where the angle between them is equal or greater than the angle dLimitAngle specified. The node in-between will be selected automatically, an imprinting line will be made from that node to the opposite edge of the given faces.

The default value is False.

dLimitAngle​

A Double specifying the angle in degrees to limit the angle within which Edge entities should be considered. This argument is to be used when the bAuto argument has the value True.

The default value is 135.0.

Return Code​

A List of Cursor specifying the created edges if success, or 0 if fail.

Sample Code​

Geometry.Part.Cylinder()

created_edges = Geometry.Edge.PerpendicularLineToEdge(crNode=Node(250), 
                                                      crEdge=Edge(1), 
                                                      crlFaces=[Face(5)])

JPT.Debugger(created_edges)
