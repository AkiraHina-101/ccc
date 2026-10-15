# Calculation.FreqResp.MPFMCFCalculation.TotalMPC()

Calculation.FreqResp.MPFMCFCalculation.TotalMPC()

説明​

合計MPCのグラフ（チャート）を表示します。

構文​

Calculation.FreqResp.MPFMCFCalculation.TotalMPC(...)

マクロ：TotalMPC

リボン：Calculation » FreqResp » MPFMCFCalculation » TotalMPC

入力​

crResponse​

合計MPCを計算する応答を指定する Cursor。

デフォルト値は None です。

戻り値​

処理が正常に実行されたかどうかを指定する Boolean：

True：処理は正常に実行されました。

False：関数を実行することができません。

サンプルコード​

# 結果モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 負荷条件を作成
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)])

# 負荷ケースを作成
Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                            crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# 応答条件を作成
Calculation.FreqResp.ResponseCondition(crTargetAnalysis=PostFreqAnalysis(1), dDampingFactor=0.02, 
                                        dStyleParamMid=10.0, dStyleParamBot=200.0, strlResultNames=["TZ"], 
                                        crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(1), strChartTitle="Frequency Analysis Displacement", 
                    strAxisTitleX="Frequency", strAxisTitleY="Amplitude")
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(3), strChartTitle="Frequency Analysis Displacement", 
                    strAxisTitleX="Frequency", strAxisTitleY="Amplitude", bNewChart=False)

# 周波数でのMPFMCF計算
Calculation.FreqResp.MPFMCFCalculation.AtFrequency(crResponse=PostFreqResultCurve(3), dFrequency=70.0)

# 合計MPC
totalMPC = Calculation.FreqResp.MPFMCFCalculation.TotalMPC(crResponse=PostFreqResultCurve(3))
JPT.Debugger(totalMPC)
