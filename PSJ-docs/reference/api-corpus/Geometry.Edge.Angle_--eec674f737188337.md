# Geometry.Edge.Angle()

Geometry.Edge.Angle()

Description​

This method generates an Edge entity by given the element edges and recursively finding adjacent element edges that are at an angle greater than or equal to the specified angle.
The direction of the automatic selection can be changed by selecting an element edge.

Syntax​

Geometry.Edge.Angle(...)

Ribbon: Geometry » Edge » Angle

Inputs​

crplElemEdges​

A List of Pairs of Cursor specifying element edges used for automatic selection.

This is a required input.

dEdgeAngle​

A Double specifying the angle in degrees.

The default value is 135.0.

bCurvature​

A Boolean specifying whether to find the adjacent element edges which can be chained to form a circle.

The default value is False.

bBreakFace​

A Boolean specifying whether to separate face where possible after generating edges.

The default value is True.

Return Code​

A List of Cursor of new edges if success, or None if fail.

Sample Code​

Geometry.Part.Cube()

edges = Geometry.Edge.Angle(crplElemEdges=[CursorPair(Node(461), Node(470)), 
                                           CursorPair(Node(445), Node(446))], 
                            dEdgeAngle=135.0, 
                            bCurvature=False, 
                            bBreakFace=True)

JPT.Debugger(edges)
