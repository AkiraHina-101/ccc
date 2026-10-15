# Meshing.SurfaceMeshing()

Meshing.SurfaceMeshing()

説明​

選択したパートに対して2Dメッシュを作成します。入力パラメータとして Meshing.SetMeshAttribute 関数が使用されます。

注記

この関数は三角形要素と四角形要素をサポートしています。

構文​

Meshing.SurfaceMeshing(...)

マクロ: SurfaceMeshing2D

リボン: Meshing » Surface Meshing

入力​

crlParts​

メッシュを作成する必要があるパートを指定する Cursor のリスト。

この入力は必須です。

surfaceMesh​

メッシュパラメータを指定する SURFACE_MESH。

この入力は必須です。

bUseSetting​

ローカル設定の使用を有効または無効にする Boolean。このパラメータが無効になっている場合（False）、既存のローカルメッシュ設定は使用されません。

デフォルト値は True です。

bFMesher​

F-mesher のステータス（使用不可/使用可）を指定する Boolean。F-mesher は Quad4要素のみを作成するメッシャです。 surfaceMesh が Tri3要素を作成するように設定されている場合、このオプションは何の効果もありません。

デフォルト値は False です。

iThreadNum​

並列メッシング用のCPUスレッド数を指定する Integer。このメッシャは各スレッドで独立した（組み立てフェースなし）パートごとに並列メッシングを作成します。2つのパートが一緒に組み立てられている場合、それらは並列メッシング用に単一のパートとして扱われます。このパラメータは、CPUコアの最大数よりも小さくする必要があります。

デフォルト値は 8 です。

bRefData​

参照データの作成のステータス（使用不可/使用可）を指定する Boolean。参照データはCADモデルを保存するために使用されます。このパラメータが有効になっている場合（True）、メッシング後も参照データは保持されます。

デフォルト値は True です。

bMeshColor​

メッシュの色の使用を有効または無効にする Boolean。このパラメータが有効になっている場合（True）、結果のメッシュ化されたパートは iPartColor で説明される色で表示されます。

デフォルト値は False です。

iPartColor​

結果のメッシュ化されたパートの色を指定する Integer。

デフォルト値は 65280（白）です。

戻り値​

成功した場合は True の Boolean、失敗した場合は False の Boolean。

サンプルコード​

Geometry.Part.Cube()
Meshing.SetMeshAttribute(crlParts=[Part(1)], 
                         surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                  iOptLevel=5, 
                                                  dAutoMergeTinyFacesAngle=0.5235987756, 
                                                  bGeomApprox=True, 
                                                  iNextEntityOffsetId=0))

meshing_status = Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                                        surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                                 iOptLevel=5, 
                                                                 dAutoMergeTinyFacesAngle=0.5235987756, 
                                                                 bGeomApprox=True, 
                                                                 iNextEntityOffsetId=0))

JPT.Debugger(meshing_status)
