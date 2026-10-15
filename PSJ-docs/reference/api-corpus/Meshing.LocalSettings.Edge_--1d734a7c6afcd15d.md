# Meshing.LocalSettings.Edge()

Meshing.LocalSettings.Edge()

説明​

選択したエッジのメッシュ設定を設定します（表面メッシュ作成前に設定を定義します）。

構文​

Meshing.LocalSettings.Edge(...)

リボン: Meshing » LocalSettings » Edge

入力​

strName​

ローカルメッシュ設定の名前を指定する String 。

これは必須の入力です。

localMesh​

エンティティ型=3、平均要素サイズ=0.005、最大要素サイズ=0.01、最小要素サイズ=0.001、トリム角度=0.7853981634、メッシュ数有効=true、節点数=8を持つローカルメッシュ設定のパラメータを指定する LOCAL_MESH 型。

これは必須の入力です。

crlTargets​

ローカルメッシュ設定の対象エッジを指定する Cursor のリスト。

これは必須の入力です。

crEditTarget​

既存のローカルメッシュ設定エッジを指定する Cursor。このパラメータを使用すると、指定された既存のローカルメッシュ設定エッジが上書きされます。使用しない場合、新しいローカルメッシュ設定エッジが作成されます。

デフォルト値は None です。

戻り値​

成功した場合は作成されたローカルメッシュ設定を指定する Cursor、失敗した場合は None。

サンプルコード​

Geometry.Part.Cube()

local_mesh = Meshing.LocalSettings.Edge(strName="MeshParam_1", 
                                        localMesh=LOCAL_MESH(iEntityType=3, 
                                                             dAvgElemSize=0.005, 
                                                             dMaxElemSize=0.01, 
                                                             dMinElemSize=0.001, 
                                                             dTrimAngle=0.7853981634, 
                                                             bEnableMeshCount=True, 
                                                             iNodeCount=8), 
                                        crlTargets=[Edge(18)])

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
