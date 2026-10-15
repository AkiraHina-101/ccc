# MeshCleanup.ManualCheck.TriQuad()

MeshCleanup.ManualCheck.TriQuad()

説明​

選択された品質基準に従って、表面メッシュ（TRI3/TRI6/QUAD4/QUAD8）を修正します。

構文​

MeshCleanup.ManualCheck.TriQuad(...)

マクロ:

リボン: MeshCleanup » ManualCheck » TriQuad

入力​

crlTargets​

メッシュ品質をチェックするターゲットを指定する Cursor リスト。ターゲットは部分、フェース、または2D要素になります。

この入力は必須です。

iElemQualityType​

メッシュ品質をチェックするために使用される標準メソッドを指定する Integer 。

0: ストレッチ

1: アスペクト比

2: エッジ長

3: 面積

4: 節点数

5: 内角

6: 不安定

7: タイムステップ（LS-Dyna）

8: タイムステップ（Abaqus）

この入力は必須です。

iCheckConditionTri​

TRI要素の閾値値に対する不等号を指定する Integer 。

iElemQualityType = 0 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 1 の場合：デフォルト値は2（以上および等しい）。

iElemQualityType = 2 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 3 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 4 の場合：デフォルト値は2（以上および等しい）。

iElemQualityType = 5 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 6 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 7 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 8 の場合：デフォルト値は0（以下および等しい）。

dLimitValueTri​

TRI要素が指定されたメッシュ品質基準を満たさないことが判明したときに使用される閾値値を指定する Double 。

iElemQualityType = 0 の場合：デフォルト値は0.1です。

iElemQualityType = 1 の場合：デフォルト値は10.0です。

iElemQualityType = 2 の場合：デフォルト値は0.1です。

iElemQualityType = 3 の場合：デフォルト値は0.01です。

iElemQualityType = 4 の場合：デフォルト値は10.0です。

iElemQualityType = 5 の場合：デフォルト値は10.0です。

iElemQualityType = 6 の場合：デフォルト値は1.0です。

iElemQualityType = 7 の場合：デフォルト値は9.9E-06です。

iElemQualityType = 8 の場合：デフォルト値は1.0E-10です。

dSafetyFactorTri​

TRI要素の安全係数値を表示するために使用される Double 型の引数です。この引数は iElementQualityType = 7 もしくは 8 の場合に使用されます。

デフォルト値は1.0です。

iCheckConditionQuad​

QUAD要素の閾値値に対する不等号を指定する Integer 。

iElemQualityType = 0 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 1 の場合：デフォルト値は2（以上および等しい）。

iElemQualityType = 2 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 3 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 4 の場合：デフォルト値は2（以上および等しい）。

iElemQualityType = 5 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 6 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 7 の場合：デフォルト値は0（以下および等しい）。

iElemQualityType = 8 の場合：デフォルト値は0（以下および等しい）。

dLimitValueQuad​

QUAD要素が指定されたメッシュ品質基準を満たさないことが判明したときに使用される閾値値を指定する Double 。

iElemQualityType = 0 の場合：デフォルト値は0.1です。

iElemQualityType = 1 の場合：デフォルト値は10.0です。

iElemQualityType = 2 の場合：デフォルト値は0.1です。

iElemQualityType = 3 の場合：デフォルト値は0.01です。

iElemQualityType = 4 の場合：デフォルト値は10.0です。

iElemQualityType = 5 の場合：デフォルト値は10.0です。

iElemQualityType = 6 の場合：デフォルト値は1.0です。

iElemQualityType = 7 の場合：デフォルト値は9.9E-06です。

iElemQualityType = 8 の場合：デフォルト値は1.0E-10です。

dSafetyFactorQuad​

QUAD要素の安全係数値を表示するために使用される Double 型の引数です。この引数は iElementQualityType = 7 もしくは 8 の場合に使用されます。

デフォルト値は1.0です。

bIncludeDiagonalQuad​

QUADの対角線を含めるかどうかを指定する Boolean 型の引数です。この引数は iElementQualityType = 7（タイムステップ（LS-Dyna））の場合に使用されます。

デフォルト値は True です。

iNonPrimary​

プライマリではないことを指定する Integer の引数です。

デフォルト値は0です。

戻り値​

メッシュ品質チェック結果を8つの値で指定する Tuple です。

成功（1）または失敗（0）

カットオフ値（最小）（Triチェック）

カットオフ値（最大）（Triチェック）

カットオフ値（平均）（Triチェック）

計測された要素の数（Triチェック）

エラー要素の数（Triチェック）

エラー要素のIDリスト（Triチェック）

エラー要素のエッジリスト（Triチェック）

カットオフ値（最小）（Quadチェック）

カットオフ値（最大）（Quadチェック）

カットオフ値（平均）（Quadチェック）

計測された要素の数（Quadチェック）

エラー要素の数（Quadチェック）

エラー要素のIDリスト（Quadチェック）

エラー要素のエッジリスト（Quadチェック）

サンプルコード​

# モデルの準備
Geometry.Part.Trapezoid(dlLength=[0.01, 0.001, 0.01], 
                        dTopXLength=0.1, 
                        strName="Trapezoid_1", 
                        iPartColor=7697908)
JPT.Exec("View Fit To Model()")
Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                    surfaceMesh=SURFACE_MESH(
                        dMaxElemSize=0.005, 
                        dMinElemSize=0.005, 
                        dGeomAngle=0.7853981634, 
                        dGeomMinSize=0.0001, 
                        dGradingFactor=0.5, 
                        iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bOutputQuadMesh=True, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0), 
                    bFMesher=True, 
                    iThreadNum=16)

# メッシュ品質をチェック
result = MeshCleanup.ManualCheck.TriQuad(crlTargets=[Part(1)], 
                                        iCheckConditionTri=0, 
                                        dLimitValueTri=0.2, 
                                        iCheckConditionQuad=0, 
                                        dLimitValueQuad=0.1)
if result[0] == 1:
    if result[5] > 0:
        print(f'The number of Tri elements that have stretch error is {result[5]}. max value={result[1]}, min value={result[2]}')
        print(f'The error elements are {result[6]}')
    else:
        print("There is no Tri error element")
    if result[12] > 0:
        print(f'The number of Quad elements that have stretch error is {result[12]}. max value={result[8]}, min value={result[9]}')
        print(f'The error elements are {result[13]}')
    else:
        print("There is no Quad error element")
else:
    print("There is no error element")
