# JPT.GetResultSetName()

JPT.GetResultSetName()

説明​

Result Set（サブケース）の名前を取得します。

構文​

JPT.GetResultSetName(PostAnalysisType,
                     resultSet)

入力​

PostAnalysisType​

解析結果のタイプを記述する PostAnalysisType を指定する Enum です。

これは必須入力です。

resultSet​

インポートされた結果のステップIDを指定する Integer です。

これは必須入力です。

戻り値​

Result Set（サブケース）の名前を指定する String です。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_set_name = JPT.GetResultSetName(1,1)
JPT.Debugger(result_set_name)
