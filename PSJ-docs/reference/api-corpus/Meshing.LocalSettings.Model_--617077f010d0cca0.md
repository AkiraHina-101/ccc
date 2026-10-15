# Meshing.LocalSettings.Model()

Meshing.LocalSettings.Model()

Description​

Set the mesh setting for the whole model (Define the settings before surface mesh creation).

Syntax​

Meshing.LocalSettings.Model(...)

Ribbon: Meshing » LocalSettings » Model

Inputs​

strName​

A String specifying the name of the local mesh setting.

This is a required input.

localMesh​

A LOCAL_MESH specifying the local mesh setting's parameter.

This is a required input.

spaceMesh​

A SPACE_MESH specifying the space mesh setting's parameter.

This is a required input.

crlTargets​

A List of Cursor specifying the target Faces of the local mesh setting.

This is a required input.

crEditTarget​

A Cursor specifying the edit target.

The default value is None.

Return Code​

A Cursor specifying the created local mesh setting.

Sample Code​

Geometry.Part.Cube()

Meshing.LocalSetting.SearchTargetFaces(dlLength=[0.003, 0.003, 0.003],
                                       dlAxisPt1=[0.0, 0.0, 0.01],
                                       dlAxisPt2=[0.005, 0.0, 0.0])

created_local_mesh_setting = Meshing.LocalSettings.Model(strName="MeshParam_1",
                                                         localMesh=LOCAL_MESH(iEntityType=11,
                                                                              bEnableSizeParams=True,
                                                                              dAvgElemSize=0.001,
                                                                              dMaxElemSize=0.01,
                                                                              dMinElemSize=0.0005,
                                                                              dTrimAngle=0.7853981634),
                                                         spaceMesh=SPACE_MESH(vLength=[0.003, 0.003, 0.003],
                                                                              vAxisPt2=[0.005, 0.0, 0.0],
                                                                              dMinElemSize=0.001),
                                                         crlTargets=[Face(21, 23, 25)])

JPT.Debugger(created_local_mesh_setting)
