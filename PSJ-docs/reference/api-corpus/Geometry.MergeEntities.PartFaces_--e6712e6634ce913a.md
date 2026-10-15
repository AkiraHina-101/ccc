# Geometry.MergeEntities.PartFaces()

Geometry.MergeEntities.PartFaces()

Description​

This method merges adjacent faces of the given part by recursively finding adjacent faces that are at an angle of less than or equal to the specified angle or face width is not greater than the specified value. The operation will ignore the specified preserved faces.

Syntax​

Geometry.MergeEntities.PartFaces(crlParts=[], crlFaces=[], bAngle=True, dTolAngle=20, bWidth=True,
    dTolWidth=0.2)

Ribbon: Geometry » Merge Entities » Part Faces

Inputs​

crlParts​

A List of Cursor specifying the target parts that faces need merging belong to.

The default value is [].

crlFaces​

A List of Cursor specifying the preserved faces not to be merged.

The default value is [].

bAngle​

A Boolean specifying whether to find the adjacent faces by face angle.

The default value is True.

dTolAngle​

A Double specifying the maximum allowable angle between two adjacent faces. If bAngle is specified, the adjacent faces that are at an angle of less than or equal to will be merged.

The default value is 20.0.

bWidth​

A Boolean specifying whether to find the adjacent faces by face width.

The default value is True.

dTolWidth​

A Double specifying the maximum allowable face width. If bWidth is specified, the faces that have a width less than or equal to will be merged to an adjacent face.

The default value is 0.2.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Trapezoid(dTopXLength=5.0)

Geometry.MergeEntities.PartFaces(crlParts=[Part(1)], dTolAngle=89.0, bWidth=False)
