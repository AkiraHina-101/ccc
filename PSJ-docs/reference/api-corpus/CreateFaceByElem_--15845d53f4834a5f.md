# CreateFaceByElem()

CreateFaceByElem()

Description​

Create Face By Elements

Syntax​

CreateFaceByElem(cursor[] elem, bool shareFace)

Inputs​

1. Cursor[]​

Target element cursor([11:Elem ID])

2. Bool​

Whether share face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateFaceByElem([11:441, 11:442, 11:444, 11:443], 0)
