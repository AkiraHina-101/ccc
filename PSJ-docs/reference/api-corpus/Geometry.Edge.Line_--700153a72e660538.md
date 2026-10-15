# Geometry.Edge.Line()

Geometry.Edge.Line()

Description​

Create edges based on the selected nodes.

Syntax​

Geometry.Edge.Line(...)

Macro: ImprintLineS

Ribbon: Geometry » Edge » Line

Inputs​

dllPoints​

A List of Position specifying points on the target faces.

This is a required input.

crlFaces​

A List of Cursor specifying the target faces.

This is a required input.

bBreakFace​

A Boolean specifying whether to break the target faces where possible.

The default value is True.

Return Code​

A List of Cursor specifying the created edges if success, or None if fail.

Sample Code​

Geometry.Part.Cube(iPartColor=6215639)

created_edges = Geometry.Edge.Line(dllPoints=[[0.01, 0, 0.01], 
                                              [0, 0.01, 0.01]], 
                                   crlFaces=[Face(26)])

JPT.Debugger(created_edges)
