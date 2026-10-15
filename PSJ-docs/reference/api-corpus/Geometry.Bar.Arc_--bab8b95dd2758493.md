# Geometry.Bar.Arc()

Geometry.Bar.Arc()

Description​

This method creates a Bar body by using three specified points on the arc's circumference.

Syntax​

Geometry.Bar.Arc(crlNodes, crPart=None, strName="Bar_1")

Ribbon: Geometry » Bar » Arc (3 Nodes)

Inputs​

crlNodes​

A List of Cursor specifying three specified points on the arc's circumference. This is a combination of a start point, a point on the arc, and an endpoint.

This is a required input.

crPart​

A Cursor specifying the body part that the arc will belong to. When the default value is used, a new Bar part will be created automatically.

The default value is None.

strName​

A String specifying the name of new part.

The default value is "Bar_1".

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Bar.Arc(crlNodes=[Node(446, 451, 474)])
