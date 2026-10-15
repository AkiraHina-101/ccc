# MeshCleanup.CloseHoles()

MeshCleanup.CloseHoles()

Description​

Close holes

Syntax​

MeshCleanup.CloseHoles(crlEdges=[], dAreaMin=0.0, dAreaMax=543210.0, bMergeFace=False, bMergeEdge=False)

Ribbon: MeshCleanup » CloseHoles

Inputs​

crlEdges​

A List of Cursor specifying the edge.

The default value is [].

dAreaMin​

A Double specifying the area minimum.

The default value is 0.0.

dAreaMax​

A Double specifying the area maximum.

The default value is 543210.0.

bMergeFace​

A Boolean specifying the merge face.

The default value is False.

bMergeEdge​

A Boolean specifying the merge edge.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.CloseHoles(crlEdges=[], dAreaMin=0.0, dAreaMax=543210.0, bMergeFace=False, bMergeEdge=False)
