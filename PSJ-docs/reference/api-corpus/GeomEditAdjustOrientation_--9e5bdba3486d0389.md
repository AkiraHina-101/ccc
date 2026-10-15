# GeomEditAdjustOrientation()

GeomEditAdjustOrientation()

Description​

Adjust Orientation

Syntax​

GeomEditAdjustOrientation(cursor[] taBody, cursor[] taFace, cursor[] taElem)

Inputs​

1. Cursor[]​

Target body cursor([3:Part ID])

2. Cursor[]​

Target face cursor([6:Face ID])

3. Cursor[]​

Target element cursor([11:Elem ID])

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

GeomEditAdjustOrientation([], [6:40], [11:182])
