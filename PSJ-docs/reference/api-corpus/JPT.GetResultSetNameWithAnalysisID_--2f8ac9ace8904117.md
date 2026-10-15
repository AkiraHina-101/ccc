# JPT.GetResultSetNameWithAnalysisID()

JPT.GetResultSetNameWithAnalysisID()

説明​

Result Set（サブケース）の名前を取得します。

構文​

JPT.GetResultSetNameWithAnalysisID(PostAnalysisType,
                     analysisID,
                     resultSet)

入力​

PostAnalysisType​

解析結果のタイプを記述する PostAnalysisType を指定する Enum です。

この入力は必須です。

analysisID​

インポートされた結果の解析IDを指定する Integer です。

この入力は必須です。

resultSet​

インポートされた結果のステップIDを指定する Integer です。

この入力は必須です。

戻り値​

Result Set（サブケース）の名前を指定する String です。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_set_name = JPT.GetResultSetNameWithAnalysisID(1,0,1)
JPT.Debugger(result_set_name)
