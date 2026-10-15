# Meshing.CADProjection.NodeToFace()

Meshing.CADProjection.NodeToFace()

Description​

Project nodes to the selected CAD (Reference) faces.

Syntax​

Meshing.CADProjection.NodeToFace(...)

Ribbon: Meshing » CADProjection » NodeToFace

Inputs​

crlCadFaces​

A List of Cursor specifying the CAD Faces. These Faces will be the reference faces for projection.
Note that for CAD face, Cursor type will take different format from normal cursor's format. Two parameters are now needed: the former is ID (external id) and the latter is Key (internal id).

For example: RefFace((1,2)) means a CAD face with ID (external id) = 1 and Key (internal id) = 2.

This is a required input.

crlMeshedNodes​

A List of Cursor specifying the Meshed Nodes. These Nodes will be projected onto the reference faces.

This is a required input.

iDirection​

An Integer specifying the direction for projection. Cannot be used together with iImproveQuality.

The default value is 0.

iImproveQuality​

An Integer specifying whether improve quality is needed or not. Improve quality means to adjust the elements after creation, to optimize the quality.

The default value is 0.

note

Selected projection direction (iDirection) is ignored in this case.

Return Code​

A Boolean specifying the status of the process:

True: Projected nodes to the CAD (Reference) faces.

False: Cannot project nodes to the CAD (Reference) faces.

Sample Code​

Geometry.Part.Cylinder(iPartColor=15658599)

Meshing.SetMeshAttribute(crlParts=[Part(1)],
                         surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bGeomApprox=True,
                                                  iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(crlParts=[Part(1)],
                       surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                iPerformanceMode=1,
                                                dAutoMergeTinyFacesAngle=0.5235987756,
                                                bGeomApprox=True,
                                                iNextEntityOffsetId=0))

Meshing.SolidMeshing(crlParts=[Part(1)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=8,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

Meshing.CADProjection.NodeToFace(crlCadFaces=[RefFace((5,5))],
                                 crlMeshedNodes=[Node(691)])
