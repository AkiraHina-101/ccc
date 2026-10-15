# SetPartAppearance()

SetPartAppearance()

Description​

Set appearance of a part.

Syntax​

SetPartAppearance(Cursor[] tacursor, String Type, Bool Show)

Inputs​

1. Cursor[]​

Cursor list of target entities

2. String​

A String specifying appearance target.

"Surface"

"Mesh"

"Edge"

"Node"

3. Bool​

-A Boolean specifying Show or Hide.

The default value is True (Show).

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

SetPartAppearance([3:1], "Mesh", 1)
