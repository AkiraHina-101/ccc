# Geometry.BreakEntity.Face()

Geometry.BreakEntity.Face()

Description​

Break the faces into separate units that are surrounded by edges.

Syntax​

Geometry.BreakEntity.Face(...)

Macro: BreakFace

Ribbon: Geometry » Break Entity » Face

Inputs​

`crlFaces​

A List of Cursor specifying faces to be separated.

This is a required input.

Return Code​

A List of Cursor specifying the faces after the break operation.

Sample Code​

Geometry.Part.Cube()

Geometry.Edge.Line(dllPoints=[[0.01, 0, 0.01], 
                              [0, 0.01, 0.01]], 
                   crlFaces=[Face(26)],
                   bBreakFace=False)

faces = Geometry.BreakEntity.Face(crlFaces=[Face(26)])

JPT.Debugger(faces)
