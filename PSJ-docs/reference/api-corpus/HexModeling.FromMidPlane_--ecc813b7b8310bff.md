# HexModeling.FromMidPlane()

HexModeling.FromMidPlane()

Description​

HexModeling From MidPlane

Syntax​

HexModeling.FromMidPlane(...)

Ribbon: HexModeling » FromMidPlane

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

bRef​

A Boolean specifying the reference.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

import os

#Check license of midplane to use midplane function
MidplaneLicense="JPT_MIDP"
JPT.EnableLicenseFeature(MidplaneLicense, 1)
check=JPT.CheckLicense(MidplaneLicense)

if check == False:
    JPT.MessageBoxPSJ(f"{MidplaneLicense} license is needed to create midplane.\n (This sample needs midplane to execute.)", JPT.MsgBoxType.MB_WARNING_OK)
else:
    cadFile=os.path.join(JPT.GetProgramPath(),'SampleData/bracket.x_t')

    Home.ImportCAD.Parasolid(strlPaths=[cadFile], dScale=0.001)

    MidPlane.PressShell(crlPart=[Part(1)], dTinyHollowDepth=0.0002)

    Meshing.SetMeshAttribute(
        crlParts=[Part(1)], 
        surfaceMesh=SURFACE_MESH(
            dAvgElemSize=0.01, 
            dMaxElemSize=0.02, 
            dGeomAngle=0.7853981634, 
            iPerformanceMode=1, 
            dAutoMergeTinyFacesAngle=0.5235987756, 
            bOutputQuadMesh=True, 
            bGeomApprox=True, 
            iNextEntityOffsetId=0))

    Meshing.SurfaceMeshing(
        crlParts=[Part(1)], 
        surfaceMesh=SURFACE_MESH(dAvgElemSize=0.01, 
        dMaxElemSize=0.02, 
        dGeomAngle=0.7853981634, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

    HexModeling.FromMidPlane(crlParts=[Part(1)])
