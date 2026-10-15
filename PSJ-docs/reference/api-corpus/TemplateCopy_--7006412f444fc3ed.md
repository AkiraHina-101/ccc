# TemplateCopy()

TemplateCopy()

Description​

Template Copy (include Window to Window)

Syntax​

TemplateCopy(cursor[] entityMaster, cursor[] entitySlave, int iMethod, bool bCopySub, double dTolerance)

Inputs​

1. Cursor[]​

Target entity master cursor([CursorType:CursorType ID])

2. Cursor[]​

Target entity slave cursor([CursorType:CursorType ID])

3. Int​

Copy settings method

0: By Shape

1: By Topology

4. Bool​

Include sub entity bool flag True = 1, False = 0

5. Double​

Tolerance (m)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

TemplateCopy([3:1], [3:2], 0, 1, 1e-06)
