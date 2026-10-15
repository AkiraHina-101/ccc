# MoveNodeAbsolute()

MoveNodeAbsolute()

Description​

Move node(s) to an absolute position

Syntax​

MoveNodeAbsolute(double dDeltaX, double dDeltaY, double dDeltaZ, bool b1stCoord,
    bool b2ndCoord, bool b3rdCoord, int[] taNodeKey, cursor crCoord)

Inputs​

1. Double​

X coordinate to move the node

2. Double​

Y coordinate to move the node

3. Double​

Z coordinate to move the node

4. Bool​

X coordinate bool flag True = 1, False = 0

5. Bool​

Y coordinate bool flag True = 1, False = 0

6. Bool​

X coordinate bool flag True = 1, False = 0

7. Int[]​

Node key cursor([Node ID])

8. Cursor​

Whether use local coordinate or not True = 27:*, False = 0:0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MoveNodeAbsolute(-0.015, 0.015, 0.015, 1, 1, 1, [1069], 0:0)
