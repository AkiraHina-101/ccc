# ImportBdf()

ImportBdf()

Description​

Import Nastran bdf file

Syntax​

ImportBdf(string[] vecPath, int importType, double faceAngle, double edgeAngle,
    bool readNameComment, int createDup1DElemAnswer)

Inputs​

1. String[]​

Path directory

2. Int​

Import type

0: Standard Nastran BDF

1: 1D2D3D-Part

2: 1D-Edge; 2D-Face; 3D-Part

3. Double​

Face angle (radian)

4. Double​

Edge angle (radian)

5. Bool​

Read Name Comments for Jupiter True=1, False=0

6. Int​

Create Dup 1D Element Answer

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportBdf(["D:/Test.bdf"], 2, 1.0472, 1.0472, 0, -1)
