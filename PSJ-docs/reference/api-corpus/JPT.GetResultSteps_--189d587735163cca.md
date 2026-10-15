# JPT.GetResultSteps()

JPT.GetResultSteps()

説明​

現在の結果からすべての既存の結果タイプとタイムステップを取得します。

構文​

JPT.GetResultSteps()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

結果のタイプ、ID、およびステップの情報を含む Integer Triple のリスト です。

注記

出力値を取得するために、以下のコードを使用できます（例）:

result_types_steps = JPT.GetResultSteps()
for item in result_types_steps:
    result_type = item.first
    result_id = item.second
    result_step = item.third
    print("Result type: " + str(result_type))
    print("Result ID: " + str(result_id))
    print("Result step: " + str(result_step))

参考のために、JPT.GetResultSteps() APIのすべてのプロパティとメソッドを印刷するには、print(dir(JPT.GetResultSteps())) を使用できます。

その他、出力値は結果タイプを指定する整数値です。したがって、利用可能な結果タイプを確認するには PostAnalysisTypes を参照してください。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

result_types_steps = JPT.GetResultSteps()

print("Result type: " + str(result_types_steps[0].first)) #2: JPT.PostAnalysisType.POST_ANALYSIS_MODAL
print("Result ID: " + str(result_types_steps[0].second))
print("Result step: " + str(result_types_steps[0].third))
