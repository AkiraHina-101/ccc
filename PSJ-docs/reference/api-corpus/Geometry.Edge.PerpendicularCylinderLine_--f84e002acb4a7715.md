# Geometry.Edge.PerpendicularCylinderLine()

Geometry.Edge.PerpendicularCylinderLine()

Description​

Create a perpendicular line to the circular face on the curved face which can offset the imprinted line by specifying an angle value or an edge length value.

Syntax​

Geometry.Edge.PerpendicularCylinderLine(...)

Macro: ImprintPerpendicularCylinderLineS

Ribbon: Geometry » Edge » Perpendicular Cylinder Line

Inputs​

crlNodes​

A List of Cursor specifying the couple nodes, which the first node is the start node where the perpendicular line will be drawn, the second node is used to determine the offset direction (in case of user want to offset).

This is a required input.

crlFaces​

A List of Cursor specifying the faces. The selected face could be curved surface or circular surface.

This is a required input.

iMethod​

An Integer specifying the Imprint method. The method will be represented by the value according to order of selection in the combobox method.

If iMethod=0: Center Angle - The angle at the cylindrical center of a perpendicular position

If iMethod=1: Arc length - The distance on the circumference of a perpendicular position

The default value is 0.

dOffset​

A Double specifying the offset value. The offset value would be an angle degrees or length of an arc of a circle in millimeters, which is depended on selection method.

The default value is 0.0.

bOppositeSide​

A Boolean specifying whether the opposite side option is checked or not. This argument will allow to imprint 2 lines in both side of selected face.

If True, Jupiter will create 2 lines in both sides of the curved surface of the cylinder. In case of the selection face is a circular face, the imprinted line will continuously go through the center node and cut the edge at a node that opposites to the start node.

If False, Jupiter will create only 1 line that defined by start node.

The default value is False.

bBreakFace​

A Boolean specifying whether the breaking face option is checked or not.

If True, Jupiter will break faces after imprinted the perpendicular line on the selected face.

If False, Jupiter won't break the target face after imprinted the perpendicular line.

The default value is True.

Return Code​

A List of Cursor refers to the created edges.

Sample Code​

Geometry.Part.Cylinder(iPartColor=5093709)

edges = Geometry.Edge.PerpendicularCylinderLine(crlNodes=[Node(19, 157)], 
                                                crlFaces=[Face(5)],
                                                dOffset=1.0, 
                                                bOppositeSide=True)

JPT.Debugger(edges)
