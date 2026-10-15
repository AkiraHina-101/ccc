# InitialTemperature()

InitialTemperature()

Description​

create initial temperature

Syntax​

InitialTemperature(string strName, int nType, double dTemp, string strFilePathName,
    bool bUseDefault, cursor crTable, cursor[] taTarget, cursor crEdit)

Inputs​

1. String​

Initial temperature name

2. Int​

Thermal type

0: Constant

2: ADVC File

3: Nastran Punch

3. Double​

Temperature value

4. String​

directory file path

5. Bool​

Use default temperature bool flag True = 1, False = 0; corresponding to Type 2, 3

6. Cursor​

Table cursor

7. Cursor[]​

Target entities cursor

8. Cursor​

Edit cursor

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

InitialTemperature("InitialTemperature1", 3, 1.79769e+308, "D:/1_heat.pch", 0, 0:0, [3:1], 0:0)
