# HexModeling.FaceToFace()

HexModeling.FaceToFace()

Description​

Create hexa mesh between selected two faces of a part facing each other.

Syntax​

HexModeling.FaceToFace(...)

Ribbon: HexModeling » FaceToFace

Inputs​

crSrcFace​

A Cursor specifying the source face.

This is a required input.

crDstFace​

A Cursor specifying the dst face.

This is a required input.

bDeleteOriginalParts​

A Boolean specifying the delete original parts.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2", iPartColor=6409934)
Geometry.Transform.Rotation(
    crlParts=[Part(2)], 
    posCenter=[0.005, 0.005, 0.005], 
    vecAxis=[0.0, 0.0, 0.001], 
    dAngle=0.523599, dTol=1e-05)
Geometry.DeleteEntity.Face(crlFaces=[Face(21, 22, 23, 24, 47, 48, 49, 50, 52, 25)])

Geometry.MergeEntities.Parts(crlParts=[Part(1, 2)], dMergeTolerance=1e-05)
Geometry.Face.Edges(crlEdges=[Edge(20, 38)])
Geometry.Face.Edges(crlEdges=[Edge(19, 37)])
Geometry.Face.Edges(crlEdges=[Edge(18, 36)])
Geometry.Face.Edges(crlEdges=[Edge(17, 35)])

Meshing.SetMeshAttribute(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dAvgElemSize=0.002, 
        dGeomAngle=0.7853981634, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dAvgElemSize=0.002, 
        dGeomAngle=0.7853981634, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

HexModeling.FaceToFace(crSrcFace=Face(26), crDstFace=Face(51))
