# HexSweepLinear()

HexSweepLinear()

Description​

Linear hex mesh creation

Syntax​

HexSweepLinear(int[] taFaceKey, double dLength, int nLayer, double[3] dSweepDir,
    bool bInterfaceElem, int nLinearDirType, bool bDelOriPart, bool bDeleteTargetParts,
    int nBiasMethod, double dFactor, int nProgression)

Inputs​

`

`1. Int[]​

Face key cursor([Face ID])

2. Double​

Sweep length

3. Int​

Number of layers

4. Double[3]​

Sweep direction([x, y, z])

5. Bool​

Interface Element bool flag True = 1, False = 0

6. Int​

Linear direction method

0: Plane normal

1: Arbitrary

2: X

3: Y

4: Z

5: Node to ElemEdge

6: Face to Face

7. Bool​

Delete original (source) part bool flag True = 1, False = 0

8. Bool​

Delete target part bool flag True = 1, False = 0; corresponding to Linear direction method type 6

9. Int​

Bias method

0: Equal

1: Bias

2: Bias-Sides

3: Bias-Center

10. Double​

Bias factor corresponding to Bias Method type 1, 2, 3

11. Int​

Linear progression

0: Geometric

1: Arithmetic

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

HexSweepLinear([6], 0.1, 10, [0, 1, 0], 0, 3, 0, 0, 0, 2, 0)
