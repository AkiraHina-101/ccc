# Imprint_PerpendicularCylinderLine()

Imprint_PerpendicularCylinderLine()

Description​

Create imprint Perpendicular Cylinder line

Syntax​

Imprint_PerpendicularCylinderLine(double[] Point_xyz, int FaceID, int type,double value,
    bool oppositeFlag, bool BreakFace,Cursor[] BodyCursor)

Inputs​

1. Double[]​

Point xyz [[x1,y1,z1],[x2,y2,z2],[x3,y3,z3]]

2. Int​

Face ID

3. Int​

Method Type 0=Arclength,1=CenterAngle

4. Double​

Length/Angle Value

5. Bool​

Opposite Flag true=1,false=0

6. Bool​

Flag Break Face true = 1,false=0

7. Cursor[]​

Body Cursor([3:*]*=Body ID)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Imprint_PerpendicularCylinderLine([[0.005, 0.00666667, 0.00866025], [0.005, 0.02, 0.00866025]], 5, 1, 0, 0, 1, [3:1])
