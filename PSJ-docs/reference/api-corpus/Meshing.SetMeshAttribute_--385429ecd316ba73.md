# Meshing.SetMeshAttribute()

Meshing.SetMeshAttribute()

Description​

Set mesh attribute for the selected part.

注記

This function will be used with Meshing.SurfaceMeshing function.

Syntax​

Meshing.SetMeshAttribute(...)

Ribbon: Meshing » SetMeshAttribute

Inputs​

crlParts​

A List of Cursor specifying the Parts to be set up with mesh setting.

This is a required input.

surfaceMesh​

A SURFACE_MESH specifying the surface mesh parameter. This parameter will change the mesher's setting.

This is a required input.

Return Code​

A Boolean of True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.FCircleAdjustVertex(crlParts=[Part(1)])

mesh_attribute = Meshing.SetMeshAttribute(crlParts=[Part(1)], 
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

JPT.Debugger(mesh_attribute)

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
