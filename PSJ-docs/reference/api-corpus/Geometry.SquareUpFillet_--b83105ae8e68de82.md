# Geometry.SquareUpFillet()

Geometry.SquareUpFillet()

Description​

This method turns fillet parts into rectangular angles.

Syntax​

Geometry.SquareUpFillet(crlFaces)

Macro: SquareUpFillet

Ribbon: Geometry » Square Up Fillet

Inputs​

crlFaces​

A List of Cursor specifying fillet faces to square up.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.MakeFillet(crlEdges=[Edge(19)])

Geometry.SquareUpFillet(crlFaces=[Face(27)])
