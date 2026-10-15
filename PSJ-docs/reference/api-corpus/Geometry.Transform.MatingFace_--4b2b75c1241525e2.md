# Geometry.Transform.MatingFace()

Geometry.Transform.MatingFace()

Description​

Translate parts by defining mating faces, mating edges, and mating points.

Syntax​

Geometry.Transform.MatingFace(...)

Ribbon: Geometry » Transform » Mating Face

Inputs​

crlParts​

A List of Cursor specifying parts to transform.

This is a required input.

crSrcFace​

A Cursor specifying the face to be used as the source for the transform operation.

This is a required input.

crDstFace​

A Cursor specifying the face to be used as the reference for the transform operation.

This is a required input.

crSrcEdge​

A Cursor specifying the edge to be used as the source for the transform operation.

The default value is None.

crDstEdge​

A Cursor specifying the edge to be used as the reference for the transform operation. This argument must be specified when iAlignMethodType=0.

The default value is None.

crSrcNode​

A Cursor specifying the node to be used as the source for the transform operation.

The default value is None.

crDstNode​

A Cursor specifying the node to be used as the reference for the transform operation. This argument must be specified when iAdjustPointType=0.

The default value is None.

iFaceOpposite​

An Integer specifying whether or not the source surface should be on the opposite side of the destination surface.
If iFaceOpposite=0: The source surface lay on the current side of the destination surface.

If iFaceOpposite=1: The source surface lay on the opposite side of the destination surface.

The default value is 0.

dEdgeAngle​

A Double specifying the angle in degrees between two specified edges, crSrcEdge and crDstEdge, after the transform operation.

The default value is 0.0.

iEdgeOpposite​

An Integer specifying whether to match the opposite direction of source edge to destination edge.
If iEdgeOpposite=0: Match the current direction of source edge to destination edge.

If iEdgeOpposite=1: Match the opposite direction of source edge to destination edge.

The default value is 0.

iAlignMethodType​

An Integer specifying how to align the edges between the source and the destination. This argument will be ignored if crSrcEdge has a default value.
If iAlignMethodType=0: Move the given source part so that crSrcEdge is coincident with crDstEdge.

If iAlignMethodType=1: Move crSrcEdge edges along the direction of the specified vector dlAlignVector.

The default value is 0.

iAdjustPointType​

An Integer specifying how to move the node along the direction. This argument will be ignored if crSrcNode has a default value.
If iAdjustPointType=0: Move on a direction defined by two nodes, from source and destination.

If iAdjustPointType=1: Move on a direction defined by a node and a coordinate, from source and destination.

The default value is 0.

iAdjustProjectionType​

An Integer specifying the projection direction. This argument will be ignored if crSrcNode has a default value.
If iAdjustProjectionType=0: Projection direction is the normal direction of the surface.

If iAdjustProjectionType=1: Projection direction is the specified vector dlAdjustVector.

The default value is 0.

dlAlignVector​

A List of Double specifying the alignment vector. This argument is used when iAlignMethodType=1.

The default value is [0.0, 0.0, 0.0].

dlAdjustPoint​

A List of Double specifying the destination point which crSrcNode will move to. This argument is used when iAdjustPointType=1.

The default value is [0.0, 0.0, 0.0].

dlAdjustVector​

A List of Double specifying adjustment vector. This argument is used when iAdjustPointType=1.

The default value is [0.0, 0.0, 0.0].

bCreateNewPart​

A Boolean specifying whether to keep the original part and make a copy one then transform.

The default value is False.

bCopyLBC​

A Boolean specifying whether to copy load boundary condition of original part to transformed part. This argument is used when bCreateNewPart=True.

The default value is False.

bCopyProperty​

A Boolean specifying whether to copy property of original part to transformed part. This argument is used when bCreateNewPart=True.

The default value is False.

bIsPreview​

A Boolean specifying whether to enable preview or not.

The default value is False.

crlCoordSyss​

A List of Cursor specifying the coordinate systems.

The default value is [].

Return Code​

No return value.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cylinder(dlOrigin=[0.02, 0.005, 0.005], dTopOuterRadius=0.005, dBottomOuterRadius=0.005)
Geometry.Transform.MatingFace(crlParts=[Part(2)], crSrcFace=Face(30), crDstFace=Face(22))
