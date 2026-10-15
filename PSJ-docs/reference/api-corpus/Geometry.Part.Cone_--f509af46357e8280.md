# Geometry.Part.Cone()

Geometry.Part.Cone()

Description​

Create a cone body in a specific location.
Its relative location is computed to the specified local coordinate system.

Syntax​

Geometry.Part.Cone(...)

Macro: CreateCone

Ribbon: Geometry » Part » Cone

Inputs​

dlOrigin​

A List of Double specifying the X, Y, and Z coordinates of the origin point.

The default value is [0.0,0.0,0.0].

dBottomRadius​

A Double specifying the radius of the bottom face in meter.

The default value is 0.01.

dHeight​

A Double specifying the cone height in meter.

The default value is 0.02.

iCircularNodes​

An Integer specifying the number of nodes to be generated on the arc.

The default value is 20.

iAxialNodes​

An Integer specifying the number of nodes to be generated on the axial direction of the cylinder.

The default value is 20.

strName​

A String specifying the name of the creating cone.

The default value is "Cone_1".

iPartColor​

An Integer specifying the color of the newly created part.

The default value is 7105764.

crLocalCoordinate​

A Cursor specifying the local coordinate system.

The default value is None.

Return Code​

The return value depends on the status of the creating process:

Cursor: The cone is created successfully.

None: The cone cannot be created.

Sample Code​

cone = Geometry.Part.Cone(dlOrigin=[0.005, 0.005, 0.005], iPartColor=7829501)
JPT.Debugger(cone)
