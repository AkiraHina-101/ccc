# MeshCopy()

MeshCopy()

Description​

Mesh Copy

Syntax​

MeshCopy(cursor[] taFace, cursor[] taNode)

Inputs​

1. Cursor[]​

Target face cursor([6:Face ID])

2. Cursor[]​

Target node cursor([10:Node ID])

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeshCopy([6:58, 6:22], [10:500, 10:8])
