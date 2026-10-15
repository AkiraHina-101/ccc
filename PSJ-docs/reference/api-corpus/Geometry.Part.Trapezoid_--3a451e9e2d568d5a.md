# Geometry.Part.Trapezoid()

Geometry.Part.Trapezoid()

Description​

Create a trapezoid body in a specific location.
Its relative location is computed to the specified local coordinate system.

Syntax​

Geometry.Part.Trapezoid(...)

Macro: CreateTrapezoid

Ribbon: Geometry » Part » Trapezoid

Inputs​

dlOrigin​

A List of Double specifying the X, Y, and Z coordinates of the origin point (The center of the trapezoid).

The default value is [0.0,0.0,0.0].

dlLength​

A List of Double specifying the trapezoid length in the X, Y, Z direction in meter.

The default value is [0.01,0.01,0.01].

dTopXLength​

A Double specifying the length in the X-axis direction at top face.

The default value is 7.0.

dRadius​

A Double specifying the radius in degrees of top face.

The default value is 0.

ilAxialNodes​

A List of Integer specifying the number of nodes in X-, Y-, Z-axis direction, respectively.

The default value is [10,10,10].

strName​

A String specifying the name of the creating part.

The default value is "Trapezoid_1".

iPartColor​

An Integer specifying the color of the creating part.

The default value is 7105764.

crLocalCoordinate​

A Cursor specifying the local coordinate system.

The default value is None.

Return Code​

The return value depends on the status of the creating process:

Cursor: The trapezoid is created successfully.

None: The trapezoid cannot be created.

Sample Code​

trapezoid = Geometry.Part.Trapezoid(dlLength=[0.02, 0.01, 0.01],
                                    strName="Trapezoid_5",
                                    iPartColor=7961077)
JPT.Debugger(trapezoid)
