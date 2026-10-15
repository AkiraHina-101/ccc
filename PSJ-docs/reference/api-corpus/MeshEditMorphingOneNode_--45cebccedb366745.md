# MeshEditMorphingOneNode()

MeshEditMorphingOneNode()

Description​

Move nodes by effect range from a selected node.

Syntax​

MeshEditMorphingOneNode(Cursor[] taNodeMove, Cursor[] taFaceFixed, bool DirectionType, Cursor Coordinate, Vector Offset, double Offset, int DistType, double DistStrong, double dDistWeak)

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

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeshEditMorphingOneNode([10:453], [], 1, 0:0, [0, 0.001, 0], 0, 0, 0.01, 0.02)
