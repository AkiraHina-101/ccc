# MeshCleanup.Manual2D.RemeshElement()

MeshCleanup.Manual2D.RemeshElement()

Description​

Local surface remesh

Syntax​

MeshCleanup.Manual2D.RemeshElement(crlTargets=[], surfaceMesh=SURFACE_MESH(), bUseSetting=False, bGrading=False, bFMesher=False, iOverrideType=0, bKeepConnection=False, bProjCAD=False, bTinyFaceMerge=False, dMinFaceWidth=0, dMaxFaceWidth=0.001, bIDchcek=False, bKeepRemeshEdge=False)

Ribbon: MeshCleanup » Manual2D » RemeshElement

Inputs​

crlTargets​

A List of Cursor specifying the target.

The default value is [].

surfaceMesh​

A SURFACE_MESH specifying the mesh.

The default value is SURFACE_MESH.

bUseSetting​

A Boolean specifying the use setting.

The default value is False.

bGrading​

A Boolean specifying the grading.

The default value is False.

bFMesher​

A Boolean specifying the mesher.

The default value is False.

iOverrideType​

An Integer specifying the override type.

The default value is 0.

bKeepConnection​

A Boolean specifying the keep connection.

The default value is False.

bProjCAD​

A Boolean specifying the projection CAD.

The default value is False.

bTinyFaceMerge​

A Boolean specifying the tiny face merge.

The default value is False.

dMinFaceWidth​

A Double specifying the minimum face width.

The default value is 0.

dMaxFaceWidth​

A Double specifying the maximum face width.

The default value is 0.001.

bIDchcek​

A Boolean specifying the i dchcek.

The default value is False.

bKeepRemeshEdge​

A Boolean specifying the keep remesh edge.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshCleanup.Manual2D.RemeshElement(crlTargets=[], surfaceMesh=SURFACE_MESH(), bUseSetting=False, bGrading=False, bFMesher=False, iOverrideType=0, bKeepConnection=False, bProjCAD=False, bTinyFaceMerge=False, dMinFaceWidth=0, dMaxFaceWidth=0.001, bIDchcek=False, bKeepRemeshEdge=False)
