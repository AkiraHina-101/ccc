# JPT.GetInternalIDRefItem()

JPT.GetInternalIDRefItem()

Description​

Get internal ID of a reference entity.

Syntax​

JPT.GetInternalIDRefItem(...)

Inputs​

DItemType​

An Enum specifying the DItemType describing the type of entity (reference entities here).

This is a required input.

externalID​

An Int specifying external ID of reference item.

This is a required input.

bUsedRef​

A Bool specifying if the target is reference item.

The defalut value is True.

Return Code​

A Int value that indicates internal ID of the reference entity.

Sample Code​

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
