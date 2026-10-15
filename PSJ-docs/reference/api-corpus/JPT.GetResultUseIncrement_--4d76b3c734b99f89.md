# JPT.GetResultUseIncrement()

JPT.GetResultUseIncrement()

説明​

結果に増分があるかどうかを確認します。

構文​

JPT.GetResultUseIncrement(PostAnalysisType,
                          resultSet)

入力​

PostAnalysisType​

解析結果の種類を表す PostAnalysisType を指定する Enum 型のデータです。

この入力は必須です。

resultSet​

インポートされた結果のステップIDを指定する Integer のデータです。

この入力は必須です。

戻り値​

入力された時間ステップの増分の存在を示す Boolean 型のデータです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

is_increment_exist = \
    JPT.GetResultUseIncrement(JPT.PostAnalysisType.POST_ANALYSIS_MODAL, 1)

JPT.Debugger(is_increment_exist)
