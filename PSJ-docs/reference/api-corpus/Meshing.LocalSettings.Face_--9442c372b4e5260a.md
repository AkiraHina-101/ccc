# Meshing.LocalSettings.Face()

Meshing.LocalSettings.Face()

説明​

選択したフェースのメッシュ設定を行います（表面メッシュ作成前に設定を定義します）。

構文​

Meshing.LocalSettings.Face(...)

リボン: Meshing » LocalSettings » Face

入力​

strName​

ローカルメッシュ設定名を指定する String です。

この入力は必須です。

localMesh​

ローカルメッシュ設定のパラメータを指定する LOCAL_MESH です。

この入力は必須です。

crlTargets​

ローカルメッシュ設定の対象フェースを指定する Cursor リストです。

この入力は必須です。

crEditTarget​

存在するローカルメッシュ設定フェースを指定する Cursor です。このパラメータを使用すると、指定されたローカルメッシュ設定フェースが上書きされます。使用しない場合、新しいローカルメッシュ設定フェースが作成されます。

デフォルト値は None です。

戻り値​

成功した場合、作成されたローカルメッシュ設定を指定する Cursor 、失敗した場合は None となります。

サンプルコード​

Geometry.Part.Cube()

local_mesh = Meshing.LocalSettings.Face(strName="MeshParam_1", 
                                        localMesh=LOCAL_MESH(iEntityType=3, 
                                                             dAvgElemSize=0.005, 
                                                             dMaxElemSize=0.01, 
                                                             dMinElemSize=0.001, 
                                                             dTrimAngle=0.7853981634, 
                                                             bEnableMeshCount=True, 
                                                             iNodeCount=8), 
                                        crlTargets=[Face(26)])

JPT.Debugger(local_mesh)

Geometry.FCircVertexAdjust(crlParts=[Part(1)])

Meshing.SetMeshAttribute(crlParts=[Part(1)], 
                         surfaceMesh=SURFACE_MESH(dMaxElemSize=0.015, 
                                                  dMinElemSize=0.0005,
                                                  dGeomAngle=0.7853981634, 
                                                  dGeomMinSize=0.0005, 
                                                  dMinStretchVal=0.0, 
                                                  iPerformanceMode=1, 
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bGeomApprox=True, 
                                                  iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(crlParts=[Part(1)], 
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
