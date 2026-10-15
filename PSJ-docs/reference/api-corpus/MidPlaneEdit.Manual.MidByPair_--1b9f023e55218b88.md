# MidPlaneEdit.Manual.MidByPair()

MidPlaneEdit.Manual.MidByPair()

Description​

Midplane Manual MidByPair

Syntax​

MidPlaneEdit.Manual.MidByPair(crlBaseFaces, crlPairFaces, crlRefFaces, crPart, bMergeFaces, bExtendFaces, bHideFaces, dExtendTol, dMergeEdgesAngle, dStitchFaces)

Ribbon: MidPlaneEdit » Manual » MidByPair

Inputs​

crlBaseFaces​

A List of Cursor specifying the base faces.

This is a required input.

crlPairFaces​

A List of Cursor specifying the pair faces.

This is a required input.

crlRefFaces​

A List of Cursor specifying the reference faces.

This is a required input.

crPart​

A Cursor specifying the part.

This is a required input.

bMergeFaces​

A Boolean specifying the merge faces.

This is a required input.

bExtendFaces​

A Boolean specifying the extend faces.

This is a required input.

bHideFaces​

A Boolean specifying the hide faces.

This is a required input.

dExtendTol​

A Double specifying the extend tolerance.

This is a required input.

dMergeEdgesAngle​

A Double specifying the merge edges angle.

This is a required input.

dStitchFaces​

A Double specifying the stitch faces.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MidPlaneEdit.Manual.MidByPair(crlBaseFaces, crlPairFaces, crlRefFaces, crPart, bMergeFaces, bExtendFaces, bHideFaces, dExtendTol, dMergeEdgesAngle, dStitchFaces)
