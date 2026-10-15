# MeasureDistanceByEdge_Node()

MeasureDistanceByEdge_Node()

Description​

Measure the distance between the Edge and the Note

Syntax​

MeasureDistanceByEdge_Node(cursor edge,cursor node,Integer N)

Inputs​

1. Cursor​

edge cursor(5:,=edge id)

2. Cursor​

node cursor(10:,=node id)

3. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureDistanceByEdge_Node(5:18,10:459,6)
