# CmdOptimizeShapeSmoothFunc()

CmdOptimizeShapeSmoothFunc()

Description​

Smoothing topology optimization result

Syntax​

CmdOptimizeShapeSmoothFunc(cursor [], cursor [], double tol, int nlayer, int cycle, double factor, double meshSize, bool keep)

Inputs​

1. cursor[]  ​

Designed parts

2. cursor[] ​

Non-designed parts

3. double ​

Tolerance of density

4. int  ​

Number of remove layer

5. int ​

Number of looping

6. double ​

factor

7. double ​

Mesh size

8. bool  ​

Keep shared nodes

Return Code​

Nothing.

Sample Code​

CmdOptimizeShapeSmoothFunc([3:1], [], 0.670000, 1, 50, 0.300000, 0.002845, 0)
