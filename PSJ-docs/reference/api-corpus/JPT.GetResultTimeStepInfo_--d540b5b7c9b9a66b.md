# JPT.GetResultTimeStepInfo()

JPT.GetResultTimeStepInfo()

説明​

入力された結果ステップの関連情報と、その時間ステップを取得します。

構文​

JPT.GetResultTimeStepInfo(PostAnalysisType,
                          resultSet,
                          timeStep)

入力​

PostAnalysisType​

解析結果の種類を記述する PostAnalysisType を指定する Enum です。

この入力は必須です。

resultSet​

インポートされた結果のステップIDを指定する Integer です。

この入力は必須です。

timeStep​

インポートされた結果の時間ステップを指定する Integer です。

この入力は必須です。

戻り値​

入力された時間ステップに関連する情報を指定する PostTimeStepInfo オブジェクトです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_time_step_info = JPT.GetResultTimeStepInfo(JPT.PostAnalysisType.POST_ANALYSIS_MODAL,
                                           1,
                                           10)

JPT.Debugger(result_time_step_info)

print(result_time_step_info.mode)
print(result_time_step_info.time)
print(result_time_step_info.freq)
