# SolidElemInterface

SolidElemInterface

Description​

Create Pyramid elements as interface elements.

Syntax​

SolidElemInterface(cursor[] taFaces, bool Flip, cursor[] taElements)

Inputs​

1. Cursor[]​

Face Cursor ([6:Face ID])

2. Bool​

Flip Normal false : 0, true : 1

3. Cursor[]​

Elements Cursor ([11:Elements ID])

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

SolidElemInterface([6:22], 0, [11:324])
