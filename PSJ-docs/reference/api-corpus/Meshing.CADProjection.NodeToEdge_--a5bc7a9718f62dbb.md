# Meshing.CADProjection.NodeToEdge()

Meshing.CADProjection.NodeToEdge()

説明​

メッシュ化されたフェースのプロジェクト節点を選択したCAD（参照）エッジに配置します。

構文​

Meshing.CADProjection.NodeToEdge(...)

リボン: Meshing » CADProjection » NodeToEdge

入力​

crCadEdge​

CADエッジを指定する Cursor。これらのエッジはプロジェクションの参照エッジになります。

CADエッジの場合、通常のカーソルの形式とは異なる Cursor 型が必要です。今回は2つのパラメータが必要です：前者がID（外部ID）、後者がキー（内部ID）です。

例：RefEdge((1,2)) は、ID（外部ID） = 1、キー（内部ID） = 2 のCADエッジを意味します。

これは必須の入力です。

crlMeshedNodes​

メッシュされた節点を指定する Cursor リスト。これらの節点は参照エッジにプロジェクションされます。

これは必須の入力です。

iDirection​

プロジェクションの方向を指定する Integer 。

デフォルト値は0です。

戻り値​

プロセスのステータスを示す Boolean 型です：

True: 節点をCAD（参照）エッジにプロジェクションしました。

False: 節点をCAD（参照）エッジにプロジェクションできませんでした。

サンプルコード​

Geometry.Part.Cylinder(iPartColor=12603072)

Meshing.SetMeshAttribute(crlParts=[Part(1)],
                         surfaceMesh=SURFACE_MESH(dAvgElemSize=0.004,
                                                  dMaxElemSize=0.015,
                                                  dMinElemSize=0.0005,
                                                  dGeomAngle=0.7853981634,
                                                  dGeomMinSize=0.0005,
                                                  dMinStretchVal=0.0,
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bGeomApprox=True,
                                                  iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(crlParts=[Part(1)],
                       surfaceMesh=SURFACE_MESH(dAvgElemSize=0.004,
                                                dMaxElemSize=0.015,
                                                dMinElemSize=0.0005,
                                                dGeomAngle=0.7853981634,
                                                dGeomMinSize=0.0005,
                                                dMinStretchVal=0.0,
                                                iPerformanceMode=1,
                                                dAutoMergeTinyFacesAngle=0.5235987756,
                                                bGeomApprox=True,
                                                iNextEntityOffsetId=0),
                       iThreadNum=4)

Meshing.SolidMeshing(crlParts=[Part(1)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=4,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

targetn=MainWindow.RightClick.AssociatedPick(crlInput=[Edge(1)],
                                             strTarget="Node")

Meshing.CADProjection.NodeToEdge(crCadEdge=RefEdge((1,1)),
                                 crlMeshedNodes=targetn)
