# NodeMovedByDirection()

NodeMovedByDirection()

Description​

Move node(s) in a specified direction

Syntax​

NodeMovedByDirection(Cursor[] crNode, Cursor crElem, Cursor crFace, double[3] vctDirection,
    double dMoveAmount, bool BDestiByFaceOrElem)

Inputs​

1. Cursor[]​

Target node cursor([10:Node ID])

2. Cursor​

Target element cursor(11:Elem ID)

3. Cursor​

Target face cursor(6:Face ID)

4. Double[3]​

Vector direction DX, DY, DZ

5. Double​

Move amount user input

6. Bool​

Destination by face or element bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

NodeMovedByDirection([10:1420], 11:3167, 6:78, [0.196116135138184, 0.98058067569092, 0], 0.005, 1)
