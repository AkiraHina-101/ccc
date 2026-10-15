# MeasureAngleBy2ElemEdges()

MeasureAngleBy2ElemEdges()

Description​

Measure the angle created by 2 Elem edges.

Syntax​

MeasureAngleBy2ElemEdges(cursorpair elemedge1,cursorpair elemedge2,String Target,Integer N)

Inputs​

1. Cursorpair​

elemedge cursorpair(10:-10:**;,**=node id)

2. Cursorpair​

elemedge cursorpair(10:-10:**;,**=node id)

3. String​

Target (Angle or XY or YZ or ZX or ALL)

4. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureAngleBy2ElemEdges(10:330-10:331,10:331-10:323,"Angle",6)

or

MeasureAngleBy2ElemEdges(10:330-10:331,10:331-10:323,"ALL",6)
