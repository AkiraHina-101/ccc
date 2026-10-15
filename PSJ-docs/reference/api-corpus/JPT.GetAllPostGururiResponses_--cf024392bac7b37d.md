# JPT.GetAllPostGururiResponses()

JPT.GetAllPostGururiResponses()

説明​

既存のすべてのぐるり応答の情報をすべて取得します。

構文​

JPT.GetAllPostGururiResponses()

入力​

このユーティリティ関数は入力値を必要としません。

戻り値​

既存のすべてのぐるり応答の情報をすべて含む DPostResponse オブジェクト。

サンプルコード​

# 結果サンプルファイルにパスを設定してください
samplePath = "C:/Temp/Sample.op2"

# 結果モデルを準備
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60, dEdgeAngle=60)

# 荷重条件を作成
Calculation.Gururi.LoadCondition(strName="FRQLoad_1", iLoadDirection=2, dlForce=[0.0, 0.0, 10.0], 
                                dAmplitude=10.0, crlTargets=[Node(501)])

# 荷重ケースを作成
loadCase = Calculation.Gururi.LoadCase(crTargetAnalysis=PostFreqAnalysis(1), strName="LoadCase_1", 
                                        crlSelectedLoad=[PostFreqLoad(1)], dlTargetFactor=[1.0])

# 応答計算
response = Calculation.Gururi.Response(crTargetAnalysis=PostFreqAnalysis(1), dInputFrequency=180.0, 
                                        iStepNumber=30)
# すべてのPostぐるり応答を取得
listResponses = JPT.GetAllPostFreqResponsesSolver()
JPT.Debugger(listResponses)
for response in listResponses:
    print(response.name)
    print(response.type)
    print(response.id)
    JPT.Debugger(response.targetAnalysis)
