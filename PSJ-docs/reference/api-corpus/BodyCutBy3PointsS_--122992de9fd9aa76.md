# BodyCutBy3PointsS()

BodyCutBy3PointsS()

Description​

Body Cut By 3 Points

Syntax​

BodyCutBy3PointsS(cursor crBody, double[] cutPosition, double dOffset , bool bSplit, bool makeSectionFace, bool shareFace, bool SeparateFace)

Inputs​

1. Cursor​

Part key cursor(Part ID)

2. Double[]​

Target points for cutting

3. Double​

Offset value from cutting plane

4. Bool​

Whether split face or not True = 1, False = 0

5. Bool​

Whether make section face or not True = 1, False = 0

6. Bool​

Whether share face or not True = 1, False = 0

7. Bool​

Whether separate face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

BodyCutBy3PointsS(3:2, [[0.01, 0.003333333333333333, 0.01], [0.02, 0.003333333333333333, 0.01], [0.02, 0.003333333333333333, 0]], 0.0022, 0, 1, 0, 1)
