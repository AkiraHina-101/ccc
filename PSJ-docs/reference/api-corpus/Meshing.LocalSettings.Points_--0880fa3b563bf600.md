# Meshing.LocalSettings.Points()

Meshing.LocalSettings.Points()

Description​

Specify setting for fixed node position (Hard Point) when you create surface mesh, to ensure node creation at a specified location.

Syntax​

Meshing.LocalSettings.Points(...)

Ribbon: Meshing » LocalSettings » Points

Inputs​

strName​

A String specifying the name of the local mesh setting.

This is a required input.

localMesh​

A LOCAL_MESH
specifying the local mesh setting's parameter.

This is a required input.

veclHardPointXYZ​

A Vector List specifying the list of hard points' position in terms of x, y, z.

This is a required input.

crlHardPointTarget​

A List of Cursor specifying the list of hard points' target. If point is on Face, target is that Face. If point is on Edge, target is that Edge.

This is a required input.

crEditTarget​

A Cursor specifying an existed local mesh setting Point. When this parameter is used, the specified local mesh setting Point will be overwritten. When it is not used, a new local mesh setting Point will be created.

The default value is None.

Return Code​

A Cursor of the newly created local mesh setting.

Sample Code​

Geometry.Part.Cube(iPartColor=7731705)
Meshing.LocalSettings.Points(strName="MeshParam_1", localMesh=LOCAL_MESH(bEnableSizeParams=True,
  dAvgElemSize=0.002, dMaxElemSize=0.01, dMinElemSize=0.001), veclHardPointXYZ=[[0.002078861077076959,
  0.008516764027639453, 0.01]], crlHardPointTarget=[Face(26)])
Meshing.SetMeshAttribute(crlParts=[Part(1)], surfaceMesh=SURFACE_MESH(dMinElemSize=0.0005,
  dGeomAngle=0.7853981634, dGeomMinSize=0.0005, iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756,
  bGeomApprox=True, iNextEntityOffsetId=0))
Meshing.SurfaceMeshing(crlParts=[Part(1)], surfaceMesh=SURFACE_MESH(dMinElemSize=0.0005, dGeomAngle=0.7853981634,
  dGeomMinSize=0.0005, iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True,
  iNextEntityOffsetId=0), iThreadNum=4)
