# Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV()

Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV()

説明​

MPC結果をCSV形式でファイルに保存します。

構文​

Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV(...)

マクロ：SaveMPCResultToCSV

リボン：Calculation » FreqResp » MPFMCFCalculation » SaveMPCResultToCSV

入力​

crResponse​

保存する応答を指定する Cursor です。

デフォルト値はありません。

dTime​

結果を保存する時刻を指定する Double です。

デフォルト値は0.0です。

strFilePath​

保存するCSVファイルのパスを指定する String です。

これは必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True：プロセスは正常に実行されました。

False：関数を実行できません。

サンプルコード​

# 結果モデルを準備します
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 荷重条件を作成します
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)])

# 荷重ケースを作成します
Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# 応答条件を作成します
Calculation.FreqResp.ResponseCondition(crTargetAnalysis=PostFreqAnalysis(1), dDampingFactor=0.02, 
                                        dStyleParamMid=10.0, dStyleParamBot=200.0, strlResultNames=["TZ"], 
                                        crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(1), strChartTitle="Frequency Analysis Displacement", 
                strAxisTitleX="Frequency", strAxisTitleY="Amplitude")
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(3), strChartTitle="Frequency Analysis Displacement", 
                strAxisTitleX="Frequency", strAxisTitleY="Amplitude", bNewChart=False)

# 頻度での MPFMCF 計算
Calculation.FreqResp.MPFMCFCalculation.AtFrequency(crResponse=PostFreqResultCurve(3), dFrequency=70.0) 

# MPC 結果を保存
resultFile = Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV(crResponse=PostFreqResultCurve(3), 
                                                                        dTime=-1, 
                                                                        strFilePath="C:/temp/Total_MPF_Info.csv")
JPT.Debugger(resultFile)
