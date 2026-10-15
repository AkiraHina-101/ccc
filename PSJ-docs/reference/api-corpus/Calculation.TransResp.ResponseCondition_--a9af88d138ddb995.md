# Calculation.TransResp.ResponseCondition()

Calculation.TransResp.ResponseCondition()

説明​

瞬時応答の応答点の結果を出力します。

構文​

Calculation.TransResp.ResponseCondition(...)

マクロ: CmdSaveOpenTsdv

リボン: Calculation » TransResp » ResponseCondition

入力​

crTargetAnalysis​

処理対象のジョブを指定する Cursor です。

デフォルト値は None です。

crCoordinate​

出力座標系を指定する Cursor です。

デフォルト値は None です。

bAllModesUsed​

すべてのモードを使用するかどうかを指定する Boolean です。

デフォルト値は True です。

strlModesSelected​

応答計算に使用する選択されたモードを指定する String のリストです。bAllModesUsed が False の場合に使用されます。

デフォルト値は [] です。

bDampingFactor​

計算にダンピング係数を使用するかどうかを指定する Boolean です。

デフォルト値は True です。

dDampingFactor​

ダンピング係数の値を指定する Double です。

デフォルト値は 0.01 です。

crDampingFactor​

ダンピング係数のフィールドデータを指定する Cursor です。

デフォルト値は None です。

iCurveStyle​

計算のための時間範囲のスタイルを指定する Integer です。

0: 開始 + ステップ番号 + ステップサイズ

1: 開始 + ステップサイズ + 終了

2: 開始 + ステップ番号 + 終了

デフォルト値は 1 です。

dStyleParamTop​

選択されたカーブスタイルの解析開始値を指定する Double です。

デフォルト値は 0.0 です。

dStyleParamMid​

選択されたカーブスタイルのステップサイズ値を指定する Double です。

デフォルト値は 1.0 です。

dStyleParamBot​

選択されたカーブスタイルの解析終了値を指定する Double です。

デフォルト値は 1.0 です。

bIncludeEigenValue​

固有値の周波数をプロットするかどうかを指定する Boolean です。

デフォルト値は False です。

bCreateNewResult​

モデル全体の新しい結果（変位と応力）を作成するかどうかを指定する Boolean です。

デフォルト値は False です。

iResultType​

計算される結果のタイプを指定する Integer です。

0: 変位

1: 速度

2: 加速度

3: 応力（ソリッド）

4: 応力（シェル）

5: 変位 + 応力。この結果タイプは bCreateNewResult = True の場合に表示されます。

デフォルト値は 0 です。

strlResultNames​

選択した結果タイプに応じてコンポーネントの結果を指定する String のリストです。

デフォルト値は ["TX"] です。

iResultPosition​

結果の出力位置を指定する Integer です。

デフォルト値は 0 です。

bAllLoadCases​

現在のすべての負荷ケースを使用するかどうかを指定する Boolean です。

デフォルト値は True です。

crSelectedLoadCase​

解析する選択した負荷ケースを指定する Cursor です。bAllLoadCases が False の場合に使用されます。

デフォルト値は None です。

bSeparateLoad​

各セット負荷に対する応答を計算するかどうかを指定する Boolean です。

デフォルト値は False です。

crlTargets​

応答を計算するターゲットを指定する Cursor のリストです。ターゲットは節点またはソリッド要素です。

これは必須の入力です。

crEdit​

既存の応答条件を指定する Cursor です

このパラメータを使用すると、指定された応答条件が変更されます。

None のままにしておくと、新しい応答条件が作成されます。

デフォルト値は None です。

戻り値​

作成された瞬時応答条件を指定する Cursor です。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 負荷条件の作成
Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, 
                                    dlForce=[0.0, 0.0, 10.0], dAmplitude=10, dT1=0.1, dT2=0.5, 
                                    dFrequency=10.0, crlTargets=[Node(1516)])

# 負荷ケースの作成
Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), strName="LoadCase_1",
                                        crlSelectedLoad=[PostTransLoad(1)], dlTargetFactor=[1.0])

# 応答条件の作成
respCondition = Calculation.TransResp.ResponseCondition(crTargetAnalysis=PostTransAnalysis(1), dDampingFactor=0.02, 
                                                        iCurveStyle=0, dStyleParamMid=80.0, dStyleParamBot=0.0125, 
                                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostTransResultCurve(1), strChartTitle="Transient Analysis Displacement", 
                strAxisTitleX="Time", strAxisTitleY="Data")
Chart.CreateGraph(crTargetCurve=PostTransResultCurve(3), strChartTitle="Transient Analysis Displacement", 
                strAxisTitleX="Time", strAxisTitleY="Data", bNewChart=False)
JPT.Debugger(respCondition) # 戻り値を確認します
