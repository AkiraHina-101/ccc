# Calculation.TransResp.MPFMCFCalculation.AtTime()

Calculation.TransResp.MPFMCFCalculation.AtTime()

説明​

モデルパーティシペーションファクターダイアログで特定の時間のMPC結果を表示します。

構文​

Calculation.TransResp.MPFMCFCalculation.AtTime(...)

マクロ: CalculateMPCAtTime

リボン: Calculation » TransResp » MPFMCFCalculation » AtTime

入力​

crResponse​

MPCを計算する応答を指定する Cursor です。

デフォルト値は None です。

dTime​

MPCを計算する時間を指定する Double です。

デフォルト値は 0.0 です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルを準備します
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 荷重条件を作成します
Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10, dT1=0.1, dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])

# 荷重ケースを作成します
Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), strName="LoadCase_1", 
                                        crlSelectedLoad=[PostTransLoad(1)], dlTargetFactor=[1.0])

# 応答条件を作成します
Calculation.TransResp.ResponseCondition(crTargetAnalysis=PostTransAnalysis(1), dDampingFactor=0.02, 
                                        iCurveStyle=0, dStyleParamMid=80.0, dStyleParamBot=0.0125, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostTransResultCurve(1), strChartTitle="Transient Analysis Displacement", 
                    strAxisTitleX="Time", strAxisTitleY="Data")
Chart.CreateGraph(crTargetCurve=PostTransResultCurve(3), strChartTitle="Transient Analysis Displacement", 
                    strAxisTitleX="Time", strAxisTitleY="Data", bNewChart=False)

# MPFMCF計算 時刻
atTime = Calculation.TransResp.MPFMCFCalculation.AtTime(crResponse=PostTransResultCurve(1), dTime=0.1625)
JPT.Debugger(atTime)
