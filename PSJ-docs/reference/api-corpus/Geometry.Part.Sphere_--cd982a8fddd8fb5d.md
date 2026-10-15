# Geometry.Part.Sphere()

Geometry.Part.Sphere()

Description​

Create a sphere body in a specific location.
Its relative location is computed to the specified local coordinate system.

Syntax​

Geometry.Part.Sphere(...)

Macro: CreateSphere

Ribbon: Geometry » Part » Sphere

Inputs​

dlOrigin​

A List of Double representing the X, Y, and Z coordinates of the origin point (The center of the sphere).

The default value is [0,0,0].

dRadius​

A Double specifying the radius of the sphere in meter.

The default value is 0.005.

iLatitudeDivisions​

An Integer specifying the number of nodes to be generated on the latitude direction.

The default value is 20.

iLongitudeDivisions​

An Integer specifying the number of nodes to be generated on the longitudinal direction.

The default value is 20.

strName​

A String specifying the name of the creating part.

The default value is "Sphere_1".

iPartColor​

An Integer specifying the color of the creating part.

The default value is 7105764.

crLocalCoordinate​

A Cursor specifying the local coordinate system.

The default value is None.

Return Code​

The return value depends on the status of the creating process:

Cursor: The sphere is created successfully.

None: The sphere cannot be created.

Sample Code​

sphere = Geometry.Part.Sphere(dlOrigin=[0.005, 0.0, 0.0], iPartColor=13259210)
JPT.Debugger(sphere)
