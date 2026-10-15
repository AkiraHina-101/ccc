# MeasureAreaByEntity()

MeasureAreaByEntity()

Description​

Measure the Area

Syntax​

MeasureAreaByEntity(cursor[] entitycursor,String Target,Integer N)

Inputs​

1. Cursor[]​

entity cursor(s)([*,**],*=EntityID,**=ID in Entity)

2. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureAreaByEntity([3:1],3)

or

MeasureAreaByEntity([6:24,6:23],6)

or

MeasureAreaByEntity([11:379],0)
