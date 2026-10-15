# Meshing.SurfaceMeshing()

Meshing.SurfaceMeshing()

Description​

Do 2D meshing for the selected parts. The Meshing.SetMeshAttribute function will be used as input parameters.

note

This function support triangular and quadrilateral element.

Syntax​

Meshing.SurfaceMeshing(...)

Macro: SurfaceMeshing2D

Ribbon: Meshing » Surface Meshing

Inputs​

crlParts​

A List of Cursor specifying the parts needed to create mesh.

This is a required input.

surfaceMesh​

A SURFACE_MESH specifying the mesh parameter.

This is a required input.

bUseSetting​

A Boolean to enable or disable the use of local setting. If this parameter is disabled (False), the existing local mesh setting will not be used.

The default value is True.

bFMesher​

A Boolean specifying the status of F-mesher (Disabled/Enabled). F-mesher is a mesher to create only Quad4 elements. If surfaceMesh is set to create Tri3 element, this options does not have any effect.

The default value is False.

iThreadNum​

An Integer specifying the number of CPU threads for parallel meshing. This mesher create parallel meshing for each independent (no assembled face) part on each thread. If 2 parts are assembled together, they will be treated as a single part for parallel meshing. This parameter must be smaller than the maximum number of CPU cores.

The default value is 8.

bRefData​

A Boolean specifying the status of the creating of Reference data (Disabled/Enabled). Reference data is used to store CAD model. If this parameter is enabled (True), Reference data will be kept after meshing.

The default value is True.

bMeshColor​

A Boolean to enable or disable the use of mesh color. If this parameter is enabled (True), the result meshed parts will be colored as described by iPartColor.

The default value is False.

iPartColor​

An Integer specifying the color of result meshed parts.

The default value is 65280 (White).

Return Code​

A Boolean of True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()
Meshing.SetMeshAttribute(crlParts=[Part(1)], 
                         surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                  iOptLevel=5, 
                                                  dAutoMergeTinyFacesAngle=0.5235987756, 
                                                  bGeomApprox=True, 
                                                  iNextEntityOffsetId=0))

meshing_status = Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                                        surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                                 iOptLevel=5, 
                                                                 dAutoMergeTinyFacesAngle=0.5235987756, 
                                                                 bGeomApprox=True, 
                                                                 iNextEntityOffsetId=0))

JPT.Debugger(meshing_status)
