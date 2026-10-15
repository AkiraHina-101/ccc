# HexModeling.Layer()

HexModeling.Layer()

説明​

サーフェースメッシュ(三角形,四角形一次要素)を法線方向にスイープしてヘキサおよびペンタ要素を作成します。

構文​

HexModeling.Layer(...)

リボン: HexModeling » Layer

入力​

crlFaces​

面を指定する Cursor 型のリストです。

デフォルト値は [] です。

dFrontWidth​

前部幅を指定する Double です。

デフォルト値は 0.0 です。

dBackWidth​

後部幅を指定する Double です。

デフォルト値は 0.0 です。

iFrontLayers​

前部のレイヤーを指定する Integer です。

デフォルト値は 1 です。

iBackLayers​

後部のレイヤーを指定する Integer です。

デフォルト値は 0 です。

iBaseFaceType​

ベースフェースタイプを指定する Integer です。

デフォルト値は 0 です。

iSeparate​

分けることを指定する Integer です。

デフォルト値は 0 です。

戻り値​

成功した場合は 1 の文字列、失敗した場合は 0 の文字列です。

サンプルコード​

Geometry.Part.Cube()
Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(dAvgElemSize=0.002, dGeomAngle=0.7853981634, 
        iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, bGeomApprox=True, iNextEntityOffsetId=0))
Geometry.DeleteEntity.Face(crlFaces=[Face(24, 22, 25, 23, 21)])
HexModeling.Layer(crlFaces=[26], dFrontWidth=0.001, dBackWidth=0.0015, iFrontLayers=3, 
                iBackLayers=2, iBaseFaceType=1)
