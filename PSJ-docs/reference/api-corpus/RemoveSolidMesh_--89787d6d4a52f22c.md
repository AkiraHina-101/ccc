# RemoveSolidMesh()

RemoveSolidMesh()

Description​

Remove Solid Mesh

Syntax​

RemoveSolidMesh(cursor[] taBody, bool bConvToFirst)

Inputs​

1. Cursor[]​

Target body cursor([3:Part ID])

2. Bool​

Convert to First order bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

RemoveSolidMesh([3:1], 0)
