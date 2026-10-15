# ExportAnsys()

ExportAnsys()

Description​

Export Ansys file

Syntax​

ExportAnsys(String m_strName,Cursor m_crAbaJob)

Inputs​

1. String​

Export file name

2. Cursor​

Ansys Job Cursor

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ExportAnsys("D:/Ansys.dat", 146:1)
