# MeshEdit.OneNode()

MeshEdit.OneNode()

Description​

Morphing one node

Syntax​

MeshEdit.OneNode(crlNodes=[], crlFaceFixed=[], bOffsetvector=False, crCoord=None, dlOffset=[0, 1, 0], dOffset=1.0, iDistType=0, dDistStrong=10, dDistWeak=20)

Ribbon: MeshEdit » OneNode

Inputs​

crlNodes​

A List of Cursor specifying the node.

The default value is [].

crlFaceFixed​

A List of Cursor specifying the face fixed.

The default value is [].

bOffsetvector​

A Boolean specifying the offsetvector.

The default value is False.

crCoord​

A Cursor specifying the coordinate.

The default value is None.

dlOffset​

A Double List specifying the offset.

The default value is [0, 1, 0].

dOffset​

A Double specifying the offset.

The default value is 1.0.

iDistType​

An Integer specifying the dist type.

The default value is 0.

dDistStrong​

A Double specifying the dist strong.

The default value is 10.

dDistWeak​

A Double specifying the dist weak.

The default value is 20.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.OneNode(crlNodes=[], crlFaceFixed=[], bOffsetvector=False, crCoord=None, dlOffset=[0, 1, 0], dOffset=1.0, iDistType=0, dDistStrong=10, dDistWeak=20)
