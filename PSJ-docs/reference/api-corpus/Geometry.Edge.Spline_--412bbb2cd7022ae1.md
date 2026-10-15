# Geometry.Edge.Spline()

Geometry.Edge.Spline()

Description​

Create a spline curve-shaped edge onto a face. At least three nodes on the given faces are specified to create a spline that passes through those nodes.

Syntax​

Geometry.Edge.Spline(...)

Macro: GeoImprintSplineS

Ribbon: Geometry » Edge » Spline

Inputs​

dllPoints​

A Nested List of Double specifying the positions on the given faces that the spline must pass through.

This is a required input.

crlFaces​

A List of Cursor specifying the target faces that the spline belong to.

This is a required input.

bBreakFace​

A Boolean specifying whether to break the given face after the imprint operation.

The default value is True.

Return Code​

A List of Cursor specifying the created spline.

Sample Code​

Geometry.Part.Cube()

created_splines = Geometry.Edge.Spline(dllPoints=[[0.01, 0.003, 0.01],
                                                  [0.007, 0.003, 0.01],
                                                  [0.005, 0.004, 0.01], 
                                                  [0.004, 0.006, 0.01], 
                                                  [0.002, 0.007, 0.01], 
                                                  [0.0, 0.003, 0.01]],
                                       crlFaces=[Face(26)])

JPT.Debugger(created_splines)
