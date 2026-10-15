# MeshCleanup.ManualCheck.Quad()

MeshCleanup.ManualCheck.Quad()

説明​

選択した品質基準に従って、表面メッシュ（Quad4/Quad8）を修正します。

構文​

MeshCleanup.ManualCheck.Quad(...)

マクロ：

リボン：MeshCleanup » ManualCheck » Quad

入力​

crlTargets​

メッシュ品質をチェックする対象を指定する Cursor リスト。対象はパート、フェース、または2D要素です。

この入力は必須です。

iElemQualityType​

メッシュ品質をチェックするために使用される標準方法を指定する Integer。

0: ストレッチ

1: アスペクト比

2: ワーピング

3: スキュー

4: エッジ長

5: 面積

6: 節点次数

7: 内部角

8: テーパー

9: 要素の重複

10: 無料エッジの節点

11: TRIsの割合

この入力は必須です。

iCheckCondition​

閾値値の不等号を指定する Integer。

iElemQualityType = 0の場合：デフォルト値は0（以下および等しい）です。

iElemQualityType = 1の場合：デフォルト値は2（以上および等しい）です。

iElemQualityType = 2の場合：デフォルト値は0（以下および等しい）です。

iElemQualityType = 3の場合：デフォルト値は0（以下および等しい）です。

iElemQualityType = 4の場合：デフォルト値は0（以下および等しい）です。

iElemQualityType = 5の場合：デフォルト値は0（以下および等しい）です。

iElemQualityType = 6の場合：デフォルト値は2（以上および等しい）です。

iElemQualityType = 7の場合：デフォルト値は0（以下および等しい）です。

iElemQualityType = 8の場合：デフォルト値は2（以上および等しい）です。

iElemQualityType = 10の場合：デフォルト値は2（以上および等しい）です。

dLimitValue​

指定されたメッシュ品質基準を違反した要素を検出して表示するために使用される Double。

iElemQualityType = 0の場合：デフォルト値は0.1です。

iElemQualityType = 1の場合：デフォルト値は10.0です。

iElemQualityType = 2の場合：デフォルト値は1.0です。

iElemQualityType = 3の場合：デフォルト値は70.0です。

iElemQualityType = 4の場合：デフォルト値は0.1です。

iElemQualityType = 5の場合：デフォルト値は0.01です。

iElemQualityType = 6の場合：デフォルト値は10.0です。

iElemQualityType = 7の場合：デフォルト値は10.0です。

iElemQualityType = 8の場合：デフォルト値は0.5です。

iElemQualityType = 10の場合：デフォルト値は4です。

戻り値​

メッシュ品質チェックの結果を順番に示す Tuple。

成功（1）または失敗（0）

Cutoff値（最小）

Cutoff値（最大）

Cutoff値（平均）

測定された要素の数

エラー要素の数

エラー要素のIDリスト

エラー要素のエッジリスト

サンプルコード​

# モデルを準備
Geometry.Part.Cube(dlLength=[0.01, 0.01, 0.0001], 
                    ilAxialNodes=[10, 10, 2], 
                    iPartColor=7697908)
JPT.Exec("View Fit To Model()")
Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                    surfaceMesh=SURFACE_MESH(
                        dMaxElemSize=0.005, 
                        dMinElemSize=0.005, 
                        dGeomAngle=0.7853981634, 
                        dGradingFactor=0.5, iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bOutputQuadMesh=True, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0), 
                        bFMesher=True, 
                        iThreadNum=16)

# メッシュ品質をチェック
result = MeshCleanup.ManualCheck.Quad(crlTargets=[Part(1)], iCheckCondition=0, dLimitValue=0.1)
(success_flag,min,max,avg,target_num,error_num,errors1,errors2) = result
if result[0] == 1:
    print(f'伸長エラーが発生している要素の数は{error_num}です。最大値={max}、最小値={min}')
    print(f'エラー要素：{errors1}')
else:
    print("エラー要素はありません")
