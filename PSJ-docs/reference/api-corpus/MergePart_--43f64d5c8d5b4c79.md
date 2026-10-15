# MergePart()

MergePart()

Description​

Merge Part

Syntax​

MergePart(double tolerance, bool removeShareFace, cursor[] part)

Inputs​

1. Double​

Insert tolerance value (m)

2. Bool​

Whether remove share face or not True = 1, No =0

3. Cursor[]​

Target parts cursor([3:Part ID])

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MergePart(1e-08, 1, [3:4, 3:1])
