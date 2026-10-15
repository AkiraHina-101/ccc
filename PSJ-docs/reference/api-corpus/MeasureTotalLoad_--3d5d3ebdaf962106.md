# MeasureTotalLoad()

MeasureTotalLoad()

Description​

Measure the Load

Syntax​

MeasureTotalLoad(cursor[] target items, cursor coordinate, string target string, Integer N)

Inputs​

1. Cursor[]​

Target Item cursors[]

2. Cursor​

coordinate cursor

3. String​

output target string X/Y/Z/Total/ALL

4. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureTotalLoad([],0:0,"ALL",6)
