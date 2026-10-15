# Geometry.Edge.NodeShortestPath()

Geometry.Edge.NodeShortestPath()

Description​

Create an edge using the shortest path between two nodes.

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

iEnableBreakFace​

An Integer specifying whether to break the target face into multiple bodies where possible. Possible values are 0 and 1.

The default value is 1.

Return Code​

A List of Cursor specifying the created edges.

Sample Code​

Geometry.Part.Cube(iPartColor=6215639)

created_edges = Geometry.Edge.NodeShortestPath(crFirstNode=Node(79), 
                                               crSecondNode=Node(91), 
                                               iEnableBreakFace=0)

JPT.Debugger(created_edges)
