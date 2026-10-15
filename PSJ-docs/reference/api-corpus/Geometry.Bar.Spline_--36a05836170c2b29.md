# Geometry.Bar.Spline()

Geometry.Bar.Spline()

Description​

This method creates a spline curve-shaped Bar body by specifying either a series of interpolation points through which the curve passes. A spline created with interpolation points will pass exactly through the interpolation points used to define it.

Syntax​

Geometry.Bar.Spline(crlNodes, crPart=None, strName="Bar_1")

Ribbon: Geometry » Bar » Spline

Inputs​

crlNodes​

A List of Cursor specifying either a series of interpolation points through which the curve passes. At least three points must be specified.

This is a required input.

crPart​

A Cursor specifying the part that spline will belong to. When the default value is used, a new Bar part will be created automatically.

The default value is None.

strName​

A String specifying the name of new part.

The default value is "Bar_1".

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Bar.Spline(crlNodes=[Node(440, 463, 443, 474)])
