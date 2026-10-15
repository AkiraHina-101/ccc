# Meshing.CADProjection.Face()

Meshing.CADProjection.Face()

説明​

メッシュ化されたフェースのプロジェクト節点を選択したCAD（参照）パートに投影します。

構文​

Meshing.CADProjection.Face(...)

リボン: Meshing » CAD Projection » Face

入力​

crCadPart​

CADパートを指定する Cursor です。選択したパートのフェースは、プロジェクションの参照フェースになります。

CADパートの場合、通常のカーソルの形式とは異なる形式になります。2つのパラメータが必要です：前者はID（外部ID）、後者はキー（内部ID）です。

例：RefPart((1,2)) は、ID（外部ID）= 1、キー（内部ID）= 2 のCADパートを意味します。

これは必須の入力です。

crlMeshedFaces​

メッシュ化されたフェースのリストを指定する Cursor のリストです。これらのフェース上の節点が参照フェースに投影されます。

これは必須の入力です。

bForceProject​

プロジェクションを強制するかどうかを指定する Boolean です。True の場合、Jupiterはより積極的にプロジェクションを試み、より多くの時間がかかる場合があります。

デフォルト値は False です。

bProjectCornerNodes​

コーナー節点をプロジェクトするかどうかを指定する Boolean です。True の場合、要素のコーナー節点がプロジェクトされます。

デフォルト値は True です。

bProjectMidNodes​

中間節点をプロジェクトするかどうかを指定する Boolean です。True の場合、要素の中間節点がプロジェクトされます。

デフォルト値は False です。

bIDcheck​

プロジェクト時にIDを確認するかどうかを指定する Boolean です。

True の場合、（選択したメッシュ化されたフェース上の）節点は、その節点のメッシュ化されたフェースと同じIDのCADフェース（選択したCADパート内の）にのみプロジェクトされます。例えば、ある節点がフェース5上にある場合、その節点はIDが同じ（つまり5）のCADフェース（選択したCADパート内の）にのみプロジェクトされます。

False の場合、IDの確認はスキップされ、節点とCADフェース（選択したCADパート内の）が最も近い距離にある場合にプロジェクションが行われます。

デフォルト値は False です。

戻り値​

プロセスの状態を示す Boolean です：

True: メッシュ化されたフェースの節点をCAD（参照）パートに投影しました。

False: メッシュ化されたフェースの節点をCAD（参照）パートに投影できませんでした。

サンプルコード​

Geometry.Part.Cylinder()
Geometry.Part.Cylinder(dlOrigin=[0.0, 0.0, 0.02], strName="Cylinder_2", iPartColor=6409934)

Geometry.FCircVertexAdjust(crlParts=[Part(1, 2)])
Meshing.SetMeshAttribute(crlParts=[Part(1, 2)],
                         surfaceMesh=SURFACE_MESH(dMaxElemSize=0.015,
                                                  dMinElemSize=0.0005,
                                                  dGeomAngle=0.7853981634,
                                                  dMinStretchVal=0.0,
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bGeomApprox=True,
                                                  iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(crlParts=[Part(1, 2)],
                       surfaceMesh=SURFACE_MESH(dMaxElemSize=0.015,
                                                dMinElemSize=0.0005,
                                                dGeomAngle=0.7853981634,
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

Meshing.CADProjection.Face(crCadPart=RefPart((2, 2)),
                           crlMeshedFaces=[Face(10)],
                           bProjectMidNodes=True,
                           bIDcheck=True)
