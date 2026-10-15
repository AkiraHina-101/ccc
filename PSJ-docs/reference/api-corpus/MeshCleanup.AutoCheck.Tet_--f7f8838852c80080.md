# MeshCleanup.AutoCheck.Tet()

MeshCleanup.AutoCheck.Tet()

説明​

多くのメッシュ品質基準を使用して、ソリッドメッシュ（TET4/TET10）を修正します。

構文​

MeshCleanup.AutoCheck.Tet(...)

マクロ:

Ribbon: MeshCleanup » AutoCheck » Tet

入力​

crlTargets​

メッシュ品質をチェックする対象を指定する Cursor のリスト。

対象はパートのみです。

これは必須の入力です。

bStretchCheck​

ストレッチ品質をチェックするかどうかを指定する Boolean 型。

デフォルト値は0です。

bAspectRatioCheck​

アスペクト比の品質をチェックするかどうかを指定する Boolean 型。

デフォルト値は0です。

bVolumeCheck​

ボリュームの品質をチェックするかどうかを指定する Boolean 型。

デフォルト値は0です。

bJacobFactorCheck​

ヤコビアン因子の品質をチェックするかどうかを指定する Boolean 型。

デフォルト値は0です。

bTetCollapseCheck​

テトラ collapse の品質をチェックするかどうかを指定する Boolean 型。

デフォルト値は0です。

bTetSkewCheck​

テトラスキューの品質をチェックするかどうかを指定する Boolean 型。

デフォルト値は0です。

dStretchLimit​

ストレッチの閾値値を指定する Double 。

閾値値以下のストレッチ値を持つ要素は検出され、ウィンドウに表示されます。

デフォルト値は0.1です。

dAspectRatioLimit​

アスペクト比の閾値値を指定する Double 。

閾値値以上のアスペクト比を持つ要素は検出され、ウィンドウに表示されます。

デフォルト値は10です。

dVolumeLimit​

ボリュームの閾値値を指定する Double 。

閾値値以下のボリュームを持つ要素は検出され、ウィンドウに表示されます。

デフォルト値は0です。

dJacobFactorLimit​

ヤコビアン因子の閾値値を指定する Double 。

閾値値以下のヤコビアン因子を持つ要素は検出され、ウィンドウに表示されます。

デフォルト値は0です。

dTetCollapseLimit​

テトラ collapse の閾値値を指定する Double 。

閾値値以下のテトラ collapse を持つ要素は検出され、ウィンドウに表示されます。

デフォルト値は0.05です。

dTetSkewLimit​

テトラスキューの閾値値を指定する Double 。

閾値値以上のテトラスキューを持つ要素は検出され、ウィンドウに表示されます。

デフォルト値は0.9です。

戻り値​

メッシュ品質で違反した要素の情報を順番に指定する Tuple 。

成功（1）または失敗（0）

エラー要素の数

エラー要素のIDのリスト

サンプルコード​

# モデルの準備
Geometry.Part.Cube(dlLength=[0.01, 0.01, 0.0001], 
                    ilAxialNodes=[10, 10, 2], 
                    iPartColor=7697908)
JPT.Exec("View Fit To Model()")
Meshing.SolidMeshing(crlParts=[Part(1)], 
                    dGradingFactor=1.05, 
                    dStretchLimit=0.1, 
                    iSpeedVsQual=1, 
                    iRegion=1, 
                    bSafeMode=False, 
                    iParallel=16, 
                    bInternalMeshOnly=False, 
                    iPartColor=65280)

# メッシュ品質をチェック
result = MeshCleanup.AutoCheck.Tet(crlTargets=[Part(1)], 
                                    bTetSkewCheck=True, 
                                    dTetSkewLimit=0.9)
if result[1] >=1:
    print("エラー要素の数は" + str(result[1]))
    print("エラー要素は" + str(result[2]))
else:
    print("エラー要素はありません")
