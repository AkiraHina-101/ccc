# Connections.Pretension.SunShine()

Connections.Pretension.SunShine()

Description​

Create bolt pretension for the SunShine solver.

Syntax​

Connections.Pretension.SunShine(...)

Ribbon: Connections » Pretension » SunShine

Inputs​

crlTargets​

A List of Cursor specifying the list of targets. It can be parts, faces or edges.

This is a required input.

dForceValue​

A Double specifying the value of pretension force.

This is a required input.

strName​

A String specifying the name of pretension force.

The default value is "PreTensionSunShine1".

iLocalUnit​

An Integer specifying local unit.

The default value is 0.

crLbcPretensionSunShine​

A Cursor specifying an existing pretension force (SunShine). 
If this parameter is used, the specified pretension force (SunShine) will be modified.

If it is left None, a new pretension force (SunShine) will be created.

The default value is None.

Return Code​

A Cursor specifying the created SunShine pretension.

Sample Code​

Geometry.Part.Cylinder(dTopOuterRadius=0.003, dBottomOuterRadius=0.003, iPartColor=7697908)
Geometry.Part.Cylinder(strName="Cylinder_2", dlOrigin=[0.0, 0.01, 0.0], dTopOuterRadius=0.003, dBottomOuterRadius=0.003, iPartColor=7463537)
Meshing.SetMeshAttribute(crlParts=[Part(1, 2)], surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634, iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True, iNextEntityOffsetId=0))
Meshing.SurfaceMeshing(crlParts=[Part(1, 2)], surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634, iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True, iNextEntityOffsetId=0))

#Pretension SunShine
Connections.Pretension.SunShine(dForceValue=123.0, crlTargets=[Part(1, 2)])
