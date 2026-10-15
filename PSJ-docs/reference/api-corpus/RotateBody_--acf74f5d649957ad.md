# RotateBody()

RotateBody()

Description​

Rotate Body

Syntax​

RotateBody(cursor[] taBody, double[3] vdCenter, double[3] vdAxis, double angle,
    bool createNewBody, bool copyLBC, int copyCount, bool mergeNode, double dTolerance)

Inputs​

1. Cursor[]​

Target part cursor([3:Part ID])

2. Double[3]​

Rotation coordinate Point([x, y, z])

3. Double[3]​

Rotation axis

4. Double​

Rotation angle (radian)

5. Bool​

Create new part bool flag True = 1, False = 0

6. Bool​

LBC copy bool flag True = 1, False = 0

7. Int​

Copy Count value

8. Bool​

Equivalence nodes bool flag True = 1, False = 0

9. Double​

Equivalence tolerance

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

RotateBody([3:1], [0, 0, 0.0055556], [0, 0, 0.001], 0.523599, 1, 0, 1, 0, 1e-08)
