# Assembly.RightClick.RestoreOriginalPart()

Assembly.RightClick.RestoreOriginalPart()

Description​

Replace the current part by using its reference. In case the number of reference = 0, it will keep the current part without changing anything.

Syntax​

Assembly.RightClick.RestoreOriginalPart(...)

Ribbon: Assembly » Right Click » Restore Original Part

Inputs​

crlBodies​

A List of Cursor specifying the list of parts which will be restored.

This is a required input.

bKeepShareFace​

A Boolean specifying whether or not keep share face after restore.

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()
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

restore_status = Assembly.RightClick.RestoreOriginalPart(crlBodies=[Part(1)])

JPT.Debugger(restore_status)
