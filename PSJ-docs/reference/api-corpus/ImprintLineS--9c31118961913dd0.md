# ImprintLineS

ImprintLineS ImprintLineS Description Create imprint line(Points) Syntax GeoImprintSplineS(double[] taPositions, cursor[] taTargetFace, bool bBreakFace) Inputs Double[] Target points for imprinting -> Point_n([xi, yi, zi]) Cursor[] Target faces cursor([6:Face ID]) Bool Whether break face or not True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code ImprintLineS([[0.007777777777777778, 0.01, 0.001111111111111111], [0.005555555555555556, 0.01, 0.001111111111111111]], [6:22], 1)
