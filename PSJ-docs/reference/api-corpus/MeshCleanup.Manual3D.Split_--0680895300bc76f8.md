# MeshCleanup.Manual3D.Split()

MeshCleanup.Manual3D.Split()

Description​

Merge two Quad elements into one Quad element

Syntax​

MeshCleanup.Manual3D.Split(crplElemEdge, crlNodes=[], dRatioDistance=0.5)

Ribbon: MeshCleanup » Manual3D » Split

Inputs​

crplElemEdge​

A Cursor Pair List specifying the element edge.

This is a required input.

crlNodes​

A List of Cursor specifying the node.

The default value is [].

dRatioDistance​

A Double specifying the ratio distance.

The default value is 0.5.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.Manual3D.Split(crplElemEdge, crlNodes=[], dRatioDistance=0.5)
