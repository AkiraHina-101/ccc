# MC_Mesh_Quality_Auto_Check_Tet()

MC_Mesh_Quality_Auto_Check_Tet()

Description​

Mesh_Quality_Auto_Check_Tet

Syntax​

MC_Mesh_Quality_Auto_Check_Tet(Cursor[] Part Cursor,Cursor[] Element Cursor,
    int nElemType, bool nStretchCheck, bool nAspectRatioCheck, bool nVolumeCheck,
    bool nJacobFactCheck, bool nTetCollapseCheck, bool nTetSkewCheck,
    double dStretchLimitValue,double dAspectRatioLimitValue, double dVolumeLimitValue,
    double dJacobFactLimitValue,double dTetCollapseLimitValue,double dTetSkewLimitValue)

Inputs​

1. Cursor[]​

Part Cursor([3:*]*=Part ID)

2. Cursor[]​

Element Cursor([11:*]*=Element ID)

3. Int​

Elem Type(2-Tet Element)

4. Bool​

Stretch Check flag,true = 1,false=0

5. Bool​

Aspect Ratio Check flag,true = 1,false=0

6. Bool​

Volume Bool flag,true = 1,false=0

7. Bool​

Jacob factor Bool flag,true = 1,false=0

8. Bool​

Tet Collapse Bool flag,true = 1,false=0

9. Bool​

Tet skew flag,true = 1,false=0

10. Double​

Stretch limit value

11. Double​

Aspect Ratio limit value

12. Double​

Volume limit value

13. Double​

Jacob factor limit value

14. Double​

Tet Collapse limit value

15. Double​

Tet skew limit value

Return Code​

It returns a string separated by commas contains 3 values.

1. Succeeded(1) or Failed(0).​

2. Number of error elements.​

3. A list of erorr elements.​

Sample Code​

import re

Geometry.Part.Cube(
    dlLength=[0.01, 0.01, 0.0001], 
    ilAxialNodes=[10, 10, 2], 
    strName="Cube_1", 
    iPartColor=13259210)

Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dMaxElemSize=0.1, 
        dGeomAngle=0.7853981634, 
        dMinStretchVal=0.0, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

Meshing.SolidMeshing(
    crlParts=[Part(1)], 
    bTet10=True, 
    dGradingFactor=1.0, 
    iSpeedVsQual=1, 
    bSafeMode=False, 
    iParallel=8, 
    bSurfaceNodes=False, 
    bEdgeNodes=False, 
    bInternalMeshOnly=False, 
    iPartColor=65280)

result=JPT.Exec('MC_Mesh_Quality_Auto_Check_Tet([3:1], [], 2, 1, 1, 1, 1, 1, 1, 0.1, 10, 0, 0, 0.05, 0.9)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)

if splitted[0]=='1':
    success_flag,error_num,errors=splitted
    print(f'The number of error elements {error_num}.')
