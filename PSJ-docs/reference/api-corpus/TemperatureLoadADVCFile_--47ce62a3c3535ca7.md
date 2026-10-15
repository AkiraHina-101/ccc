# TemperatureLoadADVCFile()

TemperatureLoadADVCFile()

Description​

Create temperature load by advc file

Syntax​

TemperatureLoadADVCFile(string strName, string strFilePathName, cursor crTable, cursor[] taTarget, cursor crEdit)

Inputs​

1. String​

name of temperature load

2. String​

file path

3. Cursor​

select table

4. Cursor[]​

targets

5. Cursor​

edit cursor

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

TemperatureLoadGeneral("TemperatureLoadsConstant1", 303.15, 0:0, [6:21], 0:0, 0)
