# MeasureAngleBy2Axis()

MeasureAngleBy2Axis()

Description​

Measure the angle created by 2 Axis.

Syntax​

MeasureAngleBy2Axis(Axis xyz1,Axis xyz2,String Target,Integer N)

Inputs​

1. Axis​

unit vector([x,y,z])

2. Axis​

unit vector([x,y,z])

3. String​

Target (Angle or XY or YZ or ZX or ALL)

4. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureAngleBy2Axis([0,0,1],[1,1,1],"ALL",6)

or

MeasureAngleBy2Axis([0,0,1],[1,1,1],"Angle",6)
