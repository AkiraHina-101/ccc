# HexModeling.FaceToFace()

HexModeling.FaceToFace()

説明​

歯車のように2つの向かい合う同じ形状を持つ複雑形状のパートにヘキサおよびペンタ要素を自動作成します。

構文​

HexModeling.FaceToFace(...)

リボン：HexModeling » FaceToFace

入力​

crSrcFace​

ソースフェースを指定する Cursor 型の入力です。

これは必須の入力です。

crDstFace​

ターゲットフェースを指定する Cursor 型の入力です。

これは必須の入力です。

bDeleteOriginalParts​

元パートを削除するかどうかを指定する Boolean 型の入力です。

デフォルト値は True です。

戻り値​

成功した場合は1の文字列、失敗した場合は0の文字列です。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2", iPartColor=6409934)
Geometry.Transform.Rotation(crlParts=[Part(2)], 
                            posCenter=[0.005, 0.005, 0.005], 
                            vecAxis=[0.0, 0.0, 0.001], 
                            dAngle=0.523599, dTol=1e-05)
Geometry.DeleteEntity.Face(crlFaces=[Face(21, 22, 23, 24, 47, 48, 49, 50, 52, 25)])

Geometry.MergeEntities.Parts(crlParts=[Part(1, 2)], dMergeTolerance=1e-05)
Geometry.Face.Edges(crlEdges=[Edge(20, 38)])
Geometry.Face.Edges(crlEdges=[Edge(19, 37)])
Geometry.Face.Edges(crlEdges=[Edge(18, 36)])
Geometry.Face.Edges(crlEdges=[Edge(17, 35)])

Meshing.SetMeshAttribute(crlParts=[Part(1)], 
                        surfaceMesh=SURFACE_MESH(
                        dAvgElemSize=0.002, 
                        dGeomAngle=0.7853981634, 
                        iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bOutputQuadMesh=True, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                    surfaceMesh=SURFACE_MESH(
                        dAvgElemSize=0.002, 
                        dGeomAngle=0.7853981634, 
                        iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bOutputQuadMesh=True, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0))

HexModeling.FaceToFace(crSrcFace=Face(26), crDstFace=Face(51))
