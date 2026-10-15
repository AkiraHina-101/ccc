# ImportInp()

ImportInp()

Description​

Import Abaqus INP file

Syntax​

ImportInp(string[] m_vecPath,double m_faceAngle,double m_edgeAngle, int iImportType)

Inputs​

1. String[]​

Multiple files Path

2. Double​

Face angle

3. Double​

Edge angle

4. Int​

Import type

0: Standard Abaqus Inp

1: Standard Abaqus Inp by Property

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportInp(["D:/Test.inp"], 1.0472, 1.0472, 1)
