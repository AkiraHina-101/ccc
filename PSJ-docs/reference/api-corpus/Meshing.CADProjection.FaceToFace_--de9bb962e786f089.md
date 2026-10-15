# Meshing.CADProjection.FaceToFace()

Meshing.CADProjection.FaceToFace()

Description​

Project nodes of the meshed faces to the selected CAD (Reference) faces.

Syntax​

Meshing.CADProjection.FaceToFace(...)

Ribbon: Meshing » CADProjection » FaceToFace

Inputs​

crlCadFaces​

A List of Cursor specifying the CAD Faces. These Faces will be the reference faces for projection.
Note that for CAD face, Cursor type will take different format from normal cursor's format. Two parameters are now needed: the former is ID (external id) and the latter is Key (internal id).

For example: RefFace((1,2)) means a CAD face with ID (external id) = 1 and Key (internal id) = 2.

This is a required input.

crlMeshedFaces​

A List of Cursor specifying the Meshed Faces. This face will be projected onto reference faces.

This is a required input.

<!--bForceProject​

A Boolean to enable/disable forcing projection. If True, Jupiter will try to do projection more aggressively, hence may takes more time to finish.

The default value is False.

bProjectCornerNodes​

A Boolean to enable/disable corner nodes projection. If True, corner nodes of elements will be projected.

The default value is False.

bProjectMidNodes​

A Boolean to enable/disable mid nodes projection. If True, mid nodes of elements will be projected.

The default value is True.

bIDcheck​

A Boolean to enable/disable ID check when projecting.

The default value is True.

Return Code​

A Boolean specifying the status of the process:

True: Projected the nodes of the meshed faces to the CAD (Reference) faces.

False: Cannot project the nodes of the meshed faces to the CAD (Reference) faces.

Sample Code​

Geometry.Part.Cylinder()
Geometry.Part.Cylinder(dlOrigin=[0.0, 0.0, 0.02], strName="Cylinder_2", iPartColor=6409934)

Geometry.FCircVertexAdjust(crlParts=[Part(1, 2)])
Meshing.SetMeshAttribute(crlParts=[Part(1, 2)],
                         surfaceMesh=SURFACE_MESH(dMaxElemSize=0.015,
                                                  dMinElemSize=0.0005,
                                                  dGeomAngle=0.7853981634,
                                                  dMinStretchVal=0.0,
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bGeomApprox=True,
                                                  iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(crlParts=[Part(1, 2)],
                       surfaceMesh=SURFACE_MESH(dMaxElemSize=0.015,
                                                dMinElemSize=0.0005,
                                                dGeomAngle=0.7853981634,
                                                dMinStretchVal=0.0,
                                                iPerformanceMode=1,
                                                dAutoMergeTinyFacesAngle=0.5235987756,
                                                bGeomApprox=True,
                                                iNextEntityOffsetId=0),
                       iThreadNum=4)

Meshing.SolidMeshing(crlParts=[Part(1, 2)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=4,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

Meshing.CADProjection.FaceToFace(crlCadFaces=[RefFace((5, 5))],
                                 crlMeshedFaces=[Face(10)],
                                 bProjectCornerNodes=True,
                                 bIDcheck=False)
