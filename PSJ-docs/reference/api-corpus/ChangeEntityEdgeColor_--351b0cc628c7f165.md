# ChangeEntityEdgeColor()

ChangeEntityEdgeColor()

Description​

Change the color of the edges of selected entity.

Syntax​

ChangeEntityEdgeColor(Cursor[] crParts, COLORREF col, bool bRandom)

Inputs​

1. Cursor[]​

A list of part.

2. color​

Specify a color to set.

2. bool​

Flag of random color

"1": Edge color is set at random.

"0": Edge color is set by specified color.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ChangeEntityEdgeColor([3:1], 16711746, 0)
