# Calculation.FreqResp.LoadCaseCondition()

Calculation.FreqResp.LoadCaseCondition()

説明​

周波数応答（ソルバー）の定常励振入力を設定します。

構文​

Calculation.FreqResp.LoadCase(...)

マクロ：DYNAMIC_FREQ_ANALYSIS_LOADCASE

リボン：Calculation » FreqResp » LoadCase

入力​

crTargetAnalysis​

作成する負荷ケースの対象解析を指定する Cursor。このパラメータが None に設定されている場合は、新しい解析が作成されます。

デフォルト値は None です。

strName​

作成する負荷ケースの名前を指定する String。

デフォルト値は "LoadCase1" です。

dFactor​

作成する負荷ケース全体の負荷係数を指定する Double。

デフォルト値は 1.0 です。

iNewID​

作成する負荷ケースのIDを指定する Integer。

デフォルト値は 1 です。

crlSelectedLoad​

作成する負荷ケースで使用される選択した負荷を指定する Cursor のリスト。

デフォルト値は [] です。

dlTargetFactor​

対応する順序で選択された各負荷の係数を指定する Double のリスト。

デフォルト値は [] です。

crEdit​

既存の負荷ケース条件を指定する Cursor

このパラメータが使用されている場合、指定された負荷ケース条件が変更されます。

None の場合、新しい負荷ケース条件が作成されます。

デフォルト値は None です。

戻り値​

作成された周波数負荷ケースを指定する Cursor。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# 負荷条件を作成
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)])

# 負荷ケースを作成
loadCase = Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                            crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])
JPT.Debugger(loadCase)
