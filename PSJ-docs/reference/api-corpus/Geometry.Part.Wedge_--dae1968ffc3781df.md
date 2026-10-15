# Geometry.Part.Wedge()

Geometry.Part.Wedge()

Description​

Create a wedge shaped body in a specific location. This relative location is computed to the specified local coordinate system.

Syntax​

Geometry.Part.Wedge(...)

Macro: CreateWedge

Ribbon: Geometry » Part » Wedge

Inputs​

dlOrigin​

A List of Double representing the X-, Y-, and Z-coordinates of f the center of the wedge.

The default value is [0.0,0.0,0.0].

dlLength​

A List of Double specifying length in meters in the X-, Y-, Z-axis direction.

The default value is [0.01,0.01,0.01].

ilAxialNodes​

A List of Integer specifying the number of nodes along to each X-, Y-, Z-axis.

The default value is [10,10,10].

strName​

A String specifying the name of the newly created part.

The default value is "Wedge_1".

iPartColor​

An Integer specifying the color of the newly created part.

The default value is 7105764.

crLocalCoordinate​

A Cursor specifying the local coordinate system.

The default value is None.

Return Code​

A Cursor specifying the new wedge body.

Sample Code​

wedge = Geometry.Part.Wedge(dlOrigin=[0.005, 0.005, 0.005], strName="Wedge", iPartColor=6409934)

JPT.Debugger(wedge)
