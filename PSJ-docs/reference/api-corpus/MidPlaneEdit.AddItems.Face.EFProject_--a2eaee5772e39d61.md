# MidPlaneEdit.AddItems.Face.EFProject()

MidPlaneEdit.AddItems.Face.EFProject()

Description​

Creat new face by project edge to destination face

Syntax​

MidPlaneEdit.AddItems.Face.EFProject(crlEdges, crlFaces, bMergeFace, bMergeEdge, dMergeEdgeAngle, bMultiEF)

Ribbon: MidPlaneEdit » AddItems » Face » EFProject

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

dMergeEdgeAngle​

A Double specifying the merge edge angle.

This is a required input.

bMultiEF​

A Boolean specifying the multi edge and face .

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MidPlaneEdit.AddItems.Face.EFProject(crlEdges, crlFaces, bMergeFace, bMergeEdge, dMergeEdgeAngle, bMultiEF)
