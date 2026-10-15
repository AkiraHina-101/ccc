# JPT.GetResultNames()

JPT.GetResultNames()

説明​

モデルに存在するすべての利用可能な結果タイプを取得します。

構文​

JPT.GetResultNames(PostAnalysisType,
                   resultSet,
                   timeStep,
                   BoolType)

入力​

PostAnalysisType​

解析結果のタイプを述べる PostAnalysisType を指定した Enum です。

これは必須の入力です。

resultSet​

インポートされた結果のステップIDを指定した Integer です。

これは必須の入力です。

timeStep​

インポートされた結果のタイムステップを指定した Integer です。

これは必須の入力です。

BoolType​

現在の言語設定の名前を使用するかどうかを示す BoolType を指定した Enum です。

True: 現在の言語設定の名前を使用します。

False: 英語の名前を使用します。

これは必須の入力です。

ヒント

JPT.BoolType.TRUE_VAL を入力する代わりに 1 または True を入力することができます。
JPT.BoolType.FALSE_VAL を入力する代わりに 0 または False を入力することができます。

戻り値​

モデルに存在するすべての利用可能な結果タイプが含まれる String のリストです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

# すべてのステップとインクリメントで結果名を取得
steps=JPT.GetResultSteps()
for step in steps:
    incs=JPT.GetResultIncrements(step.first, step.third)
    for inc in incs:
        result_name = JPT.GetResultNames(step.first,    #解析タイプ
                                         step.third,    #結果セット
                                         inc,           #タイムステップ
                                         JPT.BoolType.TRUE_VAL)

        JPT.Debugger(result_name)
