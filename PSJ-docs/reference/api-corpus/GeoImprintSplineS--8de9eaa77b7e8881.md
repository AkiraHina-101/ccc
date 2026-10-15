# GeoImprintSplineS

GeoImprintSplineS GeoImprintSplineS Description Create imprint Spline Syntax GeoImprintSplineS(double[] taPositions, cursor[] taTargetFace, bool bBreakFace) Inputs Double[] Target points for imprinting -> Point_n([xi, yi, zi]) Cursor[] Target faces cursor([6:Face ID]) Bool Whether break face or not True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code GeoImprintSplineS([[0.01, 0.01, 0.004444444444444444], [0.006666666666666666, 0.01, 0], [0.004444444444444444, 0.01, 0.004444444444444444]], [6:22], 1)
