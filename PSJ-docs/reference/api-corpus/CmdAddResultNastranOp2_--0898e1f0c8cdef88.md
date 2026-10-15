# CmdAddResultNastranOp2()

CmdAddResultNastranOp2()

Description​

Add nastran result to current model.

Syntax​

CmdAddResultNastranOp2(cursor postJob, string[] FilePath, int solverType, int offsetID, bool CreateAtMidNodes)

Inputs​

1. cursor  ​

Post job.

2. string[]  ​

File paths

3. int  ​

Solver type

4. int  ​

Offset ID

5. bool  ​

Create at mid nodes option flag.

Return Code​

Nothing.

Sample Code​

CmdAddResultNastranOp2(183:1, ["C:/Users/USERNAME/Documents/TSData/11_Desktop/Solver/boltconnection_converted_bar-fix.op2"], 1, 1, 0)
