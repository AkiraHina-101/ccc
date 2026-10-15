# Meshing.CADProjection.NodeToFace()

Meshing.CADProjection.NodeToFace()

説明​

選択されたCAD（参照）フェースにプロジェクトの節点を作成します。

構文​

Meshing.CADProjection.NodeToFace(...)

リボン: Meshing » CADProjection » NodeToFace

入力​

crlCadFaces​

CADフェースを指定する Cursor リスト。これらのフェースはプロジェクションのための参照フェースになります。

CADフェースに関しては、通常のカーソルの形式とは異なる形式となります。2つのパラメータが必要です：前者はID（外部ID）で、後者はキー（内部ID）です。

例: RefFace((1,2)) は、ID（外部ID）= 1 およびキー（内部ID）= 2 のCADフェースを意味します。

この入力は必須です。

crlMeshedNodes​

メッシュ化された節点を指定する Cursor リスト。これらの節点は参照フェースにプロジェクトされます。

この入力は必須です。

iDirection​

プロジェクションの方向を指定する Integer の値。iImproveQuality とは同時に使用できません。

デフォルト値は0です。

iImproveQuality​

クオリティを向上させる必要があるかどうかを指定する Integer の値。クオリティを向上させると、作成後に要素を調整して品質を最適化します。

デフォルト値は0です。

注記

この場合、選択されたプロジェクションの方向（iDirection）は無視されます。

戻り値​

プロセスのステータスを表す Boolean 型の値：

True: 節点がCAD（参照）フェースにプロジェクトされました。

False: 節点をCAD（参照）フェースにプロジェクトできませんでした。

サンプルコード​

Geometry.Part.Cylinder(iPartColor=15658599)

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

Meshing.SolidMeshing(crlParts=[Part(1)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=8,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

Meshing.CADProjection.NodeToFace(crlCadFaces=[RefFace((5,5))],
                                 crlMeshedNodes=[Node(691)])
