# MidPlaneEdit.AddItems.Face.EFExtendFreeEdge()

MidPlaneEdit.AddItems.Face.EFExtendFreeEdge()

Description​

Create new face by extend free edge to a destination face

Syntax​

MidPlaneEdit.AddItems.Face.EFExtendFreeEdge(crlEdges, crlFaces, bMergeFace, bMergeEdge, bUseNeighDir, dMergeEdgeAngle, bMultiEF)

Ribbon: MidPlaneEdit » AddItems » Face » EFExtendFreeEdge

Inputs​

crlEdges​

A List of Cursor specifying the edge.

This is a required input.

crlFaces​

A List of Cursor specifying the face.

This is a required input.

bMergeFace​

A Boolean specifying the merge face.

This is a required input.

bMergeEdge​

A Boolean specifying the merge edge.

This is a required input.

bUseNeighDir​

A Boolean specifying the use neighborhood edge direction.

This is a required input.

dMergeEdgeAngle​

A Double specifying the merge edge angle.

This is a required input.

bMultiEF​

A Boolean specifying the multi edge and face .

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MidPlaneEdit.AddItems.Face.EFExtendFreeEdge(crlEdges, crlFaces, bMergeFace, bMergeEdge, bUseNeighDir, dMergeEdgeAngle, bMultiEF)
