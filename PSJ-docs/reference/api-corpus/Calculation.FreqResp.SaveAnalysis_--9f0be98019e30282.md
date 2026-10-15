# Calculation.FreqResp.SaveAnalysis()

Calculation.FreqResp.SaveAnalysis()

説明​

周波数応答解析の結果を保存します（*.tsdv）。

構文​

Calculation.FreqResp.SaveAnalysis(...)

マクロ：CmdSaveOpenTsdv

リボン：Calculation » FreqResp » SaveAnalysis

入力​

strPath​

保存するファイルのパスを指定する String の値です。

この入力は必須です。

crlTargets​

保存する指定された解析ターゲットを指定する Cursor のリストです。

この入力は必須です。

bBdfMode​

BDFモードを使用するかどうかを指定する Boolean 型の値です。

デフォルト値は False です。

戻り値​

プロセスが正常に実行されたかどうかを示す Boolean 型の値です:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

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
                                        dStyleParamMid=10.0, dStyleParamBot=200.0, 
                                        strlResultNames=["TZ"], crlTargets=[Node(1516, 1016)])

# 解析を保存します（一時フォルダへのパスを設定してください。）
Calculation.FreqResp.SaveAnalysis(strPath="C:/temp/TransRespAnalysis.tsdv", crlTargets=[PostFreqAnalysis(1)])
