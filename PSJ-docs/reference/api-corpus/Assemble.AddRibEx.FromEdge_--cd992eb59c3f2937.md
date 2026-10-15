# Assemble.AddRibEx.FromEdge()

Assemble.AddRibEx.FromEdge()

Description​

Specify an edge to define the path of the rib and the attachment surface, and add the rib shape to the existing surface mesh.

Syntax​

Assemble.AddRibEx.FromEdge(...)

Macro: AddRibFromEdgesEx

Ribbon: Assemble » AddRibEx » FromEdge

Inputs​

crlFaces​

A List of Cursor specifying the target face where the created rib will be attached.

This is a required input.

crlEdges​

A List of Cursor specifying edge where the rib created from.

This is a required input.

dThickness​

A Double specifying the width of the rib.

The default value is 0.001.

dHeight​

A Double specifying the height of the rib from the attachment surface.

The default value is 0.001.

iDirection​

An Int specifying the direction of the rib from the attachment surface.

0: Normal Offset

1: Offset

2: Projection

The default value is 0.

crCoordinate​

A Cursor specifying the coordinate system to reference when attaching the rib.

The default value is None.

iBasePlane​

An Integer specifying the direction of rib extrusion when Offset or Projection is selected for Direction.

0: XY plane

1: YZ plane

2: XZ plane

The default value is 0.

dOffsetX​

A Double specifying the offset value the rib creation position in X direction.

The default value is 0.0.

dOffsetY​

A Double specifying the offset value the rib creation position in Y direction.

The default value is 0.0.

dOffsetZ​

A Double specifying the offset value the rib creation position in Z direction.

The default value is 0.0.

iRibTriangle​

An Integer specifying to make the rib triangular.

0: Creates a normal rib without making it triangular.

1: Creates a triangular rib with a higher starting point.

2: Creates a triangular rib with a higher ending point.

bCreateNewPart​

A Boolean specifying whether or not to create the rib as a new part.

The default value is False.

bMerge​

A Boolean specifying whether or not to merge the rib with the attachment part.

The default value is True.

bPreview​

A Boolean specifying whether or not to display preview.

The default value is True.

Return Code​

A Boolean specifying

Sample Code​

Geometry.Part.Cube(iPartColor=11776856)

Geometry.Edge.Spline(
    dllPoints=[
        [0.003333333333333333, 0.001111111111111111, 0.01], 
        [0.002222222222222222, 0.007777777777777778, 0.01], 
        [0.006666666666666666, 0.005555555555555556, 0.01], 
        [0.008888888888888889, 0.006666666666666666, 0.01]], 
    crlFaces=[Face(26)])

Assemble.AddRibEx.FromEdge(
    crlFaces=[Face(26)], 
    crlEdges=[Edge(41)], 
    dThickness=0.001, 
    dHeight=0.001)
