# MC_Mesh_Quality_Auto_Check_Tri()

MC_Mesh_Quality_Auto_Check_Tri()

Description​

Mesh_Quality_Auto_Check_Tri

Syntax​

MC_Mesh_Quality_Auto_Check_Tri(Cursor[] Part Cursor,Cursor[] Face Cursor,
    Cursor[] Element Cursor,int nElemType,bool nStretchCheck,bool nAspectRatioCheck,
    bool nEdgeLengthCheck,bool nAreaCheck,bool nNodeValenceCheck,bool nInteriorAngleCheck,
    bool nDuplicateElemsCheck,double dStretchLimitValue,double dAspectRatioLimitValue,
    double dEdgeLengthLimitValue,double dAreaLimitValue,double dNodeValenceLimitValue,
    double dInteriorAngleLimitValue )

Inputs​

1. Cursor[]​

Part Cursor([3:*]*=Part ID)

2. Cursor[]​

Face Cursor([6:*]*=Face ID)

3. Cursor[]​

Element Cursor([11:*]*=Element ID)

4. Int​

Elem Type(0-Tri Element)

5. Bool​

Stretch Check flag,true = 1,false=0

6. Bool​

AspectRatio Check flag,true = 1,false=0

7. Bool​

EdgeLength Check flag,true = 1,false=0

8. Bool​

Area Check flag,true = 1,false=0

9. Bool​

NodeValence Check flag,true = 1,false=0

10. Bool​

InteriorAngle Check flag,true = 1,false=0

11. Bool​

DuplicateElems Check flag,true = 1,false=0

12. Double​

Stretch limit value

13. Double​

AspectRatio limit value

14. Double​

EdgeLength limit value

15. Double​

Area limit value

16. Double​

NodeValence limit value

17. Double​

InteriorAngle limit value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MC_Mesh_Quality_Auto_Check_Tri([3:1], [], [], 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 10, 0.0001, 1e-08, 10, 0.174533)
