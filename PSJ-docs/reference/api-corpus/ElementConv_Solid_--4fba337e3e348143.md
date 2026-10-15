# ElementConv_Solid()

ElementConv_Solid()

Description​

Element Conversion for solid elements in a part.

Syntax​

ElementConv_Solid(cursor[] taBody, int iType)

Inputs​

1. Cursor[]​

Target body cursor([3:Part ID])

2. Int​

Conversion Type

0: To Linear(Tet4/Penta5/Hex8/Pyramid5)

1: To Quadratic(Tet10/Penta15/Hex20/Pyramid13)

2: Hexa to Penta5

3: Hexa/Penta to Tet4

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ElementConv_Solid([3:2], 1)
