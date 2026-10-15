# Imprint_PlanarLine()

Imprint_PlanarLine()

Description​

Create imprint Planar line

Syntax​

Imprint_PlanarLine(double[] Point_xyz, int[] FaceID,Cursor Coordinate, int PlaneType,
    bool BreakFace,Cursor[] BodyCursor)

Inputs​

1. Double[]​

Point xyz [[x1,y1,z1]]

2. Int[]​

Face ID

3. Cursor​

Coordinate System ([0:0]=Global)

4. Int​

Plane Type (YZ=0,ZX=1,XY=2,3Points=3)

5. Bool​

Flag Break Face true = 1,false=0

6. Cursor[]​

Body Cursor([3:*]*=Body ID)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Imprint_PlanarLine([[0.005, 0.0111111, 0.00866025]], [5], 0:0, 1, 1, [3:1])
