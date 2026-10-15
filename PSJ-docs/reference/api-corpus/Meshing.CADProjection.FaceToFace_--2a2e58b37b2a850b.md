# Meshing.CADProjection.FaceToFace()

Meshing.CADProjection.FaceToFace()

説明​

メッシュ化されたフェースのプロジェクト節点を選択されたCAD（参照）フェースにプロジェクトします。

構文​

Meshing.CADProjection.FaceToFace(...)

リボン：Meshing » CADProjection » FaceToFace

入力​

crlCadFaces​

CADフェースを指定する Cursor のリスト。これらのフェースはプロジェクションの参照フェースになります。

CADフェースの場合、通常のカーソル形式とは異なる形式が取られることに注意してください。 2つのパラメータが必要です：前者はID（外部ID）、後者はキー（内部ID）です。

例：RefFace((1,2)) は、ID（外部ID）= 1、キー（内部ID）= 2 のCADフェースを意味します。

これは必須の入力です。

crlMeshedFaces​

メッシュ化されたフェースを指定する Cursor のリスト。このフェースは参照フェースにプロジェクションされます。

これは必須の入力です。

bForceProject​

強制プロジェクションを有効/無効にする Boolean 値。True の場合、Jupiterはプロジェクションをより積極的に試み、そのため完了までに時間がかかる場合があります。

デフォルト値は False です。

bProjectCornerNodes​

コーナー節点プロジェクションを有効/無効にする Boolean 値。True の場合、要素のコーナー節点がプロジェクションされます。

デフォルト値は False です。

bProjectMidNodes​

ミッド節点プロジェクションを有効/無効にする Boolean 値。True の場合、要素のミッド節点がプロジェクションされます。

デフォルト値は True です。

bIDcheck​

プロジェクション時のIDチェックを有効/無効にする Boolean 値。

デフォルト値は True です。

戻り値​

プロセスの状態を指定する Boolean 値：

True：メッシュ化されたフェースの節点をCAD（参照）フェースにプロジェクトしました。

False：メッシュ化されたフェースの節点をCAD（参照）フェースにプロジェクトできません。

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

Meshing.CADProjection.FaceToFace(crlCadFaces=[RefFace((5, 5))],
                                 crlMeshedFaces=[Face(10)],
                                 bProjectCornerNodes=True,
                                 bIDcheck=False)
