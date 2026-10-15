# MeasureDistanceByPlane3Nodes_Node()

MeasureDistanceByPlane3Nodes_Node()

Description​

Measure Distance between Node and plane (created by 3 nodes).

Syntax​

MeasureDistanceByPlane3Nodes_Node(cursor node1,cursor node2,cursor node3,cursor node,Integer N)

Inputs​

`1. Cursor​

node1 cursor(10:,=node id)

`2. Cursor​

node2 cursor(10:,=node id)

`3. Cursor​

node3 cursor(10:,=node id)

`4. Cursor​

node cursor(10:,=node id)

5. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureDistanceByPlane3Nodes_Node(10:438,10:478,10:450,10:396,6)
