# JPT.GetAvailableResultOption()

JPT.GetAvailableResultOption()

説明​

入力された結果タイプの利用可能な結果オプションを取得します。

構文​

JPT.GetAvailableResultOption(PostAnalysisType,
                             resultSet,
                             timeStep,
                             resultName,
                             componentName,
                             PostResultDataLoc,
                             defaultResultOption)

入力​

PostAnalysisType​

解析結果のタイプを表す PostAnalysisType を指定する Enum です。

この入力は必須です。

resultSet​

インポートされた結果のステップIDを指定する Integer です。

この入力は必須です。

timeStep​

インポートされた結果のタイムステップを指定する Integer です。

この入力は必須です。

resultName​

結果の種類（変位、応力など）を指定する String です。

この入力は必須です。

componentName​

結果の特定の方向（X、Y、Zなど）を指定する String です。

この入力は必須です。

PostResultDataLoc​

結果の位置を示す PostResultDataLoc を指定する Enum 型です（節点上、要素上など）。

この入力は必須です。

defaultResultOption​

動作結果のデフォルト設定を指定する PostDataOp オブジェクトです。

この入力は必須です。

戻り値​

結果の利用可能な設定を含む PostDataOp オブジェクトです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

available_result_option = \
    JPT.GetAvailableResultOption(JPT.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                                 1,
                                 1,
                                 "Displacement",
                                 "X",
                                 JPT.PostResultDataLoc.POST_LOC_ON_NODE,
                                 JPT.GetDefaultResultOption(JPT.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                                                            1,
                                                            1,
                                                            "Displacement",
                                                            "X",
                                                            JPT.PostResultDataLoc.POST_LOC_ON_NODE)
                                )

JPT.Debugger(available_result_option)

# PostDataOpのコンポーネント
print("Location: " + str(available_result_option.loc))
print("Conversion: " + str(available_result_option.cnv))
print("Continuously: " + str(available_result_option.cont))
print("Coordinate: " + str(available_result_option.coord))
print("Load 1D: " + str(available_result_option.load1d))
print("Load 2D: " + str(available_result_option.load2d))
print("Complex: " + str(available_result_option.complex))
print("Phase Angle: " + str(available_result_option.phaseAngle))
print("User Coordinate ID: " + str(available_result_option.userCoordSysId))
