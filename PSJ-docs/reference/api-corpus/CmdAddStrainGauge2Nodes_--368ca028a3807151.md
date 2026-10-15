# CmdAddStrainGauge2Nodes()

CmdAddStrainGauge2Nodes()

Description​

Display stress and strain in the direction connecting two node.

Syntax​

CmdAddStrainGauge2Nodes(int iNode1, int iNode2, double dWidth, double dHeight, double dAmendFactor, str strGaugeName)

Inputs​

1. int​

An Integer specifying the ID of the 1st selected node. This argument can be used for both 2Nodes or Node-Point selection methods.

2. int​

An Integer specifying the ID of the 2nd selected node. This argument was used incase of the selection method is 2Nodes.

3. double​

A Double specifying the width of the selection when the node is picked.

4. double​

A Double specifying the length of the selection when the node is picked.

5. double​

A Double specifying the coefficient for correction that is used for strain analysis results.

6. str​

A String specifying the gauge name.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CmdAddStrainGauge2Nodes(0, 0, 0.0, 0.0, 1.0, "strGaugeName")
