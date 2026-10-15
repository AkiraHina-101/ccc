# ChangeBodyColor()

ChangeBodyColor()

Description​

Change the color of the selected part.

Syntax​

ChangeBodyColor([Cursor, color][] bool bResetFaceColor)

Inputs​

1. [Cursor, color][]​

A list of pair of part and its color.

2. bool​

Specify whether or not reset face color.

"1": Reset face color.

"0": Keep face color.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ChangeBodyColor([[3:1, 16777193]], 0)
