# SeparateNode()

SeparateNode()

Description​

Separate Node

Syntax​

SeparateNode(cursor[] vcrNode, cursor[] vcrTarget, int iKeepIDsOn)

Inputs​

1. Cursor[]​

Target node cursor([10:Node ID])

2. Cursor[]​

Target entities cursor

3. Int​

Keep Node IDs On type

0: None

1: Selection Part Order

2: Higher Part ID

3: Lower Part ID

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

SeparateNode([10:7, 10:1955, 10:1954, 10:1953], [10:7, 10:1955, 10:1954, 10:1953], 0)
