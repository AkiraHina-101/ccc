# MeshCleanup.Manual2D.Split()

MeshCleanup.Manual2D.Split()

Description​

Manual cleanup by split

Syntax​

MeshCleanup.Manual2D.Split(crplElemEdge, dRatio=0.0, crNodeRef=None, crProjectPart=None)

Ribbon: MeshCleanup » Manual2D » Split

Inputs​

crplElemEdge​

A Cursor Pair List specifying the element edge.

This is a required input.

dRatio​

A Double specifying the ratio.

The default value is 0.0.

crNodeRef​

A Cursor specifying the node reference.

The default value is None.

crProjectPart​

A Cursor specifying the project part.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.Manual2D.Split(crplElemEdge, dRatio=0.0, crNodeRef=None, crProjectPart=None)
