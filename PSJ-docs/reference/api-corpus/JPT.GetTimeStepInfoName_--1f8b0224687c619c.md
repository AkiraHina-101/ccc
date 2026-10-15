# JPT.GetTimeStepInfoName()

JPT.GetTimeStepInfoName()

説明​

時間ステップ情報の名前を取得します。

構文​

JPT.GetTimeStepInfoName(PostAnalysisType,
                        resultSet,
                        timeStep)

入力​

PostAnalysisType​

解析結果のタイプを記述する PostAnalysisType を指定する Enum。

この入力は必須です。

resultSet​

インポートされた結果のステップIDを指定する Integer。

この入力は必須です。

timeStep​

インポートされた結果の時間ステップを指定する Integer。

この入力は必須です。

戻り値​

時間ステップ情報の名前を指定する String。

サンプルコード​

# モデルを準備します
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

time_step_info_name = JPT.GetTimeStepInfoName(2,1,1)
JPT.Debugger(time_step_info_name) # Mode 1, Freq=3.235953e+04
