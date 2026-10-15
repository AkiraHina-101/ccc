# MeasureAngleByProjected_Node()

MeasureAngleByProjected_Node()

Description​

Measure the angle between the node and the plane of coordinate system.

Syntax​

MeasureAngleByProjected_Node(cursor node,String Target,Integer N)

Inputs​

1. Cursor​

node cursor(10:;=node id)

2. String​

Target (XY or YZ or ZX or ALL)

3. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureAngleByProjected_Node(10:331,"XY",6)

or

MeasureAngleByProjected_Node(10:331,"ALL",6)
