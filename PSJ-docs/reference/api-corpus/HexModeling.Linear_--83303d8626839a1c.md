# HexModeling.Linear()

HexModeling.Linear()

説明​

サーフェースメッシュ(三角形,四角形一次要素)を指定した方向にスイープしてヘキサおよびペンタ要素を作成します。

構文​

HexModeling.Linear(...)

リボン: HexModeling » Linear

入力​

crlFaces​

フェースを指定する Cursor のリストです。

デフォルト値は [] です。

dLength​

長さを指定する Double です。

デフォルト値は 10 です。

iLayer​

レイヤーを指定する Integer です。

デフォルト値は 10 です。

vecSweepDirection​

スウィープ方向を指定する Vector です。

デフォルト値は [] です。

bInterfaceElemFlag​

インターフェース要素フラグを指定する Boolean です。

デフォルト値は False です。

iLinearMethod​

線形メソッドを指定する Integer です。

デフォルト値は 0 です。

bDeleteOriginalParts​

オリジナルパートを削除するかを指定する Boolean です。

デフォルト値は False です。

bDeleteTargetParts​

ターゲットパートを削除するかを指定する Boolean です。

デフォルト値は False です。

iMethodBias​

メソッドバイアスを指定する Integer です。

デフォルト値は 0 です。

dFactor​

ファクターを指定する Double です。

デフォルト値は 2.0 です。

iProgression​

進行を指定する Integer です。

デフォルト値は 0 です。

戻り値​

成功すると 1 の文字列、失敗すると 0 の文字列。

サンプルコード​

Geometry.Part.Cube()
Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(dAvgElemSize=0.002, dGeomAngle=0.7853981634, 
        iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, bGeomApprox=True, iNextEntityOffsetId=0))
Geometry.DeleteEntity.Face(crlFaces=[Face(24, 22, 25, 23, 21)])
HexModeling.Linear(crlFaces=[Face(26)], dLength=0.01, vecSweepDirection=[0.0, 0.0, 1.0])
