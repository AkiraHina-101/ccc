# MeshCleanup.ManualCheck.Tet()

MeshCleanup.ManualCheck.Tet()

説明​

選択した品質基準に従って、固体メッシュ（Tet4/Tet10）を修正します。

構文​

MeshCleanup.ManualCheck.Tet(...)

マクロ:

リボン: MeshCleanup » ManualCheck » Tet

入力​

crlTargets​

メッシュ品質をチェックする対象を指定する Cursor のリストです。対象はパートまたは固体要素であることができます。

これは必須の入力です。

iElemQualityType​

メッシュ品質をチェックするために使用される標準メソッドを指定する Integer の値です。

0: ストレッチ

1: アスペクト比

2: 体積

3: ヤコビアン係数

4: テットコラプス

5: テットスキュウ

6: エッジ長

7: 不安定

8: タイムステップ（Abaqus）

9: 三角形の高さ

10: 内角

これは必須の入力です。

iCheckCondition​

閾値値の不等号を指定する Integer の値です。

iElemQualityType = 0の場合: デフォルト値は0（以下）

iElemQualityType = 1の場合: デフォルト値は2（以上）

iElemQualityType = 2の場合: デフォルト値は0（以下）

iElemQualityType = 3の場合: デフォルト値は0（以下）

iElemQualityType = 4の場合: デフォルト値は0（以下）

iElemQualityType = 5の場合: デフォルト値は2（以上）

iElemQualityType = 6の場合: デフォルト値は0（以下）

iElemQualityType = 7の場合: デフォルト値は0（以下）

iElemQualityType = 8の場合: デフォルト値は0（以下）

iElemQualityType = 9の場合: デフォルト値は0（以下）

iElemQualityType = 10の場合: デフォルト値は0（以下）

dLimitValue​

指定されたメッシュ品質基準を満たさない要素を検出して表示するために使用される閾値値を指定する Double です。

iElemQualityType = 0の場合: デフォルト値は0.1

iElemQualityType = 1の場合: デフォルト値は10.0

iElemQualityType = 2の場合: デフォルト値は0.0

iElemQualityType = 3の場合: デフォルト値は0.0

iElemQualityType = 4の場合: デフォルト値は0.05

iElemQualityType = 5の場合: デフォルト値は0.9

iElemQualityType = 6の場合: デフォルト値は0.1

iElemQualityType = 7の場合: デフォルト値は2.0

iElemQualityType = 8の場合: デフォルト値は1.0E-10

iElemQualityType = 9の場合: デフォルト値は0.1

iElemQualityType = 10の場合: デフォルト値は10

dSafetyFactor​

表示される要素の安全係数値を指定する Double 型の値です。この引数は、iElementQualityTypeが8、9、または10の場合に使用されます。

デフォルト値は1.0です。

戻り値​

メッシュ品質チェックの8つの値を順に指定する Tuple です。

成功（1）または失敗（0）

カットオフ値（最小）

カットオフ値（最大）

カットオフ値（平均）

測定された要素の数

エラー要素の数

エラー要素のIDのリスト

エラー要素のエッジのリスト

サンプルコード​

# モデルの準備
Geometry.Part.Cube(dlLength=[0.01, 0.01, 0.0001], 
                ilAxialNodes=[10, 10, 2], 
                strName="Cube_1", 
                iPartColor=13259210)

Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                    surfaceMesh=SURFACE_MESH(
                        dMaxElemSize=0.1, 
                        dGeomAngle=0.7853981634, 
                        dMinStretchVal=0.0, 
                        iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0))

Meshing.SolidMeshing(crlParts=[Part(1)], 
                    bTet10=True, 
                    dGradingFactor=1.0, 
                    iSpeedVsQual=1, 
                    bSafeMode=False, 
                    iParallel=8, 
                    bSurfaceNodes=False, 
                    bEdgeNodes=False, 
                    bInternalMeshOnly=False, 
                    iPartColor=65280)

# メッシュ品質をチェック
result = MeshCleanup.ManualCheck.Tet(crlTargets=[Part(1)], iCheckCondition=0, dLimitValue=0.1)
(success_flag,min,max,avg,target_num,error_num,errors1,errors2) = result
if result[0] == 1:
    print(f'ストレッチエラーの発生要素数は {error_num} です。 最大値={max}、 最小値={min}')
    print(f'エラー要素は {errors1} です')
else:
    print("エラー要素はありません")
