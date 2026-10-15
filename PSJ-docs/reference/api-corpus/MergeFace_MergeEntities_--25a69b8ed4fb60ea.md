# MergeFace_MergeEntities()

MergeFace_MergeEntities()

Description​

Merge Face

Syntax​

MergeFace_MergeEntities(cursor[] taFace, bool bMergeEdge)

Inputs​

1. Cursor[]​

Target faces cursor([6:Face ID])

2. Bool​

Whether merge edges or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MergeFace_MergeEntities([6:22, 6:47], 1)
