# ACM_CloseHoleMultiEdgeFace()

ACM_CloseHoleMultiEdgeFace()

Description​

ACM_CloseHole_MultiEdgeFace

Syntax​

ACM_CloseHoleMultiEdgeFace(cursor[] FaceCursor, cursor[] EdgeCursor, bool bNewBody,
    string newBodyname, bool bRemesh, double dAvgMeshSize)

Inputs​

1. Cursor[]​

Face List

2. Cursor[]​

Edge List

3. Bool​

Create New Body

4. string​

New Body Name

5. Bool​

Remesh

6. Double​

Average Remesh Size

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CloseHoleMultiEdgeFace([6:13049, 6:13059], [5:290520], 1, "NewBody", 1, 0.008)
