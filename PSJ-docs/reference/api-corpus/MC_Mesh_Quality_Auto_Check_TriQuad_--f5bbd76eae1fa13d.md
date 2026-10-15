# MC_Mesh_Quality_Auto_Check_TriQuad()

MC_Mesh_Quality_Auto_Check_TriQuad()

Description​

Mesh_Quality_Auto_Check_TriQuad

Syntax​

MC_Mesh_Quality_Auto_Check_TriQuad(Cursor[] Part Cursor,Cursor[] Face Cursor,
    Cursor[] Element Cursor,int nElemType,bool nStretchCheck,bool nAspectRatioCheck,
    bool nEdgeLengthCheck,bool nAreaCheck,bool nNodeValenceCheck,bool nInteriorAngleCheck,
    bool nDuplicateElemsCheck,double dStretchLimitValueTri,double dAspectRatioLimitValueTri,
    double dEdgeLengthLimitValueTri,double dAreaLimitValueTri,double dNodeValenceLimitValueTri,
    double dInteriorAngleLimitValueTri,double dStretchLimitValueQuad,
    double dAspectRatioLimitValueQuad,double dEdgeLengthLimitValueQuad,
    double dAreaLimitValueQuad,double dNodeValenceLimitValueQuad,double dInteriorAngleLimitValueQuad)

Inputs​

1. Cursor[]​

Part Cursor([3:*]*=Part ID)

2. Cursor[]​

Face Cursor([6:*]*=Face ID)

3. Cursor[]​

Element Cursor([11:*]*=Element ID)

4. Int​

Elem Type(3-Tri and Quad Element)

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

Stretch limit value Tri

13. Double​

AspectRatio limit value Tri

14. Double​

EdgeLength limit value Tri

15. Double​

Area limit value Tri

16. Double​

NodeValence limit value Tri

17. Double​

InteriorAngle limit value Tri

18. Double​

Stretch limit value Quad

19. Double​

AspectRatio limit value Quad

20. Double​

EdgeLength limit value Quad

21. Double​

Area limit value Quad

22. Double​

NodeValence limit value Quad

23. Double​

InteriorAngle limit value Quad

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MC_Mesh_Quality_Auto_Check_TriQuad([3:1], [], [], 3, 0, 0, 0, 0, 0, 0, 0, 0.1, 10,
    0.0001, 1e-08, 10, 0.174533, 0.1, 10, 0.0001, 1e-08, 10, 0.174533)
