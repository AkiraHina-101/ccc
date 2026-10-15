# MeasureVolumeParts()

MeasureVolumeParts()

Description​

Measure the Volume

Syntax​

MeasureVolumeParts(cursor[] Part cursor,Integer N)

Inputs​

1. Cursor[]​

Part cursor(s)([3,*],*=part Id)

2. Integer N​

Specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureVolumeParts([3:1,3:2],6)
