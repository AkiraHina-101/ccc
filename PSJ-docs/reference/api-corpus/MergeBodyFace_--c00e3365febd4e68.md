# MergeBodyFace()

MergeBodyFace()

Description​

Merge Body Face

Syntax​

MergeBodyFace(int[] taBodyKey, int[] taFaceKey, bool bAngle, double dToleranceAngle, bool bWidth, double dToleranceWidth)

Inputs​

1. Int[]​

Part cursor([Part ID])

2. Int[]​

Face cursor([Face ID])

3. Bool​

Whether select angle or not True = 1, False = 0

4. Double​

Insert tolerance angle value

5. Bool​

Whether select width or not True = 1, False = 0

6. Double​

Insert tolerance width value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MergeBodyFace([1], [29], 1, 20, 1, 0.0002)
