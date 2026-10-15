# MergeNode()

MergeNode()

Description​

Merge Node

Syntax​

MergeNode(double dTol, int iMergeType, cursor[] vcrTarget, bool createGroup, bool equivalenceNode)

Inputs​

1. Double​

Tolerance value

2. Int​

Merge node type

0: First entity

1: Second entity

2: Highest ID

3: Lowest ID

3. Cursor[]​

Target entity cursor

4. Bool​

Create group bool flag True = 1, False = 0

5. Bool​

Equivalence node bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MergeNode(0.001, 2, [3:1, 10:217, 11:471, 5:28, 6:18], 1, 1)
