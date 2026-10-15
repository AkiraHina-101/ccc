# BodyCutBySurfaceS()

BodyCutBySurfaceS()

Description​

Body Cut By 3 Points

Syntax​

BodyCutBySurfaceS(cursor[] crBody, cursor cutFace, bool splitOnly, bool makeSectionFace, bool shareFace, bool SeparateFace)

Inputs​

1. Cursor[]​

Target part cursor([3:PartID])

2. Cursor​

Target face for cutting

3. Bool​

Whether split face or not True = 1, False = 0

4. Bool​

Whether make section face or not True = 1, False = 0

5. Bool​

Whether share face or not True = 1, False = 0

6. Bool​

Whether separate face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

BodyCutBySurfaceS([3:2], 3:9, 0, 1, 0, 0)
