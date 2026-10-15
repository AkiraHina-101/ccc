# Property3DSolid()

Property3DSolid()

Description​

Create property 3D solid

Syntax​

Property3DSolid(string Name, int Id, color propertyColor, Cursor Material, int CordM, int iN, int OutLoc,
    int ISOP, int iFLflag, int ModifiedElem, int ModifiedElemADVC, bool HasDynaRemesh,
    double DynaRemeshValMin, double DynaRemeshValMax, int HGType, int DispHG,
    Cursor[] Target, Cursor credit, int FLG)

Inputs​

1. string​

Name Property 3d solid

2. Int​

ID

3. Color​

Color of the property.

4. Cursor​

Material

5. Int​

Material coordinate [0:blank; 1:Element CS; 2:Global]

6. Int​

Integrating network [0:blank; 1:TWO; 2:THREE; 3:BUBBLE]

7. Int​

Output location [0:blank; 1:GAUSS; 2:GRID]

8. Int​

Integrating schema[0:blank; 1:REDUCED; 2:FULL]

9. Int​

Fluid element flag[0:blank; 1:PFLUID; 2:SMECH]

10. Int​

Modified Elem = 1, if Hybrid/Incompatible/Modified/Reduced Integration/Coupled Temp-Disp/Acoustic is true for ABAQUS

11. Int​

Modified Elem ADVC = 1, if Incompatible/Modified/Reduced Integration;Selective Reduced Integration is true for ADVC

12. Bool​

Has Dyna Remesh flag true = 1, false = 0

13. Double​

Remesh [Min Edge Length]

14. Double​

Remesh[Max Edge Length]

15. Int​

Hourglass Type [Use Default;Enhanced;Stiffness]

16. double​

Displacement Hourglass

17. Cursor[]​

Target list

18. Cursor​

Edit 1D beam

19. Int​

FLG

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property3DSolid("Solid Property 1", 1, 16131973, 22:1, -2, 0, 0, 0, 0, 0, 0, 0,
    1.79769e+308, 1.79769e+308, 0, 1.79769e+308, [3:1], 0:0, -1)
