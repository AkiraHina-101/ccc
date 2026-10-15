# CreateElement()

CreateElement()

Description​

Add Element Items from Element Edges

Syntax​

CreateElement(int Elem Type, int Parent Entity ID, int[] Node ID)

Inputs​

Int​

Element Type of Newly Created Element

Int​

Parent Entity ID

Int[]​

Target Nodes for Creating New Element

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateElement(0, 0, [187,196,205])
