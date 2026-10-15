# ImportInpToPost()

ImportInpToPost()

Description​

Import inp mesh as Post document.

Syntax​

ImportInpToPost(string FilePath, float faceAngle, float edgeAngle, int ImportType)

Inputs​

1. string  ​

File path.

2. float  ​

Face Angle.

3. float  ​

Edge Angle.

4. int  ​

Import Type
0: Standard Abaqus Inp
1: Standard Abaqus Inp by Property

Return Code​

Nothing.

Sample Code​

ImportInpToPost(["C:/Temp/Data.inp"], 1.0472, 1.0472, 1)
