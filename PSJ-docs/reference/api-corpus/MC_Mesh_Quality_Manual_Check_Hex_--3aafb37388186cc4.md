# MC_Mesh_Quality_Manual_Check_Hex()

MC_Mesh_Quality_Manual_Check_Hex()

Description​

Mesh_Quality_Manual_Check_Hex

Syntax​

MC_Mesh_Quality_Manual_Check_Hex(cursor[] crBody, cursor[] crFace, cursor[] crElem,
    int iElemType, int elemQualityType, int iCond, double dSafeFact, double dDispValue)

Inputs​

1. Cursor[]​

Target part cursor([3:Part ID])

2. Cursor[]​

Target face cursor([6:Face ID])

3. Cursor[]​

Target element cursor([11:Elem ID])

4. Int​

Element type (3-Hex Element)

5. Int​

Element quality metric type

0: Stretch

1: Aspect Ratio

2: Edge Length

3: Volume

4: Unstable

5: Time Step (Abaqus)

6. Int​

Condition Display

7. double​

Safety factor

8. double​

Display value

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

Geometry.Part.Cube()

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

HexModeling.Linear(
    crlFaces=[Face(26)], 
    dLength=0.0001, iLayer=1, 
    vecSweepDirection=[0.0, 0.0, 1.0], 
    bDeleteOriginalParts=True)

result=JPT.Exec('MC_Mesh_Quality_Manual_Check_Hex([3:1], [], [], 3, 0, 0, 1, 0.1)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)
if splitted[0]=='1':
    success_flag,min,max,avg,target_num,error_num,errors1,errors2=splitted
    print(f'The number of elements that have stretch error is {error_num}. max value={max}, min value={min}')
