# JPT.GetInternalIDRefItem()

JPT.GetInternalIDRefItem()

説明​

参照エンティティの内部IDを取得します。

構文​

JPT.GetInternalIDRefItem(...)

入力​

DItemType​

エンティティのタイプ（ここでは参照エンティティ）を説明する DItemType を指定する Enum です。

この入力は必須です。

externalID​

参照アイテムの外部IDを指定する Int です。

この入力は必須です。

bUsedRef​

対象が参照アイテムであるかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

参照エンティティの内部IDを示す Int 値です。

サンプルコード​

Geometry.Part.Cube()

Tools.Renumber(
    listRenumberItem=[
        RENUMBER_ITEM(crTarget=Part(1), 
        iBeginID=1000, 
        iTargetType=5
        iCount=6, 
        ilOffset=[10000, 100, 1], 
    dlCoordTolerance=[0.1, 0.1, 0.1], 
    bEnable=True)])

Meshing.AdjustCircleVertex(crlParts=[Part(1)], bInModeSurfaceMesh=True)

Meshing.SetMeshAttribute(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dMaxElemSize=0.05, 
        dMinElemSize=0.0001, 
        dGeomAngle=0.7853981634,
         dGeomMinSize=0.0001, 
         iPerformanceMode=1, 
         dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True, iNextEntityOffsetId=0)
         )

Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dMaxElemSize=0.05, 
        MinElemSize=0.0001, 
        dGeomAngle=0.7853981634, 
        dGeomMinSize=0.0001, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True, iNextEntityOffsetId=0)
        )

result=JPT.GetInternalIDRefItem(JPT.DItemType.REF_FACE,1005)
print(result)
