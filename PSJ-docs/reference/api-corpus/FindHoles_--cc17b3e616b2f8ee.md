# FindHoles()

FindHoles()

Description​

FindHoles

Syntax​

FindHoles(Cursor[] part_list, Cursor[] edge_list, int min_length, double max_length, double findMethod)

Inputs​

1. Cursor[]​

Part List

2. Cursor[]​

Edge List

3. Double​

Edge Min Length

4. Double​

Edge Max Length

5. Int​

Find Method. All=0, Edges=1, Parts=2

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

FindHoles([3:1], [], 0, 12.345, 2)
