# Imprint_OffsetLine

Imprint_OffsetLine Imprint_OffsetLine Description Create imprint Offset line Syntax Imprint_OffsetLine(int[] FaceID, int[] EdgeID, double Offset, bool Flag_Extend, bool BreakFace,Cursor[] BodyCursor) Inputs int[] Face ID int[] Edge ID double Offset Value bool Flag Extend true = 1,false=0 bool Flag Break true = 1,false=0 Cursor[] Body Cursor([3:*]*=Body ID) Return Code 1 Succeeded 0 Failed Sample Code Imprint_OffsetLine([26], [18], 0.005, 1, 1, [3:1])
