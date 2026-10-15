# ChangeTopologyElement()

ChangeTopologyElement()

Description​

Change Topology Element

Syntax​

ChangeTopologyElement(int[] taElemKey, int[] taFaceKey, int[] taBodyKey, bool bCreateNewBody)

Inputs​

1. Int[]​

Element key cursor([Element ID])

2. Int[]​

Face key cursor([Face ID])

3. Int[]​

Part key cursor([Part ID])

4. Bool​

Create new part bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ChangeTopologyElement([2357, 2214, 2213, 2358], [], [1], 1)
