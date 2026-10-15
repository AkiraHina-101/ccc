# Geometry.BreakEntity.Part()

Geometry.BreakEntity.Part()

Description​

Separate parts into separated units based on each closed geometries.

Syntax​

Geometry.BreakEntity.Part(...)

Ribbon: Geometry » Break Entity » Part

Inputs​

crlParts​

A List of Cursor specifying parts to be separated.

This is a required input.

Return Code​

A List of Cursor specifying the speparated bodies.

Sample Code​

Geometry.Part.Cube(iPartColor=16147556)
Geometry.DeleteEntity.Face([Face(24, 22, 26, 21, 25)])
Geometry.Edge.Line(dllPoints=[[0, 0.0022, 0], 
                              [0, 0.0022, 0.01]], 
                   crlFaces=[Face(23)])
Geometry.Edge.Line(dllPoints=[[0, 0.0067, 0], 
                              [0, 0.0067, 0.01]], 
                   crlFaces=[Face(23)])
Geometry.DeleteEntity.Face([Face(23)])

bodies = Geometry.BreakEntity.Part(crlParts=[Part(1)])

JPT.Debugger(bodies)
