# BeamMeshing()

BeamMeshing()

Description​

Beam1D Meshing

Syntax​

BeamMeshing(int[] vcrCadEdgeKey, int[] vcrBarEdgeKey, int[] vcrBarBody, double dDocMeshSize, int iDocNumOfElem)

Inputs​

1. Int[]​

Edge cursor([Edge ID])

2. Int[]​

Bar and Edge cursor([BarEdge ID])

3. Int[]​

Bar cursor([Bar ID])

4. Double​

Mesh size

5. Int​

Number of Elements

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

BeamMeshing([], [155, 156], [5], 0, 5)
