# HexModeling.Sweep.Curve()

HexModeling.Sweep.Curve()

Description​

Unknown Description

Syntax​

HexModeling.Sweep.Curve(...)

Ribbon: HexModeling » Sweep » Curve

Inputs​

crFace​

A Cursor specifying the face.

The default value is None.

crlEdges​

A List of Cursor specifying the edge.

The default value is [].

crlRefEdge​

A List of Cursor specifying the reference edge.

The default value is [].

dMeshSize​

A Double specifying the mesh size.

The default value is 0.1.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
Geometry.Bar.Spline(crlNodes=[Node(1, 8, 7)], strName="Bar_2")
Geometry.Part.Cylinder(dTopOuterRadius=0.001, dBottomOuterRadius=0.001, iPartColor=6409934)

Geometry.DeleteEntity.Face(crlFaces=[Face(32, 34)])
Geometry.DeleteEntity.Part(crlParts=[Part(1)])

Meshing.SetMeshAttribute(crlParts=[Part(3)], 
    surfaceMesh=SURFACE_MESH(
        dAvgElemSize=0.002, 
        dGeomAngle=0.7853981634, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, bGeomApprox=True, 
        iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(
    crlParts=[Part(3)], 
    surfaceMesh=SURFACE_MESH(
        dAvgElemSize=0.002, 
        dGeomAngle=0.7853981634, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

HexModeling.Curve(crFace=Face(33), crlEdges=[Edge(27)], dMeshSize=0.002)
