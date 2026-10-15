# CmdShowPostContour()

CmdShowPostContour()

Description​

Load result on model and show it as contour

Syntax​

CmdShowPostContour(TCursor crPostJob,
    PostResultKey& resKey, PostDataOp& opOut,
    bool hasResult2, PostResultKey& resKey2, PostDataOp& opOut2,
    bool hasResult3, PostResultKey& resKey3, PostDataOp& opOut3,
    bool enableMidNode, bool bApplyAll = false, bool bLogMacro = true)

Inputs​

1. TCursor​

Indicates post job = 183:1

2. PostResultKey:: ​

Key ID

3. PostDataOp::​

Group creation option

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CmdShowPostContour(183:1, 1, 0, 9, NodalStrain, Mises, 1, 1, 0, 0, 0, 1, 8, 0, 0.000000, 0, 0, 0, 0, 0, , , 0, 0, 0, 0, 0, 0, 0, 0, 0.000000, 0, 0, 0, 0, 0, , , 0, 0, 0, 0, 0, 0, 0, 0, 0.000000, 0, 0, 0)
