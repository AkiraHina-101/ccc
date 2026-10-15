# JPT.GetAllPostResultCurves()

JPT.GetAllPostResultCurves()

説明​

既存のすべてのPost結果カーブの情報をすべて取得します。

構文​

JPT.GetAllPostResultCurves()

入力​

このユーティリティ関数は入力値を必要としません。

戻り値​

既存のすべてのPost結果カーブの情報をすべて含む DPostResultCurve オブジェクト。

サンプルコード​

# 結果モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16) 

# 荷重条件を作成
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)]) 

# 荷重ケースを作成
Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# 応答条件を作成
respCondition = Calculation.FreqResp.ResponseCondition(crTargetAnalysis=PostFreqAnalysis(1), 
                                                        dDampingFactor=0.02, dStyleParamMid=10.0, 
                                                        dStyleParamBot=200.0, strlResultNames=["TZ"], 
                                                        crlTargets=[Node(1516, 1016)])
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(1), strChartTitle="Frequency Analysis Displacement", 
                strAxisTitleX="Frequency", strAxisTitleY="Amplitude", bNewChart=False)
Chart.CreateGraph(crTargetCurve=PostFreqResultCurve(3), strChartTitle="Frequency Analysis Displacement", 
                strAxisTitleX="Frequency", strAxisTitleY="Amplitude", bNewChart=False)
# すべてのPost結果カーブを取得
listCurves = JPT.GetAllPostResultCurves()
JPT.Debugger(listCurves)
for curve in listCurves:
    if "MPF" not in curve.name:
        print(curve.name)
        print(curve.rowCount)
        print(curve.colCount)
        print(curve.typeID)
        print(curve.curveType)
        JPT.Debugger(curve.allData)
        JPT.Debugger(curve.frequency)
        JPT.Debugger(curve.amplitude)
        JPT.Debugger(curve.phase)
        JPT.Debugger(curve.real)
        JPT.Debugger(curve.imagine)
    else:
        print(curve.name)
        print(curve.rowCount)
        print(curve.colCount)
        print(curve.typeID)
        print(curve.curveType)
