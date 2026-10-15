# CloseHoles()

CloseHoles()

Description​

Close Holes

Syntax​

CloseHoles(Cursor[] edge_list, double area_min, double area_max, bool merge_faces, bool merge_edges)

Inputs​

1. Cursor[]​

Edge List

2. Double​

Area Min

3. Double​

Area Max

4. Bool​

Merge Faces. True=1, False=0

5. Bool​

Merge Edges. True=1, False=0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CloseHoles([5:31, 5:35, 5:39, 5:45], 0, 0.54321, 0, 0)
