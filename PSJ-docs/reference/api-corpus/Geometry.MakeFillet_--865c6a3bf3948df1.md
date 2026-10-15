# Geometry.MakeFillet()

Geometry.MakeFillet()

Description​

This method creates a smooth transition surface between two adjacent faces, which need to share at least one edge.

Syntax​

Geometry.MakeFillet(crlEdges, dRadius=1.0)

Ribbon: Geometry » Make Fillet

Inputs​

crlEdges​

A List of Cursor specifying shared edges between adjacent faces.

This is a required input.

dRadius​

A Double specifying the radius applied to the entire given edges.

The default value is 1.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.MakeFillet(crlEdges=[Edge(17, 19)])
