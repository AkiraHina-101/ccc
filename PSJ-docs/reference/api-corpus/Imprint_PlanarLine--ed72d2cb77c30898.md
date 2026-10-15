# Imprint_PlanarLine

Imprint_PlanarLine Imprint_PlanarLine Description Create imprint Planar line Syntax Imprint_PlanarLine(double[] Point_xyz, int[] FaceID,Cursor Coordinate, int PlaneType,bool BreakFace,Cursor[] BodyCursor) Inputs double[] Point xyz [[x1,y1,z1]] int[] Face ID Cursor Coordinate System ([0:0]=Global) int Plane Type (YZ=0,ZX=1,XY=2,3Points=3) bool Flag Break Face true = 1,false=0 Cursor[] Body Cursor([3:*]*=Body ID) Return Code 1 Succeeded 0 Failed Sample Code Imprint_PlanarLine([[0.005, 0.0111111, 0.00866025]], [5], 0:0, 1, 1, [3:1])
