# MeshEdit.Face()

MeshEdit.Face()

Description​

Make Mesh deformation

Syntax​

MeshEdit.Face(crlFaces, crlFaceFixed, iOffsetType=0, crCoord=None, dlOffset=[1.0, 0.0, 0.0], dOffset=0, iDistType=0, dDistStrong=10, dDistWeak=20, iNodeIdPick=-1, dlPickForMacro=[])

Ribbon: MeshEdit » Face

Inputs​

crlFaces​

A List of Cursor specifying the face.

This is a required input.

crlFaceFixed​

A List of Cursor specifying the face fixed.

This is a required input.

iOffsetType​

An Integer specifying the offset type.

The default value is 0.

crCoord​

A Cursor specifying the coordinate.

The default value is None.

dlOffset​

A Double List specifying the offset.

The default value is [1.0, 0.0, 0.0].

dOffset​

A Double specifying the offset.

The default value is 0.

iDistType​

An Integer specifying the dist type.

The default value is 0.

dDistStrong​

A Double specifying the dist strong.

The default value is 10.

dDistWeak​

A Double specifying the dist weak.

The default value is 20.

iNodeIdPick​

An Integer specifying the node ID pick.

The default value is -1.

dlPickForMacro​

A Double List specifying the pick for macro.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.Face(crlFaces, crlFaceFixed, iOffsetType=0, crCoord=None, dlOffset=[1.0, 0.0, 0.0], dOffset=0, iDistType=0, dDistStrong=10, dDistWeak=20, iNodeIdPick=-1, dlPickForMacro=[])
