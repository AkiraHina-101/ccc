# Geometry.Bar.Spline()

Geometry.Bar.Spline()

Description​

Create a spline-curve bar part passing though the selected nodes.

Syntax​

Geometry.Bar.Spline(...)

Ribbon: Geometry » Bar » Spline

Inputs​

crlNodes​

A List of Cursor specifying either a series of nodes (interpolation points) through which the curve passes. At least three nodes must be specified.

This is a required input.

crPart​

A Cursor specifying the part that the spline bar will belong to. If set none, a new bar part will be created.

The default value is None.

strName​

A String specifying the name of new bar part.

The default value is "Bar_1".

Return Code​

A Cursor specifying the created entity.

If crPart = None then return a cursor of new created bar part.

If crPart is specified then return a cursor of new created edge.

Sample Code​

Geometry.Part.Cube()

newBar = Geometry.Bar.Spline(crlNodes=[Node(440, 463, 443, 474)])
JPT.Debugger(newBar)
