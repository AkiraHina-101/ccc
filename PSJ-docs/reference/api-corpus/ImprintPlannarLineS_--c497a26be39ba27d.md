# ImprintPlannarLineS()

ImprintPlannarLineS()

Description​

Create imprint planar line

Syntax​

ImprintPlannarLineS(double[] taPositions, cursor[] taTargetFace, cursor crLocalCoor, int iType, bool bBreakFace)

Inputs​

1. Double[]​

Target points for imprinting -> Point_n([xi, yi, zi])

2. Cursor[]​

Target faces cursor([6:Face ID])

3. Cursor​

Whether use local coordinate or not True = 27:*, False = 0:0

4. Int​

Type option

5. Bool​

Whether break face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImprintPlannarLineS([[0.0017364817766693, 0.004444444444444444, -0.009848077530122082]], [6:5], 0:0, 1, 0)
