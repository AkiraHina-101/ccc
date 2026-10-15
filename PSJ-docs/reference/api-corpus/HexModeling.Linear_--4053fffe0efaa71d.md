# HexModeling.Linear()

HexModeling.Linear()

Description​

Linear hex mesh creation

Syntax​

HexModeling.Linear(...)

Ribbon: HexModeling » Linear

Inputs​

crlFaces​

A List of Cursor specifying the face.

The default value is [].

dLength​

A Double specifying the length.

The default value is 10.

iLayer​

An Integer specifying the layer.

The default value is 10.

vecSweepDirection​

A Vector specifying the sweep direction.

The default value is [].

bInterfaceElemFlag​

A Boolean specifying the interface element flag.

The default value is False.

iLinearMethod​

An Integer specifying the linear method.

The default value is 0.

bDeleteOriginalParts​

A Boolean specifying the delete original parts.

The default value is False.

bDeleteTargetParts​

A Boolean specifying the delete target parts.

The default value is False.

iMethodBias​

An Integer specifying the method bias.

The default value is 0.

dFactor​

A Double specifying the factor.

The default value is 2.0.

iProgression​

An Integer specifying the progression.

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
HexModeling.Linear(crlFaces=[Face(26)], dLength=0.01, vecSweepDirection=[0.0, 0.0, 1.0])
