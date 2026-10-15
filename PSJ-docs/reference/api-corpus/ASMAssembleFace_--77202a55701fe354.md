# ASMAssembleFace()

ASMAssembleFace()

Description​

Assemble multiple parts in a model

Syntax​

ASMAssembleFace(int[] taBodyKey, int[] taFaceKey, double tolerance, bool fitEdge, bool meshSetting)

Inputs​

1. Int[]​

Part key cursor([Part ID])

2. Int[]​

Face key cursor([Face ID])

3. Double​

Mating tolerance

4. Bool​

Imprint fit edge bool flag True = 1, False = 0

5. Bool​

Mesh setting bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ASMAssembleFace([], [22, 47], 0.001, 0, 1)
