# Meshing.LocalSettings.Part()

Meshing.LocalSettings.Part()

Description​

Set the mesh setting for the selected parts (Define the settings before surface mesh creation).

Syntax​

Meshing.LocalSettings.Part(...)

Ribbon: Meshing » LocalSettings » Part

Inputs​

strName​

A String specifying the name of the local mesh setting.

This is a required input.

localMesh​

A LOCAL_MESH specifying the local mesh setting's parameter.

This is a required input.

crlTargets​

A List of Cursor specifying the target Parts of the local mesh setting. If hard point is needed, this parameter should be []. Instead, enter target in crlHardPointTarget.

The default value is [].

veclHardPointXYZ​

A Vector List specifying the list of hard points's position in terms of x, y, z.

The default value is [].

crlHardPointTarget​

A List of Cursor specifying the list of hard points's target Part.

The default value is [].

crEditTarget​

A Cursor specifying an existed local mesh setting Point. When this parameter is used, the specified local mesh setting Point will be overwritten. When it is not used, a new local mesh setting Point will be created.

The default value is None.

Return Code​

A Cursor specifying the created local mesh setting if success, or None if fail.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.0, 0.01, 0.0], strName="Cube_2", iPartColor=6409934)

Geometry.Part.Cube()

local_mesh = Meshing.LocalSettings.Part(strName="MeshParam_1", 
                                        localMesh=LOCAL_MESH(iEntityType=1,
                                                             bEnableSizeParams=True, 
                                                             dAvgElemSize=0.002, 
                                                             dMaxElemSize=0.01, 
                                                             dMinElemSize=0.001), 
                                        crlTargets=[Part(1)])

JPT.Debugger(local_mesh)

MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.001, 0.001, 0.001]], ilNewNodeID=[977])

local_mesh = Meshing.LocalSettings.Part(strName="MeshParam_2", 
                                        localMesh=LOCAL_MESH(iEntityType=10,
                                                             dAvgElemSize=0.002, 
                                                             dMaxElemSize=0.01, 
                                                             dMinElemSize=0.001),
                                        veclHardPointXYZ=[[0.001, 
                                                           0.001, 
                                                           0.001]], 
                                        crlHardPointTarget=[Part(1)])

JPT.Debugger(local_mesh)

Geometry.FCircVertexAdjust(crlParts=[Part(1, 2)])

Meshing.SetMeshAttribute(crlParts=[Part(1, 2)], 
                         surfaceMesh=SURFACE_MESH(dMaxElemSize=0.015,
                                                  dMinElemSize=0.0005, 
                                                  dGeomAngle=0.7853981634, 
                                                  dGeomMinSize=0.0005, 
                                                  dMinStretchVal=0.0, 
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756, 
                                                  bGeomApprox=True, 
                                                  iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(crlParts=[Part(1, 2)], 
                       surfaceMesh=SURFACE_MESH(dMaxElemSize=0.015, 
                                                dMinElemSize=0.0005,
                                                dGeomAngle=0.7853981634, 
                                                dGeomMinSize=0.0005, 
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
