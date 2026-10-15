# Imprint_IntersectLine()

Imprint_IntersectLine()

Description​

Create imprint Intersection line

Syntax​

Imprint_IntersectLine(int[] FaceID, bool BreakFace,Cursor[] BodyCursor)

Inputs​

1. Int[]​

Face ID

2. Bool​

Flag true = 1,false=0

3. Cursor[]​

Body Cursor([3:*]*=Body ID)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Imprint_IntersectLine([26, 49], 1, [3:1, 3:2])
