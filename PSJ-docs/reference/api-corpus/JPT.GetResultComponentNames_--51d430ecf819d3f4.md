# JPT.GetResultComponentNames()

JPT.GetResultComponentNames()

説明​

入力された結果タイプのすべての利用可能な結果方向を取得します。

構文​

JPT.GetResultComponentNames(PostAnalysisType,
                            resultSet,
                            timeStep,
                            resultName,
                            BoolType)

入力​

PostAnalysisType​

解析結果のタイプを説明する PostAnalysisType を指定する Enum です。

これは必須の入力です。

resultSet​

インポートされた結果のステップ ID を指定する Integer です。

これは必須の入力です。

timeStep​

インポートされた結果の時間ステップを指定する Integer です。

これは必須の入力です。

resultName​

結果のタイプを指定する String です（変位、応力など）。

これは必須の入力です。

BoolType​

選択を説明する BoolType を指定する Enum 型です：

True: ID 付きのエンティティを選択します。

False: ID 付きのエンティティを選択解除します。

これは必須の入力です。

戻り値​

入力された結果タイプのすべての利用可能なデータ方向を含む String のリストです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

steps=JPT.GetResultSteps()
for step in steps:
    incs=JPT.GetResultIncrements(step.first, step.third)
    for inc in incs:
        result_comp_name = JPT.GetResultComponentNames(step.first,     # 分析のタイプ
                                                       step.third,     # 結果セット
                                                       inc,            # 時間ステップ
                                                       "Displacement", # 結果名
                                                       JPT.BoolType.TRUE_VAL)

        JPT.Debugger(result_comp_name)
