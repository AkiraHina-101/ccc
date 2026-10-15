# MC_Mesh_Quality_Auto_Check_Tet()

MC_Mesh_Quality_Auto_Check_Tet()

説明​

複数のメッシュ品質基準を使用して、ソリッドメッシュ（TET4/TET10）を修正します。

構文​

MC_Mesh_Quality_Auto_Check_Tet(Cursor[] パートCursor, Cursor[] 要素Cursor,
    int nElemType, bool nStretchCheck, bool nAspectRatioCheck, bool nVolumeCheck,
    bool nJacobFactCheck, bool nTetCollapseCheck, bool nTetSkewCheck,
    double dStretchLimitValue, double dAspectRatioLimitValue, double dVolumeLimitValue,
    double dJacobFactLimitValue, double dTetCollapseLimitValue, double dTetSkewLimitValue)

入力​

1. Cursor[]​

パートCursor（[3:*]*=Part ID）

2. Cursor[]​

要素Cursor（[11:*]*=Element ID）

3. Int​

要素タイプ（2-Tet Element）

4. Bool​

Stretch Checkフラグ、true = 1, false = 0

5. Bool​

Aspect Ratio Checkフラグ、true = 1, false = 0

6. Bool​

Volume Boolフラグ、true = 1, false = 0

7. Bool​

Jacob factor Boolフラグ、true = 1, false = 0

8. Bool​

Tet Collapse Boolフラグ、true = 1, false = 0

9. Bool​

Tet skewフラグ、true = 1, false = 0

10. Double​

Stretch制限値

11. Double​

Aspect Ratio制限値

12. Double​

Volume制限値

13. Double​

Jacob factor制限値

14. Double​

Tet Collapse制限値

15. Double​

Tet skew制限値

戻り値​

3つの値を含むカンマで区切られた文字列を返します。

1. 成功（1）または失敗（0）。​

2. エラー要素の数。​

3. エラー要素のリスト。​

サンプルコード​

import re

Geometry.Part.Cube(
    dlLength=[0.01, 0.01, 0.0001], 
    ilAxialNodes=[10, 10, 2], 
    strName="Cube_1", 
    iPartColor=13259210)

Meshing.SurfaceMeshing(
    crlParts=[Part(1)], 
    surfaceMesh=SURFACE_MESH(
        dMaxElemSize=0.1, 
        dGeomAngle=0.7853981634, 
        dMinStretchVal=0.0, 
        iPerformanceMode=1, 
        dAutoMergeTinyFacesAngle=0.5235987756, 
        bGeomApprox=True, 
        iNextEntityOffsetId=0))

Meshing.SolidMeshing(
    crlParts=[Part(1)], 
    bTet10=True, 
    dGradingFactor=1.0, 
    iSpeedVsQual=1, 
    bSafeMode=False, 
    iParallel=8, 
    bSurfaceNodes=False, 
    bEdgeNodes=False, 
    bInternalMeshOnly=False, 
    iPartColor=65280)

result = JPT.Exec('MC_Mesh_Quality_Auto_Check_Tet([3:1], [], 2, 1, 1, 1, 1, 1, 1, 0.1, 10, 0, 0, 0.05, 0.9)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)

if splitted[0] == '1':
    success_flag, error_num, errors = splitted
    print(f'エラー要素の数 {error_num}.')
