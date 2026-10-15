# CmdMarkupSearchMultiPoints()

CmdMarkupSearchMultiPoints()

Description​

Search position and put note at the positions.

Syntax​

CmdMarkupSearchMultiPoints(vector[] positions, float dTolerance, bool bVisible )

Inputs​

1. vector[] ​

List of search position [x,y,z].

2. double ​

A Double specifying the tolerance to search the satisfying element. This argument will help to find the first nearest element with the input position.

3. bool ​

A Boolean specifying the search mode.

True: Only search element which is displayed on the screen

False: Enable to search the hidden element

Return Code​

1. bool[]​

List of succeed(1) or failed(0).

Sample Code​

CmdMarkupSearchMultiPoints([[15.459201, 15.559538, 7.877257],[101.999998, 30.057640, 10.221649],[-0.827893, 23.017937, 9.930871],[66.764768, 24.950984, 7.866127]], 0.010000, 0)
>> [1,1,0,1]
