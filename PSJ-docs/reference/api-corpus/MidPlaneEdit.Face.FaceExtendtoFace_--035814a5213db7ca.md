# MidPlaneEdit.Face.FaceExtendtoFace()

MidPlaneEdit.Face.FaceExtendtoFace()

Description​

Add face by face extend to face

Syntax​

MidPlaneEdit.Face.FaceExtendtoFace(crlExtFaces, crlRefFaces, bMergeFace, bMergeEdge, dMergeEdgeAngle)

Ribbon: MidPlaneEdit » Face » FaceExtendtoFace

Inputs​

crlExtFaces​

A List of Cursor specifying the extend faces.

This is a required input.

crlRefFaces​

A List of Cursor specifying the reference faces.

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

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MidPlaneEdit.Face.FaceExtendtoFace(crlExtFaces, crlRefFaces, bMergeFace, bMergeEdge, dMergeEdgeAngle)
