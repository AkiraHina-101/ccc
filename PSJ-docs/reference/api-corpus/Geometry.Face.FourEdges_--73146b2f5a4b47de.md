# Geometry.Face.FourEdges()

Geometry.Face.FourEdges()

Description​

Create a face using the given four edges as the face's boundaries. The given edges must form a closed profile and must not contain multiple loops.

Syntax​

Geometry.Face.FourEdges(...)

Macro: CreateFaceFromFourEdges

Ribbon: Geometry » Face » Edges2 (4 Edges)

Inputs​

crlEdges​

A List of Cursor specifying four edges that bound the new face. The edges must form a closed profile and must not contain multiple loops.

This is a required input.

Return Code​

A Cursor specifying the new created face.

Sample Code​

Geometry.Part.Cube()

Geometry.DeleteEntity.Face(crlFaces=[Face(26)])

created_face = Geometry.Face.FourEdges(crlEdges=[Edge(17, 18, 19, 20)])

JPT.Debugger(created_face)
