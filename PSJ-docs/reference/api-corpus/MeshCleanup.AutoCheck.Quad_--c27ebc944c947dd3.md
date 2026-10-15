# MeshCleanup.AutoCheck.Quad()

MeshCleanup.AutoCheck.Quad()

説明​

複数のメッシュ品質基準を使用して、表面メッシュ（QUAD4/QUAD8）を修正します。

構文​

MeshCleanup.AutoCheck.Quad(...)

マクロ：

リボン：MeshCleanup » AutoCheck » Quad

入力​

crlTargets​

メッシュ品質をチェックする対象を指定する Cursor リスト。対象は部分またはフェースにできます。

これは必須の入力です。

bStretchCheck​

ストレッチ品質を確認するかを指定する Boolean。

デフォルト値は0です。

bAspectRatioCheck​

アスペクト比品質を確認するかを指定する Boolean。

デフォルト値は0です。

bWarpingCheck​

ワーピング品質を確認するかを指定する Boolean。

デフォルト値は0です。

bSkewnessCheck​

スキュー品質を確認するかを指定する Boolean。

デフォルト値は0です。

bEdgeLengthCheck​

エッジ長品質を確認するかを指定する Boolean。

デフォルト値は0です。

bAreaCheck​

面積品質を確認するかを指定する Boolean。

デフォルト値は0です。

bNodeValenceCheck​

節点価数品質を確認するかを指定する Boolean。

デフォルト値は0です。

bInteriorAngleCheck​

内角品質を確認するかを指定する Boolean。

デフォルト値は0です。

bTaperCheck​

テーパー品質を確認するかを指定する Boolean。

デフォルト値は0です。

bDuplicateElemsCheck​

重複要素を確認するかを指定する Boolean。

デフォルト値は0です。

dStretchLimit​

ストレッチの閾値値を指定する Double。指定値以下のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は0.1です。

dAspectRatioLimit​

アスペクト比の閾値値を指定する Double。指定値以上のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は10です。

dWarpingLimit​

ワーピングの閾値値を指定する Double。指定値以下のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は1です。

dSkewnessLimit​

スキューの閾値値を指定する Double。指定値以下のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は70です。

dEdgeLengthLimit​

エッジ長の閾値値を指定する Double。指定値以下のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は0.1です。

dAreaLimit​

面積の閾値値を指定する Double。指定値以下のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は0.01です。

dNodeValenceLimit​

節点価数の閾値値を指定する Double。指定値以上のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は10です。

dInteriorAngleLimit​

内角の閾値値を指定する Double。指定値以下のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は10です。

dTaperLimit​

テーパーの閾値値を指定する Double。指定値以上のストレッチ値を持つ要素が検出され、ウィンドウに表示されます。

デフォルト値は0.5です。

戻り値​

メッシュ品質に違反する要素の情報を順番に示す Tuple。

成功（1）または失敗（0）

エラー要素の数

IDエラー要素のリスト

サンプルコード​

# モデルの準備
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
result = MeshCleanup.AutoCheck.Quad(crlTargets=[Part(1)], 
                                    bStretchCheck=True, 
                                    bWarpingCheck=True, 
                                    dStretchLimit=0.1, 
                                    dWarpingLimit=0.0174533)
if result[1] >=1:
    print("エラー要素の数は " + str(result[1]) + " です")
    print("エラー要素は " + str(result[2]) + " です")
else:
    print("エラー要素はありません")
