# Calculation.FreqResp.MPFMCFCalculation.AtFrequency()

Calculation.FreqResp.MPFMCFCalculation.AtFrequency()

説明​

特定の周波数のMPC結果をModel Participation Factorダイアログに表示します。

構文​

Calculation.FreqResp.MPFMCFCalculation.AtFrequency(...)

マクロ: CalculateMPCAtFrequency

リボン: Calculation » FreqResp » MPFMCFCalculation » AtFrequency

入力​

crResponse​

MPCを計算する応答を指定する Cursor です。

デフォルト値は None です。

dFrequency​

MPCを計算する周波数を指定する Double です。

デフォルト値は 0.0 です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 負荷条件の作成
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)])

# 負荷ケースの作成
Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                            crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# 応答条件の作成
Calculation.FreqResp.ResponseCondition(crTargetAnalysis=PostFreqAnalysis(1), dDampingFactor=0.02, 
                                        dStyleParamMid=10.0, dStyleParamBot=200.0, strlResultNames=["TZ"], 
                                        crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(1), strChartTitle="Frequency Analysis Displacement", 
                    strAxisTitleX="Frequency", strAxisTitleY="Amplitude")
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(3), strChartTitle="Frequency Analysis Displacement", 
                    strAxisTitleX="Frequency", strAxisTitleY="Amplitude", bNewChart=False)

# 特定の周波数でのMPFMCF計算
atFreq = Calculation.FreqResp.MPFMCFCalculation.AtFrequency(crResponse=PostFreqResultCurve(3), dFrequency=70.0)
JPT.Debugger(atFreq)
