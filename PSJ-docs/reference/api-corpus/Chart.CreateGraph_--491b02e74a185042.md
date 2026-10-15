# Chart.CreateGraph()

Chart.CreateGraph()

説明​

ポスト結果曲線を描画します。

構文​

Chart.CreateGraph(...)

マクロ: PostCreateGraph

リボン: Chart » CreateGraph

入力​

crTargetCurve​

ポスト結果曲線を指定する Cursor です。

デフォルト値は None です。

iNumData​

グラフにプロットするデータマーカーの数を指定する Integer です。

デフォルト値は 0 です。

strLineTitle​

チャートラインのタイトルを指定する String です。

デフォルト値は "" です。

dlAxisDataX​

X軸上のデータ値を指定する Double のリストです。

デフォルト値は [] です。

dlAxisDataY​

Y軸上のデータ値を指定する Double のリストです。

デフォルト値は [] です。

strChartTitle​

チャートのタイトルを指定する String です。

デフォルト値は "" です。

strAxisTitleX​

X軸のタイトルを指定する String です。

デフォルト値は "" です。

strAxisTitleY​

Y軸のタイトルを指定する String です。

デフォルト値は "" です。

bNewChart​

新しいチャートウィンドウにグラフをプロットするかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルを準備します
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 

# 負荷条件を作成します
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)]) 

# 負荷ケースを作成します
Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                    crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# 応答条件を作成します
respCondition = Calculation.FreqResp.ResponseCondition(crTargetAnalysis=PostFreqAnalysis(1), 
                                                        dDampingFactor=0.02, dStyleParamMid=10.0, 
                                                        dStyleParamBot=200.0, strlResultNames=["TZ"], 
                                                        crlTargets=[Node(1516)])

# チャートをプロットします
newChart = Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(1), 
                            strChartTitle="Frequency Analysis Displacement", 
                            strAxisTitleX="Frequency", 
                            strAxisTitleY="Amplitude", 
                            bNewChart=False)
JPT.Debugger(newChart)
