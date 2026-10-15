# JPT.BeginDatabaseTransaction()

JPT.BeginDatabaseTransaction()

説明​

Jupiterのパフォーマンスを向上させるために、画面アニメーション、画面更新、およびステータスバー更新情報を無効にします。

important

プロセスの終了時にJPT.EndDatabaseTransaction()を使用して、Jupiterを通常の状態に戻してください。

構文​

JPT.BeginDatabaseTransaction("transactionName")

入力​

transactionName​

コマンド名を「取り消し / やり直し」メニューに表示するためのトランザクション名を指定する_String_型の入力です。

この入力は必須です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# データベーストランザクションの開始
JPT.BeginDatabaseTransaction("メッシュ化モデル作成")

# これ以降、すべての手順は「メッシュ化モデル作成」として1つのステップとして保存されます。
# 実行プロセスが完了した後、元に戻るボタンをクリックして確認できます。

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0],
                   strName="Cube_3",
                   iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0],
                   strName="Cube_4",
                   iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.04, 0.0, 0.0],
                   strName="Cube_5",
                   iPartColor=7463537)
Geometry.Part.Cube(dlOrigin=[0.05, 0.0, 0.0],
                   strName="Cube_6",
                   iPartColor=7434735)
Geometry.Part.Cube(dlOrigin=[0.06, 0.0, 0.0],
                   strName="Cube_7",
                   iPartColor=14903267)
Geometry.Part.Cube(dlOrigin=[0.07, 0.0, 0.0],
                   strName="Cube_8",
                   iPartColor=15658599)

Meshing.SetMeshAttribute(crlParts=[Part(5, 6, 7, 8)],
                         surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bOutputQuadMesh=True,
                                                  bGeomApprox=True,
                                                  iNextEntityOffsetId=0))
Meshing.SurfaceMeshing(crlParts=[Part(5, 6, 7, 8)],
                       surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                iPerformanceMode=1,
                                                dAutoMergeTinyFacesAngle=0.5235987756,
                                                bOutputQuadMesh=True,
                                                bGeomApprox=True,
                                                iNextEntityOffsetId=0),
                                                iThreadNum=12)
MeshEdit.SurfaceMesh(crlParts=[Part(2, 4, 8, 6)])
Meshing.SolidMeshing(crlParts=[Part(8, 4, 7, 3)],
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)
Meshing.SolidMeshing(crlParts=[Part(4)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

del_faces = [208, 182, 178, 204, 206, 177, 203, 179, 205, 180]
extrude_faces = [207, 181]

Geometry.DeleteEntity.Face(crlFaces=[Face(*del_faces)])

HexModeling.Linear(crlFaces=[Face(*extrude_faces)],
                   dLength=0.01,
                   iLayer=2,
                   vecSweepDirection=[0.0,
                                      0.0,
                                      1.0],
                   iLinearMethod=4)

MeshEdit.SolidMesh(crlParts=[Part(8)])

# データベーストランザクションの終了
JPT.EndDatabaseTransaction()
