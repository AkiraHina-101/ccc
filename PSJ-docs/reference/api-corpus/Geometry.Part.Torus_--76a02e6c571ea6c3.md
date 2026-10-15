# Geometry.Part.Torus()

Geometry.Part.Torus()

Description​

Create a donut body in a specific location. Its relative location is computed to the specified local coordinate system.

Syntax​

Geometry.Part.Torus(...)

Macro: CreateTorus

Ribbon: Geometry » Part » Torus

Inputs​

dlOrigin​

A List of Double specifying the X, Y, and Z coordinates of the origin point (The center of the torus).

The default value is [0.0,0.0,0.0].

dInnerRadius​

A Double specifying the radius of the inner circle of the torus in meter.

The default value is 0.015.

dRingRadius​

A Double specifying the radius of the ring of the torus in meter.

The default value is 0.02.

iCircumNodes​

An Integer specifying the number of nodes to be generated on the circumference of the ring of the torus.

The default value is 20.

iRingNodes​

An Integer specifying the number of nodes to be generated on the cross-section of the ring of the torus.

The default value is 20.

strName​

A String specifying the name of the creating part.

The default value is "Torus_1".

iPartColor​

An Integer specifying the color of the creating part.

The default value is 7105764.

crLocalCoordinate​

A Cursor specifying the local coordinate system.

The default value is None.

Return Code​

The return value depends on the status of the creating process:

Cursor: The torus is created successfully.

None: The torus cannot be created.

Sample Code​

torus = Geometry.Part.Torus(dlOrigin=[0.005, 0.005, 0.005], strName="Torus", iPartColor=7697908)
JPT.Debugger(torus)
