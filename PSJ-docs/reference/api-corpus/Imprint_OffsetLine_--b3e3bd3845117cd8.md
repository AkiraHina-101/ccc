# Imprint_OffsetLine()

Imprint_OffsetLine()

Description​

Create imprint Offset line

Syntax​

Imprint_OffsetLine(int[] FaceID, int[] EdgeID, double Offset, bool Flag_Extend, bool BreakFace,Cursor[] BodyCursor)

Inputs​

1. Int[]​

Face ID

2. Int[]​

Edge ID

3. Double​

Offset Value

4. Bool​

Flag Extend true = 1,false=0

5. Bool​

Flag Break true = 1,false=0

6. Cursor[]​

Body Cursor([3:*]*=Body ID)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Imprint_OffsetLine([26], [18], 0.005, 1, 1, [3:1])
