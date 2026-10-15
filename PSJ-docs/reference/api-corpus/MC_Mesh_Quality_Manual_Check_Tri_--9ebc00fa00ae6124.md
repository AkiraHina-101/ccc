# MC_Mesh_Quality_Manual_Check_Tri()

MC_Mesh_Quality_Manual_Check_Tri()

説明​

選択した品質基準に基づいて、表面メッシュ（TRI3/TRI6）を修正します。

構文​

MC_Mesh_Quality_Manual_Check_Tri(cursor[] crEntities, int iElemType, int iCond, double dDispValue)

入力​

1. Cursor[]​

対象エンティティのカーソル（[CursorType：CursorType ID]）

2. Int​

要素品質メトリックタイプ

0: ストレッチ

1: アスペクト比

2: エッジ長

3: 面積

4: 節点次数

5: 内部角

6: 要素の重複

7: 節点自由エッジ

3. Int​

条件表示

0: <=

1: >=

2: <

3: >

4. Double​

表示値

戻り値​

8つの値をカンマで区切って含む文字列が返されます。

1. 成功（1）または失敗（0）。​

2. カットオフ値（最小）。​

3. カットオフ値（最大）。​

4. カットオフ値（平均）。​

5. 測定された要素の数。​

6. エラー要素の数。​

7. エラー要素のリスト。​

8. エラー要素エッジのリスト。​

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

result=JPT.Exec('MC_Mesh_Quality_Manual_Check_Tri([3:1], 0, 0, 0.1)')

splitted = re.split(r',\s*(?![^(\[\]]*\])', result)
if splitted[0]=='1':
    success_flag,min,max,avg,target_num,error_num,errors1,errors2=splitted
    print(f'伸長エラーを持つ要素の数は {error_num} です。最大値={max}、最小値={min}')
