# MC_Mesh_Quality_Auto_Check_Quad()

MC_Mesh_Quality_Auto_Check_Quad()

Description​

Correct the surface mesh (QUAD4/QUAD8) by using multiple mesh quality standards.

Syntax​

MC_Mesh_Quality_Auto_Check_Quad(Cursor[] Part Cursor,Cursor[] Face Cursor,Cursor[] Element Cursor,
int nElemType, bool nStretchCheck, bool nAspectRatioCheck, bool nWarpingCheck, bool nSkewnessCheck,
bool nEdgeLengthCheck, bool nAreaCheck, bool nNodeValenceCheck, bool nInteriorAngleCheck,
bool nTaperCheck, bool nDuplicateElemsCheck,double dStretchLimitValue,double dAspectRatioLimitValue,
double dWarpingLimitValue,double dSkewnessLimitValue,double dEdgeLengthLimitValue,
double dAreaLimitValue,double dNodeValenceLimitValue,double dInteriorAngleLimitValue,double dTaperLimitValue)

Inputs​

1. Cursor[]​

Part Cursor([3:*]*=Part ID)

2. Cursor[]​

Face Cursor([6:*]*=Face ID)

3. Cursor[]​

Element Cursor([11:*]*=Element ID)

4. Int​

Elem Type(1-Quad Element)

5. Bool​

Stretch Check flag,true = 1,false=0

6. Bool​

AspectRatio Check flag,true = 1,false=0

7. Bool​

Warping Check flag,true = 1,false=0

8. Bool​

Skewness Check flag,true = 1,false=0

9. Bool​

EdgeLength Check flag,true = 1,false=0

10. Bool​

Area Check flag,true = 1,false=0

11. Bool​

NodeValence Check flag,true = 1,false=0

12. Bool​

InteriorAngle Check flag,true = 1,false=0

13. Bool​

Taper Check flag,true = 1,false=0

14. Bool​

DuplicateElems Check flag,true = 1,false=0

15. Double​

Stretch limit value

16. Double​

Aspect Ratio limit value

17. Double​

Warping limit value

18. Double​

Skewness limit value

19. Double​

Edge Length limit value

20. Double​

Area limit value

21. Double​

NodeValence limit value

22. Double​

Interior Angle limit value

23. Double​

Taper limit value

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

result=JPT.Exec('MC_Mesh_Quality_Auto_Check_Quad([3:1], [], [], \
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, \
    0.1, 10, 0.0174533, 1.22173, 0.0001, 1e-08, 10, 0.174533, 0.5)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)
if splitted[0]=='1':
    success_flag,min,error_num,errors=splitted
    print(f'The number of error elements is {error_num}.')
