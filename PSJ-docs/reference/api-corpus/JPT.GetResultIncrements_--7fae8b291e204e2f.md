# JPT.GetResultIncrements()

JPT.GetResultIncrements()

説明​

入力された結果ステップのすべての既存の増分を取得します。

構文​

JPT.GetResultIncrements(PostAnalysisType,
                        resultSet)

入力​

PostAnalysisType​

Enum で、解析結果のタイプを記述する PostAnalysisType を指定します。

この入力は必須です。

resultSet​

Integer で、インポートされた結果のステップ ID を指定します。

この入力は必須です。

戻り値​

入力された結果タイプのすべての既存の増分とそれに対応するステップが含まれる Integer のリストです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_increments = \
    JPT.GetResultIncrements(JPT.PostAnalysisType.POST_ANALYSIS_MODAL,
                            1)

JPT.Debugger(result_increments)
