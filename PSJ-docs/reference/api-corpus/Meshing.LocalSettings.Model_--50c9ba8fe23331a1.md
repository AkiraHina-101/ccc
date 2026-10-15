# Meshing.LocalSettings.Model()

Meshing.LocalSettings.Model()

説明​

モデル全体のメッシュ設定を設定します（表面メッシュ作成前に設定を定義します）。

文法​

Meshing.LocalSettings.Model(...)

リボン: Meshing » LocalSettings » Model

入力​

strName​

ローカルメッシュ設定の名前を指定する String です。

これは必須の入力です。

localMesh​

ローカルメッシュ設定のパラメータを指定する LOCAL_MESH です。

これは必須の入力です。

spaceMesh​

スペースメッシュ設定のパラメータを指定する SPACE_MESH です。

これは必須の入力です。

crlTargets​

ローカルメッシュ設定のターゲットフェースを指定する Cursor のリストです。

これは必須の入力です。

crEditTarget​

編集ターゲットを指定する Cursor です。

デフォルト値は None です。

戻り値​

作成されたローカルメッシュ設定を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

Meshing.LocalSetting.SearchTargetFaces(dlLength=[0.003, 0.003, 0.003],
                                       dlAxisPt1=[0.0, 0.0, 0.01],
                                       dlAxisPt2=[0.005, 0.0, 0.0])

created_local_mesh_setting = Meshing.LocalSettings.Model(strName="MeshParam_1",
                                                         localMesh=LOCAL_MESH(iEntityType=11,
                                                                              bEnableSizeParams=True,
                                                                              dAvgElemSize=0.001,
                                                                              dMaxElemSize=0.01,
                                                                              dMinElemSize=0.0005,
                                                                              dTrimAngle=0.7853981634),
                                                         spaceMesh=SPACE_MESH(vLength=[0.003, 0.003, 0.003],
                                                                              vAxisPt2=[0.005, 0.0, 0.0],
                                                                              dMinElemSize=0.001),
                                                         crlTargets=[Face(21, 23, 25)])

JPT.Debugger(created_local_mesh_setting)
