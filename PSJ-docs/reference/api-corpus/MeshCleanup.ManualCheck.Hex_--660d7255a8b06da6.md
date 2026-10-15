# MeshCleanup.ManualCheck.Hex()

MeshCleanup.ManualCheck.Hex()

説明​

選択した品質基準に従って、ソリッドメッシュ（Hex8）を修正します。

構文​

MeshCleanup.ManualCheck.Hex(...)

マクロ：

リボン: MeshCleanup » ManualCheck » Hex

入力​

crlTargets​

メッシュ品質をチェックする対象を指定する Cursor のリストです。対象は部分要素またはソリッド要素になります。

この入力は必須です。

iElemQualityType​

メッシュ品質をチェックするために使用される標準メソッドを指定する Integer です。

0: ストレッチ

1: アスペクト比

2: エッジ長さ

3: ボリューム

4: 不安定

5: 時間ステップ（Abaqus）

この入力は必須です。

iCheckCondition​

閾値値の不等号を指定する Integer です。

iElemQualityType = 0 の場合: デフォルト値は0（以下および等しい）です。

iElemQualityType = 1 の場合: デフォルト値は2（以上および等しい）です。

iElemQualityType = 2 の場合: デフォルト値は0（以下および等しい）です。

iElemQualityType = 3 の場合: デフォルト値は0（以下および等しい）です。

iElemQualityType = 4 の場合: デフォルト値は0（以下および等しい）です。

iElemQualityType = 5 の場合: デフォルト値は0（以下および等しい）です。

dLimitValue​

指定されたメッシュ品質基準を違反した要素を検出して表示するために使用される閾値値を指定する Double です。

iElemQualityType = 0 の場合: デフォルト値は0.1 です。

iElemQualityType = 1 の場合: デフォルト値は10.0 です。

iElemQualityType = 2 の場合: デフォルト値は0.1 です。

iElemQualityType = 3 の場合: デフォルト値は0.0 です。

iElemQualityType = 4 の場合: デフォルト値は2.0 です。

iElemQualityType = 5 の場合: デフォルト値は1.0E-10 です。

dSafetyFactor​

表示される要素の安全係数値を指定する Double です。この引数は iElementQualityType = 5 の場合に使用されます。

デフォルト値は1.0 です。

戻り値​

メッシュ品質チェックの8つの値を順に指定する Tuple です。

成功（1）または失敗（0）

カットオフ値（最小）

カットオフ値（最大）

カットオフ値（平均）

測定要素の数

エラー要素の数

IDエラー要素のリスト

エラー要素のエッジのリスト

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Meshing.SurfaceMeshing(crlParts=[Part(1)], 
                    surfaceMesh=SURFACE_MESH(
                        dMaxElemSize=0.005, 
                        dMinElemSize=0.005, 
                        dGeomAngle=0.7853981634, 
                        dMinStretchVal=0.0, 
                        iPerformanceMode=1, 
                        dAutoMergeTinyFacesAngle=0.5235987756, 
                        bOutputQuadMesh=True, 
                        bGeomApprox=True, 
                        iNextEntityOffsetId=0), 
                    bFMesher=True)
HexModeling.Linear(crlFaces=[Face(26)], 
                dLength=0.0001, iLayer=1, 
                vecSweepDirection=[0.0, 0.0, 1.0], 
                bDeleteOriginalParts=True)

# メッシュ品質をチェック
result = MeshCleanup.ManualCheck.Hex(crlTargets=[Part(1)], iCheckCondition=0, dLimitValue=0.1) 
(success_flag,min,max,avg,target_num,error_num,errors1,errors2) = result
if result[0] == 1:
    print(f'ストレッチエラーを持つ要素の数は {error_num} です。最大値={max}、最小値={min}')
    print(f'エラー要素は {errors1} です')
else:
    print("エラー要素はありません")
