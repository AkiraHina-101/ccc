# MC_Mesh_Quality_Manual_Check_Quad()

MC_Mesh_Quality_Manual_Check_Quad()

Description​

Mesh_Quality_Manual_Check_Quad

Syntax​

MC_Mesh_Quality_Manual_Check_Quad(cursor[] crBody, cursor[] crFace, cursor[] crElem,
    int iElemType, int iCond, int dSafeFact, double dDispValue)

Inputs​

1. Cursor[]​

Target part cursor([3:Part ID])

2. Cursor[]​

Target face cursor([6:Face ID])

3. Cursor[]​

Target element cursor([11:Elem ID])

4. Int​

Element type (1-Quad Element)

5. Int​

Element quality metric type

0: Stretch

1: Aspect Ratio

2: Warping

3: Skewness

4: Edge length

5: Area

6: Node Valence

7: Interior angle

8: Taper

9: Duplicate Elements

10: Node free edges

6. Int​

Condition Display

0: <=

1: >=

2: <

3: >

7. double​

Display value

Return Code​

It returns a string separated by commas contains 8 values.

1. Succeeded(1) or Failed(0).​

2. Cutoff Value (Minimum).​

3. Cutoff Value (Maximum).​

4. Cutoff Value (Average).​

5. Number of measured elements.​

6. Number of error elements.​

7. A list of error elements.​

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
        dMaxElemSize=0.005, 
        dMinElemSize=0.005, 
        dGeomAngle=0.7853981634, 
        dMinStretchVal=0.0, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bOutputQuadMesh=True, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0), 
        bFMesher=True)

result=JPT.Exec('MC_Mesh_Quality_Manual_Check_Quad([3:1], [], [], 1, 0, 0, 0.1)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)
if splitted[0]=='1':
    success_flag,min,max,avg,target_num,error_num,errors1,errors2=splitted
    print(f'The number of elements that have stretch error is {error_num}. max value={max}, min value={min}')
