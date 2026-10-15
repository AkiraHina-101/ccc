# ASMSeparateSolid()

ASMSeparateSolid()

Description​

Separate assembled parts in a solid model

Syntax​

ASMSeparateSolid(int[] bodyID, int[] faceID, bool createGroup)

Inputs​

1. Int[]​

Given body ids to be separated

2. Int[]​

Given face ids to be assembled

3. Bool​

Group creation option

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ASMSeparateSolid([2, 29], [], 0)
