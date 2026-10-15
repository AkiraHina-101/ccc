# Calculation.TransResp.SaveAnalysis()

Calculation.TransResp.SaveAnalysis()

説明​

一時応答解析（*.tsdv）の結果を保存します。

構文​

Calculation.TransResp.SaveAnalysis(...)

マクロ：SaveMPCResultToCSV

リボン：Calculation » TransResp » SaveAnalysis

入力​

strPath​

保存するファイルのパスを指定する String 。

これは必須の入力です。

crlTargets​

保存する指定された解析ターゲットを指定する Cursor のリスト型。

これは必須の入力です。

bBdfMode​

BDFモードを使用するかどうかを指定する Boolean 型。

デフォルト値は False です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型:

True: プロセスが正常に実行された。

False: 関数を実行できません。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# 荷重条件の作成
loadcondition = Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, 
                                                    dlForce=[0.0, 0.0, 10.0], dAmplitude=10, dT1=0.1, 
                                                    dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])
# 荷重ケースの作成
loadcase = Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), 
                                                    strName="LoadCase_1", crlSelectedLoad=[PostTransLoad(1)], 
                                                    dlTargetFactor=[1.0])
# 応答条件の作成
Calculation.TransResp.ResponseCondition(crTargetAnalysis=PostTransAnalysis(1), dDampingFactor=0.02, 
                                        iCurveStyle=0, dStyleParamMid=80.0, dStyleParamBot=0.0125, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])
# 解析結果の保存
saveFile = Calculation.TransResp.SaveAnalysis(strPath="C:/temp/TransRespAnalysis.tsdv", 
                                                crlTargets=[PostTransAnalysis(1)])
JPT.Debugger(saveFile)
