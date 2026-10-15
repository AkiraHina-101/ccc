# Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV()

Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV()

説明​

MPC結果をCSV形式で保存します。

構文​

Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV(...)

マクロ: SaveMPCResultToCSV

リボン: Calculation » TransResp » MPFMCFCalculation » SaveMPCResultToCSV

入力​

crResponse​

保存する応答を指定する Cursor です。

デフォルト値は None です。

dTime​

結果を保存する時間を指定する Double です。

デフォルト値は 0.0 です。

strFilePath​

保存するCSVファイルのパスを指定する String です。

これは必須入力です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 負荷条件の作成
Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10, dT1=0.1, dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])

# 負荷ケースの作成
Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), strName="LoadCase_1", 
                                        crlSelectedLoad=[PostTransLoad(1)], dlTargetFactor=[1.0])

# 応答条件の作成
Calculation.TransResp.ResponseCondition(crTargetAnalysis=PostTransAnalysis(1), dDampingFactor=0.02, 
                                        iCurveStyle=0, dStyleParamMid=80.0, dStyleParamBot=0.0125, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostTransResultCurve(1), strChartTitle="Transient Analysis Displacement", 
                    strAxisTitleX="Time", strAxisTitleY="Data")
Chart.CreateGraph(crTargetCurve=PostTransResultCurve(3), strChartTitle="Transient Analysis Displacement", 
                    strAxisTitleX="Time", strAxisTitleY="Data", bNewChart=False)

# 合計MPC
Calculation.TransResp.MPFMCFCalculation.TotalMPC(crResponse=PostTransResultCurve(1))

# MPC結果を保存
resultFile = Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV(crResponse=PostTransResultCurve(1), dTime=-1, strFilePath="C:/temp/Total_MPF_Info.csv")
JPT.Debugger(resultFile)
