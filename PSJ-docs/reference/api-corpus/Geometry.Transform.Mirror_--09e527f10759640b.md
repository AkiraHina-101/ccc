# Geometry.Transform.Mirror()

Geometry.Transform.Mirror()

Description​

This method mirrors existing part geometry across a plane to create new geometry.

Syntax​

Geometry.Transform.Mirror(crlParts, veclPoint=[[0.0, 0.0, 0.0]], dOffset=0.0, bCreateNewPart=True,
    bCopyLBC=False, bCopyProperty=False, bRemoveDupFace=True, bMergeNode=False, dTol=1e-05)

Macro: MirrorBody

Ribbon: Geometry » Transform » Mirror

Inputs​

crlParts​

A List of Cursor specifying the parts to mirror.

This is a required input.

veclPoint​

A List of Vector specifying the X-, Y-, and Z-coordinates of three-points to define the mirror plane.

The default value is [[0.0, 0.0, 0.0]].

dOffset​

A Double specifying the offset amount from the mirror plane.

The default value is 0.0.

bCreateNewPart​

A Boolean specifying whether or not the mirrored part should be moved to a new part and keep the original part as is.

The default value is True.

bCopyLBC​

A Boolean specifying whether to copy all load boundary condition from original part to mirrored part. This argument will be ignored if bCreateNewPart=False.

The default value is False.

bCopyProperty​

A Boolean specifying whether to copy all property from original part to mirrored part. This argument will be ignored if bCreateNewPart=False.

The default value is False.

bRemoveDupFace​

A Boolean specifying whether to remove the faces which overlap the mirrored with the original part. This argument will be ignored if bCreateNewPart=False.

The default value is True.

bMergeNode​

A Boolean specifying whether to merge nodes of mirrored part and the original part are at a distance of less than or equal to the specified value.

The default value is False.

dTol​

A Double specifying the maximum distance of the coupling nodes. This argument will be ignored if bMergeNode=False.

The default value is 1e-05.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Wedge()

Geometry.Transform.Mirror(crlParts=[Part(1)], veclPoint=[[0.012, 0, 0], [0, 0.012, 0], [0.012, 0, 1]])
