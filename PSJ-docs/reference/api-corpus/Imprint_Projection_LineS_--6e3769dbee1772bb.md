# Imprint_Projection_LineS()

Imprint_Projection_LineS()

Description​

Create imprint Projection line

Syntax​

Imprint_Projection_LineS(cursor[] taCrEdges, cursor[] taCrFaces, cursor[] taCrNodes,
    bool bBreakFace, int iType, bool bCheckGap, double dGap)

Inputs​

1. Cursor[]​

Target edge for projection line cursor([5:Edge ID])

2. Cursor[]​

Target face for projecting line on cursor([6:Face ID])

3. Cursor[]​

Target node cursor([10:Node ID]) corresponding to Vector Direction type 1

4. Bool​

Whether break face or not True = 1, False = 0

5. Int​

Vector Direction type

0: Target Face Normal

1: Two Nodes

2: Nearest Vector

6. Bool​

Whether check Gap or not True =1, False = 0

7. Double​

Gap value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Imprint_Projection_LineS([5:568], [6:67], [10:1347, 10:1324], 1, 1, 1, 0.003)
