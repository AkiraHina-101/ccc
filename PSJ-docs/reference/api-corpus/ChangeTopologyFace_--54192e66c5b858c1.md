# ChangeTopologyFace()

ChangeTopologyFace()

Description​

Change Topology Face

Syntax​

ChangeTopologyFace(int[] taFaceKey, int[] taBodyKey, bool bCreateNewBody)

Inputs​

1. Int[]​

Face key cursor([Face ID])

2. Int[]​

Part key cursor([Part ID])

3. Bool​

Create new part bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ChangeTopologyFace([8], [2], 1)
