# ImprintExtendLine()

ImprintExtendLine()

Description​

Create imprint Extend line

Syntax​

ImprintExtendLine(cursor[] vcrEdge, int iMethod, int iPosition, int iNoFittingPoints, int iDiv, bool bBreakFace)

Inputs​

1. Cursor[]​

Target edges for extending line cursor([5:Edge ID])

2. Int​

Method type

0: Straight

1: Same Curvature

3. Int​

Position to extend type

0: Nearest Edge

1: Boundary Edge

4. Int​

Number of fitting points

5. Int​

Number of divisions

6. Bool​

Whether break face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImprintExtendLine([5:27], 0, 0, 3, 2, 1)
