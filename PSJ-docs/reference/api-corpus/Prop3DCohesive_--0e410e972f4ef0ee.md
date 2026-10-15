# Prop3DCohesive()

Prop3DCohesive()

Description​

Create property 3d cohesive

Syntax​

Prop3DCohesive(string strName, cursor crMaterial, int iResponse, int iSpecifyThick,
double dInitialThick, cursor[] taTarget, cursor crEdit, int FLG, int iID, int iSolverType,
int iADVCResponseType, int iADVCStackDir, bool bADVCThickness, double dADVCThickness)

Inputs​

1. String​

Prop3DCohesive name

2. Cursor​

Material cursor(22:Material ID)

3. Int​

Response type

0: Traction Separation

1: Continuum

2: Gasket

4. Int​

Initial thickness type

0: Geometry

1: Specified

5. Double​

Initial thickness value, corresponding to cohesive solver type 0

6. Cursor[]​

Target entities cursor

7. Cursor​

Edit Cursor

8. Int​

FLG

9. Int​

Property ID

10. Int​

Cohesive solver type

0: ABAQUS

1: ADVC

11. Int​

ADVC response type

0: Continuum

1: Continuum2

12. Int​

Stack direction type

0: Blank

1: Stack 0

2: Stack 1

3: Stack 2

13. Bool​

ADVC thickness bool flag True = 1, False = 0

14. Double​

ADVC thickness value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Prop3DCohesive("Cohensive Property 8", 22:5, 2, 1, 20, [3:1], 0:0, 1, 6, 0, 0, 3, 1, 10)
