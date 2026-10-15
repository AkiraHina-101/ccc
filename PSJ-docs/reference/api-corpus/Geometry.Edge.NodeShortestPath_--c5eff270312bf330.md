# Geometry.Edge.NodeShortestPath()

Geometry.Edge.NodeShortestPath()

Description​

Create an edge using the shortest path of element edges between two nodes.

Syntax​

Geometry.Edge.NodeShortestPath(...)

Ribbon: Geometry » Edge » 2 Nodes Shortest Path

Inputs​

crFirstNode​

A Cursor specifying the first node.

This is a required input.

crSecondNode​

A Cursor specifying the second node.

This is a required input.

bBreakFace​

A Boolean specifying whether to break the face which the shortest edges lie on where possible.

The default value is True.

Return Code​

A List of Cursor specifying the new created edges.

Sample Code​

Geometry.Part.Cube(iPartColor=6215639)

created_edges = Geometry.Edge.NodeShortestPath(crFirstNode=Node(79), 
                                               crSecondNode=Node(91), 
                                               bBreakFace=0)
JPT.Debugger(created_edges)
