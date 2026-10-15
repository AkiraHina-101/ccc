# CmdDistancePlot()

CmdDistancePlot()

Description​

Distance Plot.

Syntax​

CmdDistancePlot(int Node1, int Node2, PostStepItem [] stepItem, bool DistXYZ, bool PosXYZ )

Inputs​

1. int  ​

Node 1 ID

2. int  ​

Node 2 ID

3. PostStepItem [] ​

Source results.

PostStepItems are:

int - Analysis type. 

int - Result set.

int - Time step.

4. bool ​

X, Y, Z Distance Plot flag.

5. bool ​

X, Y, Z Position Plot flag.

Return Code​

Nothing.

Sample Code​

CmdDistancePlot(8, 2, [[1,0,0], [1,0,1], [1,0,2], [1,0,3]], 0, 1)
