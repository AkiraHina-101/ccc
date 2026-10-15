# HexModeling.SolidElemInterface()

HexModeling.SolidElemInterface()

説明​

ソリッド要素インタフェースを作成します

構文​

HexModeling.SolidElemInterface(...)

リボン：HexModeling » SolidElemInterface

入力​

crlFaces​

フェースを指定する Cursor のリストです。

デフォルト値は[]です。

bFlip​

フリップを指定する Boolean です。

デフォルト値は False です。

crlElms​

エレメントを指定する Cursor のリストです。

デフォルト値は[]です。

戻り値​

成功すると1の文字列、失敗すると0の文字列です。

サンプルコード​

Geometry.Part.Cube()
Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(dAvgElemSize=0.002, dGeomAngle=0.7853981634, 
        iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, bGeomApprox=True, iNextEntityOffsetId=0))
Geometry.DeleteEntity.Face(crlFaces=[Face(24, 22, 25, 23, 21)])
HexModeling.Linear(crlFaces=[Face(26)], dLength=0.01, iLayer=5, vecSweepDirection=[0.0, 0.0, 1.0])
HexModeling.SolidElemInterface(crlFaces=[Face(26)])
