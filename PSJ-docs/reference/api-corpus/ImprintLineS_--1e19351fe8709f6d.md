# ImprintLineS()

ImprintLineS()

Description​

Create imprint line(Points)

Syntax​

GeoImprintSplineS(double[] taPositions, cursor[] taTargetFace, bool bBreakFace)

Inputs​

1. Double[]​

Target points for imprinting -> Point_n([xi, yi, zi])

2. Cursor[]​

Target faces cursor([6:Face ID])

3. Bool​

Whether break face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImprintLineS([[0.007777777777777778, 0.01, 0.001111111111111111], [0.005555555555555556, 0.01, 0.001111111111111111]], [6:22], 1)
