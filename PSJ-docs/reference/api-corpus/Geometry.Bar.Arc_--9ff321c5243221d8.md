# Geometry.Bar.Arc()

Geometry.Bar.Arc()

Description​

Create an arc-shaped bar part passing though the 3 selected nodes.

Syntax​

Geometry.Bar.Arc(...)

Ribbon: Geometry » Bar » Arc (3 Nodes)

Inputs​

crlNodes​

A List of Cursor specifying three specified nodes to create arc.

This is a required input.

crPart​

A Cursor specifying the part that the arc-shaped bar will belong to. If set none, a new bar part will be created.

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

newBar = Geometry.Bar.Arc(crlNodes=[Node(446, 451, 474)])
JPT.Debugger(newBar)
