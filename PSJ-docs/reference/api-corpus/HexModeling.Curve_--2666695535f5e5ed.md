# HexModeling.Curve()

HexModeling.Curve()

説明​

サーフェースメッシュ(三角形,四角形一次要素)を指定したカーブに沿ってスイープしてヘキサおよびペンタ要素を作成します。

構文​

HexModeling.Curve(...)

リボン：HexModeling » Curve

入力​

crFace​

フェースを指定する Cursor です。

デフォルト値はありません。

crlEdges​

エッジを指定する Cursor のリストです。

デフォルト値は [] です。

crlRefEdge​

参照エッジを指定する Cursor のリストです。

デフォルト値は [] です。

dMeshSize​

メッシュサイズを指定する Double です。

デフォルト値は 0.1 です。

戻り値​

成功時は 1、失敗時は 0 の文字列です。

サンプルコード​

Geometry.Part.Cube()
Geometry.Bar.Spline(crlNodes=[Node(1, 8, 7)], strName="Bar_2")
Geometry.Part.Cylinder(dTopOuterRadius=0.001, dBottomOuterRadius=0.001, iPartColor=6409934)

Geometry.DeleteEntity.Face(crlFaces=[Face(32, 34)])
Geometry.DeleteEntity.Part(crlParts=[Part(1)])

Meshing.SetMeshAttribute(crlParts=[Part(3)], 
    surfaceMesh=SURFACE_MESH(
        dAvgElemSize=0.002, 
        dGeomAngle=0.7853981634, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, bGeomApprox=True, 
        iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(
    crlParts=[Part(3)], 
    surfaceMesh=SURFACE_MESH(
        dAvgElemSize=0.002, 
        dGeomAngle=0.7853981634, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

HexModeling.Curve(crFace=Face(33), crlEdges=[Edge(27)], dMeshSize=0.002)
