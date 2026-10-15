# ElemRelatedInfo_Beam()

ElemRelatedInfo_Beam()

Description​

Set Bar/Beam Parameter

Syntax​

ElemRelatedInfo_Beam(int[] ends, int[] orientVecs, int[] orientationVecsByNode,
    int[] offsetVecAs, int[] offsetVecBs, int[] pinAs, int[] pinBs, int[] warps)

Inputs​

1. Int[]​

end node ids parameter

2. Int[]​

orientation vectors parameter

3. Int[]​

orientation vectors by Node parameter

4. Int[]​

offset A vectors parameter

5. Int[]​

offset B vectors parameter

6. Int[]​

pinA flags parameter

7. Int[]​

pinB flags parameter

8. Int[]​

warping flags parameter

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ElemRelatedInfo_Beam([], [[3, 795, 0, 1, 0], [3, 796, 0, 1, 0], [3, 797, 0, 1, 0]], [], [], [], [], [], [])
