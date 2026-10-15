# JPT.GetAllPostTransResponseSolvers()

JPT.GetAllPostTransResponseSolvers()

説明​

既存のすべての過渡応答（ソルバー）の情報をすべて取得します。

構文​

JPT.GetAllPostTransResponseSolvers()

入力​

このユーティリティ関数は入力値を必要としません。

戻り値​

既存のすべての過渡応答（ソルバー）の情報をすべて含む DPostResponse オブジェクト。

サンプルコード​

# 結果モデルを準備
inputPath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Command\\PostSample\\freq-solver\\103.bdf"
outputFolder = "C:\\temp"
JPT.RunSunShine(inputPath,outputFolder,2,1,False,True,False)

Home.ImportResults.Nastran(strPath = outputFolder + "\\103.op2", dFaceAngle=60.16, dEdgeAngle=60.16) 

# 過渡解析荷重 - ソルバーを作成
Calculation.TransRespSolver.LoadCondition(strName="TRNLoad_1", 
                                        iLoadDirection=2, 
                                        dlForce=[0.0, 0.0, 10.0], 
                                        dAmplitude=10.0, 
                                        crlTargets=[Node(514)])

# 過渡解析応答 - ソルバーを作成
respCondition = Calculation.TransRespSolver.ResponseCondition(crTargetAnalysis=PostTransAnalysisSolver(1), 
                                                            bDampingFactor=False, 
                                                            dDampingFactor=0.02, 
                                                            iCurveStyle=2, 
                                                            dStyleParamMid=20.0, 
                                                            dStyleParamBot=5000.0, 
                                                            strlResultNames=["TZ"], 
                                                            strDBFileName="103", 
                                                            strDBVersion="1", 
                                                            strMethodId="2", 
                                                            strPath="C:/temp/111.bdf", 
                                                            crlTargets=[Node(517)])
# すべてのポスト過渡応答（ソルバー）を取得
listResponses = JPT.GetAllPostTransResponseSolvers()
JPT.Debugger(listResponses)
for response in listResponses:
    print(response.name)
    print(response.type)
    print(response.id)
    JPT.Debugger(response.targetAnalysis)
    JPT.Debugger(response.resultCurve)
