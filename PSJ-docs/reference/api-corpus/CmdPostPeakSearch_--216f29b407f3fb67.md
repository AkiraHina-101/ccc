# CmdPostPeakSearch()

CmdPostPeakSearch()

Description​

Find peak nodes with higher or lower results (peaked) than nearby vertices at each node in the model and flag them.

Syntax​

CmdPostPeakSearch(int iOption, double dParameter, boolbStep)

Inputs​

1. int​

An Integer specifying the peak option.

2. double​

A Double specifying the the value for micro peak removal.

3. bool​

A Boolean specifying whether to use the Step option.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CmdPostPeakSearch(0, 0.1, 1)
