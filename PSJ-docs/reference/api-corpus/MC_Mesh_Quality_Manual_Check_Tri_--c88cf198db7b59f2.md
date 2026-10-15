# MC_Mesh_Quality_Manual_Check_Tri()

MC_Mesh_Quality_Manual_Check_Tri()

Description​

Mesh_Quality_Manual_Check_Tri

Syntax​

MC_Mesh_Quality_Manual_Check_Tri(cursor[] crEntities, int iElemType, int iCond, double dDispValue)

Inputs​

1. Cursor[]​

Target entity cursor([CursorType: CursorType ID])

2. Int​

Element quality metric type

0: Stretch

1: Aspect Ratio

2: Edge Length

3: Area

4: Node Valence

5: Interior angle

6: Duplicate Elements

7: Node free edges

3. Int​

Condition Display

0: <=

1: >=

2: <

3: >

4. Double​

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
        dMaxElemSize=0.1, 
        dGeomAngle=0.7853981634, 
        dMinStretchVal=0.0, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

result=JPT.Exec('MC_Mesh_Quality_Manual_Check_Tri([3:1], 0, 0, 0.1)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)
if splitted[0]=='1':
    success_flag,min,max,avg,target_num,error_num,errors1,errors2=splitted
    print(f'The number of elements that have stretch error is {error_num}. max value={max}, min value={min}')
