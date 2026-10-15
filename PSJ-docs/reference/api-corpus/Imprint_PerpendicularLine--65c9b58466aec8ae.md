# Imprint_PerpendicularLine

Imprint_PerpendicularLine Imprint_PerpendicularLine Description Create imprint Perpendicular line Syntax Imprint_PerpendicularLine(double[] Point_xyz, int[] FaceID, double Offset,bool BreakFace,Cursor[] BodyCursor) Inputs double[] Point xyz [[x1,y1,z1],[x2,y2,z2]] int[] Face ID double Offset Value bool Flag Break Face true = 1,false=0 Cursor[] Body Cursor([3:*]*=Body ID) Return Code 1 Succeeded 0 Failed Sample Code Imprint_PerpendicularLine([[0.01, 0.00555556, 0.01], [0.01, 0.01, 0.00444444]], [24], 0, 1, [3:1])
