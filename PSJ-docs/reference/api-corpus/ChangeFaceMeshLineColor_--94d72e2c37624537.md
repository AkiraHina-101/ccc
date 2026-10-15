# ChangeFaceMeshLineColor()

ChangeFaceMeshLineColor()

Description​

Change the color of the mesh lines of selected faces.

Syntax​

ChangeFaceMeshLineColor(Cursor[] Faces, Color Color)

Inputs​

1. Cursor[]​

A cursor list of faces.

2. color​

Specify the color of mesh line.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ChangeFaceMeshLineColor([6:21, 6:22, 6:23, 6:24, 6:25, 6:26], 12603648)
