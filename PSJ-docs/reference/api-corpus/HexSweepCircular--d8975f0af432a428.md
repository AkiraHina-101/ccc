# HexSweepCircular

HexSweepCircular

Description​

Create Hex mesh by circular sweep

Syntax​

HexSweepCircular(int[] taFaceKey, double dAngle, double dTol, int iLayer, double[3] vAxisCenterPt,
    double[3] vAxisVect, bool bInterfaceElem, bool bExtrusion, double dTranslationExtrusion,
    bool bDeleteOriginalParts)

Inputs​

1. Int[]​

Face key cursor([Face ID])

2. Double​

Circular angle

3. Double​

Axis tolerance

4. Int​

Number of layer

5. Double[3]​

Sweeping axis center point

6. Double[3]​

Sweeping axis vector point

7. Bool​

Interface Elems bool flag True = 1, False = 0

8. Bool​

Total revolution and extrusion bool flag True = 1, False = 0

9. Double​

Translation distance

10. Bool​

Delete original parts bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

HexSweepCircular([131], 360, 1e-07, 100, [-0.004, 0, -8.67362e-19], [0, 0, 1], 1, 1, 0.0122, 1)
