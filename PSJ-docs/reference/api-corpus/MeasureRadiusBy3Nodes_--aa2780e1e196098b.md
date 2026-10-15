# MeasureRadiusBy3Nodes()

MeasureRadiusBy3Nodes()

Description​

Measure the angle created by 3 nodes.

Syntax​

MeasureRadiusBy3Nodes(cursor node1,cursor node2,cursor node3,Integer N)

Inputs​

1. cursor​

node1 cursor(10:,=node id)

2. cursor​

node2 cursor(10:,=node id)

3. cursor​

node3 cursor(10:,=node id)

4. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureRadiusBy3Nodes(10:16,10:2,10:58,6)
