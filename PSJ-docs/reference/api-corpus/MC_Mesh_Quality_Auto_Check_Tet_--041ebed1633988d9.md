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

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MC_Mesh_Quality_Auto_Check_Tet([3:1], [], 2, 0, 0, 0, 0, 0, 0, 0.1, 10, 0, 0, 0.05, 0.9)
