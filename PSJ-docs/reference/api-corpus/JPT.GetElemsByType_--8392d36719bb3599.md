# JPT.GetElemsByType()

JPT.GetElemsByType()

説明​

要素の種類（Tri3、Hex8、Tet10など）を入力して、 要素のリスト を取得します。

構文​

JPT.GetElemsByType(ElemType)

入力​

ElemType​

Jupiter内の要素の ElemType を指定する Enum です。

この入力は必須です。

戻り値​

入力した要素の種類と同じ要素を持つ関連要素の情報をすべて含む ElemVector オブジェクトまたは List of DElem オブジェクトです。

サンプルコード​

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
JPT.ViewFitToModel()

listTri3Elems = JPT.GetElemsByType(JPT.ElemType.ELEMTYPE_TRI3)
listTri6Elems = JPT.GetElemsByType(JPT.ElemType.ELEMTYPE_TRI6)
listTet4Elems = JPT.GetElemsByType(JPT.ElemType.ELEMTYPE_TET4)
listTet10Elems = JPT.GetElemsByType(JPT.ElemType.ELEMTYPE_TET10)
listQuad4Elems = JPT.GetElemsByType(JPT.ElemType.ELEMTYPE_QUAD4)
listQuad8Elems = JPT.GetElemsByType(JPT.ElemType.ELEMTYPE_QUAD8)
listHex8Elems = JPT.GetElemsByType(JPT.ElemType.ELEMTYPE_HEX8)
listHex20Elems = JPT.GetElemsByType(JPT.ElemType.ELEMTYPE_HEX20)

JPT.Debugger(listTri3Elems)
JPT.Debugger(listTri6Elems)
JPT.Debugger(listTet4Elems)
JPT.Debugger(listTet10Elems)
JPT.Debugger(listQuad4Elems)
JPT.Debugger(listQuad8Elems)
JPT.Debugger(listHex8Elems)
JPT.Debugger(listHex20Elems)
