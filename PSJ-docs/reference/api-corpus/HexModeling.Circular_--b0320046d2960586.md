# HexModeling.Circular()

HexModeling.Circular()

Description​

Create Hexa mesh by revolving a surface

Syntax​

HexModeling.Circular(...)

Ribbon: HexModeling » Circular

Inputs​

crlFaces​

A List of Cursor specifying the face.

The default value is [].

dAngle​

A Double specifying the angle.

The default value is 360.

dTol​

A Double specifying the tolerance.

The default value is 0.0000001.

iLayer​

An Integer specifying the layer.

The default value is 36.

vecAxisPt​

A Vector specifying the axis point.

The default value is [0.0,0.0,0.0].

vecAxisVect​

A Vector specifying the axis vector.

The default value is [1.0,0.0,0.0].

bInterfaceElem​

A Boolean specifying the interface element.

The default value is False.

bExtrusion​

A Boolean specifying the extrusion.

The default value is False.

dTranslationExtrusion​

A Double specifying the translation extrusion.

The default value is 0.0.

dBDeleteOriginalParts​

A Double specifying the delete original parts.

The default value is 0.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cylinder(bHollow=True, dTopInnerRadius=0.003, dBottomInnerRadius=0.003, iCircularNodes=128)
Geometry.BodyCut.XXYYOnOnePoint(crPart=Part(1), posCutPoint=[0, 0.01, 0.01], iCuttingPlane=2)
Geometry.BodyCut.XXYYOnOnePoint(crPart=Part(1), posCutPoint=[-0.01, 0.01, 0])
Geometry.DeleteEntity.Part(crlParts=[Part(3, 5)])

Meshing.SetMeshAttribute(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(dAvgElemSize=0.002,
        dGeomAngle=0.7853981634, iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dAvgElemSize=0.002, 
        dGeomAngle=0.7853981634, 
        iPerformanceMode=1,
         dAutoMergeTinyFacesAngle=0.5235987756, 
         bOutputQuadMesh=True, 
         bGeomApprox=True, 
         iNextEntityOffsetId=0))

HexModeling.Circular(crlFaces=[58], dAngle=90.0, iLayer=6, vecAxisVect=[0.0, -1.0, 0.0], dBDeleteOriginalParts=1.0)
