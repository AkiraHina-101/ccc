# MeasureAngleBy3Nodes()

MeasureAngleBy3Nodes()

Description​

Measure the angle created by 3 nodes.

Syntax​

MeasureAngleBy3Nodes(cursor node1,cursor node2,ccursor node3,Axis xyz,String Target,Integer N)

Inputs​

1. Cursor​

node cursor(10:;=node id)

2. Cursor​

node cursor(10:;=node id)

3. Cursor​

node cursor(10:;=node id)

4. String​

Target (Angle or XY or YZ or ZX or ALL)

5. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureAngleBy3Nodes(10:331,10:323,10:340,"Angle",6)

or

MeasureAngleBy3Nodes(10:331,10:323,10:340,"ALL",6)
