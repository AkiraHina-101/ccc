# Meshing.CADProjection.NodeToEdge()

Meshing.CADProjection.NodeToEdge()

Description​

Project nodes of the meshed faces to the selected CAD (Reference) edges.

Syntax​

Meshing.CADProjection.NodeToEdge(...)

Ribbon: Meshing » CADProjection » NodeToEdge

Inputs​

crCadEdge​

A Cursor specifying the CAD Edges. These Edges will be the reference edges for projection.
Note that for CAD edge, Cursor type will take different format from normal cursor's format. Two parameters are now needed: the former is ID (external id) and the latter is Key (internal id).

For example: RefEdge((1,2)) means a CAD edge with ID (external id) = 1 and Key (internal id) = 2.

This is a required input.

crlMeshedNodes​

A List of Cursor specifying the Meshed Nodes. These Nodes will be projected onto the reference edges.

This is a required input.

iDirection​

An Integer specifying the direction for projection.

The default value is 0.

Return Code​

A Boolean specifying the status of the process:

True: Projected nodes to the CAD (Reference) edges.

False: Cannot project nodes to the CAD (Reference) edges.

Sample Code​

Geometry.Part.Cylinder(iPartColor=12603072)

Meshing.SetMeshAttribute(crlParts=[Part(1)],
                         surfaceMesh=SURFACE_MESH(dAvgElemSize=0.004,
                                                  dMaxElemSize=0.015,
                                                  dMinElemSize=0.0005,
                                                  dGeomAngle=0.7853981634,
                                                  dGeomMinSize=0.0005,
                                                  dMinStretchVal=0.0,
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bGeomApprox=True,
                                                  iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(crlParts=[Part(1)],
                       surfaceMesh=SURFACE_MESH(dAvgElemSize=0.004,
                                                dMaxElemSize=0.015,
                                                dMinElemSize=0.0005,
                                                dGeomAngle=0.7853981634,
                                                dGeomMinSize=0.0005,
                                                dMinStretchVal=0.0,
                                                iPerformanceMode=1,
                                                dAutoMergeTinyFacesAngle=0.5235987756,
                                                bGeomApprox=True,
                                                iNextEntityOffsetId=0),
                       iThreadNum=4)

Meshing.SolidMeshing(crlParts=[Part(1)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=4,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

targetn=MainWindow.RightClick.AssociatedPick(crlInput=[Edge(1)],
                                             strTarget="Node")

Meshing.CADProjection.NodeToEdge(crCadEdge=RefEdge((1,1)),
                                 crlMeshedNodes=targetn)
