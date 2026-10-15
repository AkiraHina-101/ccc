# Geometry.Edge.IntersectionLine()

Geometry.Edge.IntersectionLine()

Description​

This method generates an Edge along the intersection line of two faces.

Syntax​

Geometry.Edge.IntersectionLine(crlFaces=[], bBreakFace=True)

Ribbon: Geometry » Edge » Intersection Line

Inputs​

crlFaces​

A List of Cursor specifying the intersection faces.

The default value is [].

bBreakFace​

A Boolean specifying whether to break the given faces where possible.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Face.Edges(crlEdges=[Edge(20, 10)], bCreatePart=True)

Geometry.Face.Edges(crlEdges=[Edge(18, 12)], bCreatePart=True)

Geometry.DeleteEntity.Part(crlParts=[Part(1)])

Geometry.Edge.IntersectionLine(crlFaces=[Face(27), Face(30)], bBreakFace=True)
