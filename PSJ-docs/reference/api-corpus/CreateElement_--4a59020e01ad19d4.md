# CreateElement()

CreateElement()

Description​

Create element based on nodes

Syntax​

CreateElement(int iElemType, int iParentEntity, int[] viNodeKey)

Inputs​

1. Int​

Create element type

0: TRI3

1: QUAD4

2. Int​

Parent face key cursor(Face ID)

3. Int[]​

Node key cursor([Node ID])

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateElement(0, 24, [85, 489, 83])
