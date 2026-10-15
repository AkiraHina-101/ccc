# SweepCloseLoopShape

SweepCloseLoopShape SweepCloseLoopShape Description Create Hex mesh by curve sweep Syntax SweepCloseLoopShape(cursor crFace, cursor[] vcrEdges, cursor[] vcrRefEdges, double dMeshSize) Inputs Cursor Target face cursor(6:Face ID) Cursor[] Target edge cursor([5:Edge ID]) Cursor[] Target reference edge cursor([14:RefEdge ID]) Double Mesh size value Return Code 1 Succeeded 0 Failed Sample Code SweepCloseLoopShape(6:6, [5:3, 5:1, 5:2], [], 0.0001)
