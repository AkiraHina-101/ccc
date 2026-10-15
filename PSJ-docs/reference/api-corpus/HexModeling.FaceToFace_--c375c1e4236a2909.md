# HexModeling.FaceToFace()

HexModeling.FaceToFace()

Description​

Syntax​

HexModeling.FaceToFace(crSrcFace, crDstFace, bDeleteOriginalParts=True)

Ribbon: HexModeling » FaceToFace

Inputs​

crSrcFace​

A Cursor specifying the source face.

This is a required input.

crDstFace​

A Cursor specifying the dst face.

This is a required input.

bDeleteOriginalParts​

A Boolean specifying the delete original parts.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

HexModeling.FaceToFace(crSrcFace, crDstFace, bDeleteOriginalParts=True)
