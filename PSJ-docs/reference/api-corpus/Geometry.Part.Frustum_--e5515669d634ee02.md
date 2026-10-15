# Geometry.Part.Frustum()

Geometry.Part.Frustum()

Description​

Create a frustum body in a specific location.
Its relative location is computed to the specified local coordinate system.

Syntax​

Geometry.Part.Frustum(...)

Macro: CreateCylinderFrustum

Ribbon: Geometry » Part » Frustum

Inputs​

dlOrigin​

A List of Double representing the X, Y, and Z coordinates of the origin point (The center of the frustum).

The default value is [0,0,0].

dTopRadius​

A Double specifying the radius of the frustum in meter.

The default value is 0.005.

dBottomRadius​

A Double specifying the radius in meters of the bottom end of the frustum.

The default value is 0.01.

dHeight​

A Double specifying the height of the frustum..

The default value is 0.02.

iCircularNodes​

An Integer specifying the number of nodes to be generated on the circle at both ends.

The default value is 20.

iAxialNodes​

An Integer specifying the number of nodes in the axial direction of the cylinder.

The default value is 20.

strName​

A String specifying the name of the newly created part.

The default value is "Frustum_1".

iPartColor​

An Integer specifying the color of the newly created part.

The default value is 7105764.

crLocalCoordinate​

A Cursor specifying the local coordinate system.

The default value is None.

Return Code​

A Cursor specifying the created part.

Sample Code​

created_frustum = Geometry.Part.Frustum(dTopRadius=0.003, iPartColor=14903267)
JPT.Debugger(created_frustum)
