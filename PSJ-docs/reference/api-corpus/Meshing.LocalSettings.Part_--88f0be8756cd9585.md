# Meshing.LocalSettings.Part()

Meshing.LocalSettings.Part()

説明​

選択したパートのメッシュ設定を設定します（表面メッシュ作成前に設定します）。

構文​

Meshing.LocalSettings.Part(...)

リボン：Meshing » LocalSettings » Part

入力​

strName​

ローカルメッシュ設定の名前を指定する String 。

この入力は必須です。

localMesh​

ローカルメッシュ設定のパラメータを指定する LOCAL_MESH 型。

この入力は必須です。

crlTargets​

ローカルメッシュ設定の対象パートを指定する Cursor リスト。

ハードポイントが必要な場合は、このパラメータを[]にします。代わりに crlHardPointTarget に対象を入力してください。

デフォルト値は[]です。

bUseNode​

ハードポイントオプションの有効/無効を指定する Boolean 値。

デフォルト値は False です。

ilNodeID​

ハードポイントとして使用される節点のIDをいていする Integer リスト。

デフォルト値は[]です。

veclHardPointXYZ​

x、y、z の位置におけるハードポイントの位置を指定する Vector List 型。

デフォルト値は[]です。

crlHardPointTarget​

ハードポイントの対象パートのリストを指定する Cursor リスト。

デフォルト値は[]です。

crEditTarget​

既存のローカルメッシュ設定ポイントを指定する Cursor。

このパラメータを使用すると、指定されたローカルメッシュ設定ポイントが上書きされます。使用しない場合は、新しいローカルメッシュ設定ポイントが作成されます。

デフォルト値は_None_です。

戻り値​

成功した場合、作成されたローカルメッシュ設定を指定する Cursor。失敗した場合、None。

サンプルコード​

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
