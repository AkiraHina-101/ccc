# MeshEditMorphingFaces()

MeshEditMorphingFaces()

Description​

Move nodes by effect range from a selected node.

Syntax​

MeshEditMorphingFaces(Cursor[] taFaceMove, Cursor[] taFaceFixed, bool DirectionType, Cursor Coordinate, Vector Offset, double Offset, int DistType, double DistStrong, double dDistWeak, int nodeID, Vector pointPosition )

Inputs​

1. Cursor[]​

A Cursor List specifying the node move.

2. Cursor[]​

A Cursor List specifying the face fixed.

3. Bool​

A Bool specifying the Direction Type.

4. Cursor​

A Cursor specifying the Coordinate.

5. Double[]​

A Double vector specifying the dist strong for Direction Type: Offset values.

6. Double​

A Double specifying the move distance for Direction Type: Normal Offset.

7. Int​

An Int specifying the Effect Range.

8. Double​

A Double specifying the dist strong.

9. Double​

A Double specifying the dist weak.

10. Int​

An Int specifying the rotation center for Direction Type: Rotation.

11. Vector​

A Double vector specifying the position of point for Direction Type: Node+Point.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeshEditMorphingFaces([6:26], [], 0, 0:0, [0, 0.001, 0], 0, 0, 0.01, 0.02, -1, [])
