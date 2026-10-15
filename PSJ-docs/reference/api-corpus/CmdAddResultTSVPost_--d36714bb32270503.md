# CmdAddResultTSVPost()

CmdAddResultTSVPost()

Description​

Add result to current mesh data.

Syntax​

CmdAddResultTSVPost(cursor Job, string[] path, int solverType, int offsetID)

Inputs​

1. cursor ​

Post job.

2. string[] ​

File paths.

3. int ​

Solver type.

4. int ​

Offset ID.

Return Code​

Nothing.

Sample Code​

CmdAddResultTSVPost(183:1, ["C:/temp/data.unv"], 4, 1)
