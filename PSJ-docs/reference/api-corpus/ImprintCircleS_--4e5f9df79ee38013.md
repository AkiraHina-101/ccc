# ImprintCircleS()

ImprintCircleS()

Description​

Create imprint circle line

Syntax​

ImprintCircleS(double[] taPositions, cursor[] taTargetFace, double dInRadius, double dOutRadius,
    int iNoofLayer, int iNoOfDiv, bool bBreakFace)

Inputs​

1. Double[]​

Target points for imprinting -> Point_n([xi, yi, zi])

2. Cursor[]​

Target faces cursor([6:Face ID])

3. Double​

Inner radius

4. Double​

Outer radius

5. Int​

Number of layers

6. Int​

Number of divisions

7. Bool​

Whether break face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImprintCircleS([[0.007777777777777778, 0.006666666666666666, 0.01]], [6:26], 0.001, 0.002, 1, 30, 1)
