# SweepCloseLoopShape()

SweepCloseLoopShape()

Description​

Create Hex mesh by curve sweep

Syntax​

SweepCloseLoopShape(cursor crFace, cursor[] vcrEdges, cursor[] vcrRefEdges, double dMeshSize)

Inputs​

1. Cursor​

Target face cursor(6:Face ID)

2. Cursor[]​

Target edge cursor([5:Edge ID])

3. Cursor[]​

Target reference edge cursor([14:RefEdge ID])

4. Double​

Mesh size value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

SweepCloseLoopShape(6:6, [5:3, 5:1, 5:2], [], 0.0001)
