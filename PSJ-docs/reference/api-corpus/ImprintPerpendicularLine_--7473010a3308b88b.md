# ImprintPerpendicularLine()

ImprintPerpendicularLine()

Description​

Create imprint Perpendicular line

Syntax​

ImprintPerpendicularLine(cursor[] nodes, cursor[] faces, double offset, bool bBreakFace)

Inputs​

1. Cursor[]​

Target node cursor([10:Node ID])

2. Cursor[]​

Target faces cursor([6:Face ID])

3. Double​

Insert offset value

4. Bool​

Whether break face or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImprintPerpendicularLine([10:218, 10:190], [6:22], 0.002, 1)
