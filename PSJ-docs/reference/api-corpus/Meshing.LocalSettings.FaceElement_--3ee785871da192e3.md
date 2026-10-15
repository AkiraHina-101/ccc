# Meshing.LocalSettings.FaceElement()

Meshing.LocalSettings.FaceElement()

Description​

Set the mesh setting for the selected elements (Define the settings before surface mesh creation).

Syntax​

Meshing.LocalSettings.FaceElement(...)

Ribbon: Meshing » LocalSettings » FaceElement

Inputs​

strName​

A String specifying the name of the local mesh setting.

This is a required input.

localMesh​

A LOCAL_MESH specifying the local mesh setting's parameter.

This is a required input.

crlTargets​

A List of Cursor specifying the target Elements of the local mesh setting.

This is a required input.

crEditTarget​

A Cursor specifying an existed local mesh setting Face. When this parameter is used, the specified local mesh setting Face will be overwritten. When it is not used, a new local mesh setting Face will be created.

The default value is None.

Return Code​

A Cursor specifying the created local mesh setting.

Sample Code​

Geometry.Part.Cube()

created_local_mesh_setting = Meshing.LocalSettings.FaceElement(strName="MeshParam_1", 
                                                               localMesh=LOCAL_MESH(iEntityType=2,
                                                                                    bEnableSizeParams=True, 
                                                                                    dAvgElemSize=0.005, 
                                                                                    dMaxElemSize=0.01, 
                                                                                    dMinElemSize=0.001), 
                                                               crlTargets=[Elem(970)])

JPT.Debugger(created_local_mesh_setting)
