# Calculation.FreqResp.OpenAnalysis()

Calculation.FreqResp.OpenAnalysis()

説明​

周波数応答解析の結果（*.tsdv）を読み込みます。

構文​

Calculation.FreqResp.OpenAnalysis(...)

マクロ: CmdSaveOpenTsdv

リボン: Calculation » FreqResp » OpenAnalysis

入力​

strPath​

ファイルのパスを指定する String です。

この入力は必須です。

bBdfMode​

BDFモードを使用するかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

処理が正常に実行されたかどうかを指定する Boolean 型です：

True: 処理が正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果モデルを準備する
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\plate_eigen.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 荷重条件を作成する
Calculation.FreqResp.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                    dAmplitude=10.0, crlTargets=[Node(1516)])

# 荷重ケースを作成する
Calculation.FreqResp.LoadCaseCondition(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# 応答条件を作成する
Calculation.FreqResp.ResponseCondition(crTargetAnalysis=PostFreqAnalysis(1), dDampingFactor=0.02, 
                                        dStyleParamMid=10.0, dStyleParamBot=200.0, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])

# 現在のドキュメントを閉じて、結果ファイルを再度インポートします
JPT.CloseDocumentByName("plate_eigen")
JPT.CreateNewDocument()
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 保存された解析を開く（一時フォルダと保存された解析ファイルへのパスを設定してください）
openFile = Calculation.FreqResp.OpenAnalysis(strPath="C:/temp/TransRespAnalysis.tsdv")
JPT.Debugger(openFile)
