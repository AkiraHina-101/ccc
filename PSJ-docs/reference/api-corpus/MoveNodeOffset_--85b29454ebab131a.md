# MoveNodeOffset()

MoveNodeOffset()

Description​

Move node(s) to an offset position

Syntax​

MoveNodeOffset(double dDeltaX, double dDeltaY, double dDeltaZ, cursor crCoord, int[] taNodeKey)

Inputs​

1. Double​

X coordinate to move the node

2. Double​

Y coordinate to move the node

3. Double​

Z coordinate to move the node

4. Cursor​

Whether use local coordinate or not True = 27:*, False = 0:0

5. Int[]​

Node key cursor([Node ID])

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MoveNodeOffset(0, 0, 0.0005, 0:0, [1068])
