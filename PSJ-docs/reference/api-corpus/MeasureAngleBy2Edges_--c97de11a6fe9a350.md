# MeasureAngleBy2Edges()

MeasureAngleBy2Edges()

Description​

Measure the angle created by 2 Edges.

Syntax​

MeasureAngleBy2Edges(cursor edge1,cursor edge2,String Target,Integer N)

Inputs​

1. Cursor​

edge cursor(5:;=edge id)

2. Cursor​

edge cursor(5:;=edge id)

3. String​

Target (Angle or XY or YZ or ZX or ALL)

4. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureAngleBy2Edges(5:27,5:32,"Angle",6)

or

MeasureAngleBy2Edges(5:27,5:32,"ALL",6)
