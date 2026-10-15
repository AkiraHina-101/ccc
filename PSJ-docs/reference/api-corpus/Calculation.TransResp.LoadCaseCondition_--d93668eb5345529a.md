# Calculation.TransResp.LoadCaseCondition()

Calculation.TransResp.LoadCaseCondition()

説明​

瞬時応答解析のための荷重ケースを作成します。

構文​

Calculation.TransResp.LoadCaseCondition(...)

マクロ：DYNAMIC_TRANS_ANALYSIS_LOADCASE

リボン：Calculation » TransResp » LoadCaseCondition

入力​

crTargetAnalysis​

ターゲット解析を指定する Cursor です。 荷重ケースを作成する場合は新しい解析が作成されます。

デフォルト値は None です。

strName​

作成する荷重ケースの名前を指定する String です。

デフォルト値は "LoadCase1" です。

dFactor​

作成される全荷重ケースの荷重係数を指定する Double です。

デフォルト値は 1.0 です。

iNewID​

作成される荷重ケースのIDを指定する Integer です。

デフォルト値は 1 です。

crlSelectedLoad​

作成される荷重ケースに使用される選択した荷重を指定する List of Cursor です。

デフォルト値は [] です。

dlTargetFactor​

対応する順序で選択された各荷重の係数を指定する Double List です。

デフォルト値は [] です。

crEdit​

既存の荷重ケース条件を指定する Cursor です

このパラメータを使用すると、指定された荷重ケース条件が修正されます。

未使用の場合、新しい荷重ケース条件が作成されます。

デフォルト値は None です。

戻り値​

瞬時荷重ケース条件を指定する Cursor です。

サンプルコード​

# 結果モデルを準備する
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 荷重条件を作成する
loadcondition = Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, 
                                                    dlForce=[0.0, 0.0, 10.0], dAmplitude=10, dT1=0.1, 
                                                    dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])

# 荷重ケースを作成する
loadcase = Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), strName="LoadCase_1",
                                                 crlSelectedLoad=[PostTransLoad(1)], dlTargetFactor=[1.0])
JPT.Debugger(loadcase)
