# Calculation.TransResp.OpenAnalysis()

Calculation.TransResp.OpenAnalysis()

説明​

一時応答解析の結果（*.tsdv）を読み込みます。

構文​

Calculation.TransResp.OpenAnalysis(...)

マクロ: CmdSaveOpenTsdv

リボン: Calculation » TransResp » OpenAnalysis

入力​

strPath​

開くファイルのパスを指定する String です。

これは必須の入力です。

bBdfMode​

BDFモードを使用するかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値コード​

処理が正常に実行されたかどうかを指定する Boolean 型です：

True: 処理が正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 負荷条件を作成
loadcondition = Calculation.TransResp.LoadCondition(strName="TRNLoad_2", iLoadType=1, iLoadDirection=2, 
                                                    dlForce=[0.0, 0.0, 10.0], dAmplitude=10, dT1=0.1, 
                                                    dT2=0.5, dFrequency=10.0, crlTargets=[Node(1516)])

# 負荷ケースを作成
loadcase = Calculation.TransResp.LoadCaseCondition(crTargetAnalysis=PostTransAnalysis(1), 
                                                    strName="LoadCase_1", 
                                                    crlSelectedLoad=[PostTransLoad(1)], 
                                                    dlTargetFactor=[1.0])

# 応答条件を作成
Calculation.TransResp.ResponseCondition(crTargetAnalysis=PostTransAnalysis(1), dDampingFactor=0.02, 
                                        iCurveStyle=0, dStyleParamMid=80.0, dStyleParamBot=0.0125, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])

# 解析を保存
Calculation.TransResp.SaveAnalysis(strPath="C:/temp/TransRespAnalysis.tsdv", 
                                    crlTargets=[PostTransAnalysis(1)])

# 現在のドキュメントを閉じて、結果ファイルを再度インポート
JPT.CloseDocumentByName("plate_eigen")
JPT.CreateNewDocument()
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 保存した解析を開く
openFile = Calculation.TransResp.OpenAnalysis(strPath="C:/temp/TransRespAnalysis.tsdv")
JPT.Debugger(openFile)
