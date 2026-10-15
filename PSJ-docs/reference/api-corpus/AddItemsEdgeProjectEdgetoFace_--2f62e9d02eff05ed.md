# AddItemsEdgeProjectEdgetoFace()

AddItemsEdgeProjectEdgetoFace()

Description​

Add Items Edge by Projecting Edge to Face with smallest distance

Syntax​

AddItemsEdgeProjectEdgetoFace(int[] FaceKey, int[] EdgeKey, bool ExtendToEdge)

Inputs​

1. Int[]​

Target Faces for projecting Edge

2. Int[]​

Target Edge to be projected

3. Bool​

Extend the Newly Created Edge up to Nearby Edges. true = 1,false = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AddItemsEdgeProjectEdgetoFace([24], [42], 1)
