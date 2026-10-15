# ImportBdf

ImportBdf ImportBdf Description Import Nastran bdf file Syntax ImportBdf(string[] vecPath, int importType, double faceAngle, double edgeAngle, bool readNameComment, int createDup1DElemAnswer) Inputs String[] Path directory Int Import type* *0: Standard Nastran BDF &ensp;1: 1D2D3D-Part &ensp;2: 1D-Edge; 2D-Face; 3D-Part Double Face angle (radian) Double Edge angle (radian) bool Read Name Comments for Jupiter True=1, False=0 int N/A: Create Dup 1D Element Answer Return Code 1 Succeeded 0 Failed Sample Code ImportBdf(["D:/ImportFile/Test.bdf"], 2, 1.0472, 1.0472, 0, -1)
