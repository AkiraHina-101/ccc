# MidPlaneEdit.AddItems.Edge.ProjectEdgeToFace()

MidPlaneEdit.AddItems.Edge.ProjectEdgeToFace()

Description​

Project an edge to face to get a new edge

Syntax​

MidPlaneEdit.AddItems.Edge.ProjectEdgeToFace(crlEdges, crlFaces, bExtendEdge=True)

Ribbon: MidPlaneEdit » AddItems » Edge » ProjectEdgeToFace

Inputs​

crlEdges​

A List of Cursor specifying the edge.

This is a required input.

crlFaces​

A List of Cursor specifying the face.

This is a required input.

bExtendEdge​

A Boolean specifying the extend edge.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MidPlaneEdit.AddItems.Edge.ProjectEdgeToFace(crlEdges, crlFaces, bExtendEdge=True)
