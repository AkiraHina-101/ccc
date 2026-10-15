# MeshEditMorphingRibThickness()

MeshEditMorphingRibThickness()

Description​

Change rib thickness by moveing nodes.

Syntax​

MeshEditMorphingRibThickness(Cursor[] taFaceMove, Cursor[] taFaceFixed, double move, double distStrong, double distWeak)

Inputs​

1. Cursor[]​

A Cursor List specifying the face move.

2. Cursor[]​

A Cursor List specifying the face fixed.

3. Double​

A Double specifying the move.

4. Double​

A Double specifying the dist strong.

5. Double​

A Double specifying the dist weak.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeshEditMorphingRibThickness([6:26, 6:25], [], 0.003, 0.01, 0.02)
