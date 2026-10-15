# Imprint_ClosedLine()

Imprint_ClosedLine()

Description​

Create imprint Closed line

Syntax​

Imprint_ClosedLine(double[] Point_xyz,bool BreakFace,Cursor[] bodyCursor)

Inputs​

1. Double[]​

Point xyz [[x1,y1,z1],[x2,y2,z2],[x3,y3,z3]]

2. Bool​

Flag true = 1,false=0

3. Cursor[]​

Body Cursor([3:*]*=Body ID)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Imprint_ClosedLine([[0.00444444, 0.00222222, 0.01], [0.00666667, 0.00333333, 0.01],
     [0.00666667, 0.00666667, 0.01], [0.00333333, 0.00555556, 0.01]], 1, [3:1])
