# CreateBar()

CreateBar()

Description​

Create Bar Body

Syntax​

CreateBar(string bodyName, int meshCount, cursor startNode, cursor endNode)

Inputs​

1. String​

Insert body name

2. Int​

Mesh counting

3. Cursor​

Start node cursor(10:Node ID)

4. Cursor​

End node cursor(10:Node ID)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateBar("Bar_1", 7, 10:1, 10:2)
