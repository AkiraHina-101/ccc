# JPT.GetActiveDataOption()

JPT.GetActiveDataOption()

説明​

アクティブドキュメントのポストデータオプションを取得します。

構文​

JPT.GetActiveDataOption()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

アクティブドキュメントの PostDataOp オブジェクト。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

default_result_option = \
    JPT.GetDefaultResultOption(JPT.PostAnalysisType.POST_ANALYSIS_LINEAR_STATIC,
                               1,
                               1,
                               "Stress",
                               "XX",
                               JPT.PostResultDataLoc.POST_LOC_ON_ELEMENT_NODE)

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XX, 2}, {1, 1, 0, 0, 16, 0, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

active_result_option = JPT.GetActiveDataOption()
JPT.Debugger(default_result_option)
JPT.Debugger(active_result_option)
