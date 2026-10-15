# JPT.GetResultLocations()

JPT.GetResultLocations()

説明​

入力された結果タイプおよび方向に存在するすべての利用可能なデータ位置を取得します。

構文​

JPT.GetResultLocations(PostAnalysisType,
                       resultSet,
                       timeStep,
                       resultName,
                       componentName)

入力​

PostAnalysisType​

解析結果のタイプを記述する PostAnalysisType を指定する Enum です。

この入力は必須です。

resultSet​

インポートされた結果のステップIDを指定する Integer です。

この入力は必須です。

timeStep​

インポートされた結果の時間ステップを指定する Integer です。

この入力は必須です。

resultName​

結果のタイプ（変位、応力など）を指定する String です。

この入力は必須です。

componentName​

結果の特定の方向（X、Y、Zなど）を指定する String です。

この入力は必須です。

戻り値​

入力された結果タイプとその方向のすべての利用可能な PostResultDataLoc を含む Integer のリストです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_location = \
    JPT.GetResultLocations(PSJ.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                           1,
                           1,
                           "Stress",
                           "XX")

JPT.Debugger(result_location)
#2: JPT.PostResultDataLoc.POST_LOC_ON_ELEMENT
#4: JPT.PostResultDataLoc.POST_LOC_ON_ELEMENT_NODE
