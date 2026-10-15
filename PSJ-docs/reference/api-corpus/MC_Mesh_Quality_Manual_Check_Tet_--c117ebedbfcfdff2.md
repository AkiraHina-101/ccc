# MC_Mesh_Quality_Manual_Check_Tet()

MC_Mesh_Quality_Manual_Check_Tet()

Description​

Mesh_Quality_Manual_Check_Tet

Syntax​

MC_Mesh_Quality_Manual_Check_Tet(Cursor[] targetBody, Cursor[] targetFace,
    Cursor[] targetElements, int nElemType, int nElemQuality, int nCheckCondition,
    double dLimitValue, double dSafeFactor, 0)

Inputs​

1. Cursor[]​

Part Cursor([3:Part ID])

2. Cursor[]​

Face Cursor([6:Face ID])

3. Cursor[]​

Element Cursor([11:Element ID])

4. Int​

Elements type, default elements Tet = 2

5. Int​

Elemenets Quality: Stretch = 0, Aspect Ratio = 1, Volume = 2, Jacob = 3. Factor = 4, Tet Collapse = 5, Tet Skew = 6,Edge Length = 7, Unstable = 8,Time Step (Abaqus) = 9

6. Int​

Check condition "<=" = 0, "<" = 1, ">=" = 2, ">" = 3

7. Double​

Limit value

8. Double​

Safe factor value

Return Code​

It returns a string separated by commas contains 8 values.

1. Succeeded(1) or Failed(0).​

2. Cutoff Value (Minimum).​

3. Cutoff Value (Maximum).​

4. Cutoff Value (Average).​

5. Number of measured elements.​

6. Number of error elements.​

7. A list of erorr elements.​

8. A list of error element edge.​

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

result = JPT.Exec('MC_Mesh_Quality_Manual_Check_Tet([3:1], [], [], 2, 0, 0, 0.1, 1, 0)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)
if splitted[0]=='1':
    success_flag,min,max,avg,target_num,error_num,errors1,errors2=splitted
    print(f'The number of elements that have stretch error is {error_num}. max value={max}, min value={min}')
