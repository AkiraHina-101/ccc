# HexModeling.Layer()

HexModeling.Layer()

Description​

Sweep by layer

Syntax​

HexModeling.Layer(...)

Ribbon: HexModeling » Layer

Inputs​

crlFaces​

A List of Cursor specifying the face.

The default value is [].

dFrontWidth​

A Double specifying the front width.

The default value is 0.0.

dBackWidth​

A Double specifying the back width.

The default value is 0.0.

iFrontLayers​

An Integer specifying the front layers.

The default value is 1.

iBackLayers​

An Integer specifying the back layers.

The default value is 0.

iBaseFaceType​

An Integer specifying the base face type.

The default value is 0.

iSeparate​

An Integer specifying the separate.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(dAvgElemSize=0.002, dGeomAngle=0.7853981634, 
        iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, bGeomApprox=True, iNextEntityOffsetId=0))
Geometry.DeleteEntity.Face(crlFaces=[Face(24, 22, 25, 23, 21)])
HexModeling.Layer(crlFaces=[26], dFrontWidth=0.001, dBackWidth=0.0015, iFrontLayers=3, iBackLayers=2, iBaseFaceType=1)
